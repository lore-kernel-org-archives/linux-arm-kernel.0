From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 14 Jan 2015 14:42:21 +0100
Subject: [PATCH v2 2/5] irqchip: Add DT binding doc for dumb demuxer chips
In-Reply-To: <1421174781-4340-3-git-send-email-boris.brezillon@free-electrons.com>
References: <1421174781-4340-1-git-send-email-boris.brezillon@free-electrons.com>
 <1421174781-4340-3-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54B6723D.4050009@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 13/01/2015 19:46, Boris Brezillon a ?crit :
> Add documentation for the dumb demuxer.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  .../bindings/interrupt-controller/dumb-demux.txt   | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> new file mode 100644
> index 0000000..1c777ef
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/dumb-demux.txt
> @@ -0,0 +1,34 @@
> +* Generic Dumb Interrupt Demultiplexer
> +
> +This Dumb demultiplixer simply forward all incoming interrupts to its
> +enabled/unmasked children.
> +
> +Required properties:
> +- compatible: Should be "irqchip-dumb-demux".
> +- interrupt-controller: Identifies the node as an interrupt controller.
> +- interrupts-extended or interrupt-parent and interrupts: Reference the source
> +  interrupt connected to this dumb demuxer.
> +- #interrupt-cells: The number of cells to define the interrupts (should be 1).
> +  The only cell is the IRQ number.
> +- irqs: u32 bitfield specifying the interrupts provided by the demuxer.
> +
> +Examples:
> +	/*
> +	 * Dumb demuxer controller
> +	 */
> +	dumb_irq1_demux: dumb-irq-demux at 1 {
> +		compatible = "irqchip-dumb-demux";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		interrupts-extended = <&aic 1 IRQ_TYPE_LEVEL_HIGH 7>;
> +		irqs = <0x3f>;
> +	};
> +
> +	/*
> +	 * Device connected on this dumb demuxer
> +	 */
> +	dma: dma-controller at ffffec00 {
> +		compatible = "atmel,at91sam9g45-dma";
> +		reg = <0xffffec00 0x200>;
> +		interrupts-extended = <&dumb_irq1_demux 0>;
> +	};
> 


-- 
Nicolas Ferre
