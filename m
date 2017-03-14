From: alim.akhtar@samsung.com (Alim Akhtar)
Date: Tue, 14 Mar 2017 20:03:36 +0530
Subject: [3/3] arm64: exynos: Enable Exynos PMU and PM domains drivers
In-Reply-To: <20170311213856.21701-4-krzk@kernel.org>
References: <20170311213856.21701-4-krzk@kernel.org>
 <CGME20170314143652epcas5p43c7c8556228f996d19d716506eb9a0ed@epcas5p4.samsung.com>
Message-ID: <d7e15bc0-f17f-8b87-4b9d-c0abc3b554db@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/12/2017 03:08 AM, Krzysztof Kozlowski wrote:
> Enable EXYNOS_PM_DOMAINS because recently Exynos5433 got support for
> Power Management domains.  The Exynos5433 pinctrl driver requires
> EXYNOS_PMU to get the syscon-regmap for PMU address space.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
Looks good.
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

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
