From: olof@lixom.net (Olof Johansson)
Date: Wed, 1 Feb 2012 00:53:12 -0800
Subject: [PATCH 3/9] ARM: EXYNOS: add initial setup-i2c0 for EXYNOS5
In-Reply-To: <1328024354-4277-4-git-send-email-kgene.kim@samsung.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAOesGMg3xS7o1+F1ZmZvg1=oy59F+7QnSYWkJ9kTacCDu35aOg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 31, 2012 at 7:39 AM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>

A brief patch description, please.

> diff --git a/arch/arm/mach-exynos/setup-i2c0.c b/arch/arm/mach-exynos/setup-i2c0.c
> index d395bd1..3244f3e 100644
> --- a/arch/arm/mach-exynos/setup-i2c0.c
> +++ b/arch/arm/mach-exynos/setup-i2c0.c
> @@ -1,7 +1,7 @@
> ?/*
> - * linux/arch/arm/mach-exynos4/setup-i2c0.c
> + * linux/arch/arm/mach-exynos/setup-i2c0.c

The file name fills very little purpose in files like these. Consider
removing them at some point.

> @@ -18,9 +18,14 @@ struct platform_device; /* don't need the contents */
> ?#include <linux/gpio.h>
> ?#include <plat/iic.h>
> ?#include <plat/gpio-cfg.h>
> +#include <plat/cpu.h>
>
> ?void s3c_i2c0_cfg_gpio(struct platform_device *dev)
> ?{
> - ? ? ? s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
> - ? ? ? ? ? ? ? ? ? ? ? ? ? ? S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> + ? ? ? if (soc_is_exynos5250())
> + ? ? ? ? ? ? ? ;
> + ? ? ? ? ? ? ? /* will be implemented with gpio function */
> + ? ? ? else
> + ? ? ? ? ? ? ? s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> ?}

The above is pretty awkward. It's cleaner to return and avoid the else
side of the statement (move the comment accordingly, of course).


-Olof
