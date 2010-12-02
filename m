From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 2 Dec 2010 15:19:05 +0000
Subject: [PATCH 1/8] ARM: SCU: Add common routines for secondary CPU bootup
In-Reply-To: <20101201002527.GC14383@n2100.arm.linux.org.uk>
References: <20101130171626.GA6165@oksana.dev.rtsoft.ru>
	<20101130171658.GA24034@oksana.dev.rtsoft.ru>
	<20101130233204.GB14383@n2100.arm.linux.org.uk>
	<20101201002527.GC14383@n2100.arm.linux.org.uk>
Message-ID: <AANLkTikpjq-8BVanF5W76j0ZdDBur8DyHWSH8GGgJBQs@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 December 2010 00:25, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Nov 30, 2010 at 11:32:04PM +0000, Russell King - ARM Linux wrote:
>> Note that I'll go with factoring this out into arch/arm/kernel/smp_scu.c
>> for the time being, but I'm not convinced about the other parts yet.
>
> IOW, something like the attached. ?I've gone a little further and removed
> the now unnecessary scu_enable() and scu_get_core_count() global functions,
> making scu_enable() static, and eliminating scu_get_core_count() entirely.

There is some benefit in leaving get_core_count() in the platform
code. For example, the SCU on Cortex-A15 doesn't expose the core count
register and we have to get it from somewhere else (for now from some
L2 cache controller register but in the future it may be hardcoded,
passed via FDT or simply trying to boot maxcpus).

-- 
Catalin
