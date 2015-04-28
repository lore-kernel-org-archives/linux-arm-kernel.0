From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Tue, 28 Apr 2015 22:10:20 +0800
Subject: [PATCH 2/4] ARM: dts: mt8135: Add pmic wrapper nodes
In-Reply-To: <1429780875-29096-3-git-send-email-s.hauer@pengutronix.de>
References: <1429780875-29096-1-git-send-email-s.hauer@pengutronix.de>
 <1429780875-29096-3-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1430230220.32537.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-04-23 at 11:21 +0200, Sascha Hauer wrote:
> This adds the pmic wrapper node to the MediaTek MT8135 dtsi file.
> 
> This unit is used to access the PMIC on MediaTek boards.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/mt8135.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/mt8135.dtsi b/arch/arm/boot/dts/mt8135.dtsi
> index b4017e2..b0f20fc 100644
> --- a/arch/arm/boot/dts/mt8135.dtsi
> +++ b/arch/arm/boot/dts/mt8135.dtsi
> @@ -15,6 +15,7 @@
>  #include <dt-bindings/clock/mt8135-clk.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/reset-controller/mt8135-resets.h>
>  #include "skeleton64.dtsi"
>  
>  / {
> @@ -127,6 +128,19 @@
>  			reg = <0 0x10003000 0 0x1000>;
>  		};
>  
> +		pwrap: pwrap at 1000f000 {
> +			compatible = "mediatek,mt8135-pwrap";
> +			reg = <0 0x1000f000 0 0x1000>,
> +				<0 0x11017000 0 0x1000>;
> +			reg-names = "pwrap", "pwrap-bridge";
> +			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
> +			resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
> +					<&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
> +			reset-names = "pwrap", "pwrap-bridge";
> +			clocks = <&clk26m>, <&clk26m>;
> +			clock-names = "spi", "wrap";
> +		};
> +
>  		timer: timer at 10008000 {

Hi Sascha,

It seems we have many 8135 dtsi updates recently.
Please sort according to node instance address so it will be easier to
merge or resolve conflict.

Joe.C
