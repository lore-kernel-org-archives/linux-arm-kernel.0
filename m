From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 9 May 2012 14:54:10 +0200
Subject: ARM: ux500: !CONFIG_OF build error drivers/gpio/gpio-nomadik.c
In-Reply-To: <201205071551.17327.arnd@arndb.de>
References: <201205071551.17327.arnd@arndb.de>
Message-ID: <CACRpkdYa1PcLjOFemsE_LabYqyKhF+wfUCTCCsTpd0=2-gQZWg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 5:51 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> a60b57e "ddrivers/gpio: gpio-nomadik: Add support for irqdomains" broke
> building with CONFIG_OF_GPIO disabled.
>
> Without this patch, building nhk8815_defconfig results in:
>
> /home/arnd/linux-arm/drivers/gpio/gpio-nomadik.c: In function 'nmk_gpio_probe':
> /home/arnd/linux-arm/drivers/gpio/gpio-nomadik.c:1238:6: error: 'struct gpio_chip' has no member named 'of_node'
> make[3]: *** [drivers/gpio/gpio-nomadik.o] Error 1
> make[2]: *** [drivers/gpio] Error 2
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [drivers] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [sub-make] Error 2
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If I hear no complaints, I'd like to apply this patch on the ux500/gpio branch.

Sure! However I'm floating some patch moving gpio/gpio-nomadik.c to
pinctrl/pinctrl-nomadik.c so prepare to handle that merge conflict when
pulling that in.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
