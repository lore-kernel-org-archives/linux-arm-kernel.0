From: pbonzini@redhat.com (Paolo Bonzini)
Date: Tue, 23 Sep 2014 10:36:30 +0200
Subject: [GIT PULL] arm/arm64: KVM: Fix unaligned access bug on gicv2
 access
In-Reply-To: <20140922220710.GA24499@arm.com>
References: <1411420350-368-1-git-send-email-christoffer.dall@linaro.org>
 <1411420350-368-2-git-send-email-christoffer.dall@linaro.org>
 <20140922220710.GA24499@arm.com>
Message-ID: <5421310E.9020902@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Il 23/09/2014 00:07, Will Deacon ha scritto:
>> >  {
>> >  	if (!(lr_desc.state & LR_STATE_MASK))
>> > -		set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
>> > +		__set_bit(lr, (unsigned long *)vcpu->arch.vgic_cpu.vgic_v2.vgic_elrsr);
>> >  }
> Does this work for big-endian arm64 machines? Surely the bug is due to
> casting a u32 * to an unsigned long *, and not specifically related to
> atomics (which is where it happened to explode)?

I agree, this doesn't seem to be the right fix.

Paolo
