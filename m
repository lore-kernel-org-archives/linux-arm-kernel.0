From: ben@trinity.fluff.org (Ben Dooks)
Date: Wed, 2 Jun 2010 08:27:20 +0100
Subject: [PATCH] ARM: SAMSUNG: Reduce virtual memory size for WDT device
In-Reply-To: <1275462337-21587-1-git-send-email-kgene.kim@samsung.com>
References: <1275462337-21587-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100602072720.GD30276@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 02, 2010 at 04:05:37PM +0900, Kukjin Kim wrote:
> From: Banajit Goswami <banajit.g@samsung.com>
> 
> This patch reduces the virtual memory allocated for WDT device from 1M
> to 1K.
>
> Signed-off-by: Banajit Goswami <banajit.g@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
Acked-by: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/plat-samsung/dev-wdt.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/plat-samsung/dev-wdt.c b/arch/arm/plat-samsung/dev-wdt.c
> index 5efca87..019b5b8 100644
> --- a/arch/arm/plat-samsung/dev-wdt.c
> +++ b/arch/arm/plat-samsung/dev-wdt.c
> @@ -21,7 +21,7 @@
>  static struct resource s3c_wdt_resource[] = {
>  	[0] = {
>  		.start	= S3C_PA_WDT,
> -		.end	= S3C_PA_WDT + SZ_1M - 1,
> +		.end	= S3C_PA_WDT + SZ_1K,
>  		.flags	= IORESOURCE_MEM,
>  	},
>  	[1] = {
> -- 
> 1.6.2.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
