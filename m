From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 15 May 2012 12:46:45 +0000
Subject: [PATCH 00/12] pinctrl for Ux500 and Nomadik family
In-Reply-To: <CACRpkdZrs=rgfadRCcMYxhwqib96vkRdHCoC-27dyAjEu5Y5Ew@mail.gmail.com>
References: <1336470214-23407-1-git-send-email-linus.walleij@stericsson.com>
 <201205151124.13047.arnd@arndb.de>
 <CACRpkdZrs=rgfadRCcMYxhwqib96vkRdHCoC-27dyAjEu5Y5Ew@mail.gmail.com>
Message-ID: <201205151246.45384.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 15 May 2012, Linus Walleij wrote:
> On Tue, May 15, 2012 at 1:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> 
> > I get build errors with nhk8815_defconfig after this:
> >
> > arch/arm/mach-nomadik/built-in.o: In function `nhk8815_eth_init':
> > /home/arnd/linux-arm/arch/arm/mach-nomadik/board-nhk8815.c:224: undefined reference to `nmk_gpio_set_mode'
> > arch/arm/mach-nomadik/built-in.o: In function `nhk8815_i2c_init':
> > /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:46: undefined reference to `nmk_gpio_set_mode'
> > /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:47: undefined reference to `nmk_gpio_set_mode'
> > /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:50: undefined reference to `nmk_gpio_set_mode'
> > /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:51: undefined reference to `nmk_gpio_set_mode'
> >
> > Here is my suggested fix:
> 
> This looks perfect Arnd, thanks for fixing this!
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Ok, applied to next/pinctrl.

On a more general note, how shall we go about merging pinctrl stuff in the
upcoming merge window? We've got a bunch of changes in arm-soc now that depend
on your pinctrl/devel branch, and I want to get as many of my own patches
merged upstream early.

One option would be that you just try to be very early with sending your
branch and arm-soc goes directly after that, another option would be that
we send a pull request for your tree along with the stuff that depends on
it, with your permission.

> I plan to migrate also the Nomadik to pinctrl and delete the old open-coded
> interfaces in the driver for the next kernel cycle.

Sounds good.

	Arnd
