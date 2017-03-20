From: l.stach@pengutronix.de (Lucas Stach)
Date: Mon, 20 Mar 2017 10:41:08 +0100
Subject: [PATCH 5/8] soc: imx: gpc: fix comment when power up domain
In-Reply-To: <1489990547-1510-6-git-send-email-aisheng.dong@nxp.com>
References: <1489990547-1510-1-git-send-email-aisheng.dong@nxp.com>
 <1489990547-1510-6-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1490002868.2895.16.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Montag, den 20.03.2017, 14:15 +0800 schrieb Dong Aisheng:
> The correct comment should be power up domain.
> 
> Cc: Lucas Stach <l.stach@pengutronix.de>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>

Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

> ---
>  drivers/soc/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/imx/gpc.c b/drivers/soc/imx/gpc.c
> index c1d0e67..19f4e6b 100644
> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -104,7 +104,7 @@ static int imx6_pm_domain_power_on(struct generic_pm_domain *genpd)
>  	regmap_update_bits(pd->regmap, pd->reg_offs + GPC_PGC_PDN_OFFS,
>  			   0x1, 0x1);
>  
> -	/* Read ISO and ISO2SW power down delays */
> +	/* Read ISO and ISO2SW power up delays */
>  	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
>  	sw = val & 0x3f;
>  	sw2iso = (val >> 8) & 0x3f;
