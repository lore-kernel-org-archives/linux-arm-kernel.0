From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 May 2010 11:49:25 +0200
Subject: [PATCH 5/6] arm/mx25: add watchdog device
In-Reply-To: <1272528202-24159-6-git-send-email-w.sang@pengutronix.de>
References: <1272528202-24159-1-git-send-email-w.sang@pengutronix.de>
	<1272528202-24159-6-git-send-email-w.sang@pengutronix.de>
Message-ID: <20100517094925.GT31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

This patch (and the next one) miss the corresponding entry in devices.h

Sascha

On Thu, Apr 29, 2010 at 10:03:21AM +0200, Wolfram Sang wrote:
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx25/devices.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx25/devices.c b/arch/arm/mach-mx25/devices.c
> index 3f4b8a0..3a405fa 100644
> --- a/arch/arm/mach-mx25/devices.c
> +++ b/arch/arm/mach-mx25/devices.c
> @@ -500,3 +500,18 @@ struct platform_device mx25_fb_device = {
>  		.coherent_dma_mask = 0xFFFFFFFF,
>  	},
>  };
> +
> +static struct resource mxc_wdt_resources[] = {
> +	{
> +		.start = MX25_WDOG_BASE_ADDR,
> +		.end = MX25_WDOG_BASE_ADDR + SZ_16K - 1,
> +		.flags = IORESOURCE_MEM,
> +	},
> +};
> +
> +struct platform_device mxc_wdt = {
> +	.name = "imx2-wdt",
> +	.id = 0,
> +	.num_resources = ARRAY_SIZE(mxc_wdt_resources),
> +	.resource = mxc_wdt_resources,
> +};
> -- 
> 1.7.0
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
