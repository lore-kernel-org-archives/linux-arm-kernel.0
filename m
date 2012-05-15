From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 15 May 2012 14:26:28 +0200
Subject: [PATCH 00/12] pinctrl for Ux500 and Nomadik family
In-Reply-To: <201205151124.13047.arnd@arndb.de>
References: <1336470214-23407-1-git-send-email-linus.walleij@stericsson.com>
 <201205151124.13047.arnd@arndb.de>
Message-ID: <CACRpkdZrs=rgfadRCcMYxhwqib96vkRdHCoC-27dyAjEu5Y5Ew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2012 at 1:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> I get build errors with nhk8815_defconfig after this:
>
> arch/arm/mach-nomadik/built-in.o: In function `nhk8815_eth_init':
> /home/arnd/linux-arm/arch/arm/mach-nomadik/board-nhk8815.c:224: undefined reference to `nmk_gpio_set_mode'
> arch/arm/mach-nomadik/built-in.o: In function `nhk8815_i2c_init':
> /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:46: undefined reference to `nmk_gpio_set_mode'
> /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:47: undefined reference to `nmk_gpio_set_mode'
> /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:50: undefined reference to `nmk_gpio_set_mode'
> /home/arnd/linux-arm/arch/arm/mach-nomadik/i2c-8815nhk.c:51: undefined reference to `nmk_gpio_set_mode'
>
> Here is my suggested fix:

This looks perfect Arnd, thanks for fixing this!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

I plan to migrate also the Nomadik to pinctrl and delete the old open-coded
interfaces in the driver for the next kernel cycle.

Yours,
Linus Walleij
