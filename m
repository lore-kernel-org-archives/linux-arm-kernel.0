From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 25 Apr 2016 11:57:50 +0100
Subject: [PATCH v3 2/2] dt-bindings: ARM: Mediatek: add interrupt as
 required properties to the mt6397/mt6323 doc
In-Reply-To: <1460709030-23820-2-git-send-email-henryc.chen@mediatek.com>
References: <1460709030-23820-1-git-send-email-henryc.chen@mediatek.com>
 <1460709030-23820-2-git-send-email-henryc.chen@mediatek.com>
Message-ID: <20160425105750.GB2713@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Apr 2016, Henry Chen wrote:

> MT6397/MT6323 have one interrupt line connected to the main SoC.
> Interrupt should be required feature of pmic, each sub module also
> need it to complete their function or error detect, add it as
> required properties on dts file.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mfd/mt6397.txt | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mt6397.txt b/Documentation/devicetree/bindings/mfd/mt6397.txt
> index 949c85f..a96529e 100644
> --- a/Documentation/devicetree/bindings/mfd/mt6397.txt
> +++ b/Documentation/devicetree/bindings/mfd/mt6397.txt
> @@ -15,7 +15,13 @@ Documentation/devicetree/bindings/soc/pwrap.txt
>  This document describes the binding for MFD device and its sub module.
>  
>  Required properties:
> -compatible: "mediatek,mt6397" or "mediatek,mt6323"
> +- compatible: "mediatek,mt6397" or "mediatek,mt6323"
> +- interrupts: mt6323/mt6397 have one interrupt line connecteded to the main SoC
> +- interrupt-parent: The parent interrupt controller
> +- interrupt-controller : marks the device node as an interrupt controller

Nit: All sentences should start with an upper case char.

The device node is not an interrupt controller -- it's a device node.

The device the device node represents is the interrupt controller.

Look at how others describe this property, it's pretty well used.

> +- #interrupt-cells: the number of cells to describe an IRQ, this should be 2.

Nit: Captial letter.

> +  The first cell is the IRQ number.
> +  The second cell is the flags, encoded as the trigger masks from
>  
>  Optional subnodes:
>  
> @@ -43,6 +49,10 @@ Example:
>  
>  		pmic {
>  			compatible = "mediatek,mt6397";
> +			interrupt-parent = <&pio>;
> +			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
> +			interrupt-controller;
> +			#interrupt-cells = <2>;
>  
>  			codec: mt6397codec {
>  				compatible = "mediatek,mt6397-codec";

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
