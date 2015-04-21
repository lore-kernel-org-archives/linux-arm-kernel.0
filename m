From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 21 Apr 2015 12:59:53 +0200
Subject: [PATCH] soc: mediatek: Fix off-by-one checking for rate_spi
In-Reply-To: <1429613612.5644.1.camel@ingics.com>
References: <1429613612.5644.1.camel@ingics.com>
Message-ID: <20150421105953.GY6325@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 21, 2015 at 06:53:32PM +0800, Axel Lin wrote:
> If rate_spi is 26000000, current code set ck_mhz to 18 rather than 26.
> Fix the off-by-one checking for rate_spi.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Sascha Hauer <s.hauer@pengutronix.de>

> ---
>  drivers/soc/mediatek/mtk-pmic-wrap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
> index db5be1e..e910e19 100644
> --- a/drivers/soc/mediatek/mtk-pmic-wrap.c
> +++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
> @@ -568,9 +568,9 @@ static int pwrap_init_reg_clock(struct pmic_wrapper *wrp)
>  
>  	rate_spi = clk_get_rate(wrp->clk_spi);
>  
> -	if (rate_spi > 26000000)
> +	if (rate_spi >= 26000000)
>  		ck_mhz = 26;
> -	else if (rate_spi > 18000000)
> +	else if (rate_spi >= 18000000)
>  		ck_mhz = 18;
>  	else
>  		ck_mhz = 0;
> -- 
> 2.1.0
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
