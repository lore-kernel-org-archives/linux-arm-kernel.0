Return-Path: <SRS0=y9BX=QM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE757C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:17:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72829217F9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 23:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cvf1fsbr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UZSh5uHI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72829217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lunn.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=8scaBV6HcZ363wJz2GWrtSllM3xQNFs8sXaD1ybAqio=; b=cvf
	1fsbriJOquZ6UmzBr5MPciam1+kLCgYz4Q7Jd3zVcjjGNAirr1CQluq/HLPfyjB3HyRLXgfLBAf8P
	SdisslD866m9gSIqD/9XCnL78EY9jPbWmdF3xJdreomZyn5ZT1Du4oIGklS+8Jtm+KlYMZWTth6Le
	Yd4ErTNXMBxNSjHK+a/DVxqHkcv1XUrL09KZavhnhwALHXZhIXAkaXN+VcSu5BYWwE9phYBNrdqD5
	QXqJqybSzN8LwH97qL7O5o2I+cyZIYoXULqR9KpkwPMF4FVmtEWlCXbZuBLsv3ZacIPbghoocRwKM
	eUK0eJkGyHVQfY9jon0mPMyOCK+iViA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gr9xq-00053w-Jf; Tue, 05 Feb 2019 23:17:14 +0000
Received: from vps0.lunn.ch ([185.16.172.187])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gr9xn-00053P-8F
 for linux-arm-kernel@lists.infradead.org; Tue, 05 Feb 2019 23:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version
 :Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WL9OHuNWJWb1+2Gzn+kn26A8xK1kOZ/GGbYKkMROtk0=; b=UZSh5uHI4StI/OxQ2fngrXTcLc
 R9ccHQlsejEjPPxFTuWAk5ZnmzFn4ugrzF4Fbz8oZ7JvZ0SShKKfHF+iCw7B5ZRHvbJ7GwgKOFylG
 4LGNZD0tWzEdh/wRWzySnCoF214QQ69UsNxNVtsHaeQvS9lO8AOmbtGDfBTWORXan0hQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
 (envelope-from <andrew@lunn.ch>)
 id 1gr9xR-0005bd-93; Wed, 06 Feb 2019 00:16:49 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: shawnguo@kernel.org
