From: heiko@sntech.de (Heiko =?iso-8859-15?q?St=FCbner?=)
Date: Fri, 13 Dec 2013 08:57:23 +0100
Subject: [PATCH 1/2] ARM: s3c24xx: get rid of custom <mach/gpio.h>
In-Reply-To: <1386857210-4944-1-git-send-email-linus.walleij@linaro.org>
References: <1386857210-4944-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <201312130857.23890.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 12. Dezember 2013, 15:06:50 schrieb Linus Walleij:
> This isolates the custom S3C24xx GPIO definition table to
> <linux/platform_data/gpio-samsung-s3x24xx.h> as this is
> used in a few different places in the kernel, removing the
> need to depend on the implicit inclusion of <mach/gpio.h>
> from <linux/gpio.h> and thus getting rid of a few nasty
> cross-dependencies.
> 
> We also delete the nifty CONFIG_S3C24XX_GPIO_EXTRA stuff.
> The biggest this can ever be for the S3C24XX is
> CONFIG_S3C24XX_GPIO_EXTRA = 128, and then for CPU_S3C2443 or
> CPU_S3C2416 32*12 GPIOs are added, so 32*12+128 = 512
> is the absolute roof value on this platform. So we set
> the size of ARCH_NR_GPIO to this and the GPIOs array will
> fit any S3C24XX platform, as per pattern from other archs.
> 
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Cc: Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> Cc: Kukjin Kim <kgene.kim@samsung.com>
> Cc: linux-samsung-soc at vger.kernel.org
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Added an #ifdef ARCH_S3C24XX around the header inclusion
>   in drivers/gpio/gpio-samsung.c as we would otherwise
>   have colliding definitions when compiling S3C64XX.
> - Rename inclusion guard in the header file.
> 
> If one of the maintainers give me an ACK for this I will
> take it through the GPIO tree.
> ---

I'm not the maintainer of s3c24xx, but this looks nice ;-)

Acked-by: Heiko Stuebner <heiko@sntech.de>
