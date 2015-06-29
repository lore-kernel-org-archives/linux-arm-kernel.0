From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Mon, 29 Jun 2015 15:00:20 +0200
Subject: [PATCH linux-next v2 1/4] ARM: at91/dt: add a new DT property
 to support FIFOs on Atmel USARTs
In-Reply-To: <16bdcf0c3f710ca46df86eeea82c9840454cb7aa.1434038494.git.cyrille.pitchen@atmel.com>
References: <cover.1434038494.git.cyrille.pitchen@atmel.com>
 <16bdcf0c3f710ca46df86eeea82c9840454cb7aa.1434038494.git.cyrille.pitchen@atmel.com>
Message-ID: <55914164.1070800@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 11/06/2015 18:20, Cyrille Pitchen a ?crit :
> This patch adds a new DT property, "atmel,fifo-size", to enable and set
> the maximum number of data the RX and TX FIFOs can store on FIFO capable
> USARTs.
> 
> Please be aware that the VERSION register can not be used to guess the
> size of FIFOs. Indeed, for a given hardware version, the USARTs can be
> integrated on Atmel SoCs with different FIFO sizes. Also the
> "atmel,fifo-size" property is optional as older USARTs don't embed FIFO at
> all.
> 
> Besides, the FIFO size can not be read or guessed from other registers:
> When designing the FIFO feature, no dedicated registers were added to
> store this size. Unsed spaces in the I/O register range are limited and
> better reserved for future usages. Instead, the FIFO size of each
> peripheral is documented in the programmer datasheet.
> 
> Finally, on a given SoC, there can be several instances of USART with
> different FIFO sizes. This explain why we'd rather use a dedicated DT
> property than use the "compatible" property.
> 
> Signed-off-by: Cyrille Pitchen <cyrille.pitchen@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  Documentation/devicetree/bindings/serial/atmel-usart.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/atmel-usart.txt b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> index 90787aa..e6e6142 100644
> --- a/Documentation/devicetree/bindings/serial/atmel-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/atmel-usart.txt
> @@ -22,6 +22,8 @@ Optional properties:
>  		memory peripheral interface and USART DMA channel ID, FIFO configuration.
>  		Refer to dma.txt and atmel-dma.txt for details.
>  	- dma-names: "rx" for RX channel, "tx" for TX channel.
> +- atmel,fifo-size: maximum number of data the RX and TX FIFOs can store for FIFO
> +  capable USARTs.
>  
>  <chip> compatible description:
>  - at91rm9200:  legacy USART support
> @@ -57,4 +59,5 @@ Example:
>  		dmas = <&dma0 2 0x3>,
>  		       <&dma0 2 0x204>;
>  		dma-names = "tx", "rx";
> +		atmel,fifo-size = <32>;
>  	};
> 


-- 
Nicolas Ferre
