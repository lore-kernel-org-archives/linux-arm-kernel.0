From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Tue, 12 Apr 2011 19:06:20 +0400
Subject: [RFC PATCH 0/5] Convert some ARM platforms to basic-mmio-gpio
In-Reply-To: <20110411144928.GL18601@pengutronix.de>
References: <1302522502-24381-1-git-send-email-jamie@jamieiles.com>
	<20110411134320.GJ18601@pengutronix.de>
	<20110411135215.GD2818@pulham.picochip.com>
	<20110411142307.GK18601@pengutronix.de>
	<20110411143327.GA21449@pulham.picochip.com>
	<20110411144928.GL18601@pengutronix.de>
Message-ID: <20110412150620.GB8931@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 11, 2011 at 04:49:28PM +0200, Uwe Kleine-K?nig wrote:
[...]
> > Hmm, so this looks like it's because mxc_gpio_init() is being called 
> > from init_IRQ which is too early for platform devices.  Is there a 
> > suitable place where this can be called later in the boot process?  I 
> > guess the gpio irq stuff should remain where it is but the 
> > platform_device registration should be moved to later.
> I guess this means that using gpios in .init_machine (== arch_initcall
> time) stops working then?

Probably it's a bad sign for a platform if it wants to use it
that early (i.e. like init_IRQ).

But as GPIOs is quite essential part of an embedded system, and
some platform code might actually need it, I guess having the stuff
available in arch_initcall would be fine though (assuming
basic_mmio_gpio will be changed to use postcore_initcall).

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
