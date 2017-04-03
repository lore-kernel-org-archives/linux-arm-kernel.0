From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 3 Apr 2017 17:59:09 +0200
Subject: [PATCH 4/4] dt-bindings: input: Add Atmel PTC subsystem bindings
In-Reply-To: <20170331152250.12758-5-ludovic.desroches@microchip.com>
References: <20170331152250.12758-1-ludovic.desroches@microchip.com>
 <20170331152250.12758-5-ludovic.desroches@microchip.com>
Message-ID: <20170403155909.wbo4f4x3agqtim5c@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I think this patch should be first so you add the bindings before the
driver.

On 31/03/2017 at 17:22:50 +0200, Ludovic Desroches wrote:
> Add description of the Atmel PTC subsystem bindings.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  .../devicetree/bindings/input/atmel,ptc.txt        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/atmel,ptc.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/atmel,ptc.txt b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> new file mode 100644
> index 0000000..a183fd5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/atmel,ptc.txt
> @@ -0,0 +1,67 @@
> +Atmel PTC Subsystem
> +
> +The Atmel Peripheral Touch Controller subsystem offers built-in hardware
> +for capacitive touch measurement on sensors that function as buttons, sliders
> +and wheels.
> +
> +1) PTC Subsystem node
> +
> +Required properties:
> +- compatible: 		Must be "atmel,sama5d2-ptc"
> +- reg: 			Address, length of the shared memory and ppp registers location
> +			and length.
> +- clocks: 		Phandlers to the clocks.
> +- clock-names: 		Must be "ptc_clk", "ptc_int_osc", "slow_clk".
> +- #address-cells:	Must be one. The cell is the button or scroller id.
> +- #size-cells: 		Must be zero.
> +
> +Example:
> +	ptc at fc060000 {
> +		compatible = "atmel,sama5d2-ptc";
> +		reg = <0x00800000 0x10000
> +		       0xfc060000 0xcf>;
> +		interrupts = <58 IRQ_TYPE_LEVEL_HIGH 7>;
> +		clocks = <&ptc_clk>, <&main>, <&clk32k>;
> +		clock-names = "ptc_clk", "ptc_int_osc", "slow_clk";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		[ child node definitions... ]
> +	};
> +
> +2) Scroller / buttons subnodes
> +
> +Subnodes describe the kind of sensors the customer want to use. They have to be
> +named according to their function: button, slider or wheel.
> +
> +2.1) Scroller subnodes
> +
> +Required properties:
> +- reg:	Id of the scroller, each id must be different.
> +
> +Example:
> +	slider at 0 {
> +		reg = <0>;
> +	};
> +
> +	wheel at 1 {
> +		reg = <1>;
> +	};
> +
> +2.2) Button subnodes
> +
> +Required properties:
> +- reg:			Id of node used for the button, each id must be
> +			different.
> +- linux,keycode: 	Key code of the button.
> +
> +Example:
> +		button at 8 {
> +			reg = <8>;
> +			linux,keycode = <2>;
> +		};
> +
> +		button at 9 {
> +			reg = <9>;
> +			linux,keycode = <3>;
> +		};
> -- 
> 2.9.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
