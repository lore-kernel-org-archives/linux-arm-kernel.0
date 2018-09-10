From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Sep 2018 08:56:06 +0800
Subject: [PATCH v2] ARM: dts: imx6ul: Add DTS for ConnectCore 6UL SBC Pro
In-Reply-To: <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
References: <1536074909-8654-1-git-send-email-alex.gonzalez@digi.com>
 <1536074909-8654-2-git-send-email-alex.gonzalez@digi.com>
Message-ID: <20180910005604.GG21218@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2018 at 05:28:29PM +0200, Alex Gonzalez wrote:
> The ConnectCore 6UL Single Board Computer (SBC) Pro contains the
> ConnectCore 6UL System-On-Module.
> 
> Its hardware specifications are:
> 
> * 256MB DDR3 memory
> * On module 256MB NAND flash
> * Dual 10/100 Ethernet
> * USB Host and USB OTG
> * Parallel RGB display header
> * LVDS display header
> * CSI camera
> * GPIO header
> * I2C, SPI, CAN headers
> * PCIe mini card and micro SIM slot
> * MicroSD external storage
> * On board 4GB eMMC flash
> * Audio headphone, line in/out, microphone lines
> 
> Signed-off-by: Alex Gonzalez <alex.gonzalez@digi.com>
> ---
>  arch/arm/boot/dts/Makefile                  |   1 +
>  arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts | 394 ++++++++++++++++++++++++++++
>  2 files changed, 395 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index 6135d3dc381c..3f6f8983f6c6 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -534,6 +534,7 @@ dtb-$(CONFIG_SOC_IMX6SX) += \
>  dtb-$(CONFIG_SOC_IMX6UL) += \
>  	imx6ul-14x14-evk.dtb \
>  	imx6ul-ccimx6ulsbcexpress.dtb \
> +	imx6ul-ccimx6ulsbcpro.dtb \
>  	imx6ul-geam.dtb \
>  	imx6ul-isiot-emmc.dtb \
>  	imx6ul-isiot-nand.dtb \
> diff --git a/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> new file mode 100644
> index 000000000000..08d550baa684
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6ul-ccimx6ulsbcpro.dts
> @@ -0,0 +1,394 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Digi International's ConnectCore6UL SBC Pro board device tree source
> + *
> + * Copyright 2018 Digi International, Inc.
> + *
> + */
> +
> +/dts-v1/;
> +#include <dt-bindings/input/input.h>
> +#include <dt-bindings/interrupt-controller/irq.h>
> +#include "imx6ul.dtsi"
> +#include "imx6ul-ccimx6ulsom.dtsi"
> +
> +/ {
> +	model = "Digi International ConnectCore 6UL SBC Pro.";
> +	compatible = "digi,ccimx6ulsbcpro", "digi,ccimx6ulsom", "fsl,imx6ul";
> +
> +	lcd_backlight: backlight {
> +		compatible = "pwm-backlight";
> +		pwms = <&pwm5 0 50000>;
> +		brightness-levels = <0 4 8 16 32 64 128 255>;
> +		default-brightness-level = <6>;
> +		status = "okay";
> +	};
> +
> +	reg_usb_otg1_vbus: reg-usb-otg1 {

Please spell out 'regulator' in node name:

	reg_usb_otg1_vbus: regulator-usb-otg1 {
		...
	};

Shawn

> +		compatible = "regulator-fixed";
> +		regulator-name = "usb_otg1_vbus";
> +		regulator-min-microvolt = <5000000>;
> +		regulator-max-microvolt = <5000000>;
> +		gpio = <&gpio1 4 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +};
