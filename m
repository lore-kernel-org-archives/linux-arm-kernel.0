From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 27 Mar 2012 10:56:59 +0200
Subject: [PATCH] ARM: 3ds_debugboard: Fix smsc911x driver probe
In-Reply-To: <1332788037-31064-1-git-send-email-fabio.estevam@freescale.com>
References: <1332788037-31064-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <20120327085659.GW3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2012 at 03:53:57PM -0300, Fabio Estevam wrote:
> Fix smsc911x id field in order to fix smsc911x driver probe error:
> 
> smsc911x smsc911x.0: Failed to get supply 'vdd33a': -517
> smsc911x smsc911x.0: (unregistered net_device): couldn't get regulators -517
> platform smsc911x.0: Driver smsc911x requests probe deferral

Looks good. I couldn't test it on the 3ds board. Could you collect your
patches until the beginning of next week? I'm on holidays right now and
will be back next week.

Sascha

> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  arch/arm/plat-mxc/3ds_debugboard.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-mxc/3ds_debugboard.c b/arch/arm/plat-mxc/3ds_debugboard.c
> index d1e31fa..5cac2c5 100644
> --- a/arch/arm/plat-mxc/3ds_debugboard.c
> +++ b/arch/arm/plat-mxc/3ds_debugboard.c
> @@ -80,7 +80,7 @@ static struct smsc911x_platform_config smsc911x_config = {
>  
>  static struct platform_device smsc_lan9217_device = {
>  	.name = "smsc911x",
> -	.id = 0,
> +	.id = -1,
>  	.dev = {
>  		.platform_data = &smsc911x_config,
>  	},
> -- 
> 1.7.1
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
