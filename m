From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 19 Feb 2016 00:52:19 +0100
Subject: [PATCH v2 6/6] dt/bindings: rockchip: modify document of Rockchip
 power domains
In-Reply-To: <1455764899-13028-1-git-send-email-zhangqing@rock-chips.com>
References: <1455764899-13028-1-git-send-email-zhangqing@rock-chips.com>
Message-ID: <2204493.j28NF0gtji@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Donnerstag, 18. Februar 2016, 11:08:19 schrieb Elaine Zhang:
> Add binding documentation for the power domains
> found on Rockchip RK3399 SoCs
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>

This patch should probably include the devicetree people

Rob Herring <robh+dt@kernel.org>
Pawel Moll <pawel.moll@arm.com>
Mark Rutland <mark.rutland@arm.com>
Ian Campbell <ijc+devicetree@hellion.org.uk>
Kumar Gala <galak@codeaurora.org>
devicetree at vger.kernel.org


> ---
>  .../bindings/soc/rockchip/power_domain.txt          | 21
> +++++++++++++++++++++ 1 file changed, 21 insertions(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt index
> 13dc6a3..c65d401 100644
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
>  	"include/dt-bindings/power/rk3288-power.h" - for RK3288 type power
> domain. "include/dt-bindings/power/rk3368-power.h" - for RK3368 type
> power domain. +	"include/dt-bindings/power/rk3399-power.h" - for RK3399
> type power domain. - clocks (optional): phandles to clocks which need to
> be enabled while power domain switches state.
> 
> @@ -45,12 +47,25 @@ Example:
>                  };
>          };
> 
> +	power: power-controller {
> +		compatible = "rockchip,rk3399-power-controller";
> +		#power-domain-cells = <1>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		pd_gpu {
> +			reg = <RK3399_PD_GPU>;
> +			clocks = <&cru ACLK_GPU>;
> +		};
> +	};
> +

I don't think we need to add another example for every type of power-domain controller :-) .

>  Node of a device using power domains must have a power-domains property,
>  containing a phandle to the power device node and an index specifying
> which power domain to use.
>  The index should use macros in:
>  	"include/dt-bindings/power/rk3288-power.h" - for rk3288 type power
> domain. "include/dt-bindings/power/rk3368-power.h" - for rk3368 type
> power domain. +	"include/dt-bindings/power/rk3399-power.h" - for rk3399
> type power domain.
> 
>  Example of the node using power domain:
> 
> @@ -65,3 +80,9 @@ Example of the node using power domain:
>                  power-domains = <&power RK3368_PD_GPU_1>;
>                  /* ... */
>          };
> +
> +	node {
> +		/* ... */
> +		power-domains = <&power RK3399_PD_GPU>;
> +		/* ... */
> +	};

same here


Heiko
