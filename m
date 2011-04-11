From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 11 Apr 2011 16:13:21 +0100
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <20110411144928.GL18601@pengutronix.de>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<20110411134320.GJ18601@pengutronix.de>
	<20110411135215.GD2818@pulham.picochip.com>
	<20110411142307.GK18601@pengutronix.de>
	<20110411143327.GA21449@pulham.picochip.com>
	<20110411144928.GL18601@pengutronix.de>
Message-ID: <20110411151321.GB21449@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 04:49:28PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Mon, Apr 11, 2011 at 03:33:27PM +0100, Jamie Iles wrote:
> > Hmm, so this looks like it's because mxc_gpio_init() is being called 
> > from init_IRQ which is too early for platform devices.  Is there a 
> > suitable place where this can be called later in the boot process?  
> > I guess the gpio irq stuff should remain where it is but the 
> > platform_device registration should be moved to later.
> I guess this means that using gpios in .init_machine (== arch_initcall
> time) stops working then? Actually I wanted to test if this is broken
> already now because the driver is registered too late.

I've just tried this on my platform and no, the GPIO's won't be 
available for .init_machine().

> Actually my build doesn't even have CONFIG_GPIO_BASIC_MMIO=y. I 
> suggest to let the converted platforms select it.

OK, that sounds like a good plan.

Jamie
