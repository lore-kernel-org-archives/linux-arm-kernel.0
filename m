From: robh@kernel.org (Rob Herring)
Date: Mon, 7 Dec 2015 08:39:15 -0600
Subject: [PATCH v2 1/5] dt-bindings: clock: add description of LPC32xx
 clock controller
In-Reply-To: <1449398757-16834-2-git-send-email-vz@mleia.com>
References: <1449398757-16834-1-git-send-email-vz@mleia.com>
 <1449398757-16834-2-git-send-email-vz@mleia.com>
Message-ID: <20151207143915.GA887@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 06, 2015 at 12:45:53PM +0200, Vladimir Zapolskiy wrote:
> NXP LPC32xx SoC has a clocking and power control unit (CPC) as a part
> of system control block (SCB). CPC is supplied by two external
> oscillators and it manages core and most of peripheral
> clocks, the change adds description of DT bindings for clock
> controller found on LPC32xx SoC series.
> 
> Signed-off-by: Vladimir Zapolskiy <vz@mleia.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> Changes from v1 to v2:
> - none
> 
>  .../devicetree/bindings/clock/nxp,lpc3220-clk.txt  | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
> new file mode 100644
> index 0000000..20cbca3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,lpc3220-clk.txt
> @@ -0,0 +1,30 @@
> +NXP LPC32xx Clock Controller
> +
> +Required properties:
> +- compatible: should be "nxp,lpc3220-clk"
> +- reg:  should contain clock controller registers location and length
> +- #clock-cells: must be 1, the cell holds id of a clock provided by the
> +  clock controller
> +- clocks: phandles of external oscillators, the list must contain one
> +  32768 Hz oscillator and may have one optional high frequency oscillator
> +- clock-names: list of external oscillator clock names, must contain
> +  "xtal_32k" and may have optional "xtal"
> +
> +Examples:
> +
> +	/* System Control Block */
> +	scb {
> +		compatible = "simple-bus";
> +		ranges = <0x0 0x040004000 0x00001000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +
> +		clk: clock-controller at 0 {
> +			compatible = "nxp,lpc3220-clk";
> +			reg = <0x00 0x114>;
> +			#clock-cells = <1>;
> +
> +			clocks = <&xtal_32k>, <&xtal>;
> +			clock-names = "xtal_32k", "xtal";
> +		};
> +	};
> -- 
> 2.1.4
> 
