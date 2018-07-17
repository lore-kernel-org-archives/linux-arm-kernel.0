From: manivannan.sadhasivam@linaro.org (Manivannan Sadhasivam)
Date: Tue, 17 Jul 2018 19:44:29 +0530
Subject: [PATCH v6 4/5] arm64: dts: actions: Add Clock Management Unit
 for S700
In-Reply-To: <20180715203524.11948-5-sravanhome@gmail.com>
References: <20180715203524.11948-1-sravanhome@gmail.com>
 <20180715203524.11948-5-sravanhome@gmail.com>
Message-ID: <20180717141429.GC19076@mani>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravanan,

On Sun, Jul 15, 2018 at 10:35:23PM +0200, Saravanan Sekar wrote:
> Add Clock Management Unit for Actions Semi S700 SoC.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  arch/arm64/boot/dts/actions/s700.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
> index 66dd5309f0a2..4497741d48b2 100644
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
> +	cmu: clock-controller at e0168000 {
> +		compatible = "actions,s700-cmu";
> +		reg = <0x0 0xe0168000 0x0 0x1000>;
> +		clocks = <&hosc>, <&losc>;
> +		#clock-cells = <1>;
> +	};
> +

CMU node should come under soc, ordered based on the address.

Thanks,
Mani

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
