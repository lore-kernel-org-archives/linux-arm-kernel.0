From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 11 Jan 2017 16:47:46 +0100
Subject: [PATCH] gpio: mvebu: fix warning when building on 64-bit
In-Reply-To: <E1cR5IG-0008Gw-HV@rmk-PC.armlinux.org.uk>
References: <E1cR5IG-0008Gw-HV@rmk-PC.armlinux.org.uk>
Message-ID: <CACRpkdZ_LciV5a5Sj+YfGtfws2hvdSjscx0tu4=1RNYTXWU4gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 10, 2017 at 11:53 PM, Russell King
<rmk+kernel@armlinux.org.uk> wrote:

> Casting a pointer to an int is not portable, and provokes a compiler
> warning.  Cast to unsigned long instead to avoid the warning.
>
> drivers/gpio/gpio-mvebu.c: In function 'mvebu_gpio_probe':
> drivers/gpio/gpio-mvebu.c:662:17: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
>    soc_variant = (int) match->data;
>                  ^
>
> This will be needed when building gpio-mvebu for Armada 7k/8k ARM64
> SoCs.
>
> Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> ---
> Linus,
>
> I don't think this is necessary to push into -rc, as its not yet used
> on ARM64 - GPIO support is not yet present in the DTS files, and the
> Kconfig doesn't allow the driver to be built on ARM64.  Hence, please
> queue for the next merge window as a low priority fix.

Fair enough, queued for next. Thanks!

Yours,
Linus Walleij
