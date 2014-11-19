From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Nov 2014 18:07:25 +0000
Subject: [PATCH v7 4/4] dt-bindings: add bindings for mediatek sysirq
In-Reply-To: <1416406451-4578-5-git-send-email-yingjoe.chen@mediatek.com>
References: <1416406451-4578-1-git-send-email-yingjoe.chen@mediatek.com>
 <1416406451-4578-5-git-send-email-yingjoe.chen@mediatek.com>
Message-ID: <20141119180724.GE12851@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 19, 2014 at 02:14:11PM +0000, Yingjoe Chen wrote:
> Add binding documentation for Mediatek SoC SYSIRQ.
> 
> Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,sysirq.txt      | 26 ++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> new file mode 100644
> index 0000000..8669536
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> @@ -0,0 +1,26 @@
> +Mediatek 65xx/81xx sysirq
> +
> +Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
> +interrupt.
> +
> +Required properties:
> +- compatible: should be one of:
> +	"mediatek,mt8135-sysirq"
> +	"mediatek,mt8127-sysirq"
> +	"mediatek,mt6589-sysirq"
> +	"mediatek,mt6582-sysirq"
> +	"mediatek,mt6577-sysirq"
> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Must use the same cells/format as parent controller.
> +- interrupt-parent: phandle of irq domain parent for sysirq.

I'm concerned that this sounds very general while the binding assumes
the GICv2 interrupt-specifier format. Either the driver needs to become
more general, or this needs to be tightened up.

It's also odd to say "irq domain parent", as that's purely a Linux
construct and has nothing to do with the HW.

Thanks,
Mark.

> +- reg: Physical base address of the intpol registers and length of memory
> +  mapped region.
> +
> +Example:
> +	sysirq: interrupt-controller at 10200100 {
> +		compatible = "mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq";
> +		interrupt-controller;
> +		#interrupt-cells = <3>;
> +		interrupt-parent = <&gic>;
> +		reg = <0 0x10200100 0 0x1c>;
> +	};
> -- 
> 1.8.1.1.dirty
> 
> 
