From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 6 Feb 2014 09:32:59 +0100
Subject: [PATCH] backlight: add PWM dependencies
In-Reply-To: <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
References: <1391518634-6472-1-git-send-email-linus.walleij@linaro.org>
 <000401cf222f$43263b20$c972b160$%han@samsung.com>
 <CACRpkdbB8LFM0Vu8VRo4niqxwxUdS-c5gmmWaxbUTbnLCLZbMA@mail.gmail.com>
 <000101cf2307$97a3c770$c6eb5650$%han@samsung.com>
 <000001cf230c$60ec1ca0$22c455e0$%han@samsung.com>
Message-ID: <CACRpkda6SFeDKftn7he++dbkuqHwMF5M5ZbucmiWfASfJq0GbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 6, 2014 at 8:23 AM, Jingoo Han <jg1.han@samsung.com> wrote:

> In the case of "CONFIG_HAVE_PWM=y && CONFIG_PWM=n", it makes
> the problem.
>
> The HAVE_PWM symbol is only for legacy platforms that provide
> the PWM API without using the generic framework. PXA looks to
> use the generic PWM framework. Then, how about removing
> "select HAVE_PWM" from PXA as below?
>
> --- a/arch/arm/mach-pxa/Kconfig
> +++ b/arch/arm/mach-pxa/Kconfig
> @@ -7,7 +7,6 @@ comment "Intel/Marvell Dev Platforms (sorted by hardware release time)"
>  config MACH_PXA3XX_DT
>         bool "Support PXA3xx platforms from device tree"
>         select CPU_PXA300
> -       select HAVE_PWM
>         select POWER_SUPPLY
>         select PXA3xx
>         select USE_OF
> @@ -23,12 +22,10 @@ config ARCH_LUBBOCK
>
>  config MACH_MAINSTONE
>         bool "Intel HCDDBBVA0 Development Platform (aka Mainstone)"
> -       select HAVE_PWM
>         select PXA27x
>
>  config MACH_ZYLONITE
>         bool
> -       select HAVE_PWM
>         select PXA3xx

Looks like the right solution to me.

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
