From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 18:33:00 -0500
Subject: [PATCH 1/3] clk: shmobile: Add DIV6 clock support
In-Reply-To: <1383058511-26046-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-2-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <158C7FC6-F6DF-4F10-B04B-05522D09FC05@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 29, 2013, at 9:55 AM, Laurent Pinchart wrote:

> DIV6 clocks are divider gate clocks controlled through a single
> register. The divider is expressed on 6 bits, hence the name, and can
> take values from 1/1 to 1/64.
> 
> Those clocks are found on Renesas ARM SoCs.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> .../bindings/clock/renesas,cpg-div6-clocks.txt     |  27 +++
> drivers/clk/shmobile/Makefile                      |   4 +-
> drivers/clk/shmobile/clk-div6.c                    | 185 +++++++++++++++++++++
> 3 files changed, 215 insertions(+), 1 deletion(-)
> create mode 100644 Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> create mode 100644 drivers/clk/shmobile/clk-div6.c
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> new file mode 100644
> index 0000000..8036f3c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,cpg-div6-clocks.txt
> @@ -0,0 +1,27 @@
> +* Renesas CPG DIV6 Clock
> +
> +The CPG DIV6 clocks are variable factor clocks provided by the Clock Pulse
> +Generator (CPG). They clock input is divided by a configurable factor from 1
> +to 64.
> +
> +Required Properties:
> +
> +  - compatible: Must be one of the following
> +    - "renesas,r8a7790-div6-clock" for R8A7790 (R-Car H2) DIV6 clocks
> +    - "renesas,cpg-div6-clock" for generic DIV6 clocks
> +  - reg: Base address and length of the memory resource used by the DIV6 clock
> +  - clocks: Reference to the parent clock
> +  - #clock-cells: Must be 0
> +  - clock-output-name: The name of the clock as a free-form string

Is this suppose to be 'clock-output-names' (missing a 's')?

> +
> +
> +Example
> +-------
> +
> +	sd2_clk: sd2_clk {

example should be sd2_clk at e6150078

> +		compatible = "renesas,r8a7790-div6-clock", "renesas,cpg-div6-clock";
> +		reg = <0 0xe6150078 0 4>;

curious, do you really have a second register at 0?

> +		clocks = <&pll1_div2_clk>;
> +		#clock-cells = <0>;
> +		clock-output-names = "sd2";
> +	};

- k


-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
