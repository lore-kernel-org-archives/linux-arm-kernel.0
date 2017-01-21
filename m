From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 20 Jan 2017 16:52:02 -0800
Subject: [PATCH v5 1/2] dt-bindings: brcm: clocks: add binding for
 brcmstb-cpu-clk-div
In-Reply-To: <20170119002933.7529-2-code@mmayer.net>
References: <20170119002933.7529-1-code@mmayer.net>
 <20170119002933.7529-2-code@mmayer.net>
Message-ID: <20170121005202.GB8801@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18, Markus Mayer wrote:
> diff --git a/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> new file mode 100644
> index 0000000..c4acb53
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/brcm,brcmstb-cpu-clk-div.txt
> @@ -0,0 +1,27 @@
> +The CPU divider node serves as the sole clock for the CPU complex. It supports
> +power-of-2 clock division, with a divider of "1" as the default highest-speed
> +setting.
> +
> +Required properties:
> +- compatible: shall be "brcm,brcmstb-cpu-clk-div"
> +- reg: address and width of the divider configuration register
> +- #clock-cells: shall be set to 0
> +- clocks: phandle of clock provider which provides the source clock
> +          (this would typically be a "fixed-clock" type PLL)
> +- div-table: list of (raw_value,divider) ordered pairs that correspond to the
> +             allowed clock divider settings
> +- div-shift-width: least-significant bit position and width of divider value

Are these properties used? Please don't put these types of
details in DT.

> +
> +Optional properties:
> +- clock-names: the clock may be named
> +
> +Example:
> +	cpuclkdiv: cpu-clk-div at f03e257c {
> +		compatible = "brcm,brcmstb-cpu-clk-div";
> +		reg = <0xf03e257c 0x4>;

This register really looks like some offset in something larger.
Is there some clock controller? What's the hw block at
0xf03e2000? Maybe I already asked this.

> +		div-table = <0x00 1>;
> +		div-shift-width = <0 5>;
> +		#clock-cells = <0>;
> +		clocks = <&cpupll>;
> +		clock-names = "cpupll";
> +	};
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
