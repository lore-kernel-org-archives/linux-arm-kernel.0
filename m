From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 3 Dec 2013 21:34:23 +0800
Subject: [PATCHv3 3/3] ARM: dts: imx27-apf27dev: Add pinctrl for cspi,
 sdhci, leds and keys
In-Reply-To: <1386069015-10718-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
References: <1386069015-10718-1-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1386069015-10718-2-git-send-email-gwenhael.goavec-merou@armadeus.com>
 <1386069015-10718-3-git-send-email-gwenhael.goavec-merou@armadeus.com>
Message-ID: <20131203133421.GK13726@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 12:10:15PM +0100, Gwenhael Goavec-Merou wrote:
> Signed-off-by: Gwenhael Goavec-Merou <gwenhael.goavec-merou@armadeus.com>
> 
> - add chip-select pinctrl for cspi
> - add card-detect for sdhci2
> - add pinctrl for gpio-leds and gpio-keys

I put these lines before your SoB.

Shawn

>  
> ---
> Changelog:
> v3:
>  * use short subject and add commit log
> 
>  arch/arm/boot/dts/imx27-apf27dev.dts | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx27-apf27dev.dts b/arch/arm/boot/dts/imx27-apf27dev.dts
> index a794b1a..17dd206 100644
> --- a/arch/arm/boot/dts/imx27-apf27dev.dts
> +++ b/arch/arm/boot/dts/imx27-apf27dev.dts
> @@ -38,6 +38,8 @@
>  
>  	gpio-keys {
>  		compatible = "gpio-keys";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_keys>;
>  
>  		user-key {
>  			label = "user";
> @@ -48,6 +50,8 @@
>  
>  	leds {
>  		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_gpio_leds>;
>  
>  		user {
>  			label = "Heartbeat";
> @@ -61,7 +65,7 @@
>  	fsl,spi-num-chipselects = <1>;
>  	cs-gpios = <&gpio4 28 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_cspi1>;
> +	pinctrl-0 = <&pinctrl_cspi1 &pinctrl_cspi1_cs>;
>  	status = "okay";
>  };
>  
> @@ -71,7 +75,7 @@
>  		   <&gpio4 27 GPIO_ACTIVE_LOW>,
>  		   <&gpio2 17 GPIO_ACTIVE_LOW>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_cspi2>;
> +	pinctrl-0 = <&pinctrl_cspi2 &pinctrl_cspi2_cs>;
>  	status = "okay";
>  };
>  
> @@ -107,10 +111,30 @@
>  			fsl,pins = <MX27_CSPI1_PINGRP1>;
>  		};
>  
> +		pinctrl_cspi1_cs: cspi1csgrp {
> +			fsl,pins = <MX27_PAD_CSPI1_SS0__GPIO4_28 0x0>;
> +		};
> +
>  		pinctrl_cspi2: cspi2grp {
>  			fsl,pins = <MX27_CSPI2_PINGRP1>;
>  		};
>  
> +		pinctrl_cspi2_cs: cspi2csgrp {
> +			fsl,pins = <
> +				MX27_PAD_CSI_D5__GPIO2_17 0x0
> +				MX27_PAD_CSPI2_SS0__GPIO4_21 0x0
> +				MX27_PAD_CSPI1_SS1__GPIO4_27 0x0
> +			>;
> +		};
> +
> +		pinctrl_gpio_leds: gpioledsgrp {
> +			fsl,pins = <MX27_PAD_PC_VS1__GPIO6_14 0x0>;
> +		};
> +
> +		pinctrl_gpio_keys: gpiokeysgrp {
> +			fsl,pins = <MX27_PAD_PC_VS2__GPIO6_13 0x0>;
> +		};
> +
>  		pinctrl_imxfb1: imxfbgrp {
>  			fsl,pins = <MX27_FB_PINGRP1>;
>  		};
> @@ -130,6 +154,10 @@
>  		pinctrl_sdhc2: sdhc2grp {
>  			fsl,pins = <MX27_SDHC2_PINGRP1>;
>  		};
> +
> +		pinctrl_sdhc2_cd: sdhc2cdgrp {
> +			fsl,pins = <MX27_PAD_TOUT__GPIO3_14 0x0>;
> +		};
>  	};
>  };
>  
> @@ -137,7 +165,7 @@
>  	bus-width = <4>;
>  	cd-gpios = <&gpio3 14 GPIO_ACTIVE_HIGH>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pinctrl_sdhc2>;
> +	pinctrl-0 = <&pinctrl_sdhc2 &pinctrl_sdhc2_cd>;
>  	status = "okay";
>  };
>  
> -- 
> 1.8.3.2
> 
