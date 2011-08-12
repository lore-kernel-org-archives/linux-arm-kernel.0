From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 12 Aug 2011 16:23:08 +0800
Subject: [PATCH 6/6] arm/mxc: move IMX_GPIO_NR into mach/hardware.h
In-Reply-To: <20110812080240.GG4775@n2100.arm.linux.org.uk>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
	<1313135701-22456-7-git-send-email-shawn.guo@linaro.org>
	<20110812080240.GG4775@n2100.arm.linux.org.uk>
Message-ID: <20110812082307.GE6618@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 09:02:40AM +0100, Russell King - ARM Linux wrote:
> On Fri, Aug 12, 2011 at 03:55:01PM +0800, Shawn Guo wrote:
> > The patch moves IMX_GPIO_NR into mach/hardware.h, so that mach/gpio.h
> > becomes an empty header and can wait for a global removal from
> > asm/gpio.h.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > ---
> >  arch/arm/plat-mxc/include/mach/gpio.h     |    8 --------
> >  arch/arm/plat-mxc/include/mach/hardware.h |    4 ++++
> >  2 files changed, 4 insertions(+), 8 deletions(-)
> > 
> > diff --git a/arch/arm/plat-mxc/include/mach/gpio.h b/arch/arm/plat-mxc/include/mach/gpio.h
> > index 8e5276c..54fe5cb 100644
> > --- a/arch/arm/plat-mxc/include/mach/gpio.h
> > +++ b/arch/arm/plat-mxc/include/mach/gpio.h
> > @@ -19,12 +19,4 @@
> >  #ifndef __ASM_ARCH_MXC_GPIO_H__
> >  #define __ASM_ARCH_MXC_GPIO_H__
> >  
> > -#include <linux/spinlock.h>
> > -#include <mach/hardware.h>
> > -
> > -
> > -/* There's a off-by-one betweem the gpio bank number and the gpiochip */
> > -/* range e.g. GPIO_1_5 is gpio 5 under linux */
> > -#define IMX_GPIO_NR(bank, nr)		(((bank) - 1) * 32 + (nr))
> > -
> >  #endif
> 
> Please also remove the ifndef...endif, replacing it with a single line
> of /* empty */ - this matches what has been done on other SoCs, and will
> make the empty files trivially grep-able.
> 
Ok, will do.

-- 
Regards,
Shawn
