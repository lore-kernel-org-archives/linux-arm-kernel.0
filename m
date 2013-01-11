From: agraf@suse.de (Alexander Graf)
Date: Fri, 11 Jan 2013 21:26:56 +0100
Subject: [kvmarm] [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <1357935078.5475.10@snotra>
References: <1357935078.5475.10@snotra>
Message-ID: <A31F44DA-736C-4B8B-A9EF-6A8481C3E08D@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



Am 11.01.2013 um 21:11 schrieb Scott Wood <scottwood@freescale.com>:

> On 01/11/2013 09:42:55 AM, Alexander Graf wrote:
>> On 11.01.2013, at 02:10, Scott Wood wrote:
>> > struct kvm_device_attr {
>> >    __u32 device;
>> This needs some semantic specification. Is device a constant value? Is it the return value of CREATE_IRQCHIP?
> 
> As proposed, it's up to the architecture to provide that specification.  In theory this could be used for things other than IRQ chips.  We could still say that device creation functions return a valid device ID (if the device has any attributes), as well as have other architecture-specific ways of describing device IDs (static enumeration).  Or we could have non-architecture-specific static enumeration.  Or just require that all devices be explicitly created by something that returns the ID.
> 
> Do you have a preferred approach?

I am a fan of dynamically generated ids that get returned from the create functions (like open() and an fd).

I'm not sure if that would always work here though. It would mean that we explicitly have to create per-cpu interrupt controllers. Or append their state onto vcpu state.

Alex

> 
> -Scott
