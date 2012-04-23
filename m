From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Apr 2012 11:22:43 +0000
Subject: device-tree vs gpio-leds gpio_blink_set
In-Reply-To: <20120423072745.678323582@rtp-net.org>
References: <20120423072745.678323582@rtp-net.org>
Message-ID: <201204231122.43481.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 April 2012, Arnaud Patard wrote:
> The kirkwood/orion gpio have a bit that allows "gpio blinking" (I think
> it a square signal but the manual doesn't say it clearly) and it's used
> on dns323 and iconnect. When trying to use DT to declare the leds-gpio
> stuff, I've noticed that there's no way clearly documented to set the
> gpio_blink_set() hook. In fact, it even looks like it's not supported at
> all, which seems to be a regression compared to non-DT support.

Yes, that seems to be correct. You are only the third person using
gpio-led with blinking, aside from two uses in s3c24xx, and they
don't support DT either yet.

> Does anyone know how to solve that ?

One way to solve it would be to add a blink function to gpiolib so
that the gpio-led driver can access it through a common wrapper
and we can make the orion_gpio_set_blink() function a pointer in
the gpio_chip structure rather than an export from
arch/arm/plat-orion/gpio.c. I've put a few people on Cc that might
have an opion on this.

	Arnd
