From: robh@kernel.org (Rob Herring)
Date: Fri, 27 Nov 2015 14:21:14 -0600
Subject: [PATCH 1/3] dt-bindings: add Marvell core PLL and clock divider
 PMU documentation
In-Reply-To: <E1a24wj-0004iw-Rf@rmk-PC.arm.linux.org.uk>
References: <E1a24wj-0004iw-Rf@rmk-PC.arm.linux.org.uk>
Message-ID: <20151127202114.GA613@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 26, 2015 at 10:23:21PM +0000, Russell King wrote:
> Add documentation for the Marvell clock divider driver, which is used
> to source clocks for the AXI bus, video decoder, GPU and LCD blocks.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  .../bindings/clock/dove-divider-clock.txt          | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/dove-divider-clock.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/dove-divider-clock.txt b/Documentation/devicetree/bindings/clock/dove-divider-clock.txt
> new file mode 100644
> index 000000000000..0c602de279e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/dove-divider-clock.txt
> @@ -0,0 +1,28 @@
> +PLl divider based Dove clocks
> +
> +Marvell Dove has a 2GHz PLL, which feeds into a set of dividers to provide
> +high speed clocks for a number of peripherals.  These dividers are part of
> +the PMU, and thus this node should be a child of the PMU node.

It seems a bit strange to just be documenting these clocks. What about 
the rest of the SOC clocks?

> +
> +The following clocks are provided:
> +
> +ID	Clock
> +-------------
> +0	AXI bus clock
> +1	GPU clock
> +2	VMeta clock
> +3	LCD clock
> +
> +Required properties:
> +- compatible : shall be "marvell,dove-divider-clock"
> +- reg : shall be the register address of the Core PLL and Clock Divider
> +   Control 0 register.  This will cover that register, as well as the
> +   Core PLL and Clock Divider Control 1 register.  Thus, it will have
> +   a size of 8.
> +- #clock-cells : from common clock binding; shall be set to 1
> +
> +divider_clk: core-clock at 0064 {
> +	compatible = "marvell,dove-divider-clock";
> +	reg = <0x0064 0x8>;
> +	#clock-cells = <1>;
> +};
> -- 
> 2.1.0
> 
