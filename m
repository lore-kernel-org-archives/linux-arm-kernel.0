Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2062FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:39:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA4AF20660
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 01:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y/IVMKxj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rsSpgVi3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4AF20660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=CcCmvpD8fexBxcZOltrGYYACL5+wyYC6Qw3HvhCxTok=; b=Y/IVMKxjxhlfXX
	4QiFtj8BTLF7Mf4SuIy6OCwFMPvcoHvVjCXtEpn+ShTXnaZy2PW8PpNctsaDeYrF4uD4/t0Jl2Y4g
	QZN7UfciuS1vJG5dnrCl5PHil7sn/2kyVbPWWmwlocmDx4Vsm+i9ez4Q6SuYlPa3OcxR5HWtBPp7k
	ZbN35eUlOnI92KIUsXQOIgPBLYS3X9UyyP9G0PTkVNQdsW/uAaW4TqBPandtjQF0pSbxStJmF/PDw
	9kIRUUjYs5rWy/Lm7dDLcwVgITanGHtfmdowsHSv5dZDrNTO3bWZrnS0mN46uG3MrY3+ZZ4JVy1dZ
	INVJ5tscol/OfIiqBYHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1girDx-0008Rx-On; Mon, 14 Jan 2019 01:39:33 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1girDu-0008Ra-4f
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 01:39:32 +0000
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D187A20660;
 Mon, 14 Jan 2019 01:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1547429969;
 bh=KkTgylWBXbIeNKo/Mrpy/PYVLXWUT0YgwNMzRh5BuF0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=rsSpgVi35dKFdPE4unCRqgFgMjDat9aE3ScDHvVQzWeyPV9w1K+N72aLCCPUL/u8y
 2RmRg4voD90nYNasSPBrWW8AXUu7uKKLzzPzwFZCKk4hUKW4dgDIODxnz7ZjK1vKxG
 4vBPrfMApNxHQe+F2A9XUGUB90fUEsMMjfbTaCOI=
