From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 29 Nov 2017 11:35:36 -0800
Subject: [PATCH v3 3/3] arm64: dts: meson-axg: add clock DT info for
 Meson AXG SoC
In-Reply-To: <20171128125330.363-4-yixun.lan@amlogic.com>
References: <20171128125330.363-1-yixun.lan@amlogic.com>
 <20171128125330.363-4-yixun.lan@amlogic.com>
Message-ID: <20171129193536.GB19419@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/28, Yixun Lan wrote:
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index b932a784b02a..36a2e98338a8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -7,6 +7,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/axg-clkc.h>
>  
>  / {
>  	compatible = "amlogic,meson-axg";
> @@ -148,6 +149,20 @@
>  			#address-cells = <0>;
>  		};
>  
> +		hiubus: hiubus at ff63c000 {

Maybe just call the node "bus at ff63c000"?

> +			compatible = "simple-bus";
> +			reg = <0x0 0xff63c000 0x0 0x1c00>;
> +			#address-cells = <2>;
> +			#size-cells = <2>;
> +			ranges = <0x0 0x0 0x0 0xff63c000 0x0 0x1c00>;
> +
> +			clkc: clock-controller at 0 {
> +				compatible = "amlogic,axg-clkc";
> +				#clock-cells = <1>;
> +				reg = <0x0 0x0 0x0 0x320>;
> +			};
> +		};
> +
>  		mailbox: mailbox at ff63dc00 {
>  			compatible = "amlogic,meson-gx-mhu", "amlogic,meson-gxbb-mhu";
>  			reg = <0 0xff63dc00 0 0x400>;
> -- 
> 2.15.0
> 

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
