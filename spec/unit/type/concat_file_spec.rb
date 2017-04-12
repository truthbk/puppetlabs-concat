require 'spec_helper'

shared_examples 'Puppet::Parameter::Boolean' do |parameter|
    it "accepts true (#{true.class}) as a value" do
    resource[parameter] = true
    expect(resource[parameter]).to eq(:true)
  end

  it "accepts false (#{false.class}) as a value" do
    resource[parameter] = true
    expect(resource[parameter]).to eq(:false)
  end
end

describe Puppet::Type.type(:concat_file) do
  let(:resource) { described_class.new(name: '/foo/bar') }

  describe 'key attributes' do
    let(:subject) { described_class.key_attributes }

    it 'contain only :path' do
      is_expected.to eq([:path])
    end
  end

  describe 'parameter :path' do
    it 'does not accept unqualified paths' do
      expect { resource[:path] = 'foo' }.to raise_error(
        %r{File paths must be fully qualified}
      )
    end
  end

  describe 'parameter :order' do
    it 'accepts "alpha" as a value' do
      resource[:order] = 'alpha'
      expect(resource[:order]).to eq(:alpha)
    end

    it 'accepts "numeric" as a value' do
      resource[:order] = 'numeric'
      expect(resource[:order]).to eq(:numeric)
    end

    it 'does not accept "bar" as a value' do
      expect { resource[:order] = 'bar' }.to raise_error(%r{Invalid value "bar"})
    end
  end

  describe 'parameter :replace' do
    it_behaves_like 'Puppet::Parameter::Boolean', :replace
  end

  describe 'parameter :ensure_newline' do
    it_behaves_like 'Puppet::Parameter::Boolean', :ensure_newline
  end
end