Date: Mon, 14 Jan 2019 09:39:11 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/2] ARM: dts: Add devicetree for Eckelmann CI4x10
Message-ID: <20190114013909.GE15371@dragon>
References: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190111164936.7152-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190113_173930_218748_8772D919 
X-CRM114-Status: GOOD (  21.07  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Gavin Schenk <g.schenk@eckelmann.de>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Jan 11, 2019 at 05:49:35PM +0100, Uwe Kleine-K=F6nig wrote:
> This is one of two boards that make use of the recently introduced SIOX
> bus. Apart from the devices described in the dts it features a display
> with touch that I didn't include here because it needs some non-mainline
> change to operate correctly.
> =

> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/arm/boot/dts/Makefile                    |   1 +
>  arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts | 390 ++++++++++++++++++
>  2 files changed, 391 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts
> =

> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index bd40148a15b2..b60d759e39c0 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -397,6 +397,7 @@ dtb-$(CONFIG_SOC_IMX6Q) +=3D \
>  	imx6dl-cubox-i-emmc-som-v15.dtb \
>  	imx6dl-cubox-i-som-v15.dtb \
>  	imx6dl-dfi-fs700-m60.dtb \
> +	imx6dl-eckelmann-ci4x10.dtb \
>  	imx6dl-emcon-avari.dtb \
>  	imx6dl-gw51xx.dtb \
>  	imx6dl-gw52xx.dtb \
> diff --git a/arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts b/arch/arm/boo=
t/dts/imx6dl-eckelmann-ci4x10.dts
> new file mode 100644
> index 000000000000..ef7a7c9d55c3
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx6dl-eckelmann-ci4x10.dts
> @@ -0,0 +1,390 @@
> +/*
> + * Copyright (C) 2016 Eckelmann AG.
> + * Copyright (C) 2013 Freescale Semiconductor, Inc.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.

Please use SPDX-License-Identifier.

> + */
> +
> +/dts-v1/;
> +
> +#include <dt-bindings/gpio/gpio.h>
> +
> +#include "imx6dl.dtsi"
> +
> +/ {
> +	model =3D "Freescale i.MX6 DualLite Eckelmann CI 4X10 Board";

It's not a board produced by Freescale, right?

> +	compatible =3D "eckelmann,imx6dl-ci4x10", "fsl,imx6dl";

Document the compatible.

> +
> +	chosen {
> +		stdout-path =3D &uart3;
> +	};
> +
> +	memory {

device_type =3D "memory";

> +		reg =3D <0x10000000 0x40000000>;
> +	};
> +
> +	clocks {
> +		rmii_clk: rmii-clock {

clock-rmii for node name, and put it directly under root.

> +			/* This clock is provided by the phy (KSZ8091RNB) */
> +			compatible =3D "fixed-clock";
> +			#clock-cells =3D <0>;
> +			clock-frequency =3D <50000000>;
> +		};
> +	};
> +
> +	reg_usb_h1_vbus: regulator@1 {

	reg_xxx: regulator-xxx {
		...
	};


> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_reg_usb_h1_vbus>;
> +

Drop the newline.

> +		compatible =3D "regulator-fixed";
> +		regulator-name =3D "usb_h1_vbus";
> +		regulator-min-microvolt =3D <5000000>;
> +		regulator-max-microvolt =3D <5000000>;
> +		gpio =3D <&gpio3 31 0>;

Use the defines in include/dt-bindings/gpio/gpio.h.

> +		enable-active-high;
> +	};
> +
> +	siox {
> +		compatible =3D "eckelmann,siox-gpio";
> +		pinctrl-names =3D "default";
> +		pinctrl-0 =3D <&pinctrl_siox>;
> +

Ditto

> +		din-gpios =3D <&gpio6 11 0>;
> +		dout-gpios =3D <&gpio6 8 0>;
> +		dclk-gpios =3D <&gpio6 9 0>;
> +		dld-gpios =3D <&gpio6 10 0>;

Ditto

> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan1>;
> +	status =3D "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_flexcan2>;
> +	status =3D "okay";
> +};
> +
> +&ecspi2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_ecspi2>;
> +	status =3D "okay";

Put the 'status' at end of property list.

> +	cs-gpios =3D <&gpio5 12 GPIO_ACTIVE_HIGH>;
> +
> +	mram: mr25h256@0 {

Use a generic node name.

> +		compatible =3D "everspin,mr25h256";

Undocumented compatible.

> +		reg =3D <0>;
> +		spi-max-frequency =3D <15000000>;
> +	};
> +};
> +
> +&ecspi1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_ecspi1>;
> +	status =3D "okay";

Ditto.

> +	cs-gpios =3D <&gpio5 25 GPIO_ACTIVE_HIGH>;
> +
> +	tpm_spi_tis@0 {

Just 'tpm' for name maybe?

> +		compatible =3D "infineon,slb9670", "tcg,tpm_tis-spi";
> +		reg =3D <0>;
> +		spi-max-frequency =3D <10000000>;
> +	};
> +};
> +
> +&i2c1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_i2c1>;
> +	status =3D "okay";
> +
> +	temp@49 {

temperature-sensor

> +		compatible =3D "ad,ad7414";
> +		reg =3D <0x49>;
> +	};
> +
> +	rtc@51 {
> +		compatible =3D "nxp,pcf2127";
> +		reg =3D <0x51>;
> +	};
> +};
> +
> +&iomuxc {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_hog>;
> +
> +	pinctrl_hog: hog {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_NANDF_D0__GPIO2_IO00		0x00000018 /* buzzer */
> +			MX6QDL_PAD_KEY_COL1__GPIO4_IO08		0x00000018 /* OUT_1 */
> +			MX6QDL_PAD_KEY_ROW1__GPIO4_IO09		0x00000018 /* OUT_2 */
> +			MX6QDL_PAD_KEY_COL2__GPIO4_IO10		0x00000018 /* OUT_3 */
> +			MX6QDL_PAD_NANDF_CS2__GPIO6_IO15	0x00000000 /* In1 */
> +			MX6QDL_PAD_KEY_ROW0__GPIO4_IO07		0x00000000 /* In2 */
> +			MX6QDL_PAD_GPIO_9__GPIO1_IO09		0x00000018 /* unused watchdog pin */
> +			MX6QDL_PAD_SD1_DAT2__GPIO1_IO19		0x00000018 /* unused watchdog pin */
> +
> +		>;
> +	};
> +
> +	pinctrl_ecspi1: ecspi1grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_CSI0_DAT4__ECSPI1_SCLK 	0x000100a0
> +			MX6QDL_PAD_CSI0_DAT5__ECSPI1_MOSI	0x000100a0
> +			MX6QDL_PAD_CSI0_DAT6__ECSPI1_MISO	0x000100a0
> +			MX6QDL_PAD_CSI0_DAT7__GPIO5_IO25	0x000100a0
> +		>;
> +	};
> +
> +	pinctrl_ecspi2: ecspi2grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_DISP0_DAT19__ECSPI2_SCLK	0x000100b1
> +			MX6QDL_PAD_EIM_CS1__ECSPI2_MOSI		0x000100b1
> +			MX6QDL_PAD_EIM_OE__ECSPI2_MISO		0x000100b1
> +			MX6QDL_PAD_DISP0_DAT18__GPIO5_IO12	0x000100b1
> +		>;
> +	};
> +
> +	pinctrl_enet: enetgrp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_GPIO_16__ENET_REF_CLK	0x4001b0a8
> +			MX6QDL_PAD_ENET_MDIO__ENET_MDIO		0x0001b098
> +			MX6QDL_PAD_ENET_MDC__ENET_MDC		0x0001b098
> +			MX6QDL_PAD_ENET_TXD0__ENET_TX_DATA0	0x0001b098
> +			MX6QDL_PAD_ENET_TXD1__ENET_TX_DATA1	0x0001b098
> +			MX6QDL_PAD_ENET_TX_EN__ENET_TX_EN	0x0001b098
> +			MX6QDL_PAD_ENET_RX_ER__ENET_RX_ER	0x0001b0b0
> +			MX6QDL_PAD_ENET_RXD0__ENET_RX_DATA0	0x0001b0b0
> +			MX6QDL_PAD_ENET_RXD1__ENET_RX_DATA1	0x0001b0b0
> +			MX6QDL_PAD_ENET_CRS_DV__ENET_RX_EN	0x0001b0b0
> +			MX6QDL_PAD_SD1_CMD__GPIO1_IO18		0x00000018
> +		>;
> +	};
> +
> +	pinctrl_flexcan1: flexcan1grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_GPIO_7__FLEXCAN1_TX		0x0001b020
> +			MX6QDL_PAD_GPIO_8__FLEXCAN1_RX		0x0001b0b0
> +		>;
> +	};
> +
> +	pinctrl_flexcan2: flexcan2grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_KEY_COL4__FLEXCAN2_TX	0x0001b020
> +			MX6QDL_PAD_KEY_ROW4__FLEXCAN2_RX	0x0001b0b0
> +		>;
> +	};
> +
> +	pinctrl_i2c1: i2c1grp {
> +		fsl,pins =3D <
> +			/* without SION i2c doesn't detect bus busy */
> +			MX6QDL_PAD_CSI0_DAT9__I2C1_SCL		0x4001b820
> +			MX6QDL_PAD_CSI0_DAT8__I2C1_SDA		0x4001b820
> +		>;
> +	};
> +
> +	pinctrl_pcie: pciegrp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_SD1_CLK__GPIO1_IO20		0x00000018
> +		>;
> +	};
> +
> +	pinctrl_reg_usb_h1_vbus: reg_usb_h1_vbusgrp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_EIM_D31__GPIO3_IO31		0x0001b0b0
> +		>;
> +	};
> +
> +	pinctrl_siox: sioxgrp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_NANDF_CS0__GPIO6_IO11	0x0001b010	/* DIN */
> +			MX6QDL_PAD_NANDF_ALE__GPIO6_IO08	0x0001b010	/* DOUT */
> +			MX6QDL_PAD_NANDF_WP_B__GPIO6_IO09	0x0001b010	/* DCLK */
> +			MX6QDL_PAD_NANDF_RB0__GPIO6_IO10	0x0001b010	/* DLD */
> +		>;
> +	};
> +
> +	pinctrl_uart1_dte: uart1grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_CSI0_DAT11__UART1_TX_DATA	0x0001b010
> +			MX6QDL_PAD_CSI0_DAT10__UART1_RX_DATA	0x0001b010
> +			MX6QDL_PAD_EIM_D19__UART1_RTS_B 	0x0001b010
> +			MX6QDL_PAD_EIM_D20__UART1_CTS_B 	0x0001b010
> +			MX6QDL_PAD_EIM_D23__GPIO3_IO23		0x0001b010	/* DCD */
> +			MX6QDL_PAD_EIM_D24__GPIO3_IO24		0x0001b010	/* DTR */
> +			MX6QDL_PAD_EIM_D25__GPIO3_IO25		0x0001b010	/* DSR */
> +		>;
> +	};
> +
> +	pinctrl_uart2_dte: uart2grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_EIM_D27__UART2_TX_DATA	0x0001b010
> +			MX6QDL_PAD_EIM_D26__UART2_RX_DATA	0x0001b010
> +			MX6QDL_PAD_EIM_D28__UART2_RTS_B 	0x0001b010
> +			MX6QDL_PAD_EIM_D29__UART2_CTS_B 	0x0001b010
> +			MX6QDL_PAD_NANDF_D1__GPIO2_IO01		0x0001b010	/* DCD */
> +			MX6QDL_PAD_GPIO_18__GPIO7_IO13		0x0001b010	/* DTR */
> +			MX6QDL_PAD_NANDF_CS3__GPIO6_IO16	0x0001b010	/* DSR */
> +		>;
> +	};
> +
> +	pinctrl_uart3_dce: uart3grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_SD4_CLK__UART3_RX_DATA	0x0001b010
> +			MX6QDL_PAD_SD4_CMD__UART3_TX_DATA	0x0001b010
> +		>;
> +	};
> +
> +	pinctrl_uart4_dce: uart4grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_CSI0_DAT13__UART4_RX_DATA	0x0001b010
> +			MX6QDL_PAD_CSI0_DAT12__UART4_TX_DATA	0x0001b010
> +			MX6QDL_PAD_CSI0_DAT17__GPIO6_IO03	0x0001b010
> +		>;
> +	};
> +
> +	pinctrl_uart5_dce: uart5grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_CSI0_DAT15__UART5_RX_DATA	0x0001b010
> +			MX6QDL_PAD_CSI0_DAT14__UART5_TX_DATA	0x0001b010
> +			MX6QDL_PAD_CSI0_DAT19__GPIO6_IO05	0x0001b010	/* RTS */
> +		>;
> +	};
> +
> +	pinctrl_usbh1: usbh1grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_EIM_D30__USB_H1_OC		0x80000000
> +		>;
> +	};
> +
> +	pinctrl_usdhc3: usdhc3grp {
> +		fsl,pins =3D <
> +			MX6QDL_PAD_SD3_CMD__SD3_CMD		0x00017059
> +			MX6QDL_PAD_SD3_CLK__SD3_CLK		0x00010059
> +			MX6QDL_PAD_SD3_DAT0__SD3_DATA0		0x00017059
> +			MX6QDL_PAD_SD3_DAT1__SD3_DATA1		0x00017059
> +			MX6QDL_PAD_SD3_DAT2__SD3_DATA2		0x00017059
> +			MX6QDL_PAD_SD3_DAT3__SD3_DATA3		0x00017059
> +			MX6QDL_PAD_SD3_DAT4__SD3_DATA4		0x00017059
> +			MX6QDL_PAD_SD3_DAT5__SD3_DATA5		0x00017059
> +			MX6QDL_PAD_SD3_DAT6__SD3_DATA6		0x00017059
> +			MX6QDL_PAD_SD3_DAT7__SD3_DATA7		0x00017059
> +		>;
> +	};
> +};
> +
> +&gpio2 {

Out of alphabetic order.

> +	gpio-line-names =3D "buzzer", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "";
> +};
> +
> +&gpio4 {
> +	gpio-line-names =3D "", "", "", "", "", "", "", "in2",
> +			  "prio2", "prio1", "aux", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "";
> +};
> +
> +&gpio6 {
> +	gpio-line-names =3D "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "in1",
> +			  "", "", "", "", "", "", "", "",
> +			  "", "", "", "", "", "", "", "";
> +};
> +
> +&fec {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_enet>;
> +	phy-mode =3D "rmii";
> +	phy-reset-gpios =3D <&gpio1 18 GPIO_ACTIVE_LOW>;
> +	phy-handle =3D <&phy>;
> +	clocks =3D <&clks IMX6QDL_CLK_ENET>, <&clks IMX6QDL_CLK_ENET>, <&rmii_c=
lk>;
> +	status =3D "okay";
> +
> +	mdio {
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		phy: ethernet-phy@1 {
> +			compatible =3D "ethernet-phy-ieee802.3-c22";
> +			reg =3D <1>;
> +		};
> +	};
> +};
> +
> +&pcie {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_pcie>;
> +	reset-gpio =3D <&gpio1 20 0>;

GPIO_ACTIVE_XXX

> +	status =3D "okay";
> +};
> +
> +&uart1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart1_dte>;
> +	status =3D "okay";
> +

