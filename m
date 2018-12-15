Return-Path: <SRS0=YQjL=OY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C78BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:03:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21FB12086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 03:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lwCR2PH1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="hOMvtWf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21FB12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=mM1bI1IkvyfRH5vhjb62k5H6+tGRWF2fYsE6BMLnOF8=; b=lwCR2PH16E5c53kuW1Mx5Y+Xwn
	0iv5k/AdlChrEYPbLFrtX6319iBymLh/cf4uyKO2wSwqltXYIwuFxCzzja67PIBVQYetWJ9JeGk3B
	7JrGt4xtjjkuwPzDyn2WyslfslrnYq1aEmNuzhjesPpPbTeTs9rcGcfi6jjdfCOUl1FycsAa6QhRU
	4RBLPqBKiM84Up3QOM7WHjhs9LedyHeazgfrb05StGMTdr2MD0syPK+mehhrJq1FlseCrj3HErfcc
	H4/6c96JY5sRR3ONO2/d0u63CG1Frz67KMcu7+FzYHS9ayMTwhiMqsKLz/ARKHOWEF6LT/Ie5pmci
	qh+aqX0w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gY0EF-0002Ow-AF; Sat, 15 Dec 2018 03:02:59 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gY0Dv-0001yW-7l
 for linux-arm-kernel@lists.infradead.org; Sat, 15 Dec 2018 03:02:42 +0000
Received: by mail-pf1-x441.google.com with SMTP id q1so3697815pfi.5
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 14 Dec 2018 19:02:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=1fNJLUvL39cWBNfpOmnxroSKUC/RnHz0oy8A/ibN2iA=;
 b=hOMvtWf/WTmzGChczsMxD9Tel3C3DE6XJwxivQdJu64SXdwKEZeKyt8j2YXpOLC+Cb
 vSIXBhKmmLSqZwf+dN0tcGfg1iZzs6Lz+f2iLCJ0f+4QLscjVv1oQq4J+ucTuMDZRj6n
 wTLKGPCKCzCRxdE4Ab1TcKKrjLuYlXfr1FZi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=1fNJLUvL39cWBNfpOmnxroSKUC/RnHz0oy8A/ibN2iA=;
 b=DHhBNfzeZsMlsMhTtu4hlTHAsZDzvKnz9O8SUtIBKzDMMdzyJHQ581RBN6ZeBcWq7H
 O3HZ5gXd6PKLBCQD64SoqkFKEVi8SgIAH68HOIvkLXxp+cXEkA24qtnyAaBLXouoSpaP
 gHnyDNxZ/PtL+/w6Qss+3m8wIN6Ya8sbyw1tzvpjjV0uKIQWVsU6MCxl3xorB/k9p4vU
 VO9MiT69tH+O9aqEBwuuaVqHaPVSC+A0HAt8hBbKGinU5xVU0k5wJKNDECS4rR4m6PBm
 618IstQIfzb+87OcNSAV2fgb1ymYRIPQ9TJZpUvoIa27T51EekzNl/tP9wGMCsoP33Sn
 IFWA==
X-Gm-Message-State: AA+aEWZL6vCZTRLN+mHeugOXTDqOsqGU+5DZbe0SOHJGyZNVvBlQ4Dq8
 +BDOn0QmNtCqGQWCnFINQ0p4
X-Google-Smtp-Source: AFSGD/VUUHjw8mJCSB35OM4jKcGCkNNXemYu5pjLNqMTyYB+ZEXd0J8XGBZopDzoR6Tpnceuqbi4tw==
X-Received: by 2002:a62:56c7:: with SMTP id h68mr5435897pfj.134.1544842948269; 
 Fri, 14 Dec 2018 19:02:28 -0800 (PST)
Received: from localhost.localdomain
 ([2409:4072:6301:5419:f1e8:77a0:59f7:2cb5])
 by smtp.gmail.com with ESMTPSA id h15sm7309534pgl.43.2018.12.14.19.02.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 14 Dec 2018 19:02:27 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: dinguyen@kernel.org,
	robh+dt@kernel.org
