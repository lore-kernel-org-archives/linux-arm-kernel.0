From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Sun, 14 Jan 2018 11:42:57 +0100 (CET)
Subject: [PATCH v2 3/4] gpio: raspberrypi-exp: Driver for RPi3 GPIO
 expander via mailbox service
In-Reply-To: <20180114060840.ychhndc7ukulrbpe@sapphire.tkos.co.il>
References: <cover.1515698418.git.baruch@tkos.co.il>
 <35b07d1aae959c357d671f5530311320d0f10cc8.1515698418.git.baruch@tkos.co.il>
 <1313448378.43279.1515839595810@email.1und1.de>
 <20180114060840.ychhndc7ukulrbpe@sapphire.tkos.co.il>
Message-ID: <683751625.49637.1515926577491@email.1und1.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Baruch,

> Baruch Siach <baruch@tkos.co.il> hat am 14. Januar 2018 um 07:08 geschrieben:
> 
> 
> Hi Stefan,
> 
> Thanks for reviewing. Please find below a few questions.
> 
> On Sat, Jan 13, 2018 at 11:33:15AM +0100, Stefan Wahren wrote: 
> > > +	default RASPBERRYPI_FIRMWARE
> > > +	depends on OF_GPIO && RASPBERRYPI_FIRMWARE && \
> > > +		(ARCH_BCM2835 || COMPILE_TEST)
> > 
> > Since this is default on RASPBERRYPI_FIRMWARE, we could remove it from the dependencies.
> 
> This driver does not work when RASPBERRYPI_FIRMWARE is not enabled. So the 
> driver should not be selectable, regardless of its default enable/disable 
> state.

I know. My idea was to increase build test coverage. Nevertheless the more common style would be:

depends on ARCH_BCM2835 || COMPILE_TEST
depends on OF_GPIO && RASPBERRYPI_FIRMWARE

> 
> > > +	help
> > > +	  Turn on GPIO support for the expander on Raspberry Pi 3 boards, using
> > > +	  the firmware mailbox to communicate with VideoCore on BCM283x chips.
> > > +
> 
> [...]
> 
> > > --- /dev/null
> > > +++ b/drivers/gpio/gpio-raspberrypi-exp.c
> > > @@ -0,0 +1,258 @@
> > > +// SPDX-License-Identifier: GPL-2.0+
> > > +/*
> > > + *  Raspberry Pi 3 expander GPIO driver
> > > + *
> > > + *  Uses the firmware mailbox service to communicate with the
> > > + *  GPIO expander on the VPU.
> > > + *
> > > + *  Copyright (C) 2017 Raspberry Pi Trading Ltd.
> > 
> > 2018?
> 
> Why? Raspberry Pi Trading Ltd added no code to this driver in 2018.

Sure. Don't you want to add your copyright?

> 
> [...]
> 
> > > +static struct platform_driver rpi_exp_gpio_driver = {
> > > +	.driver	= {
> > > +		.name		= MODULE_NAME,
> > > +		.owner		= THIS_MODULE,
> > 
> > Please drop this, too.
> 
> Why? Recent GPIO drivers include this line.

I don't know which driver your are referring to, but platform driver doesn't need this.

Please grep for all platform_driver in gpio and you won't see any setting of ownership. I'm not speaking about the gpiochip.

Btw my replies to #2 and #4 got blocked, should i try to resend it to you.

Thanks
Stefan

> I have seen no commits removing 
> .owner from GPIO drivers in mainline or in current development tree.
> 
> baruch
> 
> -- 
>      http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
> =}------------------------------------------------ooO--U--Ooo------------{=
>    - baruch at tkos.co.il - tel: +972.2.679.5364, http://www.tkos.co.il -
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