Drop the newline and move 'status' to end of list.

> +	uart-has-rtscts;
> +	fsl,dte-mode;
> +	dcd-gpios =3D <&gpio3 23 GPIO_ACTIVE_LOW>;
> +	dtr-gpios =3D <&gpio3 24 GPIO_ACTIVE_LOW>;
> +	dsr-gpios =3D <&gpio3 25 GPIO_ACTIVE_LOW>;
> +};
> +
> +&uart2 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart2_dte>;
> +	status =3D "okay";
> +

Ditto

> +	uart-has-rtscts;
> +	fsl,dte-mode;
> +	dcd-gpios =3D <&gpio2 1 GPIO_ACTIVE_LOW>;
> +	dtr-gpios =3D <&gpio7 13 GPIO_ACTIVE_LOW>;
> +	dsr-gpios =3D <&gpio6 16 GPIO_ACTIVE_LOW>;
> +};
> +
> +&uart3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart3_dce>;
> +	status =3D "okay";
> +};
> +
> +&uart4 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart4_dce>;
> +	status =3D "okay";

Move to end of list.

> +	rts-gpios =3D <&gpio6 3 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&uart5 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_uart5_dce>;
> +	status =3D "okay";

Ditto

> +	rts-gpios =3D <&gpio6 5 GPIO_ACTIVE_HIGH>;
> +};
> +
> +&usbh1 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usbh1>;
> +

Drop the newline.

> +	vbus-supply =3D <&reg_usb_h1_vbus>;
> +	status =3D "okay";
> +};
> +
> +&usbotg {
> +	status =3D "okay";

Move to end of list.

Shawn

> +	dr_mode =3D "peripheral";
> +};
> +
> +&usdhc3 {
> +	pinctrl-names =3D "default";
> +	pinctrl-0 =3D <&pinctrl_usdhc3>;
> +	bus-width =3D <8>;
> +	non-removable;
> +	status =3D "okay";
> +};
> -- =

> 2.20.1
> =


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
