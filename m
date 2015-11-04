From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 4 Nov 2015 18:13:51 +0100
Subject: [PATCH 2/2] ARM: at91/dt: remove bootargs
In-Reply-To: <1446650149-31563-2-git-send-email-alexandre.belloni@free-electrons.com>
References: <1446650149-31563-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1446650149-31563-2-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <563A3CCF.4020308@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/11/2015 16:15, Alexandre Belloni a ?crit :
> Passing earlyprintk in the bootargs may crash the board as it depends on
> having a sane DEBUG_UART_PHYS configured which is not always the case.
> 
> Also remove ignore_loglevel
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  arch/arm/boot/dts/at91-sama5d4_xplained.dts | 1 -
>  arch/arm/boot/dts/at91-sama5d4ek.dts        | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/at91-sama5d4_xplained.dts b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> index d3de7565efc3..5a8adb6a98e1 100644
> --- a/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4_xplained.dts
> @@ -50,7 +50,6 @@
>  	compatible = "atmel,sama5d4-xplained", "atmel,sama5d4", "atmel,sama5";
>  
>  	chosen {
> -		bootargs = "ignore_loglevel earlyprintk";
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> diff --git a/arch/arm/boot/dts/at91-sama5d4ek.dts b/arch/arm/boot/dts/at91-sama5d4ek.dts
> index c9d8b73a65ad..25aebb6d932b 100644
> --- a/arch/arm/boot/dts/at91-sama5d4ek.dts
> +++ b/arch/arm/boot/dts/at91-sama5d4ek.dts
> @@ -50,7 +50,6 @@
>  	compatible = "atmel,sama5d4ek", "atmel,sama5d4", "atmel,sama5";
>  
>  	chosen {
> -		bootargs = "ignore_loglevel earlyprintk";
>  		stdout-path = "serial0:115200n8";
>  	};
>  
> 


-- 
Nicolas Ferre
