From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 13 Dec 2013 20:38:18 +0100
Subject: [PATCH 2/2 v2] ARM: s3c64xx: get rid of custom <mach/gpio.h>
In-Reply-To: <1386939234-12828-1-git-send-email-linus.walleij@linaro.org>
References: <1386939234-12828-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <10670376.uQQ4Oy6gZV@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Friday 13 of December 2013 13:53:54 Linus Walleij wrote:
> This isolates the custom S3C64xx GPIO definition table to
> <linux/platform_data/gpio-samsung-s3x64xx.h> as this is
> used in a few different places in the kernel, removing the
> need to depend on the implicit inclusion of <mach/gpio.h>
> from <linux/gpio.h> and thus getting rid of a few nasty
> cross-dependencies.
> 
> Also delete the CONFIG_SAMSUNG_GPIO_EXTRA stuff. Instead
> roof the number of GPIOs for this platform:
> First sum up all the GPIO banks from A to Q: 187 GPIOs.
> Add the 16 "board GPIOs" and the roof for SAMSUNG_GPIO_EXTRA,
> 128, so in total maximum 187+16+128 = 331 GPIOs, so let's
> take the same roof as for S3C24XX: 512. This way we can do
> away with the GPIO calculation macros for GPIO_BOARD_START,
> BOARD_NR_GPIOS and the definition of ARCH_NR_GPIOS.
> 
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Tomasz Figa <tomasz.figa@gmail.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Move the movement of the actual gpio.h file into this
>   patch after mistakenly having it end up in the S3C24xx
>   patch.
> - Add a missing ifdef for the pm-gpio.c code in
>   plat-samsung.
> 
> This patch depends on
> "ARM: s3c24xx: get rid of custom <mach/gpio.h>"
> 
> I will take this through the GPIO tree.

[on Mini6410 board]
Tested-by: Tomasz Figa <t.figa@samsung.com>
[for changes in mach-s3c64xx]
Acked-by: Tomasz Figa <t.figa@samsung.com>

Best regards,
Tomasz
