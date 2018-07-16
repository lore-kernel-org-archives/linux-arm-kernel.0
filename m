From: robh@kernel.org (Rob Herring)
Date: Mon, 16 Jul 2018 15:14:40 -0600
Subject: [PATCH 10/12] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings
In-Reply-To: <1530612152-27555-11-git-send-email-dkos@cadence.com>
References: <1530612152-27555-1-git-send-email-dkos@cadence.com>
 <1530612152-27555-11-git-send-email-dkos@cadence.com>
Message-ID: <20180716211440.GA29964@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 03, 2018 at 11:02:21AM +0100, Damian Kos wrote:
> Document the bindings used for the Cadence MHDP DPI/DP bridge.
> 
> Signed-off-by: Damian Kos <dkos@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.txt          |   39 ++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> new file mode 100644
> index 0000000..d872e26
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
> @@ -0,0 +1,39 @@
> +Cadence MHDP bridge
> +==========================
> +
> +The Cadence MHDP bridge is a DPI to DP bridge.
> +
> +Required properties:
> + - compatible: should be "cdns,mhdp",

Not very specific. Only 1 version of this block?

> + - reg: physical base address and length of the controller's registers,
> + - clocks: DP bridge clock, it's used by the IP to know how to translate
> +	   a number of clock cycles into a time (which is used to comply
> +	   with DP standard timings and delays),
> + - clock-names: must be "clk",

Not a useful name. With only 1 clock, you can just drop this.

> +
> +Required subnodes:
> + - ports: Ports as described in Documentation/devictree/bindings/graph.txt
> +   Currently contains a single input port at address 0 representing the DPI
> +   input.

Currently? You should have a port connecting to a connector node.

> +   Port 0 should be connected to a DPI encoder output.
> +
> +Example:
> +
> +	mhdp: mhdp at 0xf0fb000000 {

dp-bridge at f0fb000000

> +		compatible = "cdns,mhdp";
> +		reg = <0xf0 0xfb000000 0x0 0x1000000>;
> +		clocks = <&mhdp_clock>;
> +		clock-names = "clk";
> +
> +		ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			port at 0 {
> +				reg = <0>;
> +				mhdp0_dpi_input: endpoint {
> +					remote-endpoint = <&xxx_dpi_output>;
> +				};
> +			};
> +		};
> +	};
> -- 
> 1.7.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
