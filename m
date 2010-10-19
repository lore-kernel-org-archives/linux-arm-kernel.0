From: gadiyar@ti.com (Gadiyar, Anand)
Date: Wed, 20 Oct 2010 00:03:11 +0530
Subject: linux-next: omap2plus_defconfig does not build
In-Reply-To: <20101019171515.GB3038@atomide.com>
References: <a36d6a1047d959af6ea65cd7edacf6a8@mail.gmail.com>
	<20101019171515.GB3038@atomide.com>
Message-ID: <AANLkTikGkpx8Pd9uPSyQus2FibyU=zUjxFkwJnofFO9q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 19, 2010 at 10:45 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Anand Gadiyar <gadiyar@ti.com> [101013 06:14]:
>> Building omap2plus_defconfig (which enables support for
>> OMAP2420/2430/OMAP3
>> and OMAP4 in one image), I get the following build error.
>>
>> ? CC ? ? ?arch/arm/kernel/swp_emulate.o
>> /tmp/ccg979qz.s: Assembler messages:
>> /tmp/ccg979qz.s:343: Error: selected processor does not support ARM mode
>> `ldrexb r6,[r5]'
>> /tmp/ccg979qz.s:344: Error: selected processor does not support ARM mode
>> `strexb r1,r3,[r5]'
>> make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
>> make: *** [arch/arm/kernel] Error 2
>>
>> I'm using CodeSourcery's 2010q1-202 toolchain based on gcc 4.4.1.
>>
>> I haven't been following the lists closely the last few days, so I'm not
>> sure if this is a known issue. Just reporting it for now.
>
> This seems to be related to "ARM: Add SWP/SWPB emulation for ARMv7 processors (v5)"
> where SWP_EMULATE is selected by default. For the omap2plus_defconfig in for-next
> we now have CPU_V6 and CPU_V7 set with SMP and SMP_ON_UP.
>

I had forgotten I'd reported this earlier. I reported the build break
again today, and Catalin provided this patch [1] which solves the
build issue.

- Anand

[1] http://marc.info/?t=128748412500003&r=1&w=2
