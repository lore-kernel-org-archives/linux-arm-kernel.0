From: kmpark@infradead.org (Kyungmin Park)
Date: Wed, 1 Feb 2012 13:10:14 +0900
Subject: [PATCH 3/9] ARM: EXYNOS: add initial setup-i2c0 for EXYNOS5
In-Reply-To: <1328024354-4277-4-git-send-email-kgene.kim@samsung.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-4-git-send-email-kgene.kim@samsung.com>
Message-ID: <CAH9JG2UAPO6wfEaoTfOvu53x3whkLBjcM45SV4m7Pf4su7Gn2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2/1/12, Kukjin Kim <kgene.kim@samsung.com> wrote:
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/mach-exynos/Makefile     |    2 +-
>  arch/arm/mach-exynos/setup-i2c0.c |   13 +++++++++----
>  2 files changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-exynos/Makefile b/arch/arm/mach-exynos/Makefile
> index 995e7cc..2117f02 100644
> --- a/arch/arm/mach-exynos/Makefile
> +++ b/arch/arm/mach-exynos/Makefile
> @@ -52,7 +52,7 @@ obj-$(CONFIG_EXYNOS4_DEV_DWMCI)		+= dev-dwmci.o
>  obj-$(CONFIG_EXYNOS4_DEV_DMA)		+= dma.o
>  obj-$(CONFIG_EXYNOS4_DEV_USB_OHCI)	+= dev-ohci.o
>
> -obj-$(CONFIG_ARCH_EXYNOS4)		+= setup-i2c0.o
> +obj-$(CONFIG_ARCH_EXYNOS)		+= setup-i2c0.o
>  obj-$(CONFIG_EXYNOS4_SETUP_FIMC)	+= setup-fimc.o
>  obj-$(CONFIG_EXYNOS4_SETUP_FIMD0)	+= setup-fimd0.o
>  obj-$(CONFIG_EXYNOS4_SETUP_I2C1)	+= setup-i2c1.o
> diff --git a/arch/arm/mach-exynos/setup-i2c0.c
> b/arch/arm/mach-exynos/setup-i2c0.c
> index d395bd1..3244f3e 100644
> --- a/arch/arm/mach-exynos/setup-i2c0.c
> +++ b/arch/arm/mach-exynos/setup-i2c0.c
> @@ -1,7 +1,7 @@
>  /*
> - * linux/arch/arm/mach-exynos4/setup-i2c0.c
> + * linux/arch/arm/mach-exynos/setup-i2c0.c
>   *
> - * Copyright (c) 2009-2010 Samsung Electronics Co., Ltd.
> + * Copyright (c) 2009-2012 Samsung Electronics Co., Ltd.
>   *		http://www.samsung.com/
>   *
>   * I2C0 GPIO configuration.
> @@ -18,9 +18,14 @@ struct platform_device; /* don't need the contents */
>  #include <linux/gpio.h>
>  #include <plat/iic.h>
>  #include <plat/gpio-cfg.h>
> +#include <plat/cpu.h>
>
>  void s3c_i2c0_cfg_gpio(struct platform_device *dev)
>  {
> -	s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
> -			      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
> +	if (soc_is_exynos5250())
> +		;
> +		/* will be implemented with gpio function */
Do you want to include both exynos4-gpio and exynos5-gpio?
> +	else
> +		s3c_gpio_cfgall_range(EXYNOS4_GPD1(0), 2,
> +				      S3C_GPIO_SFN(2), S3C_GPIO_PULL_UP);
>  }
> --
> 1.7.4.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc"
> in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
