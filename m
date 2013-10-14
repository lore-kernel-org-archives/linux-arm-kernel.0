From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 14 Oct 2013 13:36:12 +0100
Subject: [PATCH 0/3] virtio-mmio: handle BE guests on LE hosts
In-Reply-To: <87d2n88dps.fsf@rustcorp.com.au>
References: <1381502171-8187-1-git-send-email-marc.zyngier@arm.com>
 <87d2n88dps.fsf@rustcorp.com.au>
Message-ID: <525BE53C.6010100@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/10/13 09:21, Rusty Russell wrote:
> Marc Zyngier <marc.zyngier@arm.com> writes:
>> This small patch series adds just enough kernel infrastructure and
>> fixes to allow a BE guest to use virtio-mmio on a LE host, provided
>> that the host actually supports such madness.
>>
>> This has been tested on arm64, with some fixes to KVM and a set of
>> changes to kvmtool, both which I am posting separately.
> 
> OK, so I already have a patch which supports config space accessors.
> I've posted the series below, and since you want it, I'll put it in
> virtio-next after more testing and rebasing...

Yes, that's definitely something I'd like to see being merged, as it
would allow me to drop a significant chunk of changes.

> But we won't be using feature bits for endianness, since we're defining
> endian in the 1.0 spec (whether LE-everywhere or LE-for-mmio-and-PCI is
> still debated).  Since we need to guess for backwards compat anyway,
> let's keep doing this until v1.0?

When is 1.0 going to happen? When will actual implementation of drivers
and devices show up in my favourite platform emulation?

Having a grand plan for the future is great, but I need something
working right now, or at least fairly soonish... And I need it to be
backward compatible, as none of the above is going to show up overnight.

> (Yeah, I made this mess with "native endian".  I promise I have learnt
> my lesson).

Paracetamol bill coming you way... ;-)

	M.
-- 
Jazz is not dead. It just smells funny...
