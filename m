From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 17 Aug 2011 08:47:37 +0200
Subject: [PATCH v2 0/8] Clean up MXC and MXS mach/gpio.h
In-Reply-To: <20110817062539.GC10037@S2100-06.ap.freescale.net>
References: <1313252047-8820-1-git-send-email-shawn.guo@linaro.org>
	<20110816071950.GV31404@pengutronix.de>
	<20110817062539.GC10037@S2100-06.ap.freescale.net>
Message-ID: <20110817064737.GC31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 17, 2011 at 02:25:40PM +0800, Shawn Guo wrote:
> On Tue, Aug 16, 2011 at 09:19:50AM +0200, Sascha Hauer wrote:
> > Shawn,
> > 
> > On Sun, Aug 14, 2011 at 12:13:59AM +0800, Shawn Guo wrote:
> > > As one step to single image for multiple platforms, mach/gpio.h needs
> > > to be removed from asm/gpio.h.  The patch set cleans up MXC and MXS
> > > mach/gpio.h to an empty header.
> > > 
> > > It's based on v3.1-rc1 plus rmk's patch series below.
> > > 
> > >   [PATCH 00/13] Clean up mach/gpio.h headers
> > > 
> > > The Ben's fix is on the way to -rc2 through arm-soc tree.
> > > 
> > > Grant, Sascha,
> > > 
> > > Can you please review the series and give comments or your ack tag?
> > 
> > I'm fine with this series. I removed the dependency on rmks patches
> > (can be easily merged later) and checked it into my cleanup branch.
> > Please check if you are fine with the result.
> > 
> It looks all good in terms of code.  But the commit messages of the
> following patches do not fit the context any more.

Yes, you are right. Changed it to the following

> 
>   arm/mxc: remove gpio_to_irq() from mach/gpio.h

    arm/mxc: use gpiolib helper for gpio_to_irq
    
    As all the users of gpio_to_irq() in static initializers have been
    migrated to IMX_GPIO_TO_IRQ, we can start using the standard gpiolib
    helper for gpio_to_irq().

>   arm/mxc: move IMX_GPIO_NR into mach/hardware.h

    arm/mxc: move IMX_GPIO_NR into mach/hardware.h
    
    The patch moves IMX_GPIO_NR into mach/hardware.h, so that we only
    use standard gpiolib helpers in mach/gpio.h.

>   arm/mxs: move MXS_GPIO_NR into mach/mxs.h

    arm/mxs: move MXS_GPIO_NR into mach/mxs.h
    
    The patch moves MXS_GPIO_NR into mach/mxs.h, so that we only use
    standard gpiolib helpers in mach/gpio.h.


Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
