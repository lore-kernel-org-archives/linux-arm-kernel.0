From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 17 Apr 2018 16:31:54 +0200
Subject: [PATCH v4 2/5] arm64: dts: mt2712: add pintcrl device node.
In-Reply-To: <1521687523-1604-3-git-send-email-zhiyong.tao@mediatek.com>
References: <1521687523-1604-1-git-send-email-zhiyong.tao@mediatek.com>
 <1521687523-1604-3-git-send-email-zhiyong.tao@mediatek.com>
Message-ID: <5b132440-d71b-b330-ee82-5e1ea915141b@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 03/22/2018 03:58 AM, Zhiyong Tao wrote:
> This patch adds pintcrl device node for mt2712.
> 
> Signed-off-by: Zhiyong Tao <zhiyong.tao@mediatek.com>
> ---

Applied to v4.17-next/dts64

Thanks!

>  arch/arm64/boot/dts/mediatek/mt2712e.dtsi | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> index d7688bc..fb3b051 100644
> --- a/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt2712e.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/mt2712-power.h>
> +#include "mt2712-pinfunc.h"
>  
>  / {
>  	compatible = "mediatek,mt2712";
> @@ -258,6 +259,23 @@
>  		#clock-cells = <1>;
>  	};
>  
> +	syscfg_pctl_a: syscfg_pctl_a at 10005000 {
> +		compatible = "mediatek,mt2712-pctl-a-syscfg", "syscon";
> +		reg = <0 0x10005000 0 0x1000>;
> +	};
> +
> +	pio: pinctrl at 10005000 {
> +		compatible = "mediatek,mt2712-pinctrl";
> +		reg = <0 0x1000b000 0 0x1000>;
> +		mediatek,pctl-regmap = <&syscfg_pctl_a>;
> +		pins-are-numbered;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +		interrupt-controller;
> +		#interrupt-cells = <2>;
> +		interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
> +	};
> +
>  	scpsys: scpsys at 10006000 {
>  		compatible = "mediatek,mt2712-scpsys", "syscon";
>  		#power-domain-cells = <1>;
> 
