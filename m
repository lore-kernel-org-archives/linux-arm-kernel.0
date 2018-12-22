Return-Path: <SRS0=zEjV=O7=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A7FC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:53:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4ED3121A48
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 10:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Gn7yUDsG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="gd42ZAAW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ED3121A48
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=mail.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=VDsuSy15O5zE38dU9uuL6X0VdfjdH+ZmoD1pcU1UXUQ=; b=Gn7yUDsGpvroR+/9hEapz6i1eJ
	CXyxXO3dogiFwoKjA+B7dHRvdTlZbFNYCdGTMUTXsJtvLdswmnqPs4atIskwJ+dfhhCZZN0pItjov
	5n1CorJZWjmW3FIoIukXdxHIWSUdFYS+xmx6YOvi+f4jPriK9jkm4ZBoVf24Z5xWGMs+5wsP8HHim
	1PBFqxcZiM4+7stBoK0zYFscDinQrjpn8/iOD0k06oOMAEXJ0Plf74qqkKA1yVmVipCisxDx0iaTd
	yndeccMXXI+fMPeI6YkcK2Iq7Yq5U1hnUNhzlh3S1GyOeSpKada9hLxZpX4voFoPGpE8EF7rZjvPn
	Tl4myPfQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaeue-0001TD-Mm; Sat, 22 Dec 2018 10:53:44 +0000
Received: from smtp52.i.mail.ru ([94.100.177.112])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaetH-0000I5-MK
 for linux-arm-kernel@lists.infradead.org; Sat, 22 Dec 2018 10:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru;
 s=mail2; 
 h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From;
 bh=Y2mod3rFDBz0fuvz/KwpYsyabw4rO6a0T3zL4BDl38E=; 
 b=gd42ZAAW6e0L60PrNUrDpKcU9mI0qfFZraxIwjav/AeLWJM8cXwBn4b0NrEGk02La1Jw4owl8SeeD+6OpdBF6cucdcgWKtP2rQjdUHhL8S4teHo5J2C3b/aWw2bWNwqP7LR9FFXVxWxAOe2YuWwQaLAAxdh0K6TWPDFoz/arsbM=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <shc_work@mail.ru>)
 id 1gaet3-00014B-3w; Sat, 22 Dec 2018 13:52:05 +0300
From: Alexander Shiyan <shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] ARM: dts: imx21: Add support for the i.MX21 Freescale ADS
 board
Date: Sat, 22 Dec 2018 13:51:57 +0300
Message-Id: <20181222105200.18502-3-shc_work@mail.ru>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20181222105200.18502-1-shc_work@mail.ru>
References: <20181222105200.18502-1-shc_work@mail.ru>
Authentication-Results: smtp52.i.mail.ru; auth=pass smtp.auth=shc_work@mail.ru
 smtp.mailfrom=shc_work@mail.ru
X-77F55803: 260C666A7D66B36A5A78504BD2AC29419868B496DAF47A9FC2F14F5A7AB53D3673701D800117DB2AEC1EF77A7AB077F7
X-7FA49CB5: 0D63561A33F958A53228BC2C66DA7434857BED211D07E6A3BBFA66BC9C3127138941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC8364767815B9869FA544D8D32BA5DBAC0009BE9E8FC8737B5C22498B372E35CF5A2D2DD32BA5DBAC0009BE395957E7521B51C24DA2F55E57A558BE49FD398EE364050FF8AB6B2BE221812676E601842F6C81A1F004C906525384306FED454B719173D6725E5C173C3A84C315AF0D0D4FC4FA3DC8DE00BB560DE647BFC944FC657CDB72C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D244531C2B742D01D006815582FFDB86750E4990A867F7ABE39706B3B2BD4812BFD4DC77752E0C033A69E93554C27080790AB3B25A7FBAAF806F0AE208404248635DF
X-Mras: OK
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181222_025220_149900_8EB90A90 
X-CRM114-Status: GOOD (  14.48  )
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
Cc: Alexander Shiyan <shc_work@mail.ru>, Russell King <linux@armlinux.org.uk>,
 NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Shawn Guo <shawnguo@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds support for the i.MX21 ADS from Freescale.
This change is intended to further remove non-DT support for this board.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/Makefile      |   2 +
 arch/arm/boot/dts/imx21-ads.dts | 242 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx21-ads.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d..e71be45 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -338,6 +338,8 @@ dtb-$(CONFIG_ARCH_MOXART) += \
 dtb-$(CONFIG_SOC_IMX1) += \
 	imx1-ads.dtb \
 	imx1-apf9328.dtb
