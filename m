From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Thu, 30 Nov 2017 16:59:14 +0000
Subject: [PATCH v3 1/6] ARM: ep93xx: ts72xx: Use DEFINE_RES_MEM macros
 where applicable
In-Reply-To: <20171130004510.23887-2-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171130004510.23887-1-lukma@denx.de> <20171130004510.23887-2-lukma@denx.de>
Message-ID: <BLUPR0101MB15548ADB26B57D7944530FEFD0380@BLUPR0101MB1554.prod.exchangelabs.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, November 29, 2017 5:45 PM, Lukasz Majewski wrote:
> This commit cleans up the code by using dedicated macros instead of full definitions.
>
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

<snip>

> @@ -187,16 +187,8 @@ static struct platform_device ts72xx_rtc_device = {  };
 >
>  static struct resource ts72xx_wdt_resources[] = {
> -	{
> -		.start	= TS72XX_WDT_CONTROL_PHYS_BASE,
> -		.end	= TS72XX_WDT_CONTROL_PHYS_BASE + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> -	{
> -		.start	= TS72XX_WDT_FEED_PHYS_BASE,
> -		.end	= TS72XX_WDT_FEED_PHYS_BASE + SZ_4K - 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> +	DEFINE_RES_MEM(TS72XX_WDT_CONTROL_PHYS_BASE, SZ_4K),
> +	DEFINE_RES_MEM(TS72XX_WDT_FEED_PHYS_BASE, SZ_4K),
>  };
 
Lukasz,

The chunk above is already cleaned up in linux-next by:

commit 97c3bca922468996c864917c9a8ea6a410233985
ARM: ep93xx: tidy up TS-72xx Watchdog resources

Can you please rebase this series against linux-next?

I'm reviewing the rest of the series now and will reply with any other issues.

Thanks,
Hartley
