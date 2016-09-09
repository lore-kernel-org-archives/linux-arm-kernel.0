From: shawnguo@kernel.org (Shawn Guo)
Date: Fri, 9 Sep 2016 14:16:31 +0800
Subject: [PATCH 1/2] ARM: clk-imx35: fix name for ckil clk
In-Reply-To: <1473327022-8065-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1473327022-8065-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20160909061631.GI16911@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2016 at 11:30:21AM +0200, Uwe Kleine-K?nig wrote:
> This fixes
> 	[    0.000000] i.MX clk 82: register failed with -17
> because the name is duplicated.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

I did not queue any clock patches for this cycle.  Can you please send
the patches directly to clock maintainers?

Shawn

> ---
>  drivers/clk/imx/clk-imx35.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/imx/clk-imx35.c b/drivers/clk/imx/clk-imx35.c
> index b0978d3b83e2..d302ed3b8225 100644
> --- a/drivers/clk/imx/clk-imx35.c
> +++ b/drivers/clk/imx/clk-imx35.c
> @@ -115,7 +115,7 @@ static void __init _mx35_clocks_init(void)
>  	}
>  
>  	clk[ckih] = imx_clk_fixed("ckih", 24000000);
> -	clk[ckil] = imx_clk_fixed("ckih", 32768);
> +	clk[ckil] = imx_clk_fixed("ckil", 32768);
>  	clk[mpll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "mpll", "ckih", base + MX35_CCM_MPCTL);
>  	clk[ppll] = imx_clk_pllv1(IMX_PLLV1_IMX35, "ppll", "ckih", base + MX35_CCM_PPCTL);
>  
> -- 
> 2.8.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
