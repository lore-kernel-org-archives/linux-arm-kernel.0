From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Mar 2014 11:10:12 +0900
Subject: [PATCH 1/1] ARM: EXYNOS: Add support to reserve memory for MFC-v7
In-Reply-To: <1395046487-21249-1-git-send-email-sachin.kamat@linaro.org>
References: <1395046487-21249-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <019e01cf43e1$86e3c390$94ab4ab0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sachin Kamat wrote:
> 
> Reserve memory for MFC-v7 IP.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Based on top of Tushar's patch:
> [PATCH V2] ARM: SAMSUNG: Reorganize calls to reserve memory for MFC
> http://www.spinics.net/lists/linux-samsung-soc/msg25501.html
> ---
>  arch/arm/mach-exynos/mach-exynos5-dt.c |   10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c
b/arch/arm/mach-exynos/mach-
> exynos5-dt.c
> index 9586439b2d0e..9a8a798d2ad0 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -59,7 +59,15 @@ static char const *exynos5_dt_compat[] __initdata = {
>  static void __init exynos5_reserve(void)
>  {
>  #ifdef CONFIG_S5P_DEV_MFC
> -	of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, "samsung,mfc-v6");
> +	int i;
> +	char *mfc_mem[] = {
> +		"samsung,mfc-v6",
> +		"samsung,mfc-v7",
> +	};
> +
> +	for (i = 0; i < ARRAY_SIZE(mfc_mem); i++)
> +		if (of_scan_flat_dt(s5p_fdt_alloc_mfc_mem, mfc_mem[i]))
> +			break;
>  #endif
>  }
> 
> --
> 1.7.9.5

Looks OK, will apply.

Thanks,
Kukjin
