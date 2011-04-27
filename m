From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 27 Apr 2011 09:39:47 +0100
Subject: [PATCH v1 3/3]ARM: mmp: support mmc on pxa910 dkb board
In-Reply-To: <BANLkTi=MitQ4R7CTcsrnrQU7wrh=sUWM5Q@mail.gmail.com>
References: <BANLkTin1mbEnZcq53r26nJBfC5YTwK7f1A@mail.gmail.com>
	<BANLkTi=MitQ4R7CTcsrnrQU7wrh=sUWM5Q@mail.gmail.com>
Message-ID: <20110427083947.GJ17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 06:44:39PM +0800, Eric Miao wrote:
> > diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> > index c8a85f1..718b87c 100644
> > --- a/arch/arm/mach-mmp/ttc_dkb.c
> > +++ b/arch/arm/mach-mmp/ttc_dkb.c
> > @@ -17,6 +17,9 @@
> > ?#include <linux/interrupt.h>
> > ?#include <linux/regulator/machine.h>
> > ?#include <linux/regulator/fixed.h>
> > +#include <linux/mmc/sdhci.h>
> > +#include <linux/gpio.h>

Ok.

> > +#include <linux/err.h>
> >
> > ?#include <asm/mach-types.h>
> > ?#include <asm/mach/arch.h>
> > @@ -24,6 +27,7 @@
> > ?#include <mach/addr-map.h>
> > ?#include <mach/mfp-pxa910.h>
> > ?#include <mach/pxa910.h>
> > +#include <mach/gpio.h>

Not ok.  mach/gpio.h is included by asm/gpio.h, which is included by
linux/gpio.h.  You should always include linux/gpio.h rather than its
asm/ or mach/ counterparts in case functionality is moved out of the
architecture-level headers into the architecture-independent headers.
