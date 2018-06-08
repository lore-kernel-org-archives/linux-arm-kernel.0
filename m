From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Fri, 08 Jun 2018 17:24:24 +0300
Subject: [PATCH v2 4/5] arm64: dts: renesas: r8a77980: add LVDS support
In-Reply-To: <3e46c70c-c6be-d019-95a9-bf09c888c9c0@cogentembedded.com>
References: <390fabf0-4caf-1600-3780-1893207d94f7@cogentembedded.com>
 <3e46c70c-c6be-d019-95a9-bf09c888c9c0@cogentembedded.com>
Message-ID: <9345530.G21j7jBrXu@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thank you for the patch.

On Thursday, 7 June 2018 23:23:06 EEST Sergei Shtylyov wrote:
> Define the generic R8A77980 part of the LVDS device node.
> 
> Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  arch/arm64/boot/dts/renesas/r8a77980.dtsi |   29 ++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> Index: renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> ===================================================================
> --- renesas.orig/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> +++ renesas/arch/arm64/boot/dts/renesas/r8a77980.dtsi
> @@ -696,6 +696,35 @@
>  				port at 1 {
>  					reg = <1>;
>  					du_out_lvds0: endpoint {
> +						remote-endpoint = <&lvds0_in>;
> +					};
> +				};
> +			};
> +		};
> +
> +		lvds0: lvds-encoder at feb90000 {
> +			compatible = "renesas,r8a77980-lvds";
> +			reg = <0 0xfeb90000 0 0x14>;
> +			clocks = <&cpg CPG_MOD 727>;
> +			power-domains = <&sysc R8A77980_PD_ALWAYS_ON>;
> +			resets = <&cpg 727>;
> +			status = "disabled";
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +
> +				port at 0 {
> +					reg = <0>;
> +					lvds0_in: endpoint {
> +						remote-endpoint =
> +							<&du_out_lvds0>;
> +					};
> +				};
> +
> +				port at 1 {
> +					reg = <1>;
> +					lvds0_out: endpoint {
>  					};
>  				};
>  			};

-- 
Regards,

Laurent Pinchart
