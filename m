From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Sep 2014 18:19:06 +0200
Subject: [PATCH] ARM: at91: enable new AIC driver even if the old one
 is selected
In-Reply-To: <1410254099-24680-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1410254099-24680-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <5422EEFA.7020303@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/09/2014 11:14, Boris BREZILLON :
> The new AIC driver is currently only selected when only DT board support
> is enabled (and not when both DT and non-DT boards are supported), thus,
> when booting a "DT + non-DT" kernel with a dtb, the irqchip is never
> initialized/registered which then triggers a panic.
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

I'm not taking this right now. The Kconfig file is in flux. I'll try to
queue it during the 3.18-rc phase.

Bye,

> ---
>  arch/arm/mach-at91/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
> index 7df2c9b..cd7c0cb 100644
> --- a/arch/arm/mach-at91/Kconfig
> +++ b/arch/arm/mach-at91/Kconfig
> @@ -51,7 +51,7 @@ config HAVE_AT91_SMD
>  config SOC_AT91SAM9
>  	bool
>  	select AT91_SAM9_TIME
> -	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
> +	select ATMEL_AIC_IRQ
>  	select CPU_ARM926T
>  	select GENERIC_CLOCKEVENTS
>  
> @@ -111,7 +111,7 @@ endif
>  if SOC_SAM_V4_V5
>  config SOC_AT91RM9200
>  	bool "AT91RM9200"
> -	select ATMEL_AIC_IRQ if !OLD_IRQ_AT91
> +	select ATMEL_AIC_IRQ
>  	select CPU_ARM920T
>  	select GENERIC_CLOCKEVENTS
>  	select HAVE_AT91_DBGU0
> 


-- 
Nicolas Ferre
