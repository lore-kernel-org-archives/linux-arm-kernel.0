Return-Path: <SRS0=AHqO=O5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F8A1C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:29:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F26321852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:29:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p1dVbnna";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSdtiwNR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F26321852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=tgolUVHbl0waXK5lzowp2RoUBcGpJwPQsKT/lyPe6LE=; b=p1d
	VbnnazJDjrMsYGLN2scrQyjhA48me8v/azbR4C5o9YmKm/MOmp0fiahd6brMFUwci/nfBET7OLuc8
	3GdAHA7KPBuCiZTs24Mfw3fJQ5OHoLE4rg0UMBA9SE2RIlmkdoWKN/GBeCqvuxUAa9JLZ8dq1bOlK
	W2gLvJMPsGwiHeZxo5e9/97Oh+7JCvSmFafNKuEA47SLd6LJNkftGmggDmf8s6/zoryGDDeDjCoiP
	v5hOwMtOx3aaalw6u4ZLmbAe/c3MaQtxmRlQKfaQaw6/p2hkzOEddFPVaOfHtUyjvEF9T5xKcf9yF
	n+CZbfGVVCebY6wIZgj6LbLCSWk9Pwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZzKE-0005zT-Bq; Thu, 20 Dec 2018 14:29:22 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZzKB-0005nW-8m
 for linux-arm-kernel@lists.infradead.org; Thu, 20 Dec 2018 14:29:21 +0000
Received: by mail-wm1-x332.google.com with SMTP id b11so2271452wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 06:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=Ag9SBmH6AE+35z5+goSJ4NdrYLId0xaYEoXuijvrrbM=;
 b=SSdtiwNRkpufHZw2eU2VANDy874Hy56oUTJxxRfa+156ZY88ihOmtox1tusbcyX2xh
 cn/oyySSys7sjmLa526brKyb5T/nIJPTNXIE6f/8MsLUD2tqfyvJQK6bo64F7y6bawfk
 4o107wRYPtHny8OYKWPMQ33rW9KqXRjY1D6l61MHiKJFJod+tA0kfvDzzQAAo0STBGuV
 FrGHc434FzVgzp9PezlgrfuTX2UyWZxe2oXMrHYjjGGWI91f4812WAV20vRuU0AOPfXF
 j6bP5b833nV7RBwAy8Bv+FSCtPSvU/EE4wAJBLej9IkcgBneIGqBVgUSdDiFEHDhUut0
 4wXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=Ag9SBmH6AE+35z5+goSJ4NdrYLId0xaYEoXuijvrrbM=;
 b=lRZwsp2PktAIEpYIOiEM7D5pS5gQusJvpr/SdheCHNOC+1jE7eQRGth5XWh8Ao7cGc
 I0Sq3abh0EMe+CThTixH7kZY6RlGWlJd2hbgNnHvhjU6ToVU4uiuZCgdPk+KHYIIhHBH
 79cr4tcptne4EzRV8Iug8wT6UNBf3Ee/ILShXnYwjIltCe2/w1sGI3cNXvwRv3WjjE58
 pn6xHdphHNrCkA2BB76Fq3FrwmGyZoJedDYJ2S/FmrFDJmiW7Wwgd2LZ5yTefrcI4x2U
 zBwAOo+qh5uiyvIhACeBMa8Xx65f8GRqzShsDl4pyEjREx+E9Z5TC5mK35HPwRZ5OJtY
 lNQQ==
X-Gm-Message-State: AA+aEWb1r/u2AgUZmTFWtcrpFz9Wn3RffkCKoBf6ZGOi8WqFO4wahLRo
 8bMOFYFJ6I9jfmpLeQXmjLB8hQNjKGg=
X-Google-Smtp-Source: AFSGD/X/DNV2yOEA0G7jxmYnNG5jwE4pb9KFcjGRqp2nOUMynh08M7FvwxRNOTlrkfZUd8z5iDuWjQ==
X-Received: by 2002:a7b:ce8e:: with SMTP id q14mr6599438wmj.10.1545316145956; 
 Thu, 20 Dec 2018 06:29:05 -0800 (PST)
Received: from localhost (ip1f11b9d6.dynamic.kabel-deutschland.de.
 [31.17.185.214])
 by smtp.gmail.com with ESMTPSA id y13sm7237570wrn.73.2018.12.20.06.29.01
 (version=TLS1_2 cipher=AES128-SHA bits=128/128);
 Thu, 20 Dec 2018 06:29:02 -0800 (PST)
