From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Tue, 24 Jul 2018 11:51:16 +0000
Subject: [PATCH v3 1/3] soc: imx: gpc: fix PDN delay
In-Reply-To: <1532425558626.11533@mixed-mode.de>
References: <1532425558626.11533@mixed-mode.de>
Message-ID: <d30cde038ae7a28bf9264e4e1cc5612f4634e3f5.camel@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2018-07-24 at 09:46 +0000, Sven Schmitt wrote:
> imx6_pm_domain_power_off() reads iso and iso2sw from
> GPC_PGC_PUPSCR_OFFS 
> which stores the power up delays. 
> So use GPC_PGC_PDNSCR_OFFS for the correct delays.
> 
> Signed-off-by: Sven Schmitt <sven.schmitt@mixed-mode.de>

Reviewed-by: Leonard Crestez <leonard.crestez@nxp.com>

> --- a/drivers/soc/imx/gpc.c
> +++ b/drivers/soc/imx/gpc.c
> @@ -73,7 +73,7 @@ static int imx6_pm_domain_power_off(struct generic_pm_domain *genpd)
>  		return -EBUSY;
>  
>  	/* Read ISO and ISO2SW power down delays */
> -	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PUPSCR_OFFS, &val);
> +	regmap_read(pd->regmap, pd->reg_offs + GPC_PGC_PDNSCR_OFFS, &val);
>  	iso = val & 0x3f;
>  	iso2sw = (val >> 8) & 0x3f;
 
