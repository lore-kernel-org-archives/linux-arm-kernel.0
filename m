From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 12 Aug 2014 19:08:53 +0200
Subject: [PATCH] ARM: at91: sama5d3: add usart dma configurations
In-Reply-To: <1407854277-328-1-git-send-email-ludovic.desroches@atmel.com>
References: <1407854277-328-1-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <53EA4A25.1040707@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/08/2014 16:37, Ludovic Desroches :
> Add the DMA configuration for USARTs mainly because it is not obvious to
> add the FIFO flag which is needed for rx.

Indeed.

> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Thanks, best regards,

> ---
>  arch/arm/boot/dts/sama5d3.dtsi |   15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index e0b15a6..829c162 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -177,6 +177,9 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf001c000 0x100>;
>  				interrupts = <12 IRQ_TYPE_LEVEL_HIGH 5>;
> +				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(3)>,
> +				       <&dma0 2 (AT91_DMA_CFG_PER_ID(4) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_usart0>;
>  				clocks = <&usart0_clk>;
> @@ -188,6 +191,9 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf0020000 0x100>;
>  				interrupts = <13 IRQ_TYPE_LEVEL_HIGH 5>;
> +				dmas = <&dma0 2 AT91_DMA_CFG_PER_ID(5)>,
> +				       <&dma0 2 (AT91_DMA_CFG_PER_ID(6) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_usart1>;
>  				clocks = <&usart1_clk>;
> @@ -333,6 +339,9 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8020000 0x100>;
>  				interrupts = <14 IRQ_TYPE_LEVEL_HIGH 5>;
> +				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(7)>,
> +				       <&dma1 2 (AT91_DMA_CFG_PER_ID(8) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_usart2>;
>  				clocks = <&usart2_clk>;
> @@ -344,6 +353,9 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xf8024000 0x100>;
>  				interrupts = <15 IRQ_TYPE_LEVEL_HIGH 5>;
> +				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(9)>,
> +				       <&dma1 2 (AT91_DMA_CFG_PER_ID(10) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_usart3>;
>  				clocks = <&usart3_clk>;
> @@ -410,6 +422,9 @@
>  				compatible = "atmel,at91sam9260-usart";
>  				reg = <0xffffee00 0x200>;
>  				interrupts = <2 IRQ_TYPE_LEVEL_HIGH 7>;
> +				dmas = <&dma1 2 AT91_DMA_CFG_PER_ID(13)>,
> +				       <&dma1 2 (AT91_DMA_CFG_PER_ID(14) | AT91_DMA_CFG_FIFOCFG_ASAP)>;
> +				dma-names = "tx", "rx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_dbgu>;
>  				clocks = <&dbgu_clk>;
> 


-- 
Nicolas Ferre
