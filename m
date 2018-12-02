Return-Path: <SRS0=zgA4=OL=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A05C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:40:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C1D20881
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 22:40:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="swGLsMFi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aOYKAVY9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C1D20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ossystems.com.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iKT+AegIRomGBXVfchqnZuENQwaV9zg5QcwepRE9kOE=; b=swGLsMFiRmZ1eI
	gvPymItIJxTp94HeWeDeMImtNfofLrkT5In9z9UlT6egyIecRGSmzybp8+X8TcSFREJBuQxCVsuP/
	J7qyfsld5X4qcJmcul2Ig0cM3XBsVtJLBnTWdCFBGhi38hpl+pU8qZknTspS5D2k93svQPSB1BIj6
	i887XqEPxchUfu9UtOUDag3Zw5AX1MAW1RGfvwAEJmPzRhGv8CSrTXBS6Yq2yKt73jV7mQ4Yccu4l
	0/NpJzJwmqmPlKGGWVW/IRKcrAKDVTVY2mp+kye+gvZ7THH6lloAhdpL1IeQLIgkssHx0ZCqKgdsQ
	LOrtvTDptYvdRQSLHGlQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTaPb-0003Hb-6D; Sun, 02 Dec 2018 22:40:27 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTaGw-0006wi-Kf
 for linux-arm-kernel@bombadil.infradead.org; Sun, 02 Dec 2018 22:31:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=55pQVhEpgT5gvpJTmZIDiBlXiFeCfhLW8JmA+NU3SGU=; b=aOYKAVY9oNVGNnAQJ/CXPPTKoe
 nQWZgB/NPk7rQOHUxTLQy1RRiqKXvQAFZ6U2a7N+1g0H9MpCSbReMYvMx84gLnHCN+eKkvJm3i7hj
 zUYU3O6AJuHX54q2pPmUzJwdggwLohpr0n68YESNt5D99WrtrRbkfrgj8uyuVS+2bOaFjutp7MXgQ
 i8TrtRPzFtVnxt6caXJz6GfBWysszvdD9mRQ1j60iQgM8/sgnK9NQhk5CfhLamRPsqozUbts+czTs
 N6ToCh0y/M9ighJx9/Yd77gEe4U+Oyioo5hhxXqA+fDQ2HFmlQjBacOrLKayGppP8UHQNoR5EyQkD
 017bH/mA==;
Received: from mail-qt1-f193.google.com ([209.85.160.193])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTZ91-0002UK-Jp
 for linux-arm-kernel@lists.infradead.org; Sun, 02 Dec 2018 21:19:16 +0000
Received: by mail-qt1-f193.google.com with SMTP id n21so11643005qtl.6
 for <linux-arm-kernel@lists.infradead.org>;
 Sun, 02 Dec 2018 13:19:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:organization:content-transfer-encoding;
 bh=55pQVhEpgT5gvpJTmZIDiBlXiFeCfhLW8JmA+NU3SGU=;
 b=Pz8Srui24rLfTdV9GKS71IATkF3y4w4j1iNtDoXuxz7FIAlrflzSXHstMTCsZyaYjn
 JR0L/rV+bahrz/CjHTfT3Bfy7a7WwjDntOExa8n87YQSPkkwDU4hBOcyc4JxBknF5r0j
 ryEJm/iHiN7enJZA1o4rGhUT5zHhGhoA/UQz9mtWwH13jeS5+zToUcKv55quqCZLhX7u
 sbFn+Tz3us0JGR/6EPpOrc49tH2gWXf52oMkRRBiEZpfZ/y6ZjzWBkd/RMvr6+UZu9AW
 eZOSLIDzM/eomdftW+wQ0F2gX8jaKOqqMiTiFZvZCeXewJ5kHuSnw0X6N0o910QNmRnO
 CYxw==
X-Gm-Message-State: AA+aEWYo2gdXCLWAO6ElYVGCW788jP7zBQvw3/7DPzR2mOmmY2lhJgT4
 EIvKDMQZHUGfkmn4j7r44XXBLgyD
X-Google-Smtp-Source: AFSGD/XT1vTeuR6YazMkcoMhEgarJmuWBWvnHJgqR0WTVfXsX7ASEPbCsVPTkKa3bJIA/14/icUxjg==
X-Received: by 2002:aed:34e6:: with SMTP id x93mr13622285qtd.156.1543785538864; 
 Sun, 02 Dec 2018 13:18:58 -0800 (PST)
Received: from localhost.localdomain ([181.220.65.91])
 by smtp.gmail.com with ESMTPSA id l12sm5524343qkk.40.2018.12.02.13.18.53
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 02 Dec 2018 13:18:57 -0800 (PST)
Received: by localhost.localdomain (sSMTP sendmail emulation);
 Sun, 02 Dec 2018 19:18:51 -0200
