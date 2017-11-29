From: alexander.sverdlin@gmail.com (Alexander Sverdlin)
Date: Wed, 29 Nov 2017 21:33:23 +0100
Subject: [PATCH v2 1/6] ARM: ep93xx: ts72xx: Use DEFINE_RES_MEM macros
 where applicable
In-Reply-To: <20171121143204.1839-2-lukma@denx.de>
References: <20171116232239.16823-1-lukma@denx.de>
 <20171121143204.1839-1-lukma@denx.de> <20171121143204.1839-2-lukma@denx.de>
Message-ID: <2f0db256-9eea-bcc0-135d-347c1c996640@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

On 21/11/17 15:31, Lukasz Majewski wrote:
> This commit cleans up the code by using dedicated macros instead of
> full definitions.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Acked-by: Alexander Sverdlin <alexander.sverdlin@gmail.com>

> ---
> Changes for v2:
> - None
> ---
>  arch/arm/mach-ep93xx/ts72xx.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/arm/mach-ep93xx/ts72xx.c b/arch/arm/mach-ep93xx/ts72xx.c
> index 8745162ec05d..06345b85f27c 100644
> --- a/arch/arm/mach-ep93xx/ts72xx.c
> +++ b/arch/arm/mach-ep93xx/ts72xx.c
> @@ -187,16 +187,8 @@ static struct platform_device ts72xx_rtc_device = {
>  };
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
>  
>  static struct platform_device ts72xx_wdt_device = {
> @@ -216,11 +208,7 @@ static struct ep93xx_eth_data __initdata ts72xx_eth_data = {
>  #define TS73XX_FPGA_LOADER_BASE		0x03c00000
>  
>  static struct resource ts73xx_fpga_resources[] = {
> -	{
> -		.start	= EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE,
> -		.end	= EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE + 1,
> -		.flags	= IORESOURCE_MEM,
> -	},
> +	DEFINE_RES_MEM(EP93XX_CS1_PHYS_BASE + TS73XX_FPGA_LOADER_BASE, 0x01),
>  };
>  
>  static struct platform_device ts73xx_fpga_device = {
