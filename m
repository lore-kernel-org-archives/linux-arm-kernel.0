From: list-09_linux_arm@tqsc.de (Markus Niebel)
Date: Thu, 07 Nov 2013 09:50:50 +0100
Subject: [PATCH 1/2] ARM: dts: imx53-mba53: create a container for fixed
 regulators
In-Reply-To: <1383724993-3731-1-git-send-email-shawn.guo@linaro.org>
References: <1383724993-3731-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <527B546A.8050209@tqsc.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Shawn,

just a little note, not sure what is correct.

Am 06.11.2013 09:03, wrote Shawn Guo:
> To align with others on fixed regulators bindings, it adds node
> 'regulators' as the container and move all regulator-fixed nodes into
> there.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  arch/arm/boot/dts/imx53-mba53.dts |   32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
> index ba95b78..c9ff1a5 100644
> --- a/arch/arm/boot/dts/imx53-mba53.dts
> +++ b/arch/arm/boot/dts/imx53-mba53.dts
> @@ -17,14 +17,6 @@
>  	model = "TQ MBa53 starter kit";
>  	compatible = "tq,mba53", "tq,tqma53", "fsl,imx53";
>  
> -	reg_backlight: fixed at 0 {
> -		compatible = "regulator-fixed";
> -		regulator-name = "lcd-supply";
> -		gpio = <&gpio2 5 0>;
> -		startup-delay-us = <5000>;
> -		enable-active-low;
> -	};
> -
>  	backlight {
>  		compatible = "pwm-backlight";
>  		pwms = <&pwm2 0 50000>;
> @@ -43,12 +35,24 @@
>  		status = "disabled";
>  	};
>  
> -	reg_3p2v: 3p2v {
> -		compatible = "regulator-fixed";
> -		regulator-name = "3P2V";
> -		regulator-min-microvolt = <3200000>;
> -		regulator-max-microvolt = <3200000>;
> -		regulator-always-on;
> +	regulators {
> +		compatible = "simple-bus";

No need for additional 
	#address-cells = <1>;
	#size-cells = <0>;
here as done in ARM: dts: imx: use generic node name for fixed regulator?
> +
> +		reg_backlight: fixed at 0 {
> +			compatible = "regulator-fixed";
> +			regulator-name = "lcd-supply";
> +			gpio = <&gpio2 5 0>;
> +			startup-delay-us = <5000>;
> +			enable-active-low;
> +		};
> +
> +		reg_3p2v: 3p2v {
> +			compatible = "regulator-fixed";
> +			regulator-name = "3P2V";
> +			regulator-min-microvolt = <3200000>;
> +			regulator-max-microvolt = <3200000>;
> +			regulator-always-on;
> +		};
>  	};
>  
>  	sound {
> 

Markus
