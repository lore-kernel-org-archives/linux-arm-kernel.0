From: robh@kernel.org (Rob Herring)
Date: Thu, 23 Mar 2017 21:36:57 -0500
Subject: [PATCH V4 3/4] dt-bindings: serial: add a new compatible string
 for SC9860
In-Reply-To: <1489729898-774-4-git-send-email-chunyan.zhang@spreadtrum.com>
References: <1489729898-774-1-git-send-email-chunyan.zhang@spreadtrum.com>
 <1489729898-774-4-git-send-email-chunyan.zhang@spreadtrum.com>
Message-ID: <20170324023657.2iyh22lr52rme5bu@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 17, 2017 at 01:51:37PM +0800, Chunyan Zhang wrote:
> SC9860 use the same serial device which SC9836 uses, so added a new
> compatible string to support SC9860 as well, also added an example
> of how to describe this serial device in DT.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
> ---
>  Documentation/devicetree/bindings/serial/sprd-uart.txt | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/sprd-uart.txt b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> index 2aff0f2..1db5d6f 100644
> --- a/Documentation/devicetree/bindings/serial/sprd-uart.txt
> +++ b/Documentation/devicetree/bindings/serial/sprd-uart.txt
> @@ -1,7 +1,19 @@
>  * Spreadtrum serial UART
>  
>  Required properties:
> -- compatible: must be "sprd,sc9836-uart"
> +- compatible: must be one of:
> +  * "sprd,sc9836-uart"
> +  * "sprd,sc9860-uart", "sprd,sc9836-uart"
> +
>  - reg: offset and length of the register set for the device
>  - interrupts: exactly one interrupt specifier
>  - clocks: phandles to input clocks.
> +
> +Example:
> +	uart0: serial at 000000 {

serial at 0

With that,

Acked-by: Rob Herring <robh@kernel.org>


> +		compatible = "sprd,sc9860-uart",
> +			     "sprd,sc9836-uart";
> +		reg = <0x000000 0x100>;
> +		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&ext_26m>;
> +	};
> -- 
> 2.7.4
> 
