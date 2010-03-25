From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Thu, 25 Mar 2010 08:35:37 +0100
Subject: [PATCH 2/3] imx3: Add rtc platform device support
In-Reply-To: <1269430338-22690-2-git-send-email-vzapolskiy@gmail.com>
References: <1269430338-22690-1-git-send-email-vzapolskiy@gmail.com>
	<1269430338-22690-2-git-send-email-vzapolskiy@gmail.com>
Message-ID: <20100325073537.GZ2241@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vladimir,

On Wed, Mar 24, 2010 at 02:32:17PM +0300, Vladimir Zapolskiy wrote:
> This patch adds support for build-in RTC device found on
> Freescale imx31 and imx35 SoCs.
> 
> Signed-off-by: Vladimir Zapolskiy <vzapolskiy@gmail.com>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-mx3/devices.c |   19 +++++++++++++++++++
>  arch/arm/mach-mx3/devices.h |    1 +
>  2 files changed, 20 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/mach-mx3/devices.c b/arch/arm/mach-mx3/devices.c
> index f891115..1ffed28 100644
> --- a/arch/arm/mach-mx3/devices.c
> +++ b/arch/arm/mach-mx3/devices.c
> @@ -588,6 +588,25 @@ struct platform_device imx_wdt_device0 = {
>  	.resource       = imx_wdt_resources,

This patch does not apply. We do not have the watchdog in devices.c atm.

>  };
>  
> +static struct resource imx_rtc_resources[] = {
> +	{
> +		.start  = MX31_RTC_BASE_ADDR,
> +		.end    = MX31_RTC_BASE_ADDR + 0x3fff,
> +		.flags  = IORESOURCE_MEM,
> +	},
> +	{
> +		.start  = MX31_INT_RTC,
> +		.flags  = IORESOURCE_IRQ,
> +	},

Can you provide a fixup for i.MX35, please? See mx3_devices_init().

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
