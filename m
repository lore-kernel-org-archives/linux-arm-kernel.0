From: shawn.lin@rock-chips.com (Shawn Lin)
Date: Wed, 3 Feb 2016 10:07:50 +0800
Subject: [PATCH v3 4/4] ARM64: dts: rockchip: add syscon-reboot-mode DT
 node
In-Reply-To: <1454407999-5476-1-git-send-email-andy.yan@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407999-5476-1-git-send-email-andy.yan@rock-chips.com>
Message-ID: <56B160F6.20308@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/2/2 18:13, Andy Yan wrote:
> Add syscon-reboot-mode driver DT node for rk3368 platform
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>

Work fine with my rk3368-sheep board :)

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>
> Changes in v3:
> - descirbe all reboot mode as property instead of subnode
>
> Changes in v2:
> - make this node as a subnode of pmugrf
>
> Changes in v1: None
>
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index 122777b..5213713 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -45,6 +45,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip_boot-mode.h>
>   #include <dt-bindings/thermal/thermal.h>
>
>   / {
> @@ -554,8 +555,19 @@
>   	};
>
>   	pmugrf: syscon at ff738000 {
> -		compatible = "rockchip,rk3368-pmugrf", "syscon";
> +		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
>   		reg = <0x0 0xff738000 0x0 0x1000>;
> +
> +		reboot-mode {
> +			compatible = "syscon-reboot-mode";
> +			offset = <0x200>;
> +			mode-normal = <BOOT_NORMAL>;
> +			mode-recovery = <BOOT_RECOVERY>;
> +			mode-fastboot = <BOOT_FASTBOOT>;
> +			mode-loader = <BOOT_LOADER>;
> +			mode-maskrom = <BOOT_MASKROM>;
> +
> +		};
>   	};
>
>   	cru: clock-controller at ff760000 {
>


-- 
Best Regards
Shawn Lin
