Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA663C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:17:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FEBB20872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UsumRZBs";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="v+yfP4Hx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FEBB20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sartura.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=i303mnp/lmR2K0YtYTorDy4tgfah0J/+iTJco8Xpa8k=; b=UsumRZBsdIghOj
	ELCjSI+Hk/ztsKW30rVhwzX4yCBhKqQzgnGcihHbfq/os6L89u2o8Z6UPUNWAtjcgCT0gvrQl5v49
	lPp69ksovScWLCpTaIPy8zVQaX1N/gApa3tPHIGImTiaIM6XsNXOV2uJygB8Ct0zCS8qggP+V1DPb
	ugxgBwWRxC5eOKfKGJQ/57vGUFRA7UO+KzE6T6uf91LuRJXfVnv8P57UWJwPSLrpQJeoEYacs0bJC
	iMNrtnfLYp1v743kiH5leXWVy30REIQVdDFykkyjjVIp0pBfhv8TQoZib6MYLZKvkMHp/fjOEWRzm
	oghZ2imGUtPHsr1pp+SQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0QX-00075K-Jg; Fri, 11 Jan 2019 17:17:01 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0QS-00074p-M3
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:16:58 +0000
Received: by mail-wr1-x441.google.com with SMTP id 96so16023005wrb.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura-hr.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q/I0W5TyEz1/1WQCEHGSIAKtHtF6Xco/pjyMU/mwY0g=;
 b=v+yfP4Hx8z8s6N0+xQ7ImYoeGzGF/E38IuVcIs4xohEGD2YX7gC5toIguzWyja+odD
 poBSfIWWU+3B1wYZwx7Xq8QPTtrp+wcJJewIazh1Ncwigw5m3F/8duOw7+m3yfO01EXf
 kU6OYTq48IINJnPiopxK+q0PyI1FNN8CYbflBEMEi6BO/vpeS8aQeUoEK+BpwMsIJaY9
 XCqFZEa44NfBV9Dy0qeFFSr/jwPI2eZD37dflqEhAzRIL1ZMg0upI8xz+b0v5LmhwpIs
 2OvdLcfoy7fCeBk3p9QVtG6F1Hc2tmqEZbGQK+6PPHKKu2RfUl2aFgspFrLI2NXWdnVz
 mhmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Q/I0W5TyEz1/1WQCEHGSIAKtHtF6Xco/pjyMU/mwY0g=;
 b=VSwdPV+xCp/iDhb6PY2Z+FkDaJYObuqusOnefoj3mh8d1r3yTjokqVtkV7nj5RWXmO
 MJGnTCWIvO3PseAz801EAPsVVuIsvp7XdnbPX7PX4SgQLPBtxpxxb1RUtcVcAgC1gZys
 2pnepYNVcSLJ8ShPHxGxqt+y9Dr/lUfd+bhFml4RB5XZKo7BNqKS42dydhCcutpwK6MX
 /8ux/bjsivvTDeCkmu+tFmCWlFVbcTEWAMa1Bg5POnNAvdpsJ92rEWgAXKkA7GLswpEJ
 hShgolt5SvnvzDSjnhaHbShiE2j5wL7TF/ILT/39VzSVOF9TagUr7Ds2dfttJOFYvO6W
 8gyg==
X-Gm-Message-State: AJcUukc+3/UrFe5xBBsWUCgMSqaP1sv7Y9F2uRd8Jcic/h0sPngrQ1Ff
 bngrutfKQxDPd26oBeBnZ1el
X-Google-Smtp-Source: ALg8bN4OZTRvUE1fVVBwh6lN5wmArsWXxHfFWZPlkCVRe/k1YfbuxNOoe6xNhQnqulWb8cdPbQ+PVA==
X-Received: by 2002:adf:be8b:: with SMTP id i11mr15057180wrh.235.1547227013103; 
 Fri, 11 Jan 2019 09:16:53 -0800 (PST)
Received: from b50.local (cpe-94-253-226-11.st.cable.xnet.hr. [94.253.226.11])
 by smtp.gmail.com with ESMTPSA id
 g188sm20267940wmf.32.2019.01.11.09.16.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:16:52 -0800 (PST)
From: Vladimir Vid <vladimir.vid@sartura.hr>
To: devicetree@vger.kernel.org
Subject: [PATCH] arm64: dts: marvell: Add device tree for uDPU board
Date: Fri, 11 Jan 2019 18:20:55 +0100
Message-Id: <20190111172055.30451-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.19.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_091656_771936_D5FA0E16 
X-CRM114-Status: GOOD (  16.57  )
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
Cc: Luis Torres <luis.torres@methode.com>, Paul Arola <paul.arola@telus.com>,
 Vladimir Vid <vladimir.vid@sartura.hr>,
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
---
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     | 178 ++++++++++++++++++
 3 files changed, 184 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts

diff --git a/MAINTAINERS b/MAINTAINERS
index 32d444476a90..0790f9a02db8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9849,6 +9849,11 @@ F:	drivers/media/platform/meson/ao-cec.c
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
index 000000000000..eae30322a037
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -0,0 +1,178 @@
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
+		     "marvell,armada3710";
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
+		led@487 {
+			gpios = <&gpionb 11 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+
+		led@488 {
+			gpios = <&gpionb 12 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@489 {
+			gpios = <&gpionb 13 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@490 {
+			gpios = <&gpionb 14 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@491 {
+			gpios = <&gpionb 15 GPIO_ACTIVE_HIGH>;
+			default-state = "off";
+		};
+
+		led@492 {
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
+&mdio {
+	status = "okay";
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
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
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
+	};
+};
+
+&i2c1 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins>;
+
+	eeprom@50 {
+		compatible = "atmel,24c04";
+		reg = <0x50>;
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
+&uart0 {
+	status = "okay";
+};
-- 
2.19.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
