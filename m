From: mr.nuke.me@gmail.com (mr.nuke.me at gmail.com)
Date: Mon, 10 Mar 2014 14:49:15 -0700 (PDT)
Subject: [PATCH v5 6/8] ARM: dts: sun4i: Add support for mmc
In-Reply-To: <20140211193423.4568.34947.stgit@dizzy-6.o2s.ch>
References: <20140211190543.4568.83517.stgit@dizzy-6.o2s.ch>
 <20140211193423.4568.34947.stgit@dizzy-6.o2s.ch>
Message-ID: <ac47de94-92ef-4b53-9983-34dd2f9924ea@googlegroups.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, February 11, 2014 1:34:25 PM UTC-6, David Lanzend?rfer wrote:
> diff --git a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> index b139ee6..20b976a 100644
> --- a/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> +++ b/arch/arm/boot/dts/sun4i-a10-cubieboard.dts
> @@ -33,6 +33,14 @@
>  			};
>  		
>  		};
> +		mmc0: mmc at 01c0f000 {
> +			pinctrl-names = "default", "default";
> +			pinctrl-0 = <&mmc0_pins_a>;
> +			pinctrl-1 = <&mmc0_cd_pin_reference_design>;
> +			cd-gpios = <&pio 7 1 0>; /* PH1 */
> +			status = "okay";
> +		};
> +
>  		pinctrl at 01c20800 {
>  		
>  			led_pins_cubieboard: led_pins at 0 {
>  			
>  				allwinner,pins = "PH20", "PH21";
> diff --git a/arch/arm/boot/dts/sun4i-a10.dtsi
> b/arch/arm/boot/dts/sun4i-a10.dtsi
> index 9044c53..d040d37 100644
> --- a/arch/arm/boot/dts/sun4i-a10.dtsi
> +++ b/arch/arm/boot/dts/sun4i-a10.dtsi
> @@ -330,6 +330,46 @@
>  			#size-cells = <0>;
>  		
>  		};
> +		mmc0: mmc at 01c0f000 {
> +			compatible = "allwinner,sun5i-a13-mmc";

Should be "allwinner,sun4i-a10-mmc", or we will hang the MMC driver on A10.

> +		mmc1: mmc at 01c10000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
ditto

> +		mmc2: mmc at 01c11000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
ditto

> +		mmc3: mmc at 01c12000 {
> +			compatible = "allwinner,sun5i-a13-mmc";
ditto
