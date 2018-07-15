From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Sun, 15 Jul 2018 20:21:15 +0530
Subject: [PATCH v4 4/5] arm64: dts: actions: Enable clock controller for
 S700
In-Reply-To: <20180715123145.16975-5-sravanhome@gmail.com>
References: <20180715123145.16975-1-sravanhome@gmail.com>
 <20180715123145.16975-5-sravanhome@gmail.com>
Message-ID: <20180715145115.GE9980@Mani-XPS-13-9360>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 15, 2018 at 02:31:44PM +0200, Saravanan Sekar wrote:
> Added clock management controller for S700
> 

Commit message can be as below:

Add Clock Management Unit binding for Actions Semi S700 SoC.

> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 66dd5309f0a2..19998f19af60 100644
> --- a/arch/arm64/boot/dts/actions/s700.dtsi
> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
> @@ -4,6 +4,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s700-cmu.h>
>  
>  / {
>  	compatible = "actions,s700";
> @@ -44,6 +45,13 @@
>  		};
>  	};
>  
> +	clock: clock-controller at e0168000 {

Following the S900 dts, label can be "cmu" instead of "clock".

> +		compatible = "actions,s700-cmu";
> +		reg = <0 0xe0168000 0 0x1000>;

Should be:

reg = <0x0 0xe0168000 0x0 0x1000>;

Thanks,
Mani

> +		clocks = <&hosc>, <&losc>;
> +		#clock-cells = <1>;
> +	};
> +
>  	reserved-memory {
>  		#address-cells = <2>;
>  		#size-cells = <2>;
> @@ -87,6 +95,12 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	losc: losc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		#clock-cells = <0>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> -- 
> 2.18.0
> 
