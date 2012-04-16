From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Mon, 16 Apr 2012 11:46:18 -0500
Subject: [PATCH 2/3] ARM: orion5x: ts78xx fix NAND resource off by one
In-Reply-To: <1334426454-3206-3-git-send-email-alex@digriz.org.uk>
References: <1334426454-3206-1-git-send-email-alex@digriz.org.uk>
 <1334426454-3206-3-git-send-email-alex@digriz.org.uk>
Message-ID: <ADE657CA350FB648AAC2C43247A983F00206987A3B56@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, April 14, 2012 11:01 AM, Alexander Clouter wrote:
>
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/arm/mach-orion5x/ts78xx-setup.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/mach-orion5x/ts78xx-setup.c b/arch/arm/mach-orion5x/ts78xx-setup.c
> index c41f27b..4ae822b 100644
> --- a/arch/arm/mach-orion5x/ts78xx-setup.c
> +++ b/arch/arm/mach-orion5x/ts78xx-setup.c
> @@ -294,7 +294,7 @@ static struct platform_nand_data ts78xx_ts_nand_data = {
>  
>  static struct resource ts78xx_ts_nand_resources = {
>  	.start		= TS_NAND_DATA,
> -	.end		= TS_NAND_DATA + 4,
> +	.end		= TS_NAND_DATA + 4 - 1,
>  	.flags		= IORESOURCE_MEM,
>  };

Just use the DEFINE_RES_MEM macro:

static struct resource ts78xx_ts_nand_resources =
	DEFINE_RES_MEM(TS_NAND_DATA, 4);

Regards,
Hartley