Subject: [PATCH v2] ARM: dts: vf610: Add ZII SSMB DTU board
Date: Wed,  6 Feb 2019 00:16:41 +0100
Message-Id: <20190205231641.21508-1-andrew@lunn.ch>
X-Mailer: git-send-email 2.11.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_151711_442972_22A2D20F 
X-CRM114-Status: GOOD (  12.59  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, stefan@agner.ch,
 linux ARM <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add the Zodiac Digital Tapping Unit, a VF610 based network device with
5 Ethernet ports. One of these ports supports 1000Base-T2.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
---
v2: Use generic node names
---
 arch/arm/boot/dts/Makefile               |   1 +
 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts | 311 +++++++++++++++++++++++
 2 files changed, 312 insertions(+)
 create mode 100644 arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148a15b2..df9c519a0433 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -599,6 +599,7 @@ dtb-$(CONFIG_SOC_VF610) += \
 	vf610-zii-dev-rev-b.dtb \
 	vf610-zii-dev-rev-c.dtb \
 	vf610-zii-scu4-aib.dtb \
+	vf610-zii-ssmb-dtu.dtb \
 	vf610-zii-ssmb-spu3.dtb
 dtb-$(CONFIG_ARCH_MXS) += \
 	imx23-evk.dtb \
diff --git a/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
new file mode 100644
index 000000000000..2b10672fadbd
--- /dev/null
+++ b/arch/arm/boot/dts/vf610-zii-ssmb-dtu.dts
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+
+/*
+ * Device tree file for ZII's SSMB DTU board
+ *
+ * SSMB - SPU3 Switch Management Board
+ * DTU - Digital Tapping Unit
+ *
+ * Copyright (C) 2015-2019 Zodiac Inflight Innovations
+ *
+ * Based on an original 'vf610-twr.dts' which is Copyright 2015,
+ * Freescale Semiconductor, Inc.
+ */
+
+/dts-v1/;
+#include "vf610.dtsi"
+
+/ {
+	model = "ZII VF610 SSMB DTU Board";
+	compatible = "zii,vf610dtu", "zii,vf610dev", "fsl,vf610";
+
+	chosen {
+		stdout-path = &uart0;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x80000000 0x20000000>;
+	};
+
+	gpio-leds {
+		compatible = "gpio-leds";
+		pinctrl-0 = <&pinctrl_leds_debug>;
+		pinctrl-names = "default";
+
+		led-debug {
+			label = "zii:green:debug1";
+			gpios = <&gpio2 18 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "heartbeat";
+			max-brightness = <1>;
+		};
+	};
+
+	reg_vcc_3v3_mcu: regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_3v3_mcu";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&adc0 {
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&adc1 {
+	vref-supply = <&reg_vcc_3v3_mcu>;
+	status = "okay";
+};
+
+&edma0 {
+	status = "okay";
+};
+
+&edma1 {
+	status = "okay";
+};
+
+&esdhc0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc0>;
+	bus-width = <8>;
+	non-removable;
+	no-1-8-v;
+	keep-power-in-suspend;
+	status = "okay";
+};
+
+&esdhc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_esdhc1>;
+	bus-width = <4>;
+	status = "okay";
+};
+
+&fec1 {
+	phy-mode = "rmii";
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fec1>;
+	status = "okay";
+
+	fixed-link {
+		speed = <100>;
+		full-duplex;
+	};
+
+	mdio1: mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+		status = "okay";
+
+		switch0: switch0@0 {
+			compatible = "marvell,mv88e6190";
+			pinctrl-0 = <&pinctrl_gpio_switch0>;
+			pinctrl-names = "default";
+			reg = <0>;
+			eeprom-length = <65536>;
+			reset-gpios = <&gpio3 11 GPIO_ACTIVE_LOW>;
+			interrupt-parent = <&gpio3>;
+			interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "cpu";
+					ethernet = <&fec1>;
+
+					fixed-link {
+						speed = <100>;
+						full-duplex;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "eth_cu_100_3";
+				};
+
+				port@5 {
+					reg = <5>;
+					label = "eth_cu_1000_4";
+				};
+
+				port@6 {
+					reg = <6>;
+					label = "eth_cu_1000_5";
+				};
+
+				port@8 {
+					reg = <8>;
+					label = "eth_cu_1000_1";
+				};
+
+				port@9 {
+					reg = <9>;
+					label = "eth_cu_1000_2";
+					phy-handle = <&phy9>;
+					phy-mode = "sgmii";
+					managed = "in-band-status";
+				};
+			};
+
+			mdio1 {
+				compatible = "marvell,mv88e6xxx-mdio-external";
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				phy9: phy9@0 {
+					compatible = "ethernet-phy-ieee802.3-c45";
+					pinctrl-0 = <&pinctrl_gpio_phy9>;
+					pinctrl-names = "default";
+					interrupt-parent = <&gpio2>;
+					interrupts = <30 IRQ_TYPE_LEVEL_LOW>;
+					reg = <0>;
+				};
+			};
+		};
+	};
+};
+
+&i2c0 {
+	clock-frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c0>;
+	status = "okay";
+
+	gpio6: gpio-expander@22 {
+		compatible = "nxp,pca9554";
+		reg = <0x22>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
+	/* On SSMB */
+	temperature-sensor@48 {
+		compatible = "national,lm75";
+		reg = <0x48>;
+	};
+
+	/* On DSB */
+	temperature-sensor@4d {
+		compatible = "national,lm75";
+		reg = <0x4d>;
+	};
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+		label = "nameplate";
+	};
+
+	eeprom@52 {
+		compatible = "atmel,24c04";
+		reg = <0x52>;
+	};
+};
+
+&uart0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart0>;
+	status = "okay";
+};
+
+&iomuxc {
+	pinctrl_dspi1: dspi1grp {
+		fsl,pins = <
+			VF610_PAD_PTD5__DSPI1_CS0		0x1182
+			VF610_PAD_PTD4__DSPI1_CS1		0x1182
+			VF610_PAD_PTC6__DSPI1_SIN		0x1181
+			VF610_PAD_PTC7__DSPI1_SOUT		0x1182
+			VF610_PAD_PTC8__DSPI1_SCK		0x1182
+		>;
+	};
+
+	pinctrl_esdhc0: esdhc0grp {
+		fsl,pins = <
+			VF610_PAD_PTC0__ESDHC0_CLK		0x31ef
+			VF610_PAD_PTC1__ESDHC0_CMD		0x31ef
+			VF610_PAD_PTC2__ESDHC0_DAT0		0x31ef
+			VF610_PAD_PTC3__ESDHC0_DAT1		0x31ef
+			VF610_PAD_PTC4__ESDHC0_DAT2		0x31ef
+			VF610_PAD_PTC5__ESDHC0_DAT3		0x31ef
+			VF610_PAD_PTD23__ESDHC0_DAT4		0x31ef
+			VF610_PAD_PTD22__ESDHC0_DAT5		0x31ef
+			VF610_PAD_PTD21__ESDHC0_DAT6		0x31ef
+			VF610_PAD_PTD20__ESDHC0_DAT7		0x31ef
+		>;
+	};
+
+	pinctrl_esdhc1: esdhc1grp {
+		fsl,pins = <
+			VF610_PAD_PTA24__ESDHC1_CLK		0x31ef
+			VF610_PAD_PTA25__ESDHC1_CMD		0x31ef
+			VF610_PAD_PTA26__ESDHC1_DAT0		0x31ef
+			VF610_PAD_PTA27__ESDHC1_DAT1		0x31ef
+			VF610_PAD_PTA28__ESDHC1_DATA2		0x31ef
+			VF610_PAD_PTA29__ESDHC1_DAT3		0x31ef
+		>;
+	};
+
+	pinctrl_fec1: fec1grp {
+		fsl,pins = <
+			VF610_PAD_PTA6__RMII_CLKIN		0x30d1
+			VF610_PAD_PTC9__ENET_RMII1_MDC		0x30d2
+			VF610_PAD_PTC10__ENET_RMII1_MDIO	0x30d3
+			VF610_PAD_PTC11__ENET_RMII1_CRS		0x30d1
+			VF610_PAD_PTC12__ENET_RMII1_RXD1	0x30d1
+			VF610_PAD_PTC13__ENET_RMII1_RXD0	0x30d1
+			VF610_PAD_PTC14__ENET_RMII1_RXER	0x30d1
+			VF610_PAD_PTC15__ENET_RMII1_TXD1	0x30d2
+			VF610_PAD_PTC16__ENET_RMII1_TXD0	0x30d2
+			VF610_PAD_PTC17__ENET_RMII1_TXEN	0x30d2
+		>;
+	};
+
+	pinctrl_gpio_phy9: pinctrl-gpio-phy9 {
+		fsl,pins = <
+			VF610_PAD_PTB24__GPIO_94		0x219d
+		>;
+	};
+
+	pinctrl_gpio_switch0: pinctrl-gpio-switch0 {
+		fsl,pins = <
+			VF610_PAD_PTE2__GPIO_107		0x31c2
+			VF610_PAD_PTB28__GPIO_98		0x219d
+		>;
+	};
+
+	pinctrl_i2c0: i2c0grp {
+		fsl,pins = <
+			VF610_PAD_PTB14__I2C0_SCL		0x37ff
+			VF610_PAD_PTB15__I2C0_SDA		0x37ff
+		>;
+	};
+
+	pinctrl_i2c1: i2c1grp {
+		fsl,pins = <
+			VF610_PAD_PTB16__I2C1_SCL		0x37ff
+			VF610_PAD_PTB17__I2C1_SDA		0x37ff
+		>;
+	};
+
+	pinctrl_leds_debug: pinctrl-leds-debug {
+		fsl,pins = <
+			VF610_PAD_PTD3__GPIO_82			0x31c2
+		>;
+	};
+
+	pinctrl_uart0: uart0grp {
+		fsl,pins = <
+			VF610_PAD_PTB10__UART0_TX		0x21a2
+			VF610_PAD_PTB11__UART0_RX		0x21a1
+		>;
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
