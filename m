From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 10 Oct 2012 10:04:42 +0200
Subject: [PATCH] ARM: mxc: platform-mxc-mmc: Fix register region size
In-Reply-To: <1349810713-12307-1-git-send-email-fabio.estevam@freescale.com>
References: <1349810713-12307-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20121010080442.GO27665@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 04:25:13PM -0300, Fabio Estevam wrote:
> Do not hardcode the register region to SZ_4K as this is not correct for mx31.
> 
> Use data->iosize instead which works for both mx27 and mx31 cases.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thanks

Sascha

> ---
>  arch/arm/plat-mxc/devices/platform-mxc-mmc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
> index 540d3a7..e7b920b 100644
> --- a/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
> +++ b/arch/arm/plat-mxc/devices/platform-mxc-mmc.c
> @@ -55,7 +55,7 @@ struct platform_device *__init imx_add_mxc_mmc(
>  	struct resource res[] = {
>  		{
>  			.start = data->iobase,
> -			.end = data->iobase + SZ_4K - 1,
> +			.end = data->iobase + data->iosize - 1,
>  			.flags = IORESOURCE_MEM,
>  		}, {
>  			.start = data->irq,
> -- 
> 1.7.9.5
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
