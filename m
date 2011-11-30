From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 30 Nov 2011 14:25:36 +0100
Subject: [PATCH v2] net: fec: Select the FEC driver by default for i.MX
 SoCs
In-Reply-To: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
References: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111130132536.GD26618@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 09:31:57AM -0200, Fabio Estevam wrote:
> Let the FEC driver be built by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
Just one small nitpick below. Other than that:

Suggested-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>

> ---
> Changes since v1: 
> Move the FEC selection into Kconfig instead of .config file
> 
>  drivers/net/ethernet/freescale/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> index c520cfd..ae269ad 100644
> --- a/drivers/net/ethernet/freescale/Kconfig
> +++ b/drivers/net/ethernet/freescale/Kconfig
> @@ -22,6 +22,7 @@ if NET_VENDOR_FREESCALE
>  
>  config FEC
>  	bool "FEC ethernet controller (of ColdFire and some i.MX CPUs)"
> +	default ARCH_MXC || ARCH_MXS if ARM
>  	depends on (M523x || M527x || M5272 || M528x || M520x || M532x || \
>  		   ARCH_MXC || ARCH_MXS)
I'd write the depends line first, then default and then select.

Best regards
Uwe

>  	select PHYLIB

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
