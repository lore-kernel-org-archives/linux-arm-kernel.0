From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 28 Apr 2011 09:07:33 +0200
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <0D753D10438DA54287A00B027084269764D2650215@AUSP01VMBX24.collaborationhost.net>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
	<0D753D10438DA54287A00B027084269764D2650215@AUSP01VMBX24.collaborationhost.net>
Message-ID: <BANLkTikc7B5J0Z_aiS5kXCxMSxcFrfSRxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/27 H Hartley Sweeten <hartleys@visionengravers.com>:
> On Wednesday, April 27, 2011 6:13 AM, Linus Walleij wrote:
>> From: Linus Walleij <linus.walleij@linaro.org>
>>
>> This rewrites the U300 GPIO driver using gpiolib and the irq_chip
>> abstractions, makes it runtime-configured rather than compile-time,
>> and moves it to the drivers/gpio subsystem where it belongs,
>> depopulating the ARM tree of one more driver.
>>
>> Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
> If this and other platform-specific GPIO drivers are going to be
> moved to the drivers/gpio subsystem, the Kconfig and Makefile should
> probably be updated to reflect this.
>
> In drivers/gpio/Kconfig:
>
> #
> # platform-neutral GPIO infrastructure and expanders
> #
>
> And in drivers/gpio/Makefile:
>
> # generic gpio support: dedicated expander chips, etc
> #
> # NOTE: platform-specific GPIO drivers don't belong in the
> # drivers/gpio directory; put them with other platform setup
> # code, IRQ controllers, board init, etc.

Yeah, you're right. I can take these comments out, simply.
I'll review the files as bit to make sure there aren't any more
statements like that.

> The Makefile should probably be reordered, either alphabetically
> or grouped by type (arch/mmio/i2c/spi/pci/etc) and then
> alphabetically in order to reduce merge conflicts.

Yes, but if I do that in my patchset I will screw up Grants GPIO tree
completely, so I prefer that Grant do this. And maybe after pulling
in my GPIO consolidation tree to his in that case, so we don't get
undesired collisions. So leaving this for the GPIO maintainer.

Yours,
Linus Walleij
