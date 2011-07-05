From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 5 Jul 2011 18:59:03 +0200
Subject: [PATCH] ARM: mxs/tx28: according to the TX28's datasheet D4-D7
	are not used for MMC0
In-Reply-To: <1309860396-9219-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1309860396-9219-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110705165903.GL6069@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 05, 2011 at 12:06:36PM +0200, Uwe Kleine-K?nig wrote:
> The pins are actually used (not in mainline yet):
> 
> 	D4 -> SSP2_D0
> 	D5 -> GPIO
> 	D6 -> GPIO
> 	D7 -> GPIO for owire
> 
> so their pinmapping for SSP0 is wrong.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

Applied for next.

Sascha

> ---
>  arch/arm/mach-mxs/mach-tx28.c |    8 --------
>  1 files changed, 0 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/arm/mach-mxs/mach-tx28.c b/arch/arm/mach-mxs/mach-tx28.c
> index b65e371..068e540 100644
> --- a/arch/arm/mach-mxs/mach-tx28.c
> +++ b/arch/arm/mach-mxs/mach-tx28.c
> @@ -101,14 +101,6 @@ static const iomux_cfg_t tx28_stk5v3_pads[] __initconst = {
>  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
>  	MX28_PAD_SSP0_DATA3__SSP0_D3 |
>  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> -	MX28_PAD_SSP0_DATA4__SSP0_D4 |
> -		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> -	MX28_PAD_SSP0_DATA5__SSP0_D5 |
> -		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> -	MX28_PAD_SSP0_DATA6__SSP0_D6 |
> -		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
> -	MX28_PAD_SSP0_DATA7__SSP0_D7 |
> -		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
>  	MX28_PAD_SSP0_CMD__SSP0_CMD |
>  		(MXS_PAD_8MA | MXS_PAD_3V3 | MXS_PAD_PULLUP),
>  	MX28_PAD_SSP0_DETECT__SSP0_CARD_DETECT |
> -- 
> 1.7.5.4
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
