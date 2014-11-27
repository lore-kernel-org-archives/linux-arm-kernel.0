From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 27 Nov 2014 11:18:39 +0000
Subject: [PATCH 15/19] arm64: exynos5433: Enable ARMv8-based Exynos5433
 SoC support
In-Reply-To: <1417073716-22997-16-git-send-email-cw00.choi@samsung.com>
References: <1417073716-22997-1-git-send-email-cw00.choi@samsung.com>
 <1417073716-22997-16-git-send-email-cw00.choi@samsung.com>
Message-ID: <20141127111839.GD11511@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 27, 2014 at 07:35:12AM +0000, Chanwoo Choi wrote:
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index f4536e0..8a5e8a0 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -152,6 +152,16 @@ config ARCH_EXYNOS
>  	help
>  	  This enables support for Samsung Exynos SoC family
>  
> +config ARCH_EXYNOS5433
> +	bool "ARMv8 based Samsung Exynos5433"
> +	select ARCH_EXYNOS
> +	select COMMON_CLK_SAMSUNG
> +	select PINCTRL
> +	select PINCTRL_EXYNOS
> +
> +	help
> +	  This enables support for Samsung Exynos5433 SoC family

Please update defconfig as well to include this. We aim for the
arm64 defconfig to build all the supported SoCs.

-- 
Catalin
