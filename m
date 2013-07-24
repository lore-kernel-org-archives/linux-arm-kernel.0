From: kgene@kernel.org (Kukjin Kim)
Date: Wed, 24 Jul 2013 15:20:57 +0900
Subject: [PATCH v3 1/1] ARM: EXYNOS: Update CONFIG_ARCH_NR_GPIO for Exynos
In-Reply-To: <1374636693-32336-1-git-send-email-sachin.kamat@linaro.org>
References: <1374636693-32336-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <0e4301ce8835$f5bef5e0$e13ce1a0$@org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> With the recent cleanup in Exynos platform code notably commits
> 17859bec ("ARM: EXYNOS: Do not select legacy Kconfig symbols any
> more") and b9222210 ("ARM: EXYNOS: Remove mach/gpio.h"), the definition
> of ARCH_NR_GPIOS got removed. This started causing problems on SoCs like
> Exynos4412 which have more than the default number of GPIOs. Thus define
> this number in KConfig file which takes care of current SoC requirements
> and provides scope for GPIO expanders. Without this patch we get the
> following
> errors during boot:
> 
> gpiochip_add: gpios 251..258 (gpv0) failed to register
> samsung-pinctrl 106e0000.pinctrl: failed to register gpio_chip gpv0,
> error code: -22
> samsung-pinctrl: probe of 106e0000.pinctrl failed with error -22
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Tomasz Figa <t.figa@samsung.com>
> ---
> Changes since v2:
> Changed the default number to 512 to accomodate GPIO exapnders.
> ---
>  arch/arm/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index ccc388d..b3c4fa4 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -1601,6 +1601,7 @@ config ARCH_NR_GPIO
>  	int
>  	default 1024 if ARCH_SHMOBILE || ARCH_TEGRA
>  	default 512 if SOC_OMAP5
> +	default 512 if ARCH_EXYNOS
>  	default 512 if ARCH_KEYSTONE

+	default 512 if ARCH_EXYNOS || ARCH_KEYSTONE || SOC_OMAP5 ?

Thanks,
Kukjin

>  	default 392 if ARCH_U8500
>  	default 352 if ARCH_VT8500
> --
> 1.7.9.5
