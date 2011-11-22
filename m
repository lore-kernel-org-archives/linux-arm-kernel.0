From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 22 Nov 2011 11:35:11 +0100
Subject: [PATCH v2] ARM: mx31pdk: Add MC13783 RTC support
In-Reply-To: <1321900012-8351-1-git-send-email-fabio.estevam@freescale.com>
References: <1321900012-8351-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111122103511.GB24770@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Mon, Nov 21, 2011 at 04:26:51PM -0200, Fabio Estevam wrote:
> MX31PDK board has a MC13783 PMIC, which provides RTC functionality.
> 
> Add support for it.

Added both. Please base your patches on mainline. I collect them as
branches descending from mainline anyway.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> 
> - Rebased on top of 3.2-rc2
> 
>  arch/arm/mach-imx/mach-mx31_3ds.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index b8c54b8..00bb308 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -492,7 +492,7 @@ static struct mc13xxx_platform_data mc13783_pdata = {
>  		.regulators = mx31_3ds_regulators,
>  		.num_regulators = ARRAY_SIZE(mx31_3ds_regulators),
>  	},
> -	.flags  = MC13XXX_USE_TOUCHSCREEN,
> +	.flags  = MC13XXX_USE_TOUCHSCREEN | MC13XXX_USE_RTC,
>  };
>  
>  /* SPI */
> -- 
> 1.7.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
