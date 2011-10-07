From: khilman@ti.com (Kevin Hilman)
Date: Fri, 07 Oct 2011 15:50:32 -0700
Subject: [PATCH 00/24 V2] OMAP4: PM: suspend,
	CPU-hotplug and CPUilde support
In-Reply-To: <87d3e8juqm.fsf@ti.com> (Kevin Hilman's message of "Fri, 07 Oct
	2011 15:35:13 -0700")
References: <1316844884-21700-1-git-send-email-santosh.shilimkar@ti.com>
	<87d3e8juqm.fsf@ti.com>
Message-ID: <87vcs0ifgn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@ti.com> writes:

> Hi Santosh,
>
> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
>
>> The series adds OMAP4 MPUSS (MPU SubSystem) power management support for
>> suspend (S2R), CPU hotplug and CPUidle.
>
> Just noticed when doing some final build/sanity testing that there are a
> few of compile/link warnings/problems when the kernel is built without
> CONFIG_PM
>
> Some warnings:
>
> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-wakeupgen.c:203:13: warning: 'irq_save_context' defined but not used
> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-wakeupgen.c:270:13: warning: 'irq_save_secure_context' defined but not used
>
> and some failures (these happen when CONFIG_SUSPEND=n but CONFIG_PM_RUNTIME=y:
>
> arch/arm/mach-omap2/built-in.o: In function `skip_l2en':
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep44xx.S:323: undefined reference to `cpu_resume'
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> /work/kernel/omap/pm/arch/arm/mach-omap2/pm34xx.c:429: undefined reference to `cpu_suspend'
> arch/arm/mach-omap2/built-in.o: In function `skipl2reen':
> /work/kernel/omap/pm/arch/arm/mach-omap2/sleep34xx.S:534: undefined reference to `cpu_resume'
> arch/arm/mach-omap2/built-in.o: In function `omap4_enter_lowpower':
> /work/kernel/omap/pm/arch/arm/mach-omap2/omap-mpuss-lowpower.c:281: undefined reference to `cpu_suspend'
>
> Turns out these are not directly related to your series and OMAP3
> exhibits the same problems.
>
> I just posted a patch[1] to attempt to address these.
>
> But could you fixup the first problem and test with [1] to see if things
> still build/work as expected.

OK, ignore my patch.

Arnd already has a fix for these link problems in his randconfig/arm
branch.

Please just cleanup the wakeupgen compile warnings and update your
branch.

Kevin
