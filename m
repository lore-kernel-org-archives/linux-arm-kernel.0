From: shawnguo@kernel.org (Shawn Guo)
Date: Sun, 4 Nov 2018 16:25:35 +0800
Subject: [PATCH V1] ARM: dts: sabreauto: Remove reg property from fixed
 regulator
In-Reply-To: <20181024102255.25640-1-qiangqing.zhang@nxp.com>
References: <20181024102255.25640-1-qiangqing.zhang@nxp.com>
Message-ID: <20181104082533.GD26016@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 24, 2018 at 10:25:12AM +0000, Joakim Zhang wrote:
> Remove reg property from fixed regulator as upstream has no longer
> needed this property.

Prefix 'ARM: dts: imx6qdl-sabreauto: ...' should be more accurate.  And
the 'reg' property was there only because we have a fake bus container
node 'regulators'.

I applied the patch after updating the prefix and rewording the commit
log a little bit.

Shawn

> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 53 ++++++++++--------------
>  1 file changed, 22 insertions(+), 31 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> index a6dc5c42c632..a10f0ad0bfb1 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
> @@ -75,39 +75,30 @@
>  		};
>  	};
>  
> -	regulators {
> -		compatible = "simple-bus";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> +	reg_audio: regulator-audio {
> +		compatible = "regulator-fixed";
> +		regulator-name = "cs42888_supply";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
>  
> -		reg_audio: regulator at 0 {
> -			compatible = "regulator-fixed";
> -			reg = <0>;
> -			regulator-name = "cs42888_supply";
> -			regulator-min-microvolt = <3300000>;
> -			regulator-max-microvolt = <3300000>;
> -			regulator-always-on;
> -		};
> +	reg_usb_h1_vbus: regulator-usb-h1-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_h1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
>  
> -		reg_usb_h1_vbus: regulator at 1 {
> -			compatible = "regulator-fixed";
> -			reg = <1>;
> -			regulator-name = "usb_h1_vbus";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			gpio = <&max7310_b 7 GPIO_ACTIVE_HIGH>;
> -			enable-active-high;
> -		};
> -
> -		reg_usb_otg_vbus: regulator at 2 {
> -			compatible = "regulator-fixed";
> -			reg = <2>;
> -			regulator-name = "usb_otg_vbus";
> -			regulator-min-microvolt = <5000000>;
> -			regulator-max-microvolt = <5000000>;
> -			gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
> -			enable-active-high;
> -		};
> +	reg_usb_otg_vbus: regulator-usb-otg-vbus {
> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&max7310_c 1 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
>  	};
>  
>  	sound-cs42888 {
> -- 
> 2.17.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
