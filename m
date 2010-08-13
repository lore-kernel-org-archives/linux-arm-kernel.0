From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Fri, 13 Aug 2010 10:39:01 +0200
Subject: [PATCH] ARM: S3C2410: Fix on build warning about dependency in
	mach-s3c2440/Kconfig
In-Reply-To: <1281687307-2421-1-git-send-email-kgene.kim@samsung.com>
References: <1281687307-2421-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <20100813083901.GA20285@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 13, 2010 at 05:15:07PM +0900, Kukjin Kim wrote:
> This patch fixes on following build warnings.
> 
> warning: (CPU_S3C2440 && ARCH_S3C2410 && S3C2410_DMA) selects S3C2440_DMA which
>              has unmet direct dependencies (ARCH_S3C2410 && CPU_S3C24405B)
> warning: (CPU_S3C2440 && ARCH_S3C2410 || CPU_S3C2442 && ARCH_S3C2410) selects
>              CPU_S3C244X which has unmet direct dependencies (!ARCH_S3C2410)
> 
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> Cc: Ben Dooks <ben-linux@fluff.org>
> ---
>  arch/arm/mach-s3c2440/Kconfig |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-s3c2440/Kconfig b/arch/arm/mach-s3c2440/Kconfig
> index cd8e7de..f60a370 100644
> --- a/arch/arm/mach-s3c2440/Kconfig
> +++ b/arch/arm/mach-s3c2440/Kconfig
> @@ -30,7 +30,7 @@ config CPU_S3C2442
>  
>  config CPU_S3C244X
>  	bool
> -	depends on ARCH_S3C2410 && (CPU_S3C2440 || CPU_S3C2442)
> +	depends on (CPU_S3C2440 || CPU_S3C2442)
>  	help
>  	  Support for S3C2440 and S3C2442 Samsung Mobile CPU based systems.
>  
> @@ -72,7 +72,7 @@ config S3C2440_PLL_16934400
>  
>  config S3C2440_DMA
>  	bool
> -	depends on ARCH_S3C2410 && CPU_S3C24405B
> +	depends on (ARCH_S3C2410 || CPU_S3C24405B)
>  	help
>  	  Support for S3C2440 specific DMA code5A
all parenthesis in your +lines are superflous.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
