From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 9 May 2014 09:48:00 +0200
Subject: [PATCH] gpio: always enable GPIO_OMAP on ARCH_OMAP
In-Reply-To: <5523458.JVZJJObMjC@wuerfel>
References: <5523458.JVZJJObMjC@wuerfel>
Message-ID: <CACRpkdYD+mSgkbUM+NXd9LQY+auTQMnvHFf7BZw_PUKbReYNcQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 28, 2014 at 11:07 AM, Arnd Bergmann <arnd@arndb.de> wrote:

> Commit 4df42de9d3e "gpio: omap: add a GPIO_OMAP option instead of using
> ARCH_OMAP" made it possible to build OMAP kernels without the GPIO driver,
> which at least on OMAP2 and OMAP3 causes build errors because of functions
> used by the platform power management code:
>
> arch/arm/mach-omap2/built-in.o: In function `omap_sram_idle':
> arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_prepare_for_idle'
> arch/arm/mach-omap2/pm24xx.c:129: undefined reference to `omap2_gpio_resume_after_idle'
>
> We presumably always want the GPIO driver on OMAP, so this adds a slightly
> broader dependency and only allows disabling the driver only when no
> OMAP2PLUS platform is selected.
>
> However, it seems entirely reasonable to include the driver in build tests
> on other platforms, so we should also allow building it for COMPILE_TEST
> builds and select the required GENERIC_IRQ_CHIP that may not already be
> enabled on other platforms.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to my devel branch, this is not a fix to Torvalds HEAD
AFAICT, but a fix to v3.16? Else poke me.

Yours,
Linus Walleij
