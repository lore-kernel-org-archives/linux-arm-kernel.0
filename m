Return-Path: <SRS0=ULCN=QZ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26B04C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:04:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7FB2176F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 12:04:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ERd7qZTI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7FB2176F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=denx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:
	Message-ID:From:References:To:Subject:Reply-To:Content-ID:Content-Description
	:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=7+IqELqfTWMRh71mG7iqRlNpgEfPqe1mx0EzA9pX36k=; b=ERd7qZTIQdSEiD
	D3YTv8Jxe6bxRuPUZ9cNedElUOzjf7RIVngVEwtg/UrxCeqkE/EF4ty0Y6Wzd257VGI5ZQwuXgj6+
	wN5gbxNZBNEckNgAN+gzCB0RjaIDwob/77tDnW4Pm356gVnZlVaAIIwUQxenBSEb2C42iP/4EZ7vU
	1CMw5vTnhdclqGX9zyExsm/M7N3n4ngkDDSmeUn5pMcY1r3TNcIkEO97rNoC8EtezhUPe+fa/qGsK
	p4rOM7+oYBZF+MNhB6D+H3t3av0P5V8HoalAP9ZYzq2SbjWyWK3Pu92a5UcwMiVzLu+cI8ipD6R1m
	is/vC7qT/74eVncc0Xfw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvhfE-0005c3-QW; Mon, 18 Feb 2019 12:04:48 +0000
Received: from mail-out.m-online.net ([212.18.0.10])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvhfA-0005ag-NA
 for linux-arm-kernel@lists.infradead.org; Mon, 18 Feb 2019 12:04:47 +0000
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
 by mail-out.m-online.net (Postfix) with ESMTP id 4432bp4YbNz1r2nF;
 Mon, 18 Feb 2019 13:04:38 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
 by mail.m-online.net (Postfix) with ESMTP id 4432bp4CHlz1qvWq;
 Mon, 18 Feb 2019 13:04:38 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
 by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new,
 port 10024)
 with ESMTP id enl0jJzeKbDT; Mon, 18 Feb 2019 13:04:37 +0100 (CET)
X-Auth-Info: NEOF72t2BZFggbvOadCeWH+lVfhXstRuUkbUvvk6WAw=
Received: from [IPv6:::1] (unknown [195.140.253.167])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.mnet-online.de (Postfix) with ESMTPSA;
 Mon, 18 Feb 2019 13:04:37 +0100 (CET)
Subject: Re: [PATCH 2/2] ARM: dts: imx53: Add Menlosystems M53 board
To: linux-arm-kernel@lists.infradead.org
References: <20181004224227.16836-1-marex@denx.de>
 <20181004224227.16836-2-marex@denx.de>
From: Marek Vasut <marex@denx.de>
Message-ID: <623d8c58-ff65-2a9c-ec56-2a81382b8391@denx.de>
Date: Mon, 18 Feb 2019 13:04:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20181004224227.16836-2-marex@denx.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_040445_058199_9ADA874F 
X-CRM114-Status: GOOD (  20.01  )
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
Cc: Shawn Guo <shawnguo@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On 10/5/18 12:42 AM, Marek Vasut wrote:
> Add device tree for the Menlosystems board based on i.MX53 M53 SoM.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Shawn, bump ?

