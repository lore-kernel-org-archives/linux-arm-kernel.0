From: l.majewski@samsung.com (Lukasz Majewski)
Date: Mon, 16 Feb 2015 16:07:54 +0100
Subject: [PATCH 3/3] thermal: exynos: Clean-up code to use oneline entry
 for exynos compatible table
In-Reply-To: <1424096414-4327-4-git-send-email-cw00.choi@samsung.com>
References: <1424096414-4327-1-git-send-email-cw00.choi@samsung.com>
 <1424096414-4327-4-git-send-email-cw00.choi@samsung.com>
Message-ID: <20150216160754.18ee3ebb@amdc2363>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Chanwoo,

> This patch cleanup the code to use oneline for entry of exynos
> compatible table.
> 
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Eduardo Valentin <edubezval@gmail.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c | 38
> ++++++++++-------------------------- 1 file changed, 10
> insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/thermal/samsung/exynos_tmu.c
> b/drivers/thermal/samsung/exynos_tmu.c index b199fff..7e6baf5 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
> @@ -919,34 +919,16 @@ static irqreturn_t exynos_tmu_irq(int irq, void
> *id) }
>  
>  static const struct of_device_id exynos_tmu_match[] = {
> -	{
> -		.compatible = "samsung,exynos3250-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos4210-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos4412-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos5250-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos5260-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos5420-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos5420-tmu-ext-triminfo",
> -	},
> -	{
> -		.compatible = "samsung,exynos5440-tmu",
> -	},
> -	{
> -		.compatible = "samsung,exynos7-tmu",
> -	},
> -	{},
> +	{ .compatible = "samsung,exynos3250-tmu", },
> +	{ .compatible = "samsung,exynos4210-tmu", },
> +	{ .compatible = "samsung,exynos4412-tmu", },
> +	{ .compatible = "samsung,exynos5250-tmu", },
> +	{ .compatible = "samsung,exynos5260-tmu", },
> +	{ .compatible = "samsung,exynos5420-tmu", },
> +	{ .compatible = "samsung,exynos5420-tmu-ext-triminfo", },
> +	{ .compatible = "samsung,exynos5440-tmu", },
> +	{ .compatible = "samsung,exynos7-tmu", },
> +	{ /* sentinel */ },
>  };
>  MODULE_DEVICE_TABLE(of, exynos_tmu_match);
>  

Acked-by: Lukasz Majewski <l.majewski@samsung.com>

Thanks for clean up!

-- 
Best regards,

Lukasz Majewski

Samsung R&D Institute Poland (SRPOL) | Linux Platform Group
