From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 9 Jan 2015 11:50:14 +0000
Subject: [PATCH v2 4/8] irqchip: devicetree: document Conexant Digicolor
 irq binding
In-Reply-To: <3bdf8fa0bf971b4881024e72312c3c9d29298e79.1420744369.git.baruch@tkos.co.il>
References: <cover.1420744368.git.baruch@tkos.co.il>
 <3bdf8fa0bf971b4881024e72312c3c9d29298e79.1420744369.git.baruch@tkos.co.il>
Message-ID: <20150109115014.GC12942@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 08, 2015 at 07:40:00PM +0000, Baruch Siach wrote:
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>
> ---
>  .../bindings/interrupt-controller/digicolor-ic.txt   | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> new file mode 100644
> index 000000000000..fdf9a4c59bf3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/digicolor-ic.txt
> @@ -0,0 +1,20 @@
> +Conexant Digicolor Interrupt Controller
> +
> +Required properties:
> +
> +- compatible : should be "cnxt,cx92755-ic"

I didn't spot "cnxt" in
Documentation/devicetree/bindings/vendor-prefixes.txt in mainline, nor
did I spot it added as part of this series. Please add it, assuming a
patch doing so is not already queued elsewhere.

> +- reg : Specifies base physical address and size of the MISC area, that is
> +  where the interrupt controller registers are located

Is this area shared with other devices?

> +- interrupt-controller : Identifies the node as an interrupt controller
> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +  interrupt source. The value shall be 1.

There is no configuration that can be applied to individual interrupt
lines (e.g. trigger type)?

Thanks,
Mark.

> +
> +Example:
> +
> +	intc: intc at f0000000 {
> +		compatible = "cnxt,cx92755-ic";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +		reg = <0xf0000000 0x1000>;
> +	};
> +
> -- 
> 2.1.4
> 
> 
