From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 25 Jul 2014 11:09:12 +0200
Subject: [PATCH v2 2/3] ARM: remove remaining definitions of
 PLAT_PHYS_OFFSET from <mach/memory.h>
In-Reply-To: <20140725000621.GO21766@n2100.arm.linux.org.uk>
References: <1404295043-6661-2-git-send-email-u.kleine-koenig@pengutronix.de>
 <1404717185-10010-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20140725000621.GO21766@n2100.arm.linux.org.uk>
Message-ID: <20140725090912.GC6146@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

On Fri, Jul 25, 2014 at 01:06:22AM +0100, Russell King - ARM Linux wrote:
> On Mon, Jul 07, 2014 at 09:13:05AM +0200, Uwe Kleine-K?nig wrote:
> > The platforms selecting NEED_MACH_MEMORY_H defined the start address of
> > their physical memory in the respective <mach/memory.h>. With
> > ARM_PATCH_PHYS_VIRT=y (which is quite common today) this is useless
> > though because the definition isn't used but determined dynamically.
> > 
> > So remove the definitions from all <mach/memory.h> and provide the
> > Kconfig symbol PHYS_OFFSET with the respective defaults in case
> > ARM_PATCH_PHYS_VIRT isn't enabled.
> > 
> > This allows to drop the dependency of PHYS_OFFSET on !NEED_MACH_MEMORY_H
> > which prevents compiling an integrator nommu-kernel.
> > (CONFIG_PAGE_OFFSET which has "default PHYS_OFFSET if !MMU" expanded to
> > "0x" because CONFIG_PHYS_OFFSET doesn't exist as INTEGRATOR selects
> > NEED_MACH_MEMORY_H.)
> 
> Should I assume that this hasn't been build tested?
darn, I admit being guilty not retesting it after rebasing to 3.16-rc. I
think I did test it when I wrote the patch the first time, but you made
me unsure if I tested all relevant cases. Working on a follow-up patch.

Mea culpa
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
