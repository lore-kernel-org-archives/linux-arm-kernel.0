From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:42:29 +0100
Subject: [PATCH 6/8] soc: imx: gpc: keep PGC_X_CTRL name align with
 reference manual
In-Reply-To: <1489990547-1510-7-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-7-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490002949.2895.17.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 20.03.2017, 14:15 +0800 schrieb Dong Aisheng:
> Instead of GPC_PGC_PDN_OFFS, naming it as GPC_PGC_CTRL_OFFS which is
> defined in reference manual for better reading.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/gpc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index 19f4e6b..a744f7e 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -21,7 +21,7 @@
>  
>  #define GPC_CNTR		0x000
>  
> -#define GPC_PGC_PDN_OFFS	0x0
> +#define GPC_PGC_CTRL_OFFS	0x0
>  #define GPC_PGC_PUPSCR_OFFS	0x4
>  #define GPC_PGC_PDNSCR_OFFS	0x8
>  #define GPC_PGC_SW2ISO_SHIFT	0x8
> @@ -65,7 +65,7 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
>  	iso2sw = (val >> 8) & 0x3f;
>  
>  	/* Gate off domain when powered down */
> -	regmap_update_bits(pd->regmap, pd->reg_offs + GPC_PGC_PDN_OFFS,
> +	regmap_update_bits(pd->regmap, pd->reg_offs + GPC_PGC_CTRL_OFFS,
>  			   0x1, 0x1);
>  
>  	/* Request GPC to power down domain */
> @@ -101,7 +101,7 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
>  		clk_prepare_enable(pd->clk[i]);
>  
>  	/* Gate off domain when powered down */
> -	regmap_update_bits(pd->regmap, pd->reg_offs + GPC_PGC_PDN_OFFS,
> +	regmap_update_bits(pd->regmap, pd->reg_offs + GPC_PGC_CTRL_OFFS,
>  			   0x1, 0x1);
>  
>  	/* Read ISO and ISO2SW power up delays */
