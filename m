From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 10 Oct 2014 08:34:22 +0900
Subject: [PATCH 21/21] thermal: exynos: Make Exynos3250 TMU compatible with
 Exynos4412
In-Reply-To: <1412872737-624-22-git-send-email-l.majewski@samsung.com>
References: <1412872737-624-1-git-send-email-l.majewski@samsung.com>
 <1412872737-624-22-git-send-email-l.majewski@samsung.com>
Message-ID: <54371B7E.5010600@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/10/2014 01:38 AM, Lukasz Majewski wrote:
> Since both SoCs have the same TMU IP block embedded on them, it is
> not necessary to maintain separate compatible entry.
> 
> Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index f1e8c9b..7818e2f 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -744,9 +744,6 @@ static irqreturn_t exynos_tmu_irq(int irq, void *id)
>  
>  static const struct of_device_id exynos_tmu_match[] = {
>  	{
> -		.compatible = "samsung,exynos3250-tmu",
> -	},
> -	{

If you want to remove compatible string for Exynos3250,
you have to modify it on exynos3250.dtsi.

Thanks,
Chanwoo Choi
