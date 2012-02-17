From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Fri, 17 Feb 2012 09:26:09 +0100
Subject: [PATCH 2/2] ARM: imx/pcm038: Don't specify regulator consumers
 by struct device
In-Reply-To: <1329449121.17110.2.camel@phoenix>
References: <1329449029.17110.1.camel@phoenix>
 <1329449121.17110.2.camel@phoenix>
Message-ID: <20120217082609.GP3852@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 11:25:21AM +0800, Axel Lin wrote:
> The dev field is remove from struct regulator_consumer_supply since commit
> 737f36 "regulator: Remove support for supplies specified by struct device".
> 
> This fixes below build error:
>   CC      arch/arm/mach-imx/mach-pcm038.o
> arch/arm/mach-imx/mach-pcm038.c:236: error: unknown field 'dev' specified in initializer
> make[1]: *** [arch/arm/mach-imx/mach-pcm038.o] Error 1
> make: *** [arch/arm/mach-imx] Error 2

This is a duplicate of one of Fabios patches, I just sent a pull
request.

Sascha

> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> This patch is against linux-next 20120217.
> 
>  arch/arm/mach-imx/mach-pcm038.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/mach-pcm038.c b/arch/arm/mach-imx/mach-pcm038.c
> index 16f126d..bfcc1ea 100644
> --- a/arch/arm/mach-imx/mach-pcm038.c
> +++ b/arch/arm/mach-imx/mach-pcm038.c
> @@ -233,7 +233,6 @@ static struct regulator_init_data sdhc1_data = {
>  
>  static struct regulator_consumer_supply cam_consumers[] = {
>  	{
> -		.dev	= NULL,
>  		.supply	= "imx_cam_vcc",
>  	},
>  };
> -- 
> 1.7.5.4
> 
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
