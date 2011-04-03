From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sun, 03 Apr 2011 17:30:22 +0530
Subject: RFC, GIC based smp_cross_call cleanup suggestion
In-Reply-To: <20110403114610.GC4213@n2100.arm.linux.org.uk>
References: <10921831-0170-4106-bb3a-a52515a32c3e@VA3EHSMHS002.ehs.local>
	<BANLkTimY+mRXqT7NwUQ86SxnfKw0HX-pTQ@mail.gmail.com>
	<20110402085133.GE8482@n2100.arm.linux.org.uk>
	<BANLkTim+bco_90iPLrc1ioV4bdSw+LRzQQ@mail.gmail.com>
	<BANLkTimjyBzh3Kc+1njcBBYCouKdSWhgng@mail.gmail.com>
	<20110403103730.GB4213@n2100.arm.linux.org.uk>
	<4D9851B5.20100@ti.com>
	<20110403114610.GC4213@n2100.arm.linux.org.uk>
Message-ID: <4D986156.8010000@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/3/2011 5:16 PM, Russell King - ARM Linux wrote:
> On Sun, Apr 03, 2011 at 04:23:41PM +0530, Santosh Shilimkar wrote:
>> Sure, it does break OMAP4. These functions are there because they
>> are used/compiled only for SMP support.
>
> If they're only used privately within the mach-omap2 code, then putting
> them in a header file in arch/arm/mach-omap2 would've been the logical
> thing to do, rather than telling the entire SMP kernel about the
> functions.
>
Ok. Make sense.

> Header files in arch/arm/*/include/mach included from
> arch/arm/include/asm/*.h are there to provide necessary definitions for
> either the rest of the kernel or the ARM specific parts.  They shouldn't
> be polluted with *any* platform private stuff which is not absolutely
> necessary to satisfy the rest of the kernel.  Those mach/ includes
> being:
>
> mach/barriers.h
> mach/clkdev.h
> mach/floppy.h
> mach/gpio.h
> mach/hardware.h
> mach/io.h
> mach/irqs.h
> mach/isa-dma.h
> mach/memory.h
> mach/mtd-xip.h
> mach/smp.h
> mach/timex.h
> mach/vmalloc.h
>
Thanks for the list. I shall move those to omap4-common.h
I didn't do it last time thinking file
"arch/arm/plat-omap/include/plat/smp.h" can have platform
specific functions as well.

I missed the point that "mach/smp.h" would be included
indirectly by "linux/smp.h"

Thanks for making this clear to me.

Regards
Santosh
