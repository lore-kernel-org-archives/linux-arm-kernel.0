From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Tue, 9 Jul 2013 09:40:59 +0200
Subject: [PATCH 7/7] serial: at91: add dma support in usart binding
 descriptions
In-Reply-To: <1373351626-30143-8-git-send-email-elen.song@atmel.com>
References: <1373351626-30143-1-git-send-email-elen.song@atmel.com>
 <1373351626-30143-8-git-send-email-elen.song@atmel.com>
Message-ID: <20130709074059.GC4013@ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 09, 2013 at 02:33:46PM +0800, Elen Song wrote:

[...]

>  Example:
> -
> +- use PDC:
>  	usart0: serial at fff8c000 {
>  		compatible = "atmel,at91sam9260-usart";
>  		reg = <0xfff8c000 0x200>;
> @@ -25,3 +31,12 @@ Example:
>  		atmel,use-pdc-tx;
>  	};
>  
> +- use DMA:
> +	usart0: serial at f001c000 {
> +		compatible = "atmel,at91sam9260-usart";
> +		reg = <0xf001c000 0x100>;
> +		interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
> +		dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
> +		       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;

Same comment than patch 1/7. Maybe wait for confirmation by someone else before
correcting it.

> +		dma-names = "tx", "rx";
> +	};
> -- 
> 1.7.9.5
> 
