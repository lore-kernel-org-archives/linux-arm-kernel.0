From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 30 Nov 2011 21:37:08 +0800
Subject: [PATCH v2] net: fec: Select the FEC driver by default for i.MX
 SoCs
In-Reply-To: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
References: <1322652717-2685-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20111130133707.GB711@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 09:31:57AM -0200, Fabio Estevam wrote:
> Let the FEC driver be built by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Acked-by: Shawn Guo <shawn.guo@linaro.org>

Regards,
Shawn

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
>  	select PHYLIB
> -- 
> 1.7.1
> 
