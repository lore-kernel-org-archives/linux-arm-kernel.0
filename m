From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 23 Jun 2011 05:03:39 +0530
Subject: [PATCH 25/25] ARM: pm: omap34xx: convert to generic suspend/resume
	support
In-Reply-To: <20110622161021.GB9449@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>	<E1QZPAo-0002XO-9G@rmk-PC.arm.linux.org.uk>
	<20110622161021.GB9449@n2100.arm.linux.org.uk>
Message-ID: <4E027BD3.6030500@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/22/2011 9:40 PM, Russell King - ARM Linux wrote:
> A couple of things to point out here:
>
> On Wed, Jun 22, 2011 at 04:16:58PM +0100, Russell King - ARM Linux wrote:
>> -	mrc	p15, 0, r4, c13, c0, 1	@ Context ID
>> -	mrc	p15, 0, r5, c13, c0, 2	@ User r/w thread and process ID
>> -	mrc	p15, 0, r6, c12, c0, 0	@ Secure or NS vector base address
>> -	mrs	r7, cpsr		@ Store current cpsr
>> -	stmia	r8!, {r4-r7}
>
> 1. The User r/w thread and process ID is not saved/restored by Linux over
> context switches, so it doesn't serve any useful purpose to save and
> restore over resume.
>
It will be needed for CPUIDLE I guess.

> 2. Compare the instruction saving and restoring the vector base address
> (see below for the restore code.)
>
That's typo. It should have been mcr. Actually VBAR isn't used on GP
devices but might be used on secure devices. I know that common suspend
code doesn't consider this register. It's fine to keep it that way
and if OMAP needs it, it can save/restored outside common code.

Regards
Santosh
