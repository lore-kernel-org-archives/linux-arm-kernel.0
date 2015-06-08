From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 08 Jun 2015 18:13:58 +0100
Subject: [PATCH 00/13] arm64: KVM: GICv3 ITS emulation
In-Reply-To: <02ae01d0a1d9$732d2ce0$598786a0$@samsung.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <01ad01d0a1b7$d4d4fe40$7e7efac0$@samsung.com> <557550F0.5070106@arm.com>
 <02ae01d0a1d9$732d2ce0$598786a0$@samsung.com>
Message-ID: <5575CD56.5020109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/15 11:54, Pavel Fedin wrote:
>  Hi!
> 
>> I'm afraid this is not enough. A write to GICR_TRANSLATER (DID+EID)
>> results in a (LPI,CPU) pair. Can you easily express the CPU part in
>> irqfd (this is a genuine question, I'm not familiar enough with that
>> part of the core)?
> 
>  But... As far as i could understand, LPI is added to a collection as a part of setup. And
> collection actually represents a destination CPU, doesn't it? And we can't have multiple
> LPIs sharing the same number and going to different CPUs. Or am i wrong? Unfortunately i
> don't have GICv3 arch reference manual.

This is true to some extent. But the point is that the result of the
translation is both an LPI and a CPU. My question was how you would
indicate convey the notion of a target vcpu when using irqfd. As far as
I know this doesn't really fit, unless we start introducing the dreaded
GSI routing...

Do we really want to go down that road?

>> Another concern
>> would be the support of GICv4, which relies on the command queue
>> handling to be handled in the kernel
> 
>  Wow, i didn't know about GICv4.

I wish I didn't know about it.

	M.
-- 
Jazz is not dead. It just smells funny...
