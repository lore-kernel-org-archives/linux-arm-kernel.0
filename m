From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 26 Nov 2012 08:22:14 +0900
Subject: [PATCH] ARM: Exynos5: fix clock initialization for exynos5250
In-Reply-To: <1353750810-21953-1-git-send-email-thomas.abraham@linaro.org>
References: <1353750810-21953-1-git-send-email-thomas.abraham@linaro.org>
Message-ID: <12b301cdcb63$b3f60ca0$1be225e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thomas Abraham wrote:
> 
> The machine compatible value cannot be checked in exynos5_dt_map_io
> function
> since the tree is not unflattened yet. Fix this by using soc_is_exynos5250
> macro.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/mach-exynos/mach-exynos5-dt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-exynos/mach-exynos5-dt.c b/arch/arm/mach-
> exynos/mach-exynos5-dt.c
> index 77010f8..845d8e2 100644
> --- a/arch/arm/mach-exynos/mach-exynos5-dt.c
> +++ b/arch/arm/mach-exynos/mach-exynos5-dt.c
> @@ -117,7 +117,7 @@ static void __init exynos5_dt_map_io(void)
>  {
>  	exynos_init_io(NULL, 0);
> 
> -	if (of_machine_is_compatible("samsung,exynos5250"))
> +	if (soc_is_exynos5250())
>  		s3c24xx_init_clocks(24000000);
>  }
> 
> --

Correct, applied.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
