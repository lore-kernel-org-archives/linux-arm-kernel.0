From: robh@kernel.org (Rob Herring)
Date: Mon, 20 Aug 2018 14:40:57 -0500
Subject: [PATCH v2 1/3] dt-bindings: soc: Add ZynqMP PM bindings
In-Reply-To: <1534446483-12156-2-git-send-email-jollys@xilinx.com>
References: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
 <1534446483-12156-2-git-send-email-jollys@xilinx.com>
Message-ID: <20180820194057.GA21738@bogus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2018 at 12:08:01PM -0700, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add documentation to describe Xilinx ZynqMP power management
> bindings.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  .../bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt    | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> index d215d15..cb9a6b7 100644
> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
> @@ -64,6 +64,17 @@ Output clocks are registered based on clock information received
>  from firmware. Output clocks indexes are mentioned in
>  include/dt-bindings/clock/xlnx,zynqmp-clk.h.
>  
> +--------------------------------------------------------------------
> +Device Tree Bindings for the Xilinx Zynq MPSoC Power Management
> +--------------------------------------------------------------------
> +The zynqmp-power node describes the power management configurations.
> +It will control remote suspend/shutdown interfaces.
> +
> +Required properties:
> + - compatible:		Must contain:	"xlnx,zynqmp-power"
> + - interrupt-parent:	Interrupt controller the interrupt is routed through

interrupt-parent is implied and could be in a parent node, so remove.

With that,

Reviewed-by: Rob Herring <robh@kernel.org>

> + - interrupts:		Interrupt specifier
> +
>  -------
>  Example
>  -------
> @@ -78,5 +89,10 @@ firmware {
>  			clocks = <&pss_ref_clk>, <&video_clk>, <&pss_alt_ref_clk>, <&aux_ref_clk>, <&gt_crx_ref_clk>;
>  			clock-names = "pss_ref_clk", "video_clk", "pss_alt_ref_clk","aux_ref_clk", "gt_crx_ref_clk";
>  		};
> +		zynqmp_power: zynqmp-power {
> +			compatible = "xlnx,zynqmp-power";
> +			interrupt-parent = <&gic>;
> +			interrupts = <0 35 4>;
> +		};
>  	};
>  };
> -- 
> 2.7.4
> 
