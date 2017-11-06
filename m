From: robh@kernel.org (Rob Herring)
Date: Mon, 6 Nov 2017 16:43:02 -0600
Subject: [PATCH v2 1/2] dt-bindings: add description of Socionext EXIU
 interrupt controller
In-Reply-To: <20171106183437.18214-1-ard.biesheuvel@linaro.org>
References: <20171106183437.18214-1-ard.biesheuvel@linaro.org>
Message-ID: <20171106224302.vnholvtagpmulays@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 06, 2017 at 06:34:36PM +0000, Ard Biesheuvel wrote:
> Add a description of the External Interrupt Unit (EXIU) interrupt
> controller as found on the Socionext SynQuacer SoC.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt | 32 ++++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
> new file mode 100644
> index 000000000000..dc3778b6fbee
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
> @@ -0,0 +1,32 @@
> +Socionext SynQuacer External Interrupt Unit (EXIU)
> +
> +The Socionext Synquacer SoC has an external interrupt unit (EXIU)
> +that forwards a block of 32 configurable input lines to 32 adjacent
> +level-high type GICv3 SPIs.
> +
> +Required properties:
> +
> +- compatible           : Should be "socionext,synquacer-exiu".
> +- reg                  : Specifies base physical address and size of the
> +                         control registers.
> +- interrupt-controller : Identifies the node as an interrupt controller.
> +- #interrupt-cells     : Specifies the number of cells needed to encode an
> +                         interrupt source. The value must be 3.
> +- interrupt-parent     : phandle of the GIC these interrupts are routed to.
> +- socionext,spi-base   : The SPI number of the first SPI of the 32 adjacent
> +                         ones the EXIU forwards its interrups to.
> +
> +Notes:
> +
> +- Only SPIs can use the EXIU as an interrupt parent.
> +
> +Example:
> +
> +	exiu: exiu at 510c0000 {

interrupt-controller at ...

With that,

Acked-by: Rob Herring <robh@kernel.org>

> +		compatible = "socionext,synquacer-exiu";
> +		reg = <0x0 0x510c0000 0x0 0x20>;
> +		interrupt-controller;
> +		interrupt-parent = <&gic>;
> +		#interrupt-cells = <3>;
> +		socionext,spi-base = <112>;
> +	};
> -- 
> 2.11.0
> 