+dtb-$(CONFIG_SOC_IMX21) += \
+	imx21-ads.dtb
 dtb-$(CONFIG_SOC_IMX25) += \
 	imx25-eukrea-mbimxsd25-baseboard.dtb \
 	imx25-eukrea-mbimxsd25-baseboard-cmo-qvga.dtb \
diff --git a/arch/arm/boot/dts/imx21-ads.dts b/arch/arm/boot/dts/imx21-ads.dts
new file mode 100644
index 0000000..58c9581
--- /dev/null
+++ b/arch/arm/boot/dts/imx21-ads.dts
@@ -0,0 +1,242 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/* Author: Alexander Shiyan <shc_work@mail.ru> */
+
+/dts-v1/;
+
+#include "imx21.dtsi"
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	model = "Freescale MX21 ADS";
+	compatible = "fsl,imx21ads", "fsl,imx21";
+
+	chosen {
+		stdout-path = &serial1;
+	};
+
+	memory {
+		device_type = "memory";
+		reg = <0xc0000000 0x04000000>;
+	};
+
+	display: LQ035Q7 {
+		model = "Sharp-LQ035Q7";
+		native-mode = <&timing>;
+		bits-per-pixel = <16>;
+		fsl,pcr = <0xfb108bc7>;
+
+		display-timings {
+			timing: 240x320 {
+				clock-frequency = <5500000>;
+				hactive = <240>;
+				vactive = <320>;
+				hback-porch = <6>;
+				hsync-len = <2>;
+				hfront-porch = <16>;
+				vback-porch = <8>;
+				vsync-len = <1>;
+				vfront-porch = <10>;
+				vsync-active = <0>;
+			};
+		};
+	};
+
+	led3: led3 {
+		compatible = "gpio-leds";
+		label = "system::live";
+		gpios = <&ioreg 15 GPIO_ACTIVE_LOW>;
+		linux,default-trigger = "heartbeat";
+	};
+
+	led4: led4 {
+		compatible = "gpio-leds";
+		label = "system::user";
+		gpios = <&ioreg 14 GPIO_ACTIVE_LOW>;
+	};
+
+	reg_lcd: regulator_lcd {
+		compatible = "regulator-fixed";
+		regulator-name = "lcd";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&ioreg 9 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+	};
+};
+
+&eim {
+	status = "okay";
+
+	nor: nor@0,0 {
+		compatible = "cfi-flash";
+		reg = <0 0x00000000 0x02000000>;
+		bank-width = <2>;
+		fsl,weim-cs-timing = <0x00003e00 0x00000e01>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+	};
+
+	ethernet: cs8900a@1,0 {
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_ethernet>;
+		compatible = "cirrus,cs8900";
+		reg = <1 0x00000000 0x00001000>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <11 IRQ_TYPE_LEVEL_LOW>;
+		fsl,weim-cs-timing = <0x00002000 0x11118501>;
+	};
+
+	ioreg: ioreg@1,800000 {
+		compatible = "ti,7416374";
+		reg = <1 0x00800000 0x00000002>;
+		gpio-controller;
+		fsl,weim-cs-timing = <0x00002000 0x11118501>;
+		#gpio-cells = <2>;
+	};
+};
+
+&fb {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_fb>;
+	display = <&display>;
+	fsl,dmacr = <0x00020008>;
+	fsl,lscr1 = <0x00120300>;
+	fsl,lpccr = <0x00a903ff>;
+	lcd-supply = <&reg_lcd>;
+	status = "okay";
+};
+
+&nandfc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_nandfc>;
+	nand-bus-width = <8>;
+	nand-ecc-mode = "hw";
+	nand-on-flash-bbt;
+	status = "okay";
+};
+
+&sdhci1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sdhci1>;
+	cd-gpios = <&gpio4 25 GPIO_ACTIVE_LOW>;
+	status = "okay";
+};
+
+&serial1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_serial1>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&serial3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_serial3>;
+	status = "okay";
+};
+
+&serial4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_serial4>;
+	uart-has-rtscts;
+	status = "okay";
+};
+
+&iomuxc {
+	imx21_ads21 {
+		pinctrl_ethernet: ethernetgrp {
+			fsl,pins = <
+				MX21_PAD_UART3_RTS__GPIO5_11	0x0	/* IRQ */
+			>;
+		};
+
+		pinctrl_fb: fbgrp {
+			fsl,pins = <
+				MX21_PAD_LSCLK__LSCLK		0x0
+				MX21_PAD_LD0__LD0		0x0
+				MX21_PAD_LD1__LD1		0x0
+				MX21_PAD_LD2__LD2		0x0
+				MX21_PAD_LD3__LD3		0x0
+				MX21_PAD_LD4__LD4		0x0
+				MX21_PAD_LD5__LD5		0x0
+				MX21_PAD_LD6__LD6		0x0
+				MX21_PAD_LD7__LD7		0x0
+				MX21_PAD_LD8__LD8		0x0
+				MX21_PAD_LD9__LD9		0x0
+				MX21_PAD_LD10__LD10		0x0
+				MX21_PAD_LD11__LD11		0x0
+				MX21_PAD_LD12__LD12		0x0
+				MX21_PAD_LD13__LD13		0x0
+				MX21_PAD_LD14__LD14		0x0
+				MX21_PAD_LD15__LD15		0x0
+				MX21_PAD_REV__REV		0x0
+				MX21_PAD_CLS__CLS		0x0
+				MX21_PAD_PS__PS			0x0
+				MX21_PAD_SPL_SPR__SPL_SPR	0x0
+				MX21_PAD_HSYNC__HSYNC		0x0
+				MX21_PAD_VSYNC__VSYNC		0x0
+				MX21_PAD_CONTRAST__CONTRAST	0x0
+				MX21_PAD_OE_ACD__OE_ACD		0x0
+			>;
+		};
+
+		pinctrl_nandfc: nandfcgrp {
+			fsl,pins = <
+				MX21_PAD_NFRB__NFRB		0x0
+				MX21_PAD_NFCE__NFCE		0x0
+				MX21_PAD_NFWP__NFWP		0x0
+				MX21_PAD_NFCLE__NFCLE		0x0
+				MX21_PAD_NFALE__NFALE		0x0
+				MX21_PAD_NFRE__NFRE		0x0
+				MX21_PAD_NFWE__NFWE		0x0
+				MX21_PAD_NFIO0__NFIO0		0x0
+				MX21_PAD_NFIO1__NFIO1		0x0
+				MX21_PAD_NFIO2__NFIO2		0x0
+				MX21_PAD_NFIO3__NFIO3		0x0
+				MX21_PAD_NFIO4__NFIO4		0x0
+				MX21_PAD_NFIO5__NFIO5		0x0
+				MX21_PAD_NFIO6__NFIO6		0x0
+				MX21_PAD_NFIO7__NFIO7		0x0
+			>;
+		};
+
+		pinctrl_sdhci1: sdhci1grp {
+			fsl,pins = <
+				MX21_PAD_SD1_D0__SD1_D0		0x0
+				MX21_PAD_SD1_D1__SD1_D1		0x0
+				MX21_PAD_SD1_D2__SD1_D2		0x0
+				MX21_PAD_SD1_D3__SD1_D3		0x0
+				MX21_PAD_SD1_CMD__SD1_CMD	0x0
+				MX21_PAD_SD1_CLK__SD1_CLK	0x0
+				MX21_PAD_CSPI1_RDY__GPIO4_25	0x0	/* CD */
+			>;
+		};
+
+		pinctrl_serial1: serial1grp {
+			fsl,pins = <
+				MX21_PAD_UART1_TXD__UART1_TXD	0x0
+				MX21_PAD_UART1_RXD__UART1_RXD	0x0
+				MX21_PAD_UART1_CTS__UART1_CTS	0x0
+				MX21_PAD_UART1_RTS__UART1_RTS	0x0
+			>;
+		};
+
+		pinctrl_serial3: serial3grp {
+			fsl,pins = <
+				MX21_PAD_UART3_TXD__UART3_TXD	0x0
+				MX21_PAD_UART3_RXD__UART3_RXD	0x0
+			>;
+		};
+
+		pinctrl_serial4: serial4grp {
+			fsl,pins = <
+				MX21_PAD_USBH1_TXDM__UART4_TXD	0x0
+				MX21_PAD_USBH1_RXDP__UART4_RXD	0x0
+				MX21_PAD_USBH1_FS__UART4_RTS	0x0
+				MX21_PAD_USBH1_TXDP__UART4_CTS	0x0
+			>;
+		};
+	};
+};
-- 
2.10.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
