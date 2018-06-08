From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 08 Jun 2018 17:21:08 +0300
Subject: [PATCH v2 3/5] arm64: dts: renesas: r8a77980: add DU support
In-Reply-To: <842200af-095f-7096-a542-1d2865543264@cogentembedded.com>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <842200af-095f-7096-a542-1d2865543264@cogentembedded.com>
Message-ID: <2730856.67CqOl6nIY@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for the patch.

On Thursday, 7 June 2018 23:21:38 EEST Sergei Shtylyov wrote:
> Define the generic R8A77980 part of the DU device node.
> 
> Based on the original (and large) patch by Vladimir Barinov.
> 
> Signed-off-by: Vladimir Barinov <vladimir.barinov@cogentembedded.com>
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |   30 ++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -671,6 +671,36 @@
>  			resets = <&cpg 603>;
>  		};
> 
> +		du: display at feb00000 {
> +			compatible = "renesas,du-r8a77980",
> +				     "renesas,du-r8a77970";
> +			reg = <0 0xfeb00000 0 0x80000>;
> +			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&cpg CPG_MOD 724>;
> +			clock-names = "du.0";
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 724>;
> +			vsps = <&vspd0>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					du_out_rgb: endpoint {
> +					};
> +				};
> +
> +				port at 1 {
> +					reg = <1>;
> +					du_out_lvds0: endpoint {
> +					};
> +				};
> +			};
> +		};
> +
>  		prr: chipid at fff00044 {
>  			compatible = "renesas,prr";
>  			reg = <0 0xfff00044 0 4>;

-- 
Regards,

Laurent Pinchart
