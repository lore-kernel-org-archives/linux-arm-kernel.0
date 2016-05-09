From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 May 2016 09:32:47 -0400
Subject: [PATCH] clk: samsung: exynos5420: Remove useless check for return
 value of samsung_clk_init
In-Reply-To: <1462699496-16646-1-git-send-email-krzk@kernel.org>
References: <1462699496-16646-1-git-send-email-krzk@kernel.org>
Message-ID: <4033d4d5-558d-898f-cdc9-07a19654ade6@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 05/08/2016 05:24 AM, Krzysztof Kozlowski wrote:
> The samsung_clk_init() cannot return NULL. Either it returns allocated
> memory or it panics.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 92382cef9f90..770c0f007c6b 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1356,8 +1356,6 @@ static void __init exynos5x_clk_init(struct device_node *np,
>  	exynos5x_soc = soc;
>  
>  	ctx = samsung_clk_init(np, reg_base, CLK_NR_CLKS);
> -	if (!ctx)
> -		panic("%s: unable to allocate context.\n", __func__);
>

Indeed, the check is superfluous. I see that most callers [0] currently
do the same, so probably makes sense to remove those too in this patch.

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

[0]:
drivers/clk/samsung/clk-exynos4.c
drivers/clk/samsung/clk-exynos5250.c
drivers/clk/samsung/clk-exynos5440.c
drivers/clk/samsung/clk-s3c2410.c
drivers/clk/samsung/clk-s3c2412.c
drivers/clk/samsung/clk-s3c2443.c
drivers/clk/samsung/clk-s3c64xx.c
drivers/clk/samsung/clk-s5pv210.c

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
