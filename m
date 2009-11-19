From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Nov 2009 09:13:23 +0000
Subject: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
In-Reply-To: <7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
References: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
	<7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
Message-ID: <20091119091323.GD13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 19, 2009 at 05:04:14PM +0800, Jun Nie wrote:
> > diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> > index dbd8cfd..15e64b4 100644
> > --- a/arch/arm/mach-mmp/ttc_dkb.c
> > +++ b/arch/arm/mach-mmp/ttc_dkb.c
> > @@ -14,6 +14,8 @@
> > ?#include <linux/mtd/mtd.h>
> > ?#include <linux/mtd/partitions.h>
> > ?#include <linux/mtd/onenand.h>
> > +#include <linux/delay.h>
> > +#include <video/pxa168fb.h>
> >
> > ?#include <asm/mach-types.h>
> > ?#include <asm/mach/arch.h>
> > @@ -21,6 +23,7 @@
> > ?#include <mach/addr-map.h>
> > ?#include <mach/mfp-pxa910.h>
> > ?#include <mach/pxa910.h>
> > +#include <mach/gpio.h>

linux/gpio.h please.
