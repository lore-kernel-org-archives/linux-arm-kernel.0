From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 7 Jun 2012 14:30:43 +0200
Subject: [PATCH] ARM: at91: fix at91_aic_write macro
In-Reply-To: <1338477965-19581-1-git-send-email-ludovic.desroches@atmel.com>
References: <1338477965-19581-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <4FD09EF3.8000506@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2012 05:26 PM, ludovic.desroches at atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Fix at91_aic_write macro to avoid potential issues.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And queued in the AT91 branch at91-3.6-cleanup on
git://github.com/at91linux/linux-at91.git

Thanks,

> ---
>  arch/arm/mach-at91/include/mach/at91_aic.h |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
> index 3045781..c1413ed 100644
> --- a/arch/arm/mach-at91/include/mach/at91_aic.h
> +++ b/arch/arm/mach-at91/include/mach/at91_aic.h
> @@ -23,7 +23,7 @@ extern void __iomem *at91_aic_base;
>  	__raw_readl(at91_aic_base + field)
>  
>  #define at91_aic_write(field, value) \
> -	__raw_writel(value, at91_aic_base + field);
> +	__raw_writel(value, at91_aic_base + field)
>  #else
>  .extern at91_aic_base
>  #endif


-- 
Nicolas Ferre