From: Otavio Salvador <otavio@ossystems.com.br>
To: linux-arm-kernel@lists.infradead.org
Subject: [PATCH 5/5] ARM: dts: imx6ul-pico: Add the imx6ul-pico-pi variant
Date: Sun,  2 Dec 2018 19:18:09 -0200
Message-Id: <20181202211809.11621-6-otavio@ossystems.com.br>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181202211809.11621-1-otavio@ossystems.com.br>
References: <20181202211809.11621-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Organization: O.S. Systems Software LTDA.
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181202_161915_668984_9C7848C6 
X-CRM114-Status: GOOD (  17.82  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Otavio Salvador <otavio@ossystems.com.br>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, NXP Linux Team <linux-imx@nxp.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <fabio.estevam@nxp.com>, Fabio Estevam <festevam@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Fabio Estevam <festevam@gmail.com>

The imx6ul-pico-pi contains a imx6ul-pico SoM and a pi baseboard:
https://www.technexion.com/products/pico-baseboards/detail/PICO-PI

Add support for it.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
---

 arch/arm/boot/dts/Makefile           |  1 +
 arch/arm/boot/dts/imx6ul-pico-pi.dts | 97 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/imx6ul-pico.dtsi   | 32 ---------
 3 files changed, 98 insertions(+), 32 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6ul-pico-pi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 12a3cfb7d280..f26591295497 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -557,6 +557,7 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-liteboard.dtb \
 	imx6ul-opos6uldev.dtb \
 	imx6ul-pico-hobbit.dtb \
+	imx6ul-pico-pi.dtb \
 	imx6ul-tx6ul-0010.dtb \
 	imx6ul-tx6ul-0011.dtb \
 	imx6ul-tx6ul-mainboard.dtb \
diff --git a/arch/arm/boot/dts/imx6ul-pico-pi.dts b/arch/arm/boot/dts/imx6ul-pico-pi.dts
new file mode 100644
index 000000000000..de07357b27fc
--- /dev/null
+++ b/arch/arm/boot/dts/imx6ul-pico-pi.dts
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+//
+// Copyright 2015 Technexion Ltd.
+//
+// Author: Wig Cheng  <wig.cheng@technexion.com>
+//	   Richard Hu <richard.hu@technexion.com>
+//	   Tapani Utriainen <tapani@technexion.com>
+/dts-v1/;
+
+#include "imx6ul-pico.dtsi"
+/ {
+	model = "TechNexion PICO-IMX6UL and PI baseboard";
+	compatible = "technexion,imx6ul-pico-pi", "fsl,imx6ul";
+
+	leds {
+		compatible = "gpio-leds";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_gpio_leds>;
+
+		led {
+			label = "gpio-led";
+			gpios = <&gpio4 20 GPIO_ACTIVE_HIGH>;
+		};
+	};
+
+	sound {
+		compatible = "fsl,imx-audio-sgtl5000";
+		model = "imx6ul-sgtl5000";
+		audio-cpu = <&sai1>;
+		audio-codec = <&sgtl5000>;
+		audio-routing =
+			"LINE_IN", "Line In Jack",
+			"MIC_IN", "Mic Jack",
+			"Mic Jack", "Mic Bias",
+			"Headphone Jack", "HP_OUT";
+	};
+
+	sys_mclk: clock-sys-mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <24576000>;
+	};
+};
+
+&i2c2 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c2>;
+	status = "okay";
+
+	sgtl5000: codec@a {
+		reg = <0x0a>;
+		compatible = "fsl,sgtl5000";
+		clocks = <&sys_mclk>;
+		VDDA-supply = <&reg_2p5v>;
+		VDDIO-supply = <&reg_3p3v>;
+	};
+};
+
+&i2c3 {
+	clock_frequency = <100000>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_i2c3>;
+	status = "okay";
+
+	polytouch: touchscreen@38 {
+		compatible = "edt,edt-ft5x06";
+		reg = <0x38>;
+		interrupt-parent = <&gpio1>;
+		interrupts = <29 IRQ_TYPE_EDGE_FALLING>;
+		reset-gpios = <&gpio4 24 GPIO_ACTIVE_LOW>;
+		touchscreen-size-x = <800>;
+		touchscreen-size-y = <480>;
+	};
+};
+
+&iomuxc {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_hog>;
+
+	pinctrl_hog: hoggrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_VSYNC__GPIO4_IO19		0x10b0
+			MX6UL_PAD_CSI_DATA00__GPIO4_IO21	0x10b0
+			MX6UL_PAD_CSI_DATA01__GPIO4_IO22	0x10b0
+			MX6UL_PAD_CSI_DATA02__GPIO4_IO23	0x10b0
+			MX6UL_PAD_UART1_CTS_B__GPIO1_IO18	0x10b0
+			MX6UL_PAD_SNVS_TAMPER2__GPIO5_IO02	0x10b0
+		>;
+	};
+
+	pinctrl_gpio_leds: gpioledsgrp {
+		fsl,pins = <
+			MX6UL_PAD_CSI_HSYNC__GPIO4_IO20		0x10b0
+		>;
+	};
+};
diff --git a/arch/arm/boot/dts/imx6ul-pico.dtsi b/arch/arm/boot/dts/imx6ul-pico.dtsi
index 89269955440b..de9f83189ba8 100644
--- a/arch/arm/boot/dts/imx6ul-pico.dtsi
+++ b/arch/arm/boot/dts/imx6ul-pico.dtsi
@@ -72,24 +72,6 @@
 		regulator-max-microvolt = <3300000>;
 		startup-delay-us = <200000>;
 	};
-
-	sound {
-		compatible = "fsl,imx-audio-sgtl5000";
-		model = "imx6ul-sgtl5000";
-		audio-cpu = <&sai1>;
-		audio-codec = <&codec>;
-		audio-routing =
-			"LINE_IN", "Line In Jack",
-			"MIC_IN", "Mic Jack",
-			"Mic Jack", "Mic Bias",
-			"Headphone Jack", "HP_OUT";
-	};
-
-	sys_mclk: clock-sys-mclk {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <24576000>;
-	};
 };
 
 &can1 {
@@ -169,20 +151,6 @@
 	};
 };
 
-&i2c2 {
-	clock_frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c2>;
-	status = "okay";
-};
-
-&i2c3 {
-	clock_frequency = <100000>;
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_i2c3>;
-	status = "okay";
-};
-
 &lcdif {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_lcdif_dat &pinctrl_lcdif_ctrl>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
