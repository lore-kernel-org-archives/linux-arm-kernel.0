From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 5 Mar 2015 10:58:27 +0100
Subject: [PATCH] ARM: at91: debug: fix non MMU debug
In-Reply-To: <1425480087-31097-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1425480087-31097-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <54F828C3.6090901@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 04/03/2015 15:41, Alexandre Belloni a ?crit :
> Linux may be used without MMU on atmel SoCs, fix debug in this configuration.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
and stacked on top of at91-4.0-fixes.

Thanks!

> ---
>  arch/arm/include/debug/at91.S | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/debug/at91.S b/arch/arm/include/debug/at91.S
> index 80a6501b4d50..c3c45e628e33 100644
> --- a/arch/arm/include/debug/at91.S
> +++ b/arch/arm/include/debug/at91.S
> @@ -18,8 +18,11 @@
>  #define AT91_DBGU 0xfc00c000 /* SAMA5D4_BASE_USART3 */
>  #endif
>  
> -/* Keep in sync with mach-at91/include/mach/hardware.h */
> +#ifdef CONFIG_MMU
>  #define AT91_IO_P2V(x) ((x) - 0x01000000)
> +#else
> +#define AT91_IO_P2V(x) (x)
> +#endif
>  
>  #define AT91_DBGU_SR		(0x14)	/* Status Register */
>  #define AT91_DBGU_THR		(0x1c)	/* Transmitter Holding Register */
> 


-- 
Nicolas Ferre
