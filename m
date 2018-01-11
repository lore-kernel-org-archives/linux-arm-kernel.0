From: robh@kernel.org (Rob Herring)
Date: Thu, 11 Jan 2018 15:45:16 -0600
Subject: [PATCH v5 17/44] dt-bindings: clock: Add bindings for DA8XX
 CFGCHIP gate clocks
In-Reply-To: <1515377863-20358-18-git-send-email-david@lechnology.com>
References: <1515377863-20358-1-git-send-email-david@lechnology.com>
 <1515377863-20358-18-git-send-email-david@lechnology.com>
Message-ID: <20180111214516.quplp3kwwfrzocfp@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 07, 2018 at 08:17:16PM -0600, David Lechner wrote:
> This adds a new binding for the gate clocks present in the CFGCHIP syscon
> registers in TI DA8XX SoCs. There are actually other gate clocks in this
> block that could be added in the future, but TBCLK is currently the only
> one being used.

Like how many? 2 more?, then fine. 20 more, then perhaps cfgchip should 
be the clock provider.

In any case, I'd prefer to see all the cfgchip clocks documented in one 
doc.

> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../clock/ti/davinci/da8xx-cfgchip-gate.txt        | 38 ++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-gate.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-gate.txt b/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-gate.txt
> new file mode 100644
> index 0000000..55821b0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/ti/davinci/da8xx-cfgchip-gate.txt
> @@ -0,0 +1,38 @@
> +Binding for TI DA8XX/OMAP-L13X/AM17XX/AM18XX CFGCHIP gate clocks
> +
> +TI DA8XX/OMAP-L13X/AM17XX/AM18XX SoCs contain a general purpose set of
> +registers call CFGCHIPn. Some of these registers function as clock
> +gates. This document describes the bindings for those clocks.
> +
> +Required properties:
> +- compatible: shall be "ti,da830-tbclk".
> +- #clock-cells: from common clock binding; shall be set to 0.
> +- clocks: phandle to the parent clock
> +
> +Optional properties:
> +- clock-output-names: from common clock binding.
> +
> +Parent:
> +This node must be a child of a "ti,da830-cfgchip" node.
> +
> +Assignment:
> +The assigned-clocks and assigned-clock-parents from the common clock bindings
> +can be used to indicate which parent clock should be used.
> +
> +Examples:
> +
> +	cfgchip: syscon at 1417c {
> +		compatible = "ti,da830-cfgchip", "syscon", "simple-mfd";
> +		reg = <0x1417c 0x14>;
> +
> +		ehrpwm_tbclk: tbclk {
> +			compatible = "ti,da830-tbclk";
> +			#clock-cells = <0>;
> +			clocks = <&psc1 17>;
> +			clock-output-names = "ehrpwm_tbclk";
> +		};
> +	};
> +
> +Also see:
> +- Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> -- 
> 2.7.4
> 
