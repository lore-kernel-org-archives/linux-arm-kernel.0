From: diana.craciun@freescale.com (Diana Craciun)
Date: Thu, 21 Aug 2014 14:44:36 +0300
Subject: [PATCHv2 2/6] ARM: dts: Add initial LS1021A QDS board dts support
In-Reply-To: <1407145148-29217-3-git-send-email-jingchang.lu@freescale.com>
References: <1407145148-29217-1-git-send-email-jingchang.lu@freescale.com>
 <1407145148-29217-3-git-send-email-jingchang.lu@freescale.com>
Message-ID: <53F5DBA4.5010002@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/04/2014 12:39 PM, Jingchang Lu wrote:
> From: Jingchang Lu <b35083@freescale.com>
>
> Signed-off-by: Alison Wang <alison.wang@freescale.com>
> Signed-off-by: Chao Fu <B44548@freescale.com>
> Signed-off-by: Jason Jin <Jason.Jin@freescale.com>
> Signed-off-by: Xiubo Li <Li.Xiubo@freescale.com>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@freescale.com>
> Signed-off-by: Jaiprakash Singh <b44839@freescale.com>
> Signed-off-by: Jingchang Lu <jingchang.lu@freescale.com>
> ---
>   arch/arm/boot/dts/Makefile        |   3 +-
>   arch/arm/boot/dts/ls1021a-qds.dts | 349 ++++++++++++++++++++++++++++++++++++++
>   2 files changed, 351 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm/boot/dts/ls1021a-qds.dts
>
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 82f498b..af0d999 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -239,7 +239,8 @@ dtb-$(CONFIG_ARCH_MXC) += \
>   	imx6sx-sdb.dtb \
>   	vf610-colibri.dtb \
>   	vf610-cosmic.dtb \
> -	vf610-twr.dtb
> +	vf610-twr.dtb \
> +	ls1021a-qds.dtb
>   dtb-$(CONFIG_ARCH_MXS) += imx23-evk.dtb \
>   	imx23-olinuxino.dtb \
>   	imx23-stmp378x_devb.dtb \
> diff --git a/arch/arm/boot/dts/ls1021a-qds.dts b/arch/arm/boot/dts/ls1021a-qds.dts
> new file mode 100644
> index 0000000..d107edd
> --- /dev/null
> +++ b/arch/arm/boot/dts/ls1021a-qds.dts
> @@ -0,0 +1,349 @@
> +/*
> + * Copyright 2013-2014 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */
> +
> +/dts-v1/;
> +#include "ls1021a.dtsi"
> +
> +/ {
> +	model = "LS1021A QDS Board";
> +
> +	aliases {
> +		enet0_rgmii_phy = &rgmii_phy1;
> +		enet1_rgmii_phy = &rgmii_phy2;
> +		enet2_rgmii_phy = &rgmii_phy3;
> +		enet0_sgmii_phy = &sgmii_phy1c;
> +		enet1_sgmii_phy = &sgmii_phy1d;
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_3p3v: regulator at 0 {
> +			compatible = "regulator-fixed";
> +			reg = <0>;
> +			regulator-name = "3P3V";
> +			regulator-min-microvolt = <3300000>;
> +			regulator-max-microvolt = <3300000>;
> +			regulator-always-on;
> +		};
> +	};
> +
> +	sound {
> +		compatible = "fsl,vf610-sgtl5000";
> +		simple-audio-card,name = "FSL-VF610-TWR-BOARD";
> +		simple-audio-card,routing =
> +			"MIC_IN", "Microphone Jack",
> +			"Microphone Jack", "Mic Bias",
> +			"LINE_IN", "Line In Jack",
> +			"Headphone Jack", "HP_OUT",
> +			"Speaker Ext", "LINE_OUT";
> +
> +		simple-audio-card,cpu = <&sai2>;
> +
> +		simple-audio-card,codec = <&codec>;
> +	};
> +
> +	soc {
> +		leds {
> +			compatible = "pwm-leds";
> +			led0 {
> +				label = "led0";
> +				pwms = <&pwm3 0 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led1 {
> +				label = "led1";
> +				pwms = <&pwm3 1 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led2 {
> +				label = "led2";
> +				pwms = <&pwm3 2 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led3 {
> +				label = "led3";
> +				pwms = <&pwm3 3 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led4 {
> +				label = "led4";
> +				pwms = <&pwm3 4 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led5 {
> +				label = "led5";
> +				pwms = <&pwm3 5 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led6 {
> +				label = "led6";
> +				pwms = <&pwm3 6 150000 0>;
> +				max-brightness = <100>;
> +			};
> +			led7 {
> +				label = "led7";
> +				pwms = <&pwm3 7 150000 0>;
> +				max-brightness = <100>;
> +			};
> +		};
> +	};
> +};
> +
> +&dspi0 {
> +	bus-num = <0>;
> +	status = "okay";
> +
> +	dspiflash: at45db021d at 0 {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		compatible = "atmel,at45db021d", "atmel,at45", "atmel,dataflash";
> +		spi-max-frequency = <16000000>;
> +		spi-cpol;
> +		spi-cpha;
> +		reg = <0>;
> +	};
> +};
> +
> +&enet0 {
> +	tbi-handle = <&tbi0>;
> +	phy-handle = <&sgmii_phy1c>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&enet1 {
> +	tbi-handle = <&tbi0>;
> +	phy-handle = <&sgmii_phy1d>;
> +	phy-connection-type = "sgmii";
> +	status = "okay";
> +};
> +
> +&enet2 {
> +	phy-handle = <&rgmii_phy3>;
> +	phy-connection-type = "rgmii-id";
> +	status = "okay";
> +};
> +
> +&i2c0 {
> +	status = "okay";
> +	pca9547 at 77 {
> +		compatible = "philips,pca9547";
> +		reg = <0x77>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		i2c at 0 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x0>;
> +
> +			rtc at 68 {
> +				compatible = "dallas,ds3232";
> +				reg = <0x68>;
> +				interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
> +			};
> +		};
> +
> +		i2c at 2 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x2>;
> +
> +			ina220 at 40 {
> +				compatible = "ti,ina220";
> +				reg = <0x40>;
> +				shunt-resistor = <1000>;
> +			};
> +
> +			ina220 at 41 {
> +				compatible = "ti,ina220";
> +				reg = <0x41>;
> +				shunt-resistor = <1000>;
> +			};
> +		};
> +
> +		i2c at 3 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x3>;
> +
> +			eeprom at 56 {
> +				compatible = "at24,24c512";
> +				reg = <0x56>;
> +			};
> +
> +			eeprom at 57 {
> +				compatible = "at24,24c512";
> +				reg = <0x57>;
> +			};
> +
> +			adt7461a at 4c {
> +				compatible = "adt7461a";
> +				reg = <0x4c>;
> +			};
> +		};
> +
> +		i2c at 4 {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			reg = <0x4>;
> +
> +			codec: sgtl5000 at 0a {
> +				compatible = "fsl,sgtl5000";
> +				reg = <0x0a>;
> +				VDDA-supply = <&reg_3p3v>;
> +				VDDIO-supply = <&reg_3p3v>;
> +				clocks = <&platform_clk 1>;
> +			};
> +		};
> +	};
> +};
> +
> +&ifc {
> +	status = "okay";
> +	#address-cells = <2>;
> +	#size-cells = <1>;
> +	/* NOR, NAND Flashes and FPGA on board */
> +	ranges = <0x0 0x0 0x0 0x60000000 0x08000000
> +		0x2 0x0 0x0 0x7e800000 0x00010000
> +		0x3 0x0 0x0 0x7fb00000 0x00000100>;
> +
> +		nor at 0,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "cfi-flash";
> +			reg = <0x0 0x0 0x8000000>;
> +			bank-width = <2>;
> +			device-width = <1>;
> +		};
> +
> +		nand at 2,0 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "fsl,ifc-nand";
> +			reg = <0x2 0x0 0x10000>;
> +
> +			partition at 0 {
> +				/* This location must not be altered  */
> +				/* 1MB for u-boot Bootloader Image */
> +				reg = <0x0 0x00100000>;
> +				label = "NAND U-Boot Image";
> +				read-only;
> +			};
> +
> +			partition at 100000 {
> +				/* 1MB for DTB Image */
> +				reg = <0x00100000 0x00100000>;
> +				label = "NAND DTB Image";
> +			};
> +
> +			partition at 200000 {
> +				/* 10MB for Linux Kernel Image */
> +				reg = <0x00200000 0x00a00000>;
> +				label = "NAND Linux Kernel Image";
> +			};
> +
> +			partition at c00000 {
> +				/* 500MB for Root file System Image */
> +				reg = <0x00c00000 0x1f400000>;
> +				label = "NAND Compressed RFS Image";
> +			};

I do not think that partitions should be put in the dts file. They are a 
convention, not a description of the hardware.

Diana
