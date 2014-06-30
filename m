From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 30 Jun 2014 16:03:02 +0200
Subject: [PATCH 16/17] [media] exynos4-is: removes s5pc100 related fimc
 codes
In-Reply-To: <1404163947-3105-17-git-send-email-kgene.kim@samsung.com>
References: <1404163947-3105-1-git-send-email-kgene.kim@samsung.com>
 <1404163947-3105-17-git-send-email-kgene.kim@samsung.com>
Message-ID: <53B16E16.7080200@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/06/14 23:32, Kukjin Kim wrote:
> This patch removes s5pc100 related fimc codes because of no more support
> S5PC100 SoC in mainline.

I have applied this patch to my tree. It's also fine if you would like to
merge the whole series together. In such case feel free to add:

Acked-by: Sylwester Nawrocki <s.nawrocki@samsung.com>

Please let me know if you want me to drop this patch from the media tree.

--
Regards,
Sylwester

> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Cc: Mauro Carvalho Chehab <m.chehab@samsung.com>
> ---
>  Documentation/video4linux/fimc.txt            |    2 +-
>  drivers/media/platform/exynos4-is/fimc-core.c |   15 ---------------
>  2 files changed, 1 insertion(+), 16 deletions(-)
> 
> diff --git a/Documentation/video4linux/fimc.txt b/Documentation/video4linux/fimc.txt
> index e0c6b8b..1441fcf 100644
> --- a/Documentation/video4linux/fimc.txt
> +++ b/Documentation/video4linux/fimc.txt
> @@ -15,7 +15,7 @@ drivers/media/platform/exynos4-is directory.
>  1. Supported SoCs
>  =================
>  
> -S5PC100 (mem-to-mem only), S5PV210, EXYNOS4210
> +S5PV210, EXYNOS4210
>  
>  2. Supported features
>  =====================
> diff --git a/drivers/media/platform/exynos4-is/fimc-core.c b/drivers/media/platform/exynos4-is/fimc-core.c
> index b70fd99..5c800b4 100644
> --- a/drivers/media/platform/exynos4-is/fimc-core.c
> +++ b/drivers/media/platform/exynos4-is/fimc-core.c
> @@ -1204,18 +1204,6 @@ static const struct fimc_variant fimc2_variant_s5pv210 = {
>  	.pix_limit	 = &s5p_pix_limit[2],
>  };
>  
> -/* S5PC100 */
> -static const struct fimc_drvdata fimc_drvdata_s5p = {
> -	.variant = {
> -		[0] = &fimc0_variant_s5p,
> -		[1] = &fimc0_variant_s5p,
> -		[2] = &fimc2_variant_s5p,
> -	},
> -	.num_entities	= 3,
> -	.lclk_frequency = 133000000UL,
> -	.out_buf_count	= 4,
> -};
> -
>  /* S5PV210, S5PC110 */
>  static const struct fimc_drvdata fimc_drvdata_s5pv210 = {
>  	.variant = {
> @@ -1251,9 +1239,6 @@ static const struct fimc_drvdata fimc_drvdata_exynos4x12 = {
>  
>  static const struct platform_device_id fimc_driver_ids[] = {
>  	{
> -		.name		= "s5p-fimc",
> -		.driver_data	= (unsigned long)&fimc_drvdata_s5p,
> -	}, {
>  		.name		= "s5pv210-fimc",
>  		.driver_data	= (unsigned long)&fimc_drvdata_s5pv210,
>  	}, {
