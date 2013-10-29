From: galak@codeaurora.org (Kumar Gala)
Date: Tue, 29 Oct 2013 18:56:42 -0500
Subject: [PATCH 3/3] clk: shmobile: Add R8A7790 clocks support
In-Reply-To: <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383058511-26046-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1383058511-26046-4-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <A519A094-2E76-43C7-99D8-763122413ECD@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Oct 29, 2013, at 9:55 AM, Laurent Pinchart wrote:

> The R8A7790 has several clocks that are too custom to be supported in a
> generic driver. Those clocks can be divided in two categories:
> 
> - Fixed rate clocks with multiplier and divisor set according to boot
>  mode configuration
> 
> - Custom divider clocks with SoC-specific divider values
> 
> This driver supports both.
> 
> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> ---
> .../bindings/clock/renesas,r8a7790-cpg-clocks.txt  |  26 +++
> drivers/clk/shmobile/Makefile                      |   1 +
> drivers/clk/shmobile/clk-r8a7790.c                 | 176 +++++++++++++++++++++
> include/dt-bindings/clock/r8a7790-clock.h          |  10 ++
> include/linux/clk/shmobile.h                       |  19 +++
> 5 files changed, 232 insertions(+)
> create mode 100644 Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> create mode 100644 drivers/clk/shmobile/clk-r8a7790.c
> create mode 100644 include/linux/clk/shmobile.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt b/Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> new file mode 100644
> index 0000000..d889917
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/renesas,r8a7790-cpg-clocks.txt
> @@ -0,0 +1,26 @@
> +* Renesas R8A7790 Clock Pulse Generator (CPG)
> +
> +The CPG generates core clocks for the R8A7790. It includes three PLLs and
> +several fixed ratio dividers.
> +
> +Required Properties:
> +
> +  - compatible: Must be "renesas,r8a7790-cpg-clocks"
> +  - reg: Base address and length of the memory resource used by the CPG
> +  - clocks: Reference to the parent clock
> +  - #clock-cells: Must be 1
> +  - clock-output-names: The name of the clocks, must be "main", "pll1",
> +    "pll3", "lb", "qspi", "sdh", "sd0", "sd1".
> +
> +
> +Example
> +-------
> +
> +	cpg_clocks: cpg_clocks {

cpg_clocks at e6150000

> +		compatible = "renesas,r8a7790-cpg-clocks";
> +		reg = <0 0xe6150000 0 0x1000>;
> +		clocks = <&extal_clk>;
> +		#clock-cells = <1>;
> +		clock-output-names = "main", "pll1", "pll3", "lb",
> +				     "qspi", "sdh", "sd0", "sd1";
> +	};

Other than minor nit, ack.

For the DT-Binding portion:

Acked-by: Kumar Gala <galak@codeaurora.org>

- k



-- 
Employee of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
