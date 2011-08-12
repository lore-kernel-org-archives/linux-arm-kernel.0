From: shawn.guo@freescale.com (Shawn Guo)
Date: Fri, 12 Aug 2011 16:25:39 +0800
Subject: [PATCH 2/6] arm/imx: remove the uses of gpio_to_irq()
In-Reply-To: <20110812082211.GD6618@S2100-06.ap.freescale.net>
References: <1313135701-22456-1-git-send-email-shawn.guo@linaro.org>
	<1313135701-22456-3-git-send-email-shawn.guo@linaro.org>
	<20110812080000.GF4775@n2100.arm.linux.org.uk>
	<20110812082211.GD6618@S2100-06.ap.freescale.net>
Message-ID: <20110812082538.GF6618@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 12, 2011 at 04:22:12PM +0800, Shawn Guo wrote:
> On Fri, Aug 12, 2011 at 09:00:00AM +0100, Russell King - ARM Linux wrote:
> > On Fri, Aug 12, 2011 at 03:54:57PM +0800, Shawn Guo wrote:
> > > gpio_to_irq() is too generic to be defined and used by i.mx platform
> > > code.  The patch defines IMX_GPIO_TO_IRQ() in mach/hardware.h and
> > > replaces all the uses of gpio_to_irq() with IMX_GPIO_TO_IRQ().
> > 
> > That makes no sense.  Why not continue to use gpio_to_irq() but provide
> > the .to_irq method in your gpiolib driver so it can work, and use that
> > in the places where its used at runtime?
> > 
> I did provide .to_irq in patch #3. 
> 
> > (You won't be able to use it for static initialization obviously.)
> > 
> All users of gpio_to_irq() in platform codes are static initialization.

Sorry, not all but most.

> And IMX_GPIO_TO_IRQ() is actually a renaming of gpio_to_irq().  Only
> difference there is naming and place change, which I think is good, no?
> 

But adding IMX namespace is still worth of the LOC changes?

-- 
Regards,
Shawn
