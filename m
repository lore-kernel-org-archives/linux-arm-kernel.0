From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Sat, 12 Mar 2016 21:22:29 +0100
Subject: [PATCH v6 5/6] dt/bindings: rockchip: modify document of Rockchip
 power domains
In-Reply-To: <1457558661-22125-1-git-send-email-zhangqing@rock-chips.com>
References: <1457558578-22049-1-git-send-email-zhangqing@rock-chips.com>
 <1457558661-22125-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <3411414.M8tSXDEXFG@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Donnerstag, 10. M?rz 2016, 05:24:21 schrieb Elaine Zhang:
> Add binding documentation for the power domains
> found on Rockchip RK3399 SoCs
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

that already got Acked by Kevin, aka
Acked-by: Kevin Hilman <khilman@baylibre.com>

When you get things like Acked-by, Reviewed-by, Tested-by tags in one version, 
please include them into new versions. That way these are preserved and 
reviewers won't do work twice.


Heiko


> ---
>  .../bindings/soc/rockchip/power_domain.txt         | 37
> ++++++++++++++++++++++ 1 file changed, 37 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt index
> 13dc6a3..98085c8 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> +++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> @@ -7,6 +7,7 @@ Required properties for power domain controller:
>  - compatible: Should be one of the following.
>  	"rockchip,rk3288-power-controller" - for RK3288 SoCs.
>  	"rockchip,rk3368-power-controller" - for RK3368 SoCs.
> +	"rockchip,rk3399-power-controller" - for RK3399 SoCs.
>  - #power-domain-cells: Number of cells in a power-domain specifier.
>  	Should be 1 for multiple PM domains.
>  - #address-cells: Should be 1.
> @@ -16,6 +17,7 @@ Required properties for power domain sub nodes:
>  - reg: index of the power domain, should use macros in:
>  	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power domain.
> "include/dt-bindings/power/rk3368-power.h" - for RK3368 type power domain.
> +	"include/dt-bindings/power/rk3399-power.h" - for RK3399 type power
> domain. - clocks (optional): phandles to clocks which need to be enabled
> while power domain switches state.
> 
> @@ -45,12 +47,41 @@ Example:
>                  };
>          };
> 
> +Example 2:
> +		power: power-controller {
> +			compatible = "rockchip,rk3399-power-controller";
> +			#power-domain-cells = <1>;
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			pd_vio {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				reg = <RK3399_PD_VIO>;
> +
> +				pd_vo {
> +					#address-cells = <1>;
> +					#size-cells = <0>;
> +					reg = <RK3399_PD_VO>;
> +
> +					pd_vopb {
> +						reg = <RK3399_PD_VOPB>;
> +					};
> +
> +					pd_vopl {
> +						reg = <RK3399_PD_VOPL>;
> +					};
> +				};
> +			};
> +		};
> +
>  Node of a device using power domains must have a power-domains property,
>  containing a phandle to the power device node and an index specifying which
> power domain to use.
>  The index should use macros in:
>  	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power domain.
> "include/dt-bindings/power/rk3368-power.h" - for rk3368 type power domain.
> +	"include/dt-bindings/power/rk3399-power.h" - for rk3399 type power
> domain.
> 
>  Example of the node using power domain:
> 
> @@ -65,3 +96,9 @@ Example of the node using power domain:
>                  power-domains = <&power RK3368_PD_GPU_1>;
>                  /* ... */
>          };
> +
> +	node {
> +		/* ... */
> +		power-domains = <&power RK3399_PD_VOPB>;
> +		/* ... */
> +	};
