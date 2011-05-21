From: jamie@jamieiles.com (Jamie Iles)
Date: Sat, 21 May 2011 14:03:02 +0100
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <0D753D10438DA54287A00B027084269764D30C10DC@AUSP01VMBX24.collaborationhost.net>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<20110519085638.GA26816@S2100-06.ap.freescale.net>
	<BANLkTinD9rAipfwNnh6QpgbcogckdtQ=OQ@mail.gmail.com>
	<20110519135631.GB26816@S2100-06.ap.freescale.net>
	<20110519191156.GE2429@pengutronix.de>
	<0D753D10438DA54287A00B027084269764D3045B3B@AUSP01VMBX24.collaborationhost.net>
	<20110520015022.GA3095@pulham.picochip.com>
	<0D753D10438DA54287A00B027084269764D30C10DC@AUSP01VMBX24.collaborationhost.net>
Message-ID: <20110521130302.GA4111@pulham.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 20, 2011 at 05:07:12PM -0500, H Hartley Sweeten wrote:
> On Thursday, May 19, 2011 6:50 PM, Jamie Iles wrote:
> > diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> > index becef59..aa9e97f 100644
> > --- a/drivers/gpio/Makefile
> > +++ b/drivers/gpio/Makefile
> > @@ -10,6 +10,7 @@ obj-$(CONFIG_GPIOLIB)         += gpiolib.o
> >  
> >  obj-$(CONFIG_GPIO_ADP5520)     += adp5520-gpio.o
> >  obj-$(CONFIG_GPIO_ADP5588)     += adp5588-gpio.o
> > +obj-$(CONFIG_GPIO_BASIC_MMIO_CORE)     += basic_mmio_gpio.o
> >  obj-$(CONFIG_GPIO_BASIC_MMIO)  += basic_mmio_gpio.o
> 
> I think the line above should be removed.  GPIO_BASIC_MMIO selects
> GPIO_BASIC_MMIO_CORE so the line you added previous to it will cause
> basic_mmio_gpio to be compiled.
> 
> GPIO_BASIC_MMIO is really just used in the driver to enable the code
> at the end which creates the generic gbpio_driver.

Yes, well spotted.  I'll create a patch to remove this.

Jamie
