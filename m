From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Wed, 27 Apr 2011 13:23:37 -0500
Subject: [PATCH 02/10] mach-u300: rewrite gpio driver, move to drivers/gpio
In-Reply-To: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
References: <1303910002-3333-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <0D753D10438DA54287A00B027084269764D2650215@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 27, 2011 6:13 AM, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
>
> This rewrites the U300 GPIO driver using gpiolib and the irq_chip
> abstractions, makes it runtime-configured rather than compile-time,
> and moves it to the drivers/gpio subsystem where it belongs,
> depopulating the ARM tree of one more driver.
>
> Cc: Jonas Aaberg <jonas.aberg@stericsson.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

If this and other platform-specific GPIO drivers are going to be
moved to the drivers/gpio subsystem, the Kconfig and Makefile should
probably be updated to reflect this.

In drivers/gpio/Kconfig:

#
# platform-neutral GPIO infrastructure and expanders
#

And in drivers/gpio/Makefile:

# generic gpio support: dedicated expander chips, etc
#
# NOTE: platform-specific GPIO drivers don't belong in the
# drivers/gpio directory; put them with other platform setup
# code, IRQ controllers, board init, etc.

The Makefile should probably be reordered, either alphabetically
or grouped by type (arch/mmio/i2c/spi/pci/etc) and then
alphabetically in order to reduce merge conflicts.

Regards,
Hartley
