From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 17 Jun 2013 08:27:30 +0200
Subject: [PATCH] gpio/omap: omap_gpio_init_context stub must be inline
In-Reply-To: <2942784.trumtc2GjZ@wuerfel>
References: <2942784.trumtc2GjZ@wuerfel>
Message-ID: <CACRpkdYUXAgK24aUkCXR1wdPNTDvJ6c-i7tqYUQ=6EZPY2a-WQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 31, 2013 at 5:59 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The bug fix 352a2d5bf "gpio/omap: ensure gpio context is initialised"
> has caused a new warning for omap1_defconfig:
>
> drivers/gpio/gpio-omap.c:1465:13: warning: 'omap_gpio_init_context' defined but not used [-Wunused-function]
>  static void omap_gpio_init_context(struct gpio_bank *p) {}
>              ^
>
> The solution is to mark the stub function as 'static inline' so
> it gets left out of the build when unused.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied with Tony's and Santosh's ACKs.

Yours,
Linus Walleij
