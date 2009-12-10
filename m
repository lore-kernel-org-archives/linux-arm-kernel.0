From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 10 Dec 2009 17:41:27 +0000
Subject: GPIO support for HTC Dream
In-Reply-To: <20091210172458.GJ19454@elf.ucw.cz>
References: <20091208102842.GH12264@elf.ucw.cz>
	<4B1EB57D.6070408@bluewatersys.com>
	<20091208214658.GC4164@elf.ucw.cz>
	<4B1ECEEE.3000209@bluewatersys.com>
	<4B203575.6050407@bluewatersys.com>
	<20091210172458.GJ19454@elf.ucw.cz>
Message-ID: <20091210174127.GA22554@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2009 at 06:24:58PM +0100, Pavel Machek wrote:

> > Further to this, I think it is worth doing the work to make this gpiolib
> > now. Most of the other ARM chips now support gpiolib, so it would seem a
> > bit of a step backwards to start adding new chips which don't. I think
> > that adding the gpiolib support will also cleanup the mess that is
> > register_gpio_chip, since this is all already handled by the gpiolib core.

> I tried going through drivers/gpio/gpiolib.c and it seems to be a lot
> of code -- mostly sysrq interface to userland. I'm not sure how much
> code could be shared... 

Everything in generic_gpio.c could easily be shared, which also gives
you all the standard APIs drivers and userspace expect without having to
reimplement them or ending up with slightly incompatible implementations.