From: Oliver Graute <oliver.graute@gmail.com>
X-Google-Original-From: Oliver Graute <oliver2000@gmx.net>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] ARM: dts: Add support for Variscite DART-6UL board
Date: Thu, 20 Dec 2018 15:28:37 +0100
Message-Id: <1545316119-18459-1-git-send-email-oliver2000@gmx.net>
X-Mailer: git-send-email 1.9.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_062919_358963_2CCD12B5 
X-CRM114-Status: GOOD (  17.56  )
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
Cc: s.hauer@pengutronix.de, Oliver Graute <oliver.graute@gmail.com>,
 linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
 shawnguo@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Oliver Graute <oliver.graute@gmail.com>

This patch adds support for the Variscite DART-6UL SoM

Signed-off-by: Oliver Graute <oliver.graute@gmail.com>
---
 .../boot/dts/imx6ul-imx6ull-var-dart-common.dtsi   | 623 +++++++++++++++++++++
 1 file changed, 623 insertions(+)
 create mode 100644 arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi

diff --git a/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
new file mode 100644
index 0000000..0bcb459
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-imx6ull-var-dart-common.dtsi
@@ -0,0 +1,623 @@
+// SPDX-License-Identifier: (GPL-2.0)
+/*
+ * Copyright (C) 2015 Freescale Semiconductor, Inc.
+ *
+ * Copyright (C) 2015-2017 Variscite Ltd. - http://www.variscite.com
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+/ {
+	chosen {
+		stdout-path = &uart1;
+	};
+
+	memory {
+		reg = <0x80000000 0x20000000>;
+	};
+
+	backlight {
+		compatible = "pwm-backlight";
+		pwms = <&pwm1 0 20000>;
+		brightness-levels = <0 4 8 16 32 64 128 255>;
+		default-brightness-level = <6>;
+		status = "okay";
+	};
+
+	pxp_v4l2 {
+		compatible = "fsl,imx6ul-pxp-v4l2", "fsl,imx6sx-pxp-v4l2", "fsl,imx6sl-pxp-v4l2";
+		status = "okay";
+	};
+
+	regulators {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		touch_3v3_regulator: touch_3v3_regulator {
+			compatible = "regulator-fixed";
+			regulator-name = "touch_3v3_supply";
+			regulator-always-on;
+			status = "okay";
+		};
+
+		reg_sd1_vmmc: regulator_sd1_vmmc {
+			compatible = "regulator-fixed";
+			regulator-name = "VSD_3V3";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		reg_gpio_dvfs: regulator-gpio {
+			compatible = "regulator-gpio";
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1400000>;
+			regulator-name = "gpio_dvfs";
+			regulator-type = "voltage";
+			gpios = <&gpio4 13 GPIO_ACTIVE_HIGH>;
+			states = <1300000 0x1 1400000 0x0>;
+		};
+	};
+
+	sound {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "wm8731audio";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line Jack",
+			"Microphone", "Mic Jack";
+		simple-audio-card,routing =
+			"Headphone Jack", "RHPOUT",
+			"Headphone Jack", "LHPOUT",
+			"LLINEIN", "Line Jack",
+			"RLINEIN", "Line Jack",
+			"MICIN", "Mic Bias",
+			"Mic Bias", "Mic Jack";
+		simple-audio-card,format = "i2s";
+		simple-audio-card,bitclock-master = <&sound_master>;
+		simple-audio-card,frame-master = <&sound_master>;
+		/*simple-audio-card,bitclock-inversion;*/
+
+		sound_master: simple-audio-card,cpu {
+			sound-dai = <&sai2>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&codec>;
+			system-clock-id = <2>;  /* WM8731_SYSCLK_MCLK */
+			system-clock-frequency = <12288000>;
+		};
+	};
+
+	keys {
+		compatible = "gpio-keys";
+
+		user {
+			gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_BACK>;
+			gpio-key,wakeup;
+		};
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		d16_led {
+			gpios = <&gpio4 20 0>;
+			linux,default-trigger = "heartbeat";
+		};
+	};
+};
+
+&cpu0 {
+	arm-supply = <&reg_arm>;
+	soc-supply = <&reg_soc>;
+	dc-supply = <&reg_gpio_dvfs>;
+};
+
+&clks {
+	/* ref_clk for micrel ethernet phy */
+	rmii_ref_clk: rmii_ref_clk_grp {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <25000000>;
+		clock-output-names = "rmii-ref";
+	};
+};
+
+&clks {
+	assigned-clocks = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <786432000>;
+};
+
+&fec1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet1>;
+	phy-mode = "rmii";
+	phy-reset-gpios=<&gpio5 0 1>;
+	phy-reset-duration=<100>;
+	phy-reset-on-resume;
+	phy-handle = <&ethphy0>;
+	status = "okay";
+};
+
+&fec2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_enet2>;
+	phy-mode = "rmii";
+	phy-handle = <&ethphy1>;
+	phy-reset-gpios=<&gpio1 10 1>;
+	phy-reset-duration=<100>;
+	phy-reset-on-resume;
+	status = "okay";
+	mdio {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		ethphy0: ethernet-phy@1 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,rmii-reference-clock-select-25-mhz;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reg = <1>;
+		};
+
+		ethphy1: ethernet-phy@3 {
+			compatible = "ethernet-phy-ieee802.3-c22";
+			micrel,rmii-reference-clock-select-25-mhz;
+			clocks = <&rmii_ref_clk>;
+			clock-names = "rmii-ref";
+			reg = <3>;
+		};
+	};
+};
+
+&can1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan1>;
+	status = "okay";
+};
+
+&can2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexcan2>;
+	status = "disabled";
+};
+
+&gpc {
+	fsl,cpu_pupscr_sw2iso = <0x2>;
+	fsl,cpu_pupscr_sw = <0x1>;
+	fsl,cpu_pdnscr_iso2sw = <0x1>;
+	fsl,cpu_pdnscr_iso = <0x1>;
+	fsl,ldo-bypass = <0>; /* DCDC, ldo-enable */
+};
+
+&lcdif {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_lcdif_dat
+		     &pinctrl_lcdif_ctrl>;
+	display = <&display0>;
+	status = "okay";
+
+	display0: display {
+		bits-per-pixel = <16>;
+		bus-width = <24>;
+
+		display-timings {
+			native-mode = <&timing0>;
+			timing0: timing0 {
+				clock-frequency =<35000000>;
+				hactive = <800>;
+				vactive = <480>;
+				hfront-porch = <40>;
+				hback-porch = <40>;
+				hsync-len = <48>;
+				vback-porch = <29>;
+				vfront-porch = <13>;
+				vsync-len = <3>;
+				hsync-active = <0>;
+				vsync-active = <0>;
+				de-active = <1>;
+				pixelclk-active = <0>;
+			};
+		};
+	};
+};
+
+&pwm1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_pwm1>;
+	status = "okay";
+};
+
+&sai2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_sai2>;
+	assigned-clocks = <&clks IMX6UL_CLK_SAI2_SEL>,
+			  <&clks IMX6UL_CLK_SAI2>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL4_AUDIO_DIV>;
+	assigned-clock-rates = <0>, <12288000>;
+	fsl,sai-mclk-direction-output;
+	status = "okay";
+};
+
+&adc1 {
+	vref-supply = <&touch_3v3_regulator>;
+	status = "okay";
+};
+
+&tsc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_tsc>;
+	xnur-gpio = <&gpio1 3 GPIO_ACTIVE_LOW>;
+	measure_delay_time = <0xffff>;
+	pre_charge_time = <0xfff>;
+	status = "disabled";
+};
+
+/* Console UART */
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart1>;
+	status = "okay";
+};
+
+/* Bluetooth UART */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart2>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+/* ttymxc2 UART */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_uart3>;
+	fsl,uart-has-rtscts;
+	status = "okay";
+};
+
+&wdog1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_wdog>;
+	fsl,ext-reset-output;
+};
+
+&usbotg1 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+&usbotg2 {
+	dr_mode = "host";
+	disable-over-current;
+	status = "okay";
+};
+
+/*  Wi-Fi/BT SD Card Slot Definition */
+&usdhc1 {
+	pinctrl-names = "default", "state_100mhz", "state_200mhz";
+	pinctrl-0 = <&pinctrl_usdhc1>;
+	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
+	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	assigned-clocks = <&clks IMX6UL_CLK_USDHC1_SEL>, <&clks IMX6UL_CLK_USDHC1>;
+	assigned-clock-parents = <&clks IMX6UL_CLK_PLL2_PFD2>;
+	assigned-clock-rates = <0>, <132000000>;
+	fsl,tuning-step= <2>;
+	vmmc-supply = <&reg_sd1_vmmc>;
+	status = "okay";
+};
+
+&gpmi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_gpmi_nand_1>;
+	fsl,legacy-bch-geometry;
+	status = "okay";
+
+	partition@0 {
+		label = "spl";
+		reg = <0x00000000 0x00200000>;
+	};
+
+	partition@1 {
+		label = "uboot";
+		reg = <0x00200000 0x00200000>;
+	};
+
+	partition@2 {
+		label = "uboot-env";
+		reg = <0x00400000 0x00200000>;
+	};
+
+	partition@3 {
+		label = "kernel";
+		reg = <0x00600000 0x00800000>;
+	};
+
+	partition@4 {
+		label = "rootfs";
+		reg = <0x00e00000 0x3f200000>;
+	};
+};
+
+&usdhc2 {
+	status = "disabled";
+};
+
+&i2c1 {
+	clock-frequency = <400000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c1>;
+	status = "okay";
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	codec: wm8731@1a {
+		#sound-dai-cells = <0>;
+		compatible = "wlf,wm8731";
+		reg = <0x1a>;
+		clocks = <&clks IMX6UL_CLK_SAI2>;
+		clock-names = "mclk";
+	};
+
+	ft5x06_ts@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio3>;
+		interrupts = <4 0>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+		touchscreen-inverted-x;
+		touchscreen-inverted-y;
+	};
+
+	/* DS1337 RTC module */
+	rtc@0x68 {
+		compatible = "dallas,ds1337";
+		reg = <0x68>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_rtc>;
+		interrupt-parent = <&gpio5>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog_1>;
+	imx6ul-evk {
+		pinctrl_hog_1: hoggrp-1 {
+			fsl,pins = <
+				MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x1b0b0
+				MX6UL_PAD_GPIO1_IO00__GPIO1_IO00	0x17059
+				MX6UL_PAD_GPIO1_IO07__ENET2_MDC		0x1b0b0
+				MX6UL_PAD_GPIO1_IO06__ENET2_MDIO	0x1b0b0
+				MX6UL_PAD_GPIO1_IO03__OSC32K_32K_OUT    0x03029
+			>;
+		};
+
+		pinctrl_enet1: enet1grp {
+			fsl,pins = <
+				MX6UL_PAD_ENET1_RX_EN__ENET1_RX_EN	0x1b0b0
+				MX6UL_PAD_ENET1_RX_ER__ENET1_RX_ER	0x1b0b0
+				MX6UL_PAD_ENET1_RX_DATA0__ENET1_RDATA00	0x1b0b0
+				MX6UL_PAD_ENET1_RX_DATA1__ENET1_RDATA01	0x1b0b0
+				MX6UL_PAD_ENET1_TX_EN__ENET1_TX_EN	0x1b0b0
+				MX6UL_PAD_ENET1_TX_DATA0__ENET1_TDATA00	0x1b0b0
+				MX6UL_PAD_ENET1_TX_DATA1__ENET1_TDATA01	0x1b0b0
+				MX6UL_PAD_ENET1_TX_CLK__ENET1_REF_CLK1	0x4001b031
+			>;
+		};
+
+		pinctrl_enet2: enet2grp {
+			fsl,pins = <
+				MX6UL_PAD_ENET2_RX_EN__ENET2_RX_EN	0x1b0b0
+				MX6UL_PAD_ENET2_RX_ER__ENET2_RX_ER	0x1b0b0
+				MX6UL_PAD_ENET2_RX_DATA0__ENET2_RDATA00	0x1b0b0
+				MX6UL_PAD_ENET2_RX_DATA1__ENET2_RDATA01	0x1b0b0
+				MX6UL_PAD_ENET2_TX_EN__ENET2_TX_EN	0x1b0b0
+				MX6UL_PAD_ENET2_TX_DATA0__ENET2_TDATA00	0x1b0b0
+				MX6UL_PAD_ENET2_TX_DATA1__ENET2_TDATA01	0x1b0b0
+				MX6UL_PAD_ENET2_TX_CLK__ENET2_REF_CLK2	0x4001b031
+				MX6UL_PAD_JTAG_MOD__GPIO1_IO10		0x1b0b0
+			>;
+		};
+
+		pinctrl_flexcan1: flexcan1grp{
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA09__FLEXCAN1_RX	0x1b020
+				MX6UL_PAD_LCD_DATA08__FLEXCAN1_TX	0x1b020
+			>;
+		};
+
+		pinctrl_flexcan2: flexcan2grp{
+			fsl,pins = <
+				MX6UL_PAD_UART2_RTS_B__FLEXCAN2_RX	0x1b020
+				MX6UL_PAD_UART2_CTS_B__FLEXCAN2_TX	0x1b020
+			>;
+		};
+
+		pinctrl_lcdif_dat: lcdifdatgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA02__LCDIF_DATA02	0x79
+				MX6UL_PAD_LCD_DATA03__LCDIF_DATA03	0x79
+				MX6UL_PAD_LCD_DATA04__LCDIF_DATA04	0x79
+				MX6UL_PAD_LCD_DATA05__LCDIF_DATA05	0x79
+				MX6UL_PAD_LCD_DATA06__LCDIF_DATA06	0x79
+				MX6UL_PAD_LCD_DATA07__LCDIF_DATA07	0x79
+				MX6UL_PAD_LCD_DATA10__LCDIF_DATA10	0x79
+				MX6UL_PAD_LCD_DATA11__LCDIF_DATA11	0x79
+				MX6UL_PAD_LCD_DATA12__LCDIF_DATA12	0x79
+				MX6UL_PAD_LCD_DATA13__LCDIF_DATA13	0x79
+				MX6UL_PAD_LCD_DATA14__LCDIF_DATA14	0x79
+				MX6UL_PAD_LCD_DATA15__LCDIF_DATA15	0x79
+				MX6UL_PAD_LCD_DATA18__LCDIF_DATA18	0x79
+				MX6UL_PAD_LCD_DATA19__LCDIF_DATA19	0x79
+				MX6UL_PAD_LCD_DATA20__LCDIF_DATA20	0x79
+				MX6UL_PAD_LCD_DATA21__LCDIF_DATA21	0x79
+				MX6UL_PAD_LCD_DATA22__LCDIF_DATA22	0x79
+				MX6UL_PAD_LCD_DATA23__LCDIF_DATA23	0x79
+			>;
+		};
+
+		pinctrl_lcdif_ctrl: lcdifctrlgrp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_CLK__LCDIF_CLK		0x79
+				MX6UL_PAD_LCD_ENABLE__LCDIF_ENABLE	0x79
+			>;
+		};
+
+		pinctrl_pwm1: pwm1grp {
+			fsl,pins = <
+				MX6UL_PAD_LCD_DATA00__PWM1_OUT		0x110b0
+			>;
+		};
+
+		pinctrl_uart1: uart1grp {
+			fsl,pins = <
+				MX6UL_PAD_UART1_TX_DATA__UART1_DCE_TX	0x1b0b1
+				MX6UL_PAD_UART1_RX_DATA__UART1_DCE_RX	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart2: uart2grp {
+			fsl,pins = <
+				MX6UL_PAD_UART2_TX_DATA__UART2_DCE_TX	0x1b0b1
+				MX6UL_PAD_UART2_RX_DATA__UART2_DCE_RX	0x1b0b1
+				MX6UL_PAD_UART2_CTS_B__UART2_DCE_CTS	0x1b0b1
+				MX6UL_PAD_UART2_RTS_B__UART2_DCE_RTS	0x1b0b1
+			>;
+		};
+
+		pinctrl_uart3: uart3grp {
+			fsl,pins = <
+				MX6UL_PAD_UART3_TX_DATA__UART3_DCE_TX	0x1b0b1
+				MX6UL_PAD_UART3_RX_DATA__UART3_DCE_RX	0x1b0b1
+				MX6UL_PAD_UART3_CTS_B__UART3_DCE_CTS	0x1b0b1
+				MX6UL_PAD_UART3_RTS_B__UART3_DCE_RTS	0x1b0b1
+			>;
+		};
+
+		pinctrl_usdhc1: usdhc1grp {
+			fsl,pins = <
+				MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x17059
+				MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x17059
+				MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x17059
+				MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x17059
+				MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x17059
+				MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x17059
+				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+			>;
+		};
+
+		pinctrl_usdhc1_100mhz: usdhc1grp100mhz {
+			fsl,pins = <
+				MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170b9
+				MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100b9
+				MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170b9
+				MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170b9
+				MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170b9
+				MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170b9
+				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+			>;
+		};
+
+		pinctrl_usdhc1_200mhz: usdhc1grp200mhz {
+			fsl,pins = <
+				MX6UL_PAD_SD1_CMD__USDHC1_CMD		0x170f9
+				MX6UL_PAD_SD1_CLK__USDHC1_CLK		0x100f9
+				MX6UL_PAD_SD1_DATA0__USDHC1_DATA0	0x170f9
+				MX6UL_PAD_SD1_DATA1__USDHC1_DATA1	0x170f9
+				MX6UL_PAD_SD1_DATA2__USDHC1_DATA2	0x170f9
+				MX6UL_PAD_SD1_DATA3__USDHC1_DATA3	0x170f9
+				MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x1b0b1
+			>;
+		};
+
+		pinctrl_gpmi_nand_1: gpmi-nand-1 {
+			fsl,pins = <
+				MX6UL_PAD_NAND_CLE__RAWNAND_CLE		0xb0b1
+				MX6UL_PAD_NAND_ALE__RAWNAND_ALE		0xb0b1
+				MX6UL_PAD_NAND_WP_B__RAWNAND_WP_B	0xb0b1
+				MX6UL_PAD_NAND_READY_B__RAWNAND_READY_B	0xb000
+				MX6UL_PAD_NAND_CE0_B__RAWNAND_CE0_B	0xb0b1
+				MX6UL_PAD_NAND_CE1_B__RAWNAND_CE1_B	0xb0b1
+				MX6UL_PAD_NAND_RE_B__RAWNAND_RE_B	0xb0b1
+				MX6UL_PAD_NAND_WE_B__RAWNAND_WE_B	0xb0b1
+				MX6UL_PAD_NAND_DATA00__RAWNAND_DATA00	0xb0b1
+				MX6UL_PAD_NAND_DATA01__RAWNAND_DATA01	0xb0b1
+				MX6UL_PAD_NAND_DATA02__RAWNAND_DATA02	0xb0b1
+				MX6UL_PAD_NAND_DATA03__RAWNAND_DATA03	0xb0b1
+				MX6UL_PAD_NAND_DATA04__RAWNAND_DATA04	0xb0b1
+				MX6UL_PAD_NAND_DATA05__RAWNAND_DATA05	0xb0b1
+				MX6UL_PAD_NAND_DATA06__RAWNAND_DATA06	0xb0b1
+				MX6UL_PAD_NAND_DATA07__RAWNAND_DATA07	0xb0b1
+			>;
+		};
+
+		pinctrl_i2c1: i2c1grp {
+			fsl,pins = <
+				MX6UL_PAD_UART4_TX_DATA__I2C1_SCL	0x4001b8b0
+				MX6UL_PAD_UART4_RX_DATA__I2C1_SDA	0x4001b8b0
+			>;
+		};
+
+		pinctrl_i2c2: i2c2grp {
+			fsl,pins = <
+				MX6UL_PAD_UART5_TX_DATA__I2C2_SCL	0x4001b8b0
+				MX6UL_PAD_UART5_RX_DATA__I2C2_SDA	0x4001b8b0
+			>;
+		};
+
+		pinctrl_tsc: tscgrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO01__GPIO1_IO01	0xb0
+				MX6UL_PAD_GPIO1_IO02__GPIO1_IO02	0xb0
+				MX6UL_PAD_GPIO1_IO03__GPIO1_IO03	0xb0
+				MX6UL_PAD_GPIO1_IO04__GPIO1_IO04	0xb0
+			>;
+		};
+
+		pinctrl_sai1: sai1grp {
+			fsl,pins = <
+				MX6UL_PAD_CSI_DATA05__SAI1_TX_BCLK	0x11088
+				MX6UL_PAD_CSI_DATA04__SAI1_TX_SYNC	0x17088
+				MX6UL_PAD_CSI_DATA06__SAI1_RX_DATA	0x11088
+				MX6UL_PAD_CSI_DATA07__SAI1_TX_DATA	0x11088
+			>;
+		};
+
+		pinctrl_sai2: sai2grp {
+			fsl,pins = <
+				MX6UL_PAD_JTAG_TDI__SAI2_TX_BCLK	0x17088
+				MX6UL_PAD_JTAG_TDO__SAI2_TX_SYNC	0x17088
+				MX6UL_PAD_JTAG_TRST_B__SAI2_TX_DATA	0x11088
+				MX6UL_PAD_JTAG_TCK__SAI2_RX_DATA	0x11088
+				MX6UL_PAD_JTAG_TMS__SAI2_MCLK		0x17088
+			>;
+		};
+
+		pinctrl_wdog: wdoggrp {
+			fsl,pins = <
+				MX6UL_PAD_GPIO1_IO08__WDOG1_WDOG_B	0x78b0
+			>;
+		};
+	};
+};
+
+&snvs_rtc {
+	status = "disabled";
+};
+
+&snvs_poweroff {
+	status = "okay";
+};
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
