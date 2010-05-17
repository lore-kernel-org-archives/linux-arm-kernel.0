From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 May 2010 11:51:24 +0200
Subject: [PATCH 2/6] arm/mach-mx2/3: Fix watchdog-devices to match the
	current driver
In-Reply-To: <1272528202-24159-3-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-3-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100517095124.GV31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 29, 2010 at 10:03:18AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx2/devices.c |    9 ++-------
>  arch/arm/mach-mx3/devices.c |    2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)

Applied to mxc-master.

Sascha


> 
> 
> diff --git a/arch/arm/mach-mx2/devices.c b/arch/arm/mach-mx2/devices.c
> index b91e412..a9377ce 100644
> --- a/arch/arm/mach-mx2/devices.c
> +++ b/arch/arm/mach-mx2/devices.c
> @@ -109,12 +109,7 @@ DEFINE_IMX_GPT_DEVICE(4, MX27_GPT5_BASE_ADDR, MX27_INT_GPT5);
>  DEFINE_IMX_GPT_DEVICE(5, MX27_GPT6_BASE_ADDR, MX27_INT_GPT6);
>  #endif
>  
> -/*
> - * Watchdog:
> - * - i.MX1
> - * - i.MX21
> - * - i.MX27
> - */
> +/* Watchdog: i.MX1 has seperate driver, i.MX21 and i.MX27 are equal */
>  static struct resource mxc_wdt_resources[] = {
>  	{
>  		.start = MX2x_WDOG_BASE_ADDR,
> @@ -124,7 +119,7 @@ static struct resource mxc_wdt_resources[] = {
>  };
>  
>  struct platform_device mxc_wdt = {
> -	.name = "mxc_wdt",
> +	.name = "imx2-wdt",
>  	.id = 0,
>  	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
>  	.resource = mxc_wdt_resources,
> diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
> index 1ffed28..81a1dba 100644
> --- a/arch/arm/mach-mx3/devices.c
> +++ b/arch/arm/mach-mx3/devices.c
> @@ -582,7 +582,7 @@ static struct resource imx_wdt_resources[] = {
>  };
>  
>  struct platform_device imx_wdt_device0 = {
> -	.name           = "imx-wdt",
> +	.name           = "imx2-wdt",
>  	.id             = 0,
>  	.num_resources  = ARRAY_SIZE(imx_wdt_resources),
>  	.resource       = imx_wdt_resources,
> -- 
> 1.7.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