Subject: [PATCH 2/2] ARM: dts: Add support for 96Boards Chameleon96 board
Date: Sat, 15 Dec 2018 08:31:52 +0530
Message-Id: <20181215030152.4386-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
References: <20181215030152.4386-1-manivannan.sadhasivam@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_190239_824816_58FF5C15 
X-CRM114-Status: GOOD (  16.97  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 amit.kucheria@linaro.org, nazik@novtech.com, yossi@novtech.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add devicetree support for 96Boards Chameleon96 board from Novtech, Inc.
based on Altera CycloneV SoC FPGA. This board is one of the Consumer
Edition boards of the 96Boards family and has the following key features:

* SoC - Intel Cyclone V SoC FPGA
* GPU - Graphics based on Intel Video Suite for FPGA
* RAM - 512MB DDR3L
* USB - 2x USB2.0 Host, 1x USB2.0 OTG
* Wireless - Wifi, BT

More information about this board can be found in 96Boards product
page: https://www.96boards.org/product/chameleon96/

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../boot/dts/socfpga_cyclone5_chameleon96.dts | 130 ++++++++++++++++++
 2 files changed, 131 insertions(+)
 create mode 100644 arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index b0e966d625b9..d6cf081ec325 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -897,6 +897,7 @@ dtb-$(CONFIG_ARCH_SOCFPGA) += \
 	socfpga_arria10_socdk_nand.dtb \
 	socfpga_arria10_socdk_qspi.dtb \
 	socfpga_arria10_socdk_sdmmc.dtb \
+	socfpga_cyclone5_chameleon96.dtb \
 	socfpga_cyclone5_mcvevk.dtb \
 	socfpga_cyclone5_socdk.dtb \
 	socfpga_cyclone5_de0_nano_soc.dtb \
diff --git a/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts b/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
new file mode 100644
index 000000000000..f6561766d83f
--- /dev/null
+++ b/arch/arm/boot/dts/socfpga_cyclone5_chameleon96.dts
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: (GPL-2.0 OR MIT)
+/*
+ * Device Tree file for the Chameleon96
+ *
+ * Copyright (c) 2018 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+
+#include "socfpga_cyclone5.dtsi"
+
+/ {
+	model = "Novetech Chameleon96";
+	compatible = "novtech,chameleon96", "altr,socfpga-cyclone5", "altr,socfpga";
+
+	chosen {
+		bootargs = "earlyprintk";
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		name = "memory";
+		device_type = "memory";
+		reg = <0x0 0x20000000>; /* 512MB */
+	};
+
+	regulator_3_3v: 3-3-v-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "3.3V";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+
+		user_led1 {
+			label = "green:user1";
+			gpios = <&porta 14 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "heartbeat";
+		};
+
+		user_led2 {
+			label = "green:user2";
+			gpios = <&porta 22 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "mmc0";
+		};
+
+		user_led3 {
+			label = "green:user3";
+			gpios = <&porta 25 GPIO_ACTIVE_LOW>;
+			linux,default-trigger = "none";
+		};
+
+		user_led4 {
+			label = "green:user4";
+			gpios = <&portb 3 GPIO_ACTIVE_LOW>;
+			panic-indicator;
+			linux,default-trigger = "none";
+		};
+	};
+};
+
+&gpio0 {
+	status = "okay";
+};
+
+&gpio1 {
+	status = "okay";
+};
+
+&i2c0 {
+	/* On Low speed expansion */
+	label = "LS-I2C0";
+	status = "okay";
+};
+
+&i2c1 {
+	/* On Low speed expansion */
+	label = "LS-I2C1";
+	status = "okay";
+};
+
+&i2c2 {
+	status = "okay";
+};
+
+&i2c3 {
+	/* On High speed expansion */
+	label = "HS-I2C2";
+	status = "okay";
+};
+
+&mmc0 {
+	vmmc-supply = <&regulator_3_3v>;
+	vqmmc-supply = <&regulator_3_3v>;
+	status = "okay";
+};
+
+&spi0 {
+	/* On High speed expansion */
+	label = "HS-SPI1";
+	status = "okay";
+};
+
+&spi1 {
+	/* On Low speed expansion */
+	label = "LS-SPI0";
+	status = "okay";
+};
+
+&uart0 {
+	/* On Low speed expansion */
+	label = "LS-UART1";
+	status = "okay";
+};
+
+&uart1 {
+	/* On Low speed expansion */
+	label = "LS-UART0";
+	status = "okay";
+};
+
+&usbphy0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
