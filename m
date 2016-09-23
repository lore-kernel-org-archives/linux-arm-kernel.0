From: robh@kernel.org (Rob Herring)
Date: Fri, 23 Sep 2016 10:30:43 -0500
Subject: [PATCH 07/11] dt-bindings: Add DMA bindings for STM32 USART
In-Reply-To: <1473957763-30629-8-git-send-email-alexandre.torgue@st.com>
References: <1473957763-30629-1-git-send-email-alexandre.torgue@st.com>
 <1473957763-30629-8-git-send-email-alexandre.torgue@st.com>
Message-ID: <20160923153043.GA22364@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 06:42:39PM +0200, Alexandre TORGUE wrote:
> Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
> Signed-off-by: Alexandre TORGUE <alexandre.torgue@st.com>

Squash this with the other binding patch. You are describing the h/w 
block, do so completely. 

> 
> diff --git a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> index 75b1400..85ec5f2 100644
> --- a/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> +++ b/Documentation/devicetree/bindings/serial/st,stm32-usart.txt
> @@ -12,6 +12,8 @@ stm32(f4) or stm32f7.
>  Optional properties:
>  - pinctrl: The reference on the pins configuration
>  - st,hw-flow-ctrl: bool flag to enable hardware flow control.
> +- dmas: phandle(s) to DMA controller node(s). Refer to stm32-dma.txt
> +- dma-names: "rx" and/or "tx"
>  
>  Examples:
>  usart4: serial at 40004c00 {
> @@ -32,3 +34,13 @@ usart2: serial at 40004400 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usart2 &pinctrl_usart2_rtscts>;
>  };
> +
> +usart1: serial at 40011000 {
> +	compatible = "st,stm32-usart", "st,stm32-uart";
> +	reg = <0x40011000 0x400>;
> +	interrupts = <37>;
> +	clocks = <&rcc 0 164>;
> +	dmas = <&dma2 2 4 0x414 0x0>,
> +	       <&dma2 7 4 0x414 0x0>;
> +	dma-names = "rx", "tx";
> +};
> -- 
> 1.9.1
> 
