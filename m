From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Wed, 15 Mar 2017 09:55:30 +0900
Subject: [PATCH v2 3/3] arm64: exynos: Enable Exynos PMU and PM domains
 drivers
In-Reply-To: <20170314171028.20337-4-krzk@kernel.org>
References: <20170314171028.20337-1-krzk@kernel.org>
 <CGME20170314171217epcas3p10a2dfd5bb9f157c49e5f20a2799e58ee@epcas3p1.samsung.com>
 <20170314171028.20337-4-krzk@kernel.org>
Message-ID: <58C89102.6000408@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 2017? 03? 15? 02:10, Krzysztof Kozlowski wrote:
> Enable EXYNOS_PM_DOMAINS because recently Exynos5433 got support for
> Power Management domains.  The Exynos5433 pinctrl driver requires
> EXYNOS_PMU to get the syscon-regmap for PMU address space.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> Reviewed-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  arch/arm64/Kconfig.platforms | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
> index 129cc5ae4091..9cdaecd3e583 100644
> --- a/arch/arm64/Kconfig.platforms
> +++ b/arch/arm64/Kconfig.platforms
> @@ -54,6 +54,8 @@ config ARCH_BRCMSTB
>  config ARCH_EXYNOS
>  	bool "ARMv8 based Samsung Exynos SoC family"
>  	select COMMON_CLK_SAMSUNG
> +	select EXYNOS_PM_DOMAINS if PM_GENERIC_DOMAINS
> +	select EXYNOS_PMU
>  	select HAVE_S3C2410_WATCHDOG if WATCHDOG
>  	select HAVE_S3C_RTC if RTC_CLASS
>  	select PINCTRL
> 

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
