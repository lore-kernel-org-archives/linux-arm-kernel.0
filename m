From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Apr 2012 18:49:25 +0100
Subject: device-tree vs gpio-leds gpio_blink_set
In-Reply-To: <201204231122.43481.arnd@arndb.de>
References: <20120423072745.678323582@rtp-net.org>
 <201204231122.43481.arnd@arndb.de>
Message-ID: <20120423174924.GA457@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 23, 2012 at 11:22:43AM +0000, Arnd Bergmann wrote:
> On Monday 23 April 2012, Arnaud Patard wrote:

> > Does anyone know how to solve that ?

> One way to solve it would be to add a blink function to gpiolib so
> that the gpio-led driver can access it through a common wrapper
> and we can make the orion_gpio_set_blink() function a pointer in
> the gpio_chip structure rather than an export from
> arch/arm/plat-orion/gpio.c. I've put a few people on Cc that might
> have an opion on this.

Another idea would be to use pinctrl and represent the blink as a
special function.  Not sure that's sensible though.
