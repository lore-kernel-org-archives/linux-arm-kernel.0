From: robh@kernel.org (Rob Herring)
Date: Wed, 1 Nov 2017 19:06:16 -0500
Subject: [PATCH 1/3] arm64: dts: actions: add s900 clock controller nodes
In-Reply-To: <1509479663-8985-2-git-send-email-manivannan.sadhasivam@linaro.org>
References: <1509479663-8985-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1509479663-8985-2-git-send-email-manivannan.sadhasivam@linaro.org>
Message-ID: <20171102000616.ug7s7s6fmnubq7y5@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 01, 2017 at 01:24:21AM +0530, Manivannan Sadhasivam wrote:
> This patch adds clock controller nodes for Actions Semi s900 SoC
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/actions/s900.dtsi | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/actions/s900.dtsi b/arch/arm64/boot/dts/actions/s900.dtsi
> index 11406f6..c099ef1 100644
> --- a/arch/arm64/boot/dts/actions/s900.dtsi
> +++ b/arch/arm64/boot/dts/actions/s900.dtsi
> @@ -5,6 +5,7 @@
>   */
>  
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
> +#include <dt-bindings/clock/actions,s900-clock.h>
>  
>  / {
>  	compatible = "actions,s900";
> @@ -88,6 +89,24 @@
>  		#clock-cells = <0>;
>  	};
>  
> +	losc: losc {
> +		compatible = "fixed-clock";
> +		clock-frequency = <32768>;
> +		#clock-cells = <0>;
> +	};
> +
> +	diff_24M: diff_24M {
> +		compatible = "fixed-clock";
> +		clock-frequency = <24000000>;
> +		#clock-cells = <0>;
> +	};

These 2 are inputs to the clock ctrlr? The clock controller should have 
a clocks property then.

> +
> +	clock: clock-controller at e0160000 {
> +		compatible = "actions,s900-clock";
> +		reg = <0 0xe0160000 0 0x1000>;
> +		#clock-cells = <1>;
> +	};
> +
>  	soc {
>  		compatible = "simple-bus";
>  		#address-cells = <2>;
> -- 
> 2.7.4
> 
