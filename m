From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 5 Jan 2011 00:21:33 +0530
Subject: [PATCH 5/5] omap2plus: voltage: Trivial linking fix for 'EINVAL'
	undeclared
In-Reply-To: <4D236BA0.8010002@ti.com>
References: <1294165576-15628-1-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-2-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-3-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-4-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-5-git-send-email-santosh.shilimkar@ti.com>
	<1294165576-15628-6-git-send-email-santosh.shilimkar@ti.com>
	<4D236BA0.8010002@ti.com>
Message-ID: <bd04d3678881a910a0639746ed04043d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Nishanth Menon [mailto:nm at ti.com]
> Sent: Wednesday, January 05, 2011 12:19 AM
> To: Santosh Shilimkar
> Cc: linux-omap at vger.kernel.org; khilman at ti.com; tony at atomide.com;
> linux-arm-kernel at lists.infradead.org; Thara Gopinath; Kevin Hilman
> Subject: Re: [PATCH 5/5] omap2plus: voltage: Trivial linking fix for
> 'EINVAL' undeclared
>
> Santosh Shilimkar had written, on 01/04/2011 12:26 PM, the
> following:
> > CC      arch/arm/mach-omap2/omap_hwmod_common_data.o
> > In file included from arch/arm/plat-
> omap/include/plat/omap_hwmod.h:38,
> >                  from arch/arm/mach-
> omap2/omap_hwmod_common_data.c:20:
> > arch/arm/plat-omap/include/plat/voltage.h: In function
> 'omap_voltage_late_init':
> > arch/arm/plat-omap/include/plat/voltage.h:145: error: 'EINVAL'
> undeclared (first use in this function)
> > arch/arm/plat-omap/include/plat/voltage.h:145: error: (Each
> undeclared identifier is reported only once
> > arch/arm/plat-omap/include/plat/voltage.h:145: error: for each
> function it appears in.)
> > make[1]: *** [arch/arm/mach-omap2/omap_hwmod_common_data.o] Error
> 1
> > make: *** [arch/arm/mach-omap2] Error 2
> >
> > The error is reported when omap2plus_defconfig built with
> CONFIG_PM disabled
> >
> > Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> > Cc: Thara Gopinath <thara@ti.com>
> > Cc: Kevin Hilman <khilman@deeprootsystems.com>
> > ---
> >  arch/arm/plat-omap/include/plat/voltage.h |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/plat-omap/include/plat/voltage.h
> b/arch/arm/plat-omap/include/plat/voltage.h
> > index c095351..2b776f0 100644
> > --- a/arch/arm/plat-omap/include/plat/voltage.h
> > +++ b/arch/arm/plat-omap/include/plat/voltage.h
> > @@ -14,6 +14,8 @@
> >  #ifndef __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> >  #define __ARCH_ARM_MACH_OMAP2_VOLTAGE_H
> >
> > +#include <linux/err.h>
> > +
>
> Not sure if this is better OR including the err.h in c files is
> better,
> since the c file is the location where the error code is actually
> used..
>
> but no strong feelings about either personally.
>
The error is because of 'EINVAL' usage in header file. How
Will this error get fixed by including err.h is C file ?
