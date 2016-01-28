From: shawnguo@kernel.org (Shawn Guo)
Date: Thu, 28 Jan 2016 15:57:21 +0800
Subject: [PATCH v2 3/5] ARM: dts: imx: Add basic dts support for
 imx6qp-sabreauto
In-Reply-To: <1450159673-27314-4-git-send-email-b51503@freescale.com>
References: <1450159673-27314-1-git-send-email-b51503@freescale.com>
 <1450159673-27314-4-git-send-email-b51503@freescale.com>
Message-ID: <20160128075721.GN9070@tiger>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 15, 2015 at 02:07:51PM +0800, Bai Ping wrote:
> This patch adds basic dts file for imx6qp-sabreauto board.
> 
> Signed-off-by: Bai Ping <b51503@freescale.com>
> ---
>  arch/arm/boot/dts/Makefile             |  1 +
>  arch/arm/boot/dts/imx6qp-sabreauto.dts | 67 ++++++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6qp-sabreauto.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index dfba765..7996a51 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -329,6 +329,7 @@ dtb-$(CONFIG_SOC_IMX6Q) += \
>  	imx6q-phytec-pbab01.dtb \
>  	imx6q-rex-pro.dtb \
>  	imx6q-sabreauto.dtb \
> +	imx6qp-sabreauto.dtb \

This order is incorrect either.

>  	imx6q-sabrelite.dtb \
>  	imx6q-sabresd.dtb \
>  	imx6q-sbc6x.dtb \
> diff --git a/arch/arm/boot/dts/imx6qp-sabreauto.dts b/arch/arm/boot/dts/imx6qp-sabreauto.dts
> new file mode 100644
> index 0000000..b24aae6
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6qp-sabreauto.dts
> @@ -0,0 +1,67 @@
> +/*
> + * Copyright (C) 2015 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

GPL/X11 dual license please.

> + */
> +
> +#include "imx6q-sabreauto.dts"
> +#include "imx6qp.dtsi"
> +
> +/ {
> +	model = "Freescale i.MX6 Quad Plus SABRE Automotive Board";
> +	compatible = "fsl,imx6qp-sabreauto", "fsl,imx6qp";
> +};
> +
> +
> +&fec {
> +	pinctrl-assert-gpios = <&max7322 0 GPIO_ACTIVE_HIGH>;

Upstream kernel doesn't have this property.

Shawn

> +};
> +
> +&i2c2 {
> +	max7322: gpio at 68 {
> +		compatible = "maxim,max7322";
> +		reg = <0x68>;
> +		gpio-controller;
> +		#gpio-cells = <2>;
> +	};
> +};
> +
> +&iomuxc {
> +	imx6qdl-sabreauto {
> +		pinctrl_enet: enetgrp {
> +			fsl,pins = <
> +				MX6QDL_PAD_KEY_COL1__ENET_MDIO          0x1b0b0
> +				MX6QDL_PAD_KEY_COL2__ENET_MDC           0x1b0b0
> +				MX6QDL_PAD_RGMII_TXC__RGMII_TXC         0x1b018
> +				MX6QDL_PAD_RGMII_TD0__RGMII_TD0         0x1b018
> +				MX6QDL_PAD_RGMII_TD1__RGMII_TD1         0x1b018
> +				MX6QDL_PAD_RGMII_TD2__RGMII_TD2         0x1b018
> +				MX6QDL_PAD_RGMII_TD3__RGMII_TD3         0x1b018
> +				MX6QDL_PAD_RGMII_TX_CTL__RGMII_TX_CTL   0x1b018
> +				MX6QDL_PAD_RGMII_RXC__RGMII_RXC         0x1b018
> +				MX6QDL_PAD_RGMII_RD0__RGMII_RD0         0x1b018
> +				MX6QDL_PAD_RGMII_RD1__RGMII_RD1         0x1b018
> +				MX6QDL_PAD_RGMII_RD2__RGMII_RD2         0x1b018
> +				MX6QDL_PAD_RGMII_RD3__RGMII_RD3         0x1b018
> +				MX6QDL_PAD_RGMII_RX_CTL__RGMII_RX_CTL   0x1b018
> +				MX6QDL_PAD_GPIO_16__ENET_REF_CLK        0x4001b0a8
> +				MX6QDL_PAD_GPIO_6__ENET_IRQ		0x000b1
> +			>;
> +		};
> +	};
> +};
> +
> +&pcie {
> +	reset-gpio = <&max7310_c 5 GPIO_ACTIVE_LOW>;
> +	status = "okay";
> +};
> +
> +&sata {
> +	status = "okay";
> +};
> +
> +&vgen3_reg {
> +	regulator-always-on;
> +};
> -- 
> 1.9.1
> 
> 