> ---
>  arch/arm/boot/dts/Makefile           |   1 +
>  arch/arm/boot/dts/imx53-m53menlo.dts | 327 +++++++++++++++++++++++++++
>  2 files changed, 328 insertions(+)
>  create mode 100644 arch/arm/boot/dts/imx53-m53menlo.dts
> 
> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
> index b0e966d625b9..731fc7de76b3 100644
> --- a/arch/arm/boot/dts/Makefile
> +++ b/arch/arm/boot/dts/Makefile
> @@ -376,6 +376,7 @@ dtb-$(CONFIG_SOC_IMX53) += \
>  	imx53-kp-ddc.dtb \
>  	imx53-kp-hsc.dtb \
>  	imx53-m53evk.dtb \
> +	imx53-m53menlo.dtb \
>  	imx53-mba53.dtb \
>  	imx53-ppd.dtb \
>  	imx53-qsb.dtb \
> diff --git a/arch/arm/boot/dts/imx53-m53menlo.dts b/arch/arm/boot/dts/imx53-m53menlo.dts
> new file mode 100644
> index 000000000000..405a57ad01a7
> --- /dev/null
> +++ b/arch/arm/boot/dts/imx53-m53menlo.dts
> @@ -0,0 +1,327 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * Copyright (C) 2017 Marek Vasut <marex@denx.de>
> + */
> +
> +/dts-v1/;
> +#include "imx53-m53.dtsi"
> +
> +/ {
> +	model = "MENLO M53 EMBEDDED DEVICE";
> +	compatible = "fsl,imx53";
> +
> +	leds {
> +		compatible = "gpio-leds";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&led_pin_gpio>;
> +
> +		user1 {
> +			label = "TestLed601";
> +			gpios = <&gpio6 1 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "mmc0";
> +		};
> +
> +		user2 {
> +			label = "TestLed602";
> +			gpios = <&gpio6 2 GPIO_ACTIVE_HIGH>;
> +			linux,default-trigger = "heartbeat";
> +		};
> +
> +		eth {
> +			label = "EthLedYe";
> +			gpios = <&gpio2 11 GPIO_ACTIVE_LOW>;
> +			linux,default-trigger = "none";
> +		};
> +	};
> +
> +	panel {
> +		compatible = "edt,etm070080dh6";
> +		enable-gpios = <&gpio6 0 GPIO_ACTIVE_HIGH>;
> +
> +		port {
> +			panel_in: endpoint {
> +				remote-endpoint = <&lvds0_out>;
> +			};
> +		};
> +	};
> +
> +	regulators {
> +		compatible = "simple-bus";
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		reg_usbh1_vbus: regulator@3 {
> +			compatible = "regulator-fixed";
> +			reg = <3>;
> +			regulator-name = "vbus";
> +			regulator-min-microvolt = <5000000>;
> +			regulator-max-microvolt = <5000000>;
> +			gpio = <&gpio1 2 0>;
> +		};
> +	};
> +};
> +
> +&can1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can1>;
> +	status = "okay";
> +};
> +
> +&can2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_can2>;
> +	status = "okay";
> +};
> +
> +&clks {
> +	assigned-clocks = <&clks IMX5_CLK_CKO1_SEL>,
> +			  <&clks IMX5_CLK_CKO1_PODF>,
> +			  <&clks IMX5_CLK_CKO1>;
> +	assigned-clock-parents = <&clks IMX5_CLK_AHB>;
> +	assigned-clock-rates = <133333334>, <33333334>, <33333334>;
> +};
> +
> +&esdhc1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_esdhc1>;
> +	cd-gpios = <&gpio1 1 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio1 9 GPIO_ACTIVE_HIGH>;
> +	status = "okay";
> +};
> +
> +&fec {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_fec>;
> +	phy-mode = "rmii";
> +	status = "okay";
> +};
> +
> +&i2c1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c1>;
> +	status = "okay";
> +
> +	edt-ft5x06@38 {
> +		compatible = "edt,edt-ft5x06";
> +		reg = <0x38>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&pinctrl_edt_ft5x06>;
> +		interrupt-parent = <&gpio6>;
> +		interrupts = <5 GPIO_ACTIVE_LOW>;
> +		reset-gpios = <&gpio2 9 GPIO_ACTIVE_LOW>;
> +		wake-gpios = <&gpio2 10 GPIO_ACTIVE_HIGH>;
> +	};
> +
> +	eeprom@50 {
> +		compatible = "atmel,24c64";
> +		reg = <0x50>;
> +		pagesize = <32>;
> +	};
> +
> +	dac@60 {
> +		compatible = "microchip,mcp4725";
> +		reg = <0x60>;
> +	};
> +};
> +
> +&i2c2 {
> +	stmpe610@41 {
> +		status = "disabled";
> +	};
> +};
> +
> +&i2c3 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c3>;
> +	status = "okay";
> +};
> +
> +&iomuxc {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_hog>;
> +
> +	imx53-m53evk {
> +		hoggrp {
> +			fsl,pins = <
> +				MX53_PAD_GPIO_0__CCM_SSI_EXT1_CLK	0x80000000
> +				MX53_PAD_EIM_EB3__GPIO2_31		0x80000000
> +				MX53_PAD_PATA_DA_0__GPIO7_6		0x80000000
> +				MX53_PAD_GPIO_19__CCM_CLKO		0x1d5
> +				MX53_PAD_CSI0_MCLK__CCM_CSI0_MCLK	0x1d5
> +				MX53_PAD_CSI0_DAT4__GPIO5_22		0x1d5
> +				MX53_PAD_CSI0_DAT5__GPIO5_23		0x1d5
> +				MX53_PAD_CSI0_DAT6__GPIO5_24		0x1d5
> +				MX53_PAD_CSI0_DAT7__GPIO5_25		0x1d5
> +				MX53_PAD_CSI0_DAT8__GPIO5_26		0x1d5
> +				MX53_PAD_CSI0_DAT9__GPIO5_27		0x1d5
> +				MX53_PAD_CSI0_DAT10__GPIO5_28		0x1d5
> +				MX53_PAD_CSI0_DAT11__GPIO5_29		0x1d5
> +				MX53_PAD_CSI0_DAT14__GPIO6_0		0x1d5
> +			>;
> +		};
> +
> +		led_pin_gpio: led_gpio@0 {
> +			fsl,pins = <
> +				MX53_PAD_CSI0_DAT15__GPIO6_1		0x1d5
> +				MX53_PAD_CSI0_DAT16__GPIO6_2		0x1d5
> +			>;
> +		};
> +
> +		pinctrl_can1: can1grp {
> +			fsl,pins = <
> +				MX53_PAD_GPIO_7__CAN1_TXCAN		0x80000000
> +				MX53_PAD_GPIO_8__CAN1_RXCAN		0x80000000
> +			>;
> +		};
> +
> +		pinctrl_can2: can2grp {
> +			fsl,pins = <
> +				MX53_PAD_KEY_COL4__CAN2_TXCAN		0x80000000
> +				MX53_PAD_KEY_ROW4__CAN2_RXCAN		0x80000000
> +			>;
> +		};
> +
> +		pinctrl_display_gpio: display-gpiogrp {
> +			fsl,pins = <
> +				MX53_PAD_CSI0_DAT12__GPIO5_30		0x1d5 /* Reset */
> +				MX53_PAD_CSI0_DAT13__GPIO5_31		0x1d5 /* Interrupt */
> +			>;
> +		};
> +
> +		pinctrl_edt_ft5x06: edt-ft5x06grp {
> +			fsl,pins = <
> +				MX53_PAD_PATA_DATA9__GPIO2_9		0x1d5 /* Reset */
> +				MX53_PAD_CSI0_DAT19__GPIO6_5		0x1d5 /* Interrupt */
> +				MX53_PAD_PATA_DATA10__GPIO2_10		0x1d5 /* Wake */
> +			>;
> +		};
> +
> +		pinctrl_esdhc1: esdhc1grp {
> +			fsl,pins = <
> +				MX53_PAD_SD1_DATA0__ESDHC1_DAT0		0x1d5
> +				MX53_PAD_SD1_DATA1__ESDHC1_DAT1		0x1d5
> +				MX53_PAD_SD1_DATA2__ESDHC1_DAT2		0x1d5
> +				MX53_PAD_SD1_DATA3__ESDHC1_DAT3		0x1d5
> +				MX53_PAD_SD1_CMD__ESDHC1_CMD		0x1d5
> +				MX53_PAD_SD1_CLK__ESDHC1_CLK		0x1d5
> +			>;
> +		};
> +
> +		pinctrl_fec: fecgrp {
> +			fsl,pins = <
> +				MX53_PAD_FEC_MDC__FEC_MDC		0x80000000
> +				MX53_PAD_FEC_MDIO__FEC_MDIO		0x80000000
> +				MX53_PAD_FEC_REF_CLK__FEC_TX_CLK	0x80000000
> +				MX53_PAD_FEC_RX_ER__FEC_RX_ER		0x80000000
> +				MX53_PAD_FEC_CRS_DV__FEC_RX_DV		0x80000000
> +				MX53_PAD_FEC_RXD1__FEC_RDATA_1		0x80000000
> +				MX53_PAD_FEC_RXD0__FEC_RDATA_0		0x80000000
> +				MX53_PAD_FEC_TX_EN__FEC_TX_EN		0x80000000
> +				MX53_PAD_FEC_TXD1__FEC_TDATA_1		0x80000000
> +				MX53_PAD_FEC_TXD0__FEC_TDATA_0		0x80000000
> +			>;
> +		};
> +
> +		pinctrl_i2c1: i2c1grp {
> +			fsl,pins = <
> +				MX53_PAD_EIM_D21__I2C1_SCL		0xc0000000
> +				MX53_PAD_EIM_D28__I2C1_SDA		0xc0000000
> +			>;
> +		};
> +
> +		pinctrl_i2c3: i2c3grp {
> +			fsl,pins = <
> +				MX53_PAD_GPIO_6__I2C3_SDA		0xc0000000
> +				MX53_PAD_GPIO_5__I2C3_SCL		0xc0000000
> +			>;
> +		};
> +
> +		pinctrl_lvds0: lvds0grp {
> +			fsl,pins = <
> +				MX53_PAD_LVDS0_CLK_P__LDB_LVDS0_CLK	0x80000000
> +				MX53_PAD_LVDS0_TX0_P__LDB_LVDS0_TX0	0x80000000
> +				MX53_PAD_LVDS0_TX1_P__LDB_LVDS0_TX1	0x80000000
> +				MX53_PAD_LVDS0_TX2_P__LDB_LVDS0_TX2	0x80000000
> +				MX53_PAD_LVDS0_TX3_P__LDB_LVDS0_TX3	0x80000000
> +			>;
> +		};
> +
> +		pinctrl_power_button_gpio: powerbutgrp {
> +			fsl,pins = <
> +				MX53_PAD_SD2_DATA0__AUDMUX_AUD4_RXD	0x1d5
> +			>;
> +		};
> +
> +		pinctrl_power_out_gpio: poweroutgrp {
> +			fsl,pins = <
> +				MX53_PAD_SD2_DATA2__AUDMUX_AUD4_TXD	0x1d5
> +			>;
> +		};
> +
> +		pinctrl_uart1: uart1grp {
> +			fsl,pins = <
> +				MX53_PAD_PATA_DIOW__UART1_TXD_MUX	0x1e4
> +				MX53_PAD_PATA_DMACK__UART1_RXD_MUX	0x1e4
> +			>;
> +		};
> +
> +		pinctrl_uart2: uart2grp {
> +			fsl,pins = <
> +				MX53_PAD_PATA_BUFFER_EN__UART2_RXD_MUX	0x1e4
> +				MX53_PAD_PATA_DMARQ__UART2_TXD_MUX	0x1e4
> +			>;
> +		};
> +
> +		pinctrl_usb: usbgrp {
> +			fsl,pins = <
> +				MX53_PAD_GPIO_2__GPIO1_2		0x80000000
> +				MX53_PAD_GPIO_3__USBOH3_USBH1_OC	0x80000000
> +			>;
> +		};
> +	};
> +};
> +
> +&ldb {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_lvds0>;
> +	status = "okay";
> +
> +	lvds0: lvds-channel@0 {
> +		fsl,data-mapping = "spwg";
> +		fsl,data-width = <18>;
> +		status = "okay";
> +
> +		port@2 {
> +			reg = <2>;
> +			lvds0_out: endpoint {
> +				remote-endpoint = <&panel_in>;
> +			};
> +		};
> +	};
> +};
> +
> +&uart1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart1>;
> +	status = "okay";
> +};
> +
> +&uart2 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_uart2>;
> +	status = "okay";
> +};
> +
> +&usbh1 {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_usb>;
> +	vbus-supply = <&reg_usbh1_vbus>;
> +	phy_type = "utmi";
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> +
> +&usbotg {
> +	dr_mode = "peripheral";
> +	status = "okay";
> +};
> 


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
