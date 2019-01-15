Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22823C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:10:35 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E640520657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 12:10:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="MA2LOaVi";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="0wrnSI/+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E640520657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sartura.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gVmiMen39uDguecVOPrKlDU5yxCF6P7PkroZt1n7Iw8=; b=MA2LOaVi1xAvqe
	ZcWA0+YlDTUb7MYqP7LrvZzHEHGwXTh25ggmAPTBMyILqGQ68FzgdIrrfHMsaDeqAWMVX59wGRF6C
	6rATVV0/b/jt0Am76YWhWH0h7Rh/r2fWL79SR3C9kp71Nv4oO5In1ClVN19ikXc/J76CsKcXNvBkS
	q5UXl01ZKImB3pXwVK3S7/BMqsJpdONd1AEOwwRMUndjO1t/Z9LWoxAbxGJ77peaZOsiVXCed17aE
	yC95Pm+/oCRQYpDUX3Ljt/pIPmQ5bWrz8oEvXuK0fpyqTzfrq5O0BJjr8ARHDHvIuvFN32j7U20jv
	ggZA00V1BDxg/gTAKAhA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjNY6-0007If-JY; Tue, 15 Jan 2019 12:10:30 +0000
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjNY2-0007I0-3n
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 12:10:28 +0000
Received: by mail-wr1-x442.google.com with SMTP id x10so2659041wrs.8
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 04:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura-hr.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=zh1WxAuYeQTnY3KInOlRNLJ87yNVAdkCrMEFWj4uDm8=;
 b=0wrnSI/+yva3lZDEOwBVrtgVoIN46xazmgvQm49gi9penaLtTjJJrLmEevurfADkqb
 benvGbLEuxbV2phzPE0hPQL0WFitpntlXfpORglK0SdfGEa+ZQQAB4W2T3tO4OJaBQ3W
 35rmqltMx4f1IDPpP84yPWk2QI4vZ2hFqFaak+1NGjmerAReC5fSjZ8Onjmktpf4rz+c
 3slXFC8bodYOKAx63NSGKo47S3xV9KibT0GVbA2Y0/adztRfdO2DMD+xqoty+pFjMgXA
 HmNQftmDPg6j1W2bbmvg00iyxs5ILG1MKE5ILasN2RmHI1TMk3FxPOy1aVhb1cphU3tJ
 xIsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zh1WxAuYeQTnY3KInOlRNLJ87yNVAdkCrMEFWj4uDm8=;
 b=DO5fYO30JVOPL/AH862N2gQicvmbUhFHStc+owPXJ/7z2WgKvNS4eeHEDXQizQ/xKQ
 AEp0ALkIiESV6fdhB0E2EfBQ4vFZGgBvGCR1nBdxHdpaA/6NH/68SU9zWWUaMSqzK8BL
 h8cUgb+WELUFiYcMZUGrKL9+LxF0MkCGTc2zXe+UnbttJbOKidF3/l9muLah0uoQYruT
 /YFmlToR1L6Ly32lgHO7MB0OEjWmJICCzPr1A84pE/5fvE8bwJAao4cS2p6tgKmSiRJB
 6BwCBAyDCezYf8OBdqmh3LGhfkRpZ9caRY1gSv8kKODhrA0NIj4IAO2JFhV1zj8wwvfZ
 jk1w==
X-Gm-Message-State: AJcUukfosSHT757DGieoPx6fdfzWPSfy1hJuD67FdL7npqPvqhwsxTrG
 xAb9bQGq3eYXMLbBY6Bb1c2y
X-Google-Smtp-Source: ALg8bN5hZNxWCc3hwrxKdHpJnWcD3HwolycDn668FEHmPl8X/LhwN1AA6SoNnwmBZkIqVYZC9zKDJQ==
X-Received: by 2002:adf:e983:: with SMTP id h3mr2793886wrm.232.1547554220261; 
 Tue, 15 Jan 2019 04:10:20 -0800 (PST)
Received: from b50.local (cpe-94-253-227-73.st.cable.xnet.hr. [94.253.227.73])
 by smtp.gmail.com with ESMTPSA id
 v4sm28515177wme.6.2019.01.15.04.10.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 04:10:19 -0800 (PST)
From: Vladimir Vid <vladimir.vid@sartura.hr>
To: devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: marvell: Add device tree for uDPU board
Date: Tue, 15 Jan 2019 13:11:13 +0100
Message-Id: <20190115121113.5636-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190111172055.30451-1-vladimir.vid@sartura.hr>
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_041026_206772_6ABCE653 
X-CRM114-Status: GOOD (  18.52  )
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
Cc: Andrew Lunn <andrew@lunn.ch>, Luis Torres <luis.torres@methode.com>,
 Paul Arola <paul.arola@telus.com>, Vladimir Vid <vladimir.vid@sartura.hr>,
 Scott Roberts <scott.roberts@telus.com>, Luka Perkov <luka.perkov@sartura.hr>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds initial support for micro-DPU (uDPU) board which is based on
Armada-3720 SoC.  micro-DPU is the single-port FTTdp distribution point
unit made by Methode Electronics which offers complete modularity with
replaceable SFP modules both for uplink and downlink (G.hn over
twisted-pair, G.hn over coax, 1G and 2.5G Ethernet over Cat-5e cable).

