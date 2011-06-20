From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 20 Jun 2011 09:26:58 +0200
Subject: [PATCH] ARM: mach-imx/mx31_3ds: Fix IOMUX for SPI1 signals
In-Reply-To: <1308242572-5158-1-git-send-email-fabio.estevam@freescale.com>
References: <1308242572-5158-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20110620072658.GQ23771@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 16, 2011 at 01:42:52PM -0300, Fabio Estevam wrote:
> The LCD on the mx31_3ds board is connected to CSPI1.


>From bogus@does.not.exist.com  Wed Jun  1 12:03:18 2011
From: bogus@does.not.exist.com ()
Date: Wed, 01 Jun 2011 16:03:18 -0000
Subject: No subject
Message-ID: <mailman.29.1308554824.24103.linux-arm-kernel@lists.infradead.org>

instead of adding it. Can you explain a bit more?

Sascha

> 
> Fix the IOMUX settings so that LCD can work.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/mach-imx/mach-mx31_3ds.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-mx31_3ds.c b/arch/arm/mach-imx/mach-mx31_3ds.c
> index ab2a626..a6160ee 100644
> --- a/arch/arm/mach-imx/mach-mx31_3ds.c
> +++ b/arch/arm/mach-imx/mach-mx31_3ds.c
> @@ -53,11 +53,8 @@ static int mx31_3ds_pins[] = {
>  	MX31_PIN_RXD1__RXD1,
>  	IOMUX_MODE(MX31_PIN_GPIO1_1, IOMUX_CONFIG_GPIO),
>  	/*SPI0*/
> -	MX31_PIN_CSPI1_SCLK__SCLK,
> -	MX31_PIN_CSPI1_MOSI__MOSI,
> -	MX31_PIN_CSPI1_MISO__MISO,
> -	MX31_PIN_CSPI1_SPI_RDY__SPI_RDY,
> -	MX31_PIN_CSPI1_SS2__SS2, /* CS for LCD */
> +	IOMUX_MODE(MX31_PIN_DSR_DCE1, IOMUX_CONFIG_ALT1),
> +	IOMUX_MODE(MX31_PIN_RI_DCE1, IOMUX_CONFIG_ALT1),
>  	/* SPI 1 */
>  	MX31_PIN_CSPI2_SCLK__SCLK,
>  	MX31_PIN_CSPI2_MOSI__MOSI,
> @@ -690,6 +687,9 @@ static void __init mx31_3ds_init(void)
>  	int ret;
>  
>  	imx31_soc_init();
> +
> +	/* Configure SPI1 IOMUX */
> +	mxc_iomux_set_gpr(MUX_PGP_CSPI_BB, true);
>  
>  	mxc_iomux_setup_multiple_pins(mx31_3ds_pins, ARRAY_SIZE(mx31_3ds_pins),
>  				      "mx31_3ds");
> -- 
> 1.6.0.4
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
