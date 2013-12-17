From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 17 Dec 2013 21:48:30 +0800
Subject: [PATCH V2 13/13] ARM: dts: imx: add nitrogen6x board
In-Reply-To: <1387242783-1462-14-git-send-email-troy.kisky@boundarydevices.com>
References: <1387242783-1462-1-git-send-email-troy.kisky@boundarydevices.com>
 <1387242783-1462-14-git-send-email-troy.kisky@boundarydevices.com>
Message-ID: <20131217134826.GR6691@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 06:13:03PM -0700, Troy Kisky wrote:
> Add file imx6q-nitrogen6x.dts,
> 	imx6dl-nitrogen6x.dts,
> 	imx6qdl-nitrogen6x.dtsi
> 
> And add board to makefile.
> 
> Eric Nelson created a web page to show the
> differences between Nitrogen6x and Sabre Lite boards.
> http://boundarydevices.com/differences-sabre-lite-nitrogen6x
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> 
> ---
> v2: rebase only
> ---
>  arch/arm/boot/dts/Makefile                         |  2 ++
>  arch/arm/boot/dts/imx6dl-nitrogen6x.dts            | 22 ++++++++++++++++++
>  arch/arm/boot/dts/imx6q-nitrogen6x.dts             | 26 ++++++++++++++++++++++
>  ...6qdl-sabrelite.dtsi => imx6qdl-nitrogen6x.dtsi} | 17 +++++++-------
>  4 files changed, 58 insertions(+), 9 deletions(-)
>  create mode 100644 arch/arm/boot/dts/imx6dl-nitrogen6x.dts
>  create mode 100644 arch/arm/boot/dts/imx6q-nitrogen6x.dts
>  copy arch/arm/boot/dts/{imx6qdl-sabrelite.dtsi => imx6qdl-nitrogen6x.dtsi} (95%)
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index c55a22d..16f0c5c 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -150,6 +150,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6dl-gw52xx.dtb \
>  	imx6dl-gw53xx.dtb \
>  	imx6dl-gw54xx.dtb \
> +	imx6dl-nitrogen6x.dtb \
>  	imx6dl-sabreauto.dtb \
>  	imx6dl-sabrelite.dtb \
>  	imx6dl-sabresd.dtb \
> @@ -162,6 +163,7 @@ dtb-$(CONFIG_ARCH_MXC) += \
>  	imx6q-gw53xx.dtb \
>  	imx6q-gw5400-a.dtb \
>  	imx6q-gw54xx.dtb \
> +	imx6q-nitrogen6x.dtb \
>  	imx6q-phytec-pbab01.dtb \
>  	imx6q-sabreauto.dtb \
>  	imx6q-sabrelite.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-nitrogen6x.dts b/arch/arm/boot/dts/imx6dl-nitrogen6x.dts
> new file mode 100644
> index 0000000..89d32f3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-nitrogen6x.dts
> @@ -0,0 +1,22 @@
> +/*
> + * Copyright 2013 Boundary Devices, Inc.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6dl.dtsi"
> +#include "imx6qdl-nitrogen6x.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 DualLite Nitrogen6x Board";
> +	compatible = "fsl,imx6dl-nitrogen6x", "fsl,imx6dl";
> +

Unnecessary blank line.

> +};
> diff --git a/arch/arm/boot/dts/imx6q-nitrogen6x.dts b/arch/arm/boot/dts/imx6q-nitrogen6x.dts
> new file mode 100644
> index 0000000..5790172
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6q-nitrogen6x.dts
> @@ -0,0 +1,26 @@
> +/*
> + * Copyright 2013 Boundary Devices, Inc.
> + * Copyright 2012 Freescale Semiconductor, Inc.
> + * Copyright 2011 Linaro Ltd.
> + *
> + * The code contained herein is licensed under the GNU General Public
> + * License. You may obtain a copy of the GNU General Public License
> + * Version 2 or later at the following locations:
> + *
> + * http://www.opensource.org/licenses/gpl-license.html
> + * http://www.gnu.org/copyleft/gpl.html
> + */
> +
> +/dts-v1/;
> +#include "imx6q.dtsi"
> +#include "imx6qdl-nitrogen6x.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 Quad Nitrogen6x Board";
> +	compatible = "fsl,imx6q-nitrogen6x", "fsl,imx6q";
> +

Ditto

I fixed them up and applied the whole series expect patch #8, which I
have a comment on.

Shawn

> +};
> +
> +&sata {
> +	status = "okay";
> +};
> diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> similarity index 95%
> copy from arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> copy to arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> index b2711ae..65c9a9b 100644
> --- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
> @@ -1,4 +1,5 @@
>  /*
> + * Copyright 2013 Boundary Devices, Inc.
>   * Copyright 2011 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
>   *
> @@ -92,9 +93,9 @@
>  	};
>  
>  	sound {
> -		compatible = "fsl,imx6q-sabrelite-sgtl5000",
> +		compatible = "fsl,imx6q-nitrogen6x-sgtl5000",
>  			     "fsl,imx-audio-sgtl5000";
> -		model = "imx6q-sabrelite-sgtl5000";
> +		model = "imx6q-nitrogen6x-sgtl5000";
>  		ssi-controller = <&ssi1>;
>  		audio-codec = <&codec>;
>  		audio-routing =
> @@ -102,7 +103,7 @@
>  			"Mic Jack", "Mic Bias",
>  			"Headphone Jack", "HP_OUT";
>  		mux-int-port = <1>;
> -		mux-ext-port = <4>;
> +		mux-ext-port = <3>;
>  	};
>  
>  	backlight_lcd {
> @@ -148,7 +149,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_enet>;
>  	phy-mode = "rgmii";
> -	phy-reset-gpios = <&gpio3 23 0>;
> +	phy-reset-gpios = <&gpio1 27 0>;
>  	txen-skew-ps = <0>;
>  	txc-skew-ps = <3000>;
>  	rxdv-skew-ps = <0>;
> @@ -183,7 +184,7 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_hog>;
>  
> -	imx6q-sabrelite {
> +	imx6q-nitrogen6x {
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
>  				/* SGTL5000 sys_mclk */
> @@ -204,7 +205,7 @@
>  		};
>  
>  		pinctrl_audmux: audmuxgrp {
> -			fsl,pins = <MX6QDL_AUDMUX_PINGRP1>;
> +			fsl,pins = <MX6QDL_AUDMUX_PINGRP2>;
>  		};
>  
>  		pinctrl_ecspi1: ecspi1grp {
> @@ -232,7 +233,7 @@
>  				MX6QDL_PAD_RGMII_RD3__RGMII_RD3		0x1b0b0
>  				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL	0x1b0b0
>  				/* Phy reset */
> -				MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x000b0
> +				MX6QDL_PAD_ENET_RXD0__GPIO1_IO27	0x000b0
>  			>;
>  		};
>  
> @@ -279,7 +280,6 @@
>  			fsl,pins = <
>  				MX6QDL_USDHC3_PINGRP_D4
>  				MX6QDL_PAD_SD3_DAT5__GPIO7_IO00 0x1b0b0	/* CD */
> -				MX6QDL_PAD_SD3_DAT4__GPIO7_IO01 0x1f0b0	/* WP */
>  			>;
>  		};
>  
> @@ -372,7 +372,6 @@
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_usdhc3>;
>  	cd-gpios = <&gpio7 0 0>;
> -	wp-gpios = <&gpio7 1 0>;
>  	vmmc-supply = <&reg_3p3v>;
>  	status = "okay";
>  };
> -- 
> 1.8.1.2
> 