On-board features:
- 512 MiB DDR3
- 2 x 2.5G SFP via HSGMII SERDES interface to the A3720 SoC
- USB 2.0 Type-C connector
- 4GB eMMC
- ETSI TS 101548 reverse powering via twisted pair (RJ45) or coax (F Type)

Cc: Luka Perkov <luka.perkov@sartura.hr>
Cc: Luis Torres <luis.torres@methode.com>
Cc: Scott Roberts <scott.roberts@telus.com>
Cc: Paul Arola <paul.arola@telus.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>

Cc: Andrew Lunn <andrew@lunn.ch>
---

v2:
- add compatible string for the uDPU board
- add names and labels for the LEDs
- remove unused mdio node
- remove eeprom nodes

---
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     | 164 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 4d04cebb4a71..4ba06bfc1a1e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9852,6 +9852,11 @@ F:	drivers/media/platform/meson/ao-cec.c
 F:	Documentation/devicetree/bindings/media/meson-ao-cec.txt
 T:	git git://linuxtv.org/media_tree.git
 
+METHODE UDPU SUPPORT
+M:	Vladimir Vid <vladimir.vid@sartura.hr>
+S:	Maintained
+F:	arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+
 MICROBLAZE ARCHITECTURE
 M:	Michal Simek <monstr@monstr.eu>
 W:	http://www.monstr.eu/fdt/
diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 2eff1f927471..caed4334f27d 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -2,6 +2,7 @@
 # Mvebu SoC Family
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-espressobin.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += armada-3720-uDPU.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-7040-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-clearfog-gt-8k.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += armada-8040-db.dtb
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
new file mode 100644
index 000000000000..fbdc6b0afb6f
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device tree for the uDPU board.
+ * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
+ * Copyright (C) 2016 Marvell
+ * Copyright (C) 2018 Methode
+ * Copyright (C) 2018 Telus
+ *
+ * Vladimir Vid <vladimir.vid@sartura.hr>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/gpio/gpio.h>
+#include "armada-372x.dtsi"
+
+/ {
+	model = "Methode uDPU Board";
+	compatible = "marvell,armada-3720-db", "marvell,armada3720",
+		     "marvell,armada3710", "methode,udpu";
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x00000000 0x00000000 0x00000000 0x20000000>;
+	};
+
+	leds {
+		pinctrl-names = "default";
+		compatible = "gpio-leds";
+
+		power@487 {
+			label = "power:green:led1";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		power@488 {
+			label = "power:red:led1";
+			gpios = <&gpionb 12 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		network@489 {
+			label = "network:green:led2";
+			gpios = <&gpionb 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		network@490 {
+			label = "network:red:led2";
+			gpios = <&gpionb 14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		alarm@491 {
+			label = "alarm:green:led3";
+			gpios = <&gpionb 15 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		alarm@492 {
+			label = "alarm:red:led3";
+			gpios = <&gpionb 16 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+	};
+
+	sfp_eth0: sfp-eth0 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c0>;
+		los-gpio = <&gpiosb 2 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&gpiosb 3 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&gpiosb 4 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&gpiosb 5 GPIO_ACTIVE_HIGH>;
+	};
+
+	sfp_eth1: sfp-eth1 {
+		compatible = "sff,sfp";
+		i2c-bus = <&i2c1>;
+		los-gpio = <&gpiosb 7 GPIO_ACTIVE_HIGH>;
+		mod-def0-gpio = <&gpiosb 8 GPIO_ACTIVE_LOW>;
+		tx-disable-gpio = <&gpiosb 9 GPIO_ACTIVE_HIGH>;
+		tx-fault-gpio = <&gpiosb 10 GPIO_ACTIVE_HIGH>;
+	};
+};
+
+&sdhci0 {
+	non-removable;
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,pad-type = "fixed-1-8v";
+	status = "okay";
+};
+
+&sdhci1 {
+	marvell,xenon-phy-type = "emmc 5.0 phy";
+	cd-gpios = <&gpiosb 2 GPIO_ACTIVE_LOW>;
+	bus-width = <4>;
+	marvell,pad-type = "fixed-1-8v";
+	status = "okay";
+	non-removable;
+	no-sd;
+	no-sdio;
+};
+
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&spi_quad_pins>;
+
+	m25p80@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <54000000>;
+
+		/* bootloader is located on the SPI */
+		partition@0 {
+			label = "uboot";
+			reg = <0 0x400000>;
+		};
+	};
+};
+
+&usb3 {
+	status = "okay";
+	usb-phy = <&usb3_phy>;
+};
+
+&i2c0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins>;
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+};
+
+&eth0 {
+	phy-mode = "sgmii";
+	status = "okay";
+	managed = "in-band-status";
+	sfp = <&sfp_eth0>;
+};
+
+&eth1 {
+	phy-mode = "sgmii";
+	status = "okay";
+	managed = "in-band-status";
+	sfp = <&sfp_eth1>;
+};
+
+&uart0 {
+	status = "okay";
+};
-- 
2.19.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
