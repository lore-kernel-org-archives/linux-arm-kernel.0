Return-Path: <SRS0=vAN3=QB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 321B9C282C0
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:15:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EECD320811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 17:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F2i5Sc+x";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="Z09ok8WN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EECD320811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sartura.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=M3ogjepGaBZYfjdkRKDzXN5TgntnlPxdibKmXUZMorY=; b=F2i5Sc+xw1kbED
	NSdIlFlm0L6uSyq1zdB/wAJX8zVzVgp87MzM0I3tXwiJTpxV2T9YECWqPn+Sge+LssMM1MA93XHOt
	c6Xb0f01UcDiA5F/q2BPIPxGNXA7LFCpjyZblPFS2eK0gOw4g3a43+zAvqmqx7DHXr7BjsCjCay2o
	HNREtXIAJCX5ifFJxfTPW4XPlF69iNArzEi2GnmyyEpSdrXSIGuP0LnfvLAASStlAQnCxVzBXSej1
	2fOP0t16969dnrN7/IKtD9HGwJLo8wBKGv4p3gej2RDwp1liyn/apfnbqXqpae2Zid4zWsYGV1ewB
	2m0RRam28wWvCtnC9H7A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gn54f-0006QG-Na; Fri, 25 Jan 2019 17:15:25 +0000
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gn54b-0006Pp-PO
 for linux-arm-kernel@lists.infradead.org; Fri, 25 Jan 2019 17:15:23 +0000
Received: by mail-wm1-x344.google.com with SMTP id g67so7333959wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 25 Jan 2019 09:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura-hr.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+e9pluMdE1ABNbBgyJ0RNl4dBO2t8PcsYv8wVKZxmko=;
 b=Z09ok8WNKMOBjCHaM5T9BOMMt4X2v9GnvQkZhI4Toh4blBUhjDis6evPyJ1886LXK0
 IRfygpZawChu+VvbxXfSYeelmaW+zCidap3k46QCf2sXn5qkgcE/lJ0Eb10gMM4rYGKO
 1lk0rk9g0BqF3hGc9B+S4ddflrC2SmMvzo9ffALGU2l2CwUyYkQkrEs7JLM1zFOnVF2k
 3m135Q8l8JhKiS60VQbwtQcwiUyDJOCE/tGWVitc1JyoPhBX55QNp7vqWgdpJfGD7Zik
 GY94a1N9/5ggTRvN4FL/HpAd3XvRSEnrcvzlujQmOjsKs7mOt8lA2MziEiu5GGBi6NAb
 k44g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+e9pluMdE1ABNbBgyJ0RNl4dBO2t8PcsYv8wVKZxmko=;
 b=eWihqAAUTwvvpAEGTH3z0qQ6Jzek0bBH2IlsFJbfwQtAy4UfdQdICdjhyK8M8/rW16
 zX+U7o3N4f2MDUI4VnzrzJ7D1yucUgqm7iSSrVKDPd7RomStdK721YsOtxuAKpykMRuf
 gG/oYjrH4DIj5B9QKZM+JYskEvcNDBPBKlSv0+9ZcfMAJEGbJQMgWYsUx5EAA8J6FIah
 PNafyC2hE8u4KdCDpWNyDbtLqcsP49cNRyf70JV6oOOokmoEWuCtQaG/i2SN1DHRh6/M
 ebxNORDIhbBbVFbGZSonN4jj61UT3uDG2IOq+O7/YKZWQL7VkfYg7DWz78CwiiEUJWj9
 0h0w==
X-Gm-Message-State: AJcUukc5CpYaEEb5xq0q60JcJZBtqvI6IZpc6ZftSE1ZOuqud3Unm+kA
 fzWUg5JDirUhyZNO9UU5vRt+
X-Google-Smtp-Source: ALg8bN5pIU1zwDwxZKcd172/d9Sq77cQUDZGuJcnsQcu1XSkBRpRUbOJy3PuZqgfg/XOkFK7nQxAPg==
X-Received: by 2002:a1c:c58d:: with SMTP id v135mr7881595wmf.88.1548436519443; 
 Fri, 25 Jan 2019 09:15:19 -0800 (PST)
Received: from b50.local (cpe-94-253-225-226.st.cable.xnet.hr.
 [94.253.225.226])
 by smtp.gmail.com with ESMTPSA id y14sm7738603wro.92.2019.01.25.09.15.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 25 Jan 2019 09:15:18 -0800 (PST)
From: Vladimir Vid <vladimir.vid@sartura.hr>
To: devicetree@vger.kernel.org
Subject: [PATCH v6] arm64: dts: marvell: Add device tree for uDPU board
Date: Fri, 25 Jan 2019 18:17:08 +0100
Message-Id: <20190125171707.27742-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190125_091521_876951_AC9F87F6 
X-CRM114-Status: GOOD (  15.93  )
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

v6 changes:
- updated LED labels per naming convention (Documentation/leds/leds-class.txt)

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
index 000000000000..2441481643a4
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
+			label = "udpu:green:power";
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+		};
+
+		power2 {
+			label = "udpu:red:power";
+			gpios = <&gpionb 12 GPIO_ACTIVE_LOW>;
+		};
+
+		network1 {
+			label = "udpu:green:network";
+			gpios = <&gpionb 13 GPIO_ACTIVE_LOW>;
+		};
+
+		network2 {
+			label = "udpu:red:network";
+			gpios = <&gpionb 14 GPIO_ACTIVE_LOW>;
+		};
+
+		alarm1 {
+			label = "udpu:green:alarm";
+			gpios = <&gpionb 15 GPIO_ACTIVE_LOW>;
+		};
+
+		alarm2 {
+			label = "udpu:red:alarm";
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
