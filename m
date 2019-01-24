Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A5FC282C5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:35:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C25FB2184C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 16:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iEwBtqjH";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="rYQkttLa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C25FB2184C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sartura.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=mg8ETOX0vP+sgXkqQnegO+y+CllCD+p0LNgV6Iu28S8=; b=iEwBtqjHZ1cujj
	AJbwSawMk3GZxbot6oiInMivj33g9bwF+XuNI9m1h6GyUnznVzXgrH5toNRfwHZXFtoYQQ+XZcYXr
	xmEiE6fpdSpUjSIw9b1FiPxztp7h/x5cGPdBaBEdROMXJY6M+wM9e10ybnUSPL99XHn0VBY5doDjk
	16+fJX4BB5hSz9fByi3gSzpEGlWgdP0w/S4OreVOzb3PG7fJOocjpny78KWOqIDhrtUpv5vB17Wys
	QJRga9EmClG5n/NUwWsmV6sBV5gRlpbgupLmj+XweFVFKYrZPUt8+WRe+IyBJ6qxHTx2zNXa3uEyk
	TC0oq5OBfW/99rlkT7jA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmhyY-0000MW-KZ; Thu, 24 Jan 2019 16:35:34 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmhyU-0000Lr-PM
 for linux-arm-kernel@lists.infradead.org; Thu, 24 Jan 2019 16:35:33 +0000
Received: by mail-wm1-x344.google.com with SMTP id b11so3863008wmj.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 24 Jan 2019 08:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura-hr.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xOLgmWv1CixzRG0gAahd+OV4nK+ui3rkUsLQLlamsjw=;
 b=rYQkttLa0VZU1jz2xytITMsZQc1ZC8kxNJ7F57G3iZ4MPlysUiDN48CQscygH7aZ4r
 HinH9jIRNDE1OznTDSQKUI/ZkzYg2toDz8Vf+uF668wIzrGbHxDankLJBYzGugOBIveY
 aFh9rcibB3y/BK58L4QOeFFRcRmduJLvNHrM4D4zthzqBMJoKRXuhfiRlfA40oJz9ti/
 59zh4uRxhRbx6261VoWOu6CKggw6uU6uR/lxCY7yCJFRZetClAZezbyku+JVyqrRAwSC
 yaNLA6mbWO1V3hgvW2aUKVjXo9Cp0QOG/XX99iDaqxDPjDs4I07BMWw4w78EqIScChve
 N7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=xOLgmWv1CixzRG0gAahd+OV4nK+ui3rkUsLQLlamsjw=;
 b=TJ858G5T9HwlcXBnEppfK7YrlrQ7kWHt1G3d4RXnF8oM0FuSQGBUFO08E+zGvFFdkX
 XpbwTAj6vdGvAMihGh7aYT2Mo8kcENR9biL3cbWoiKXMPjWORK6YmDwxg38l3caoxJFK
 DBJ2pCgVwy6iGhuxFX5uUc21QebYr7H5mkD+G7nvj6jpC8FpphfqBx869QA61kOKxD6u
 oPWe594rYt3w4bdEZiMWKFkJwGZS+O/oLHLR2fMyJIjzS0CFnqJjLlrTy2dbkTVJ59nz
 awq4pzAAqrTHX7dx3e5JDbJSQsRnfw1aZyCXBjygyBxpSZEEcrzEwAN0hg6BaOGOneTO
 c01g==
X-Gm-Message-State: AJcUukfw+5nxLwziLYl/0ZDny/lstDXGEvV1j8Kxy/7jGSnJJ3DzKpJ2
 OlXZy9LwEfF68mrgzCd9DfUl
X-Google-Smtp-Source: ALg8bN5U6PscYbhqklRBxcYW4mqtQjbIcEVShrRmuGWDR6To/Ry8g/u4R0g9Y+o1vuJiIQ/7mLqdtg==
X-Received: by 2002:a7b:c1d7:: with SMTP id a23mr3222619wmj.48.1548347728481; 
 Thu, 24 Jan 2019 08:35:28 -0800 (PST)
Received: from b50.local (cpe-94-253-225-226.st.cable.xnet.hr.
 [94.253.225.226])
 by smtp.gmail.com with ESMTPSA id g9sm59706415wmg.44.2019.01.24.08.35.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 24 Jan 2019 08:35:27 -0800 (PST)
From: Vladimir Vid <vladimir.vid@sartura.hr>
To: devicetree@vger.kernel.org
Subject: [PATCH v5] arm64: dts: marvell: Add device tree for uDPU board
Date: Thu, 24 Jan 2019 17:32:26 +0100
Message-Id: <20190124163225.10863-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190124_083530_882884_2F8F79E9 
X-CRM114-Status: GOOD (  17.23  )
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
 Jason Cooper <jason@lakedaemon.net>, Paul Arola <paul.arola@telus.com>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Vladimir Vid <vladimir.vid@sartura.hr>,
 Scott Roberts <scott.roberts@telus.com>, Luka Perkov <luka.perkov@sartura.hr>,
 linux-arm-kernel@lists.infradead.org,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Gregory Clement <gregory.clement@bootlin.com>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Vladimir Vid <vladimir.vid@sartura.hr>
---

v5:
- set all LEDs off by default, these should be handled from the userspace
- added 2 temperature sensors (NCT375) on 'i2c1' node
- removed unused 'sdhci1' node as only eMMC is available on 'sdhci0'
- added 'usb3' node - USB 2.0 type-C is connected on USB3 interface on SoC

---
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     | 164 ++++++++++++++++++
 3 files changed, 170 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 51029a425dbe..21174a13049b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9851,6 +9851,11 @@ F:	drivers/media/platform/meson/ao-cec.c
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
index 000000000000..048a3770ce09
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device tree for the uDPU board.
+ * Based on Marvell Armada 3720 development board (DB-88F3720-DDR3)
+ * Copyright (C) 2016 Marvell
+ * Copyright (C) 2019 Methode Electronics
+ * Copyright (C) 2019 Telus
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
+	compatible = "methode,udpu", "marvell,armada3720";
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
+		power1 {
+			label = "power:green:led1";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+		};
+
+		power2 {
+			label = "power:red:led1";
+			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
+		};
+
+		network1 {
+			label = "network:green:led2";
+			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
+		};
+
+		network2 {
+			label = "network:red:led2";
+			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
+		};
+
+		alarm1 {
+			label = "alarm:green:led3";
+			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
+		};
+
+		alarm2 {
+			label = "alarm:red:led3";
+			gpios = <&gpionb 16 GPIO_ACTIVE_LOW>;
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
+	status = "okay";
+	bus-width = <8>;
+	mmc-ddr-1_8v;
+	mmc-hs400-1_8v;
+	marvell,pad-type = "fixed-1-8v";
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
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			/* only bootloader is located on the SPI */
+			partition@0 {
+				label = "uboot";
+				reg = <0 0x400000>;
+			};
+		};
+	};
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
+
+	lm75@48 {
+		status = "okay";
+		compatible = "lm75";
+		reg = <0x48>;
+	};
+
+	lm75@49 {
+		status = "okay";
+		compatible = "lm75";
+		reg = <0x49>;
+	};
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
+&usb3 {
+	status = "okay";
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
