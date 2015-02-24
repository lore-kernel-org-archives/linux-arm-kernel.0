From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 Feb 2015 09:31:41 +0100
Subject: [PATCH v4 1/8] arm64: exynos5433: Enable ARMv8 based Exynos5433
 (SoC) support
In-Reply-To: <1424755011-15999-2-git-send-email-cw00.choi@samsung.com>
References: <1424755011-15999-1-git-send-email-cw00.choi@samsung.com>
 <1424755011-15999-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <8838911.kfOYZxBsJP@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 February 2015 14:16:44 Chanwoo Choi wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 1b8e973..d83cea0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -154,6 +154,17 @@ config ARCH_EXYNOS
>         help
>           This enables support for Samsung Exynos SoC family
>  
> +config ARCH_EXYNOS5433
> +       bool "ARMv8 based Samsung Exynos5433"
> +       select ARCH_EXYNOS
> +       select COMMON_CLK_SAMSUNG
> +       select HAVE_S3C_RTC if RTC_CLASS
> +       select PINCTRL
> +       select PINCTRL_EXYNOS
> +
> +       help
> +         This enables support for Samsung Exynos5433 SoC family
> +
>  config ARCH_EXYNOS7
>         bool "ARMv8 based Samsung Exynos7"
>         select ARCH_EXYNOS
> -- 
> 

Can we collapse all these entries into one for EXYNOS? I don't
want to end up with endless lists like we have on arm32 when
there is no platform specific code that is actually controlled
by this anway.

	Arnd
