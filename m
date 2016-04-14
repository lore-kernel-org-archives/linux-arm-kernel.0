From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 14 Apr 2016 06:52:53 +0200
Subject: [PATCH v2 1/2] dt-bindings: modify document of Rockchip power
 domains
In-Reply-To: <1460599856-4224-2-git-send-email-zhangqing@rock-chips.com>
References: <1460599856-4224-1-git-send-email-zhangqing@rock-chips.com>
 <1460599856-4224-2-git-send-email-zhangqing@rock-chips.com>
Message-ID: <21803486.DAfo7MBcca@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Elaine,

Am Donnerstag, 14. April 2016, 10:10:55 schrieb Elaine Zhang:
> Add qos example for power domain which found on Rockchip SoCs.
> These qos register description in TRMs
> (rk3036, rk3228, rk3288, rk3366, rk3368, rk3399) looks the same.
> 
> Changes in v2:
> 	No Changes.

Changelogs please below the "---" below your Signed-off-by and not as part of 
the commit message.

Also could please check if a commit message like

---- 8< ----
Rockchip SoCs contain quality of service (qos) blocks managing priority, 
bandwidth, etc of the connection of each domain to the interconnect.
These blocks loose state when their domain gets disabled and therefore
need to be saved when disabling and restored when enabling a power-domain.

These qos blocks also are similar over all currently available Rockchip 
SoCs.
---- 8< ----

works for you? [See replies to your v1 series]

> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---

[changelog here]

>  Documentation/devicetree/bindings/soc/rockchip/power_domain.txt | 8
> ++++++++ 1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt index
> 98085c888d65..6c571a40cd31 100644
> --- a/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> +++ b/Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
> @@ -21,6 +21,13 @@ Required properties for power domain sub nodes:
>  - clocks (optional): phandles to clocks which need to be enabled while
> power domain switches state.
> 
> +Qos Example:
> +
> +	qos_gpu: qos_gpu at ffaf0000 {
> +		compatible ="syscon";
> +		reg = <0x0 0xffaf0000 0x0 0x20>;
> +	};
> +
>  Example:
> 
>  	power: power-controller {
> @@ -32,6 +39,7 @@ Example:
>  		pd_gpu {
>  			reg = <RK3288_PD_GPU>;
>  			clocks = <&cru ACLK_GPU>;
> +			pm_qos = <&qos_gpu>;
>  		};
>  	};
