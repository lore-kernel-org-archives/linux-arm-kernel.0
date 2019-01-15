Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C093C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:44:03 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 059D720657
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 14:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SAAYp0KX";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="RkDrQxnb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 059D720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sartura.hr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fiCHhQLH8yCzZ5qtDDexTmzL9LGT7W46JxrAMPCgNVE=; b=SAAYp0KXtUB9qn
	X4HgPfqY3Gh7PQx9BqUFwuet/beka+PCWE5os4VhzwLyL799V+TdwHFVdA+g7Q/WI0c757dsveqwh
	Dw0mDBGZt1kSLz5Ij/E+SC6KeAoe+pITwxX2KMwHppRiCGlFsanPZo1vpL2C93b1dHiUQScmqMtH3
	/+MUJ1DGt1YeR2giAbSyq9coc2u68IKU3nJkZydvIt35h3xkPXd8/evCNh4iBnsGM5M3w1Ck3vZ7s
	leSZ6NH+YJZFzxFOx6QBW7NuuPwkdjeQH3alRUkalH3BcKqWNRftx6X3u7CuyKk7AMgNTFLPbUO73
	QXoZqQdeRdBWkjVb+RzQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjPwc-0005YB-5E; Tue, 15 Jan 2019 14:43:58 +0000
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjPwY-0005Xf-9R
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 14:43:56 +0000
Received: by mail-wm1-x341.google.com with SMTP id a62so3535498wmh.4
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 06:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sartura-hr.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=bVUKmtUKhBtPWZ2wSgp0dQEzMdILM6Patf4HDjjLg6E=;
 b=RkDrQxnbMdiRFf/qkffjSXzn0XYV50baYdCt+gLlb0cNidVWzvtm2O8If0Pp+H+5vL
 FffHDR08kBSWKehFPbczaDEv+Ze+rvUT1DIP7DHOkOg5r9AocmviVOndAIJfVyimTYso
 pPUdvxr0ptjn5EjqWDCoi486/DltxHugzuqx3Ezr1orUCZdkK9/Yk16UriEgGVL4HLAa
 AdXQcSCMVzEEjM3c8+l143W6H6aplcRENeXYwDwLx0jEVGvFptkFAXXqFs/wnP90CpZ6
 Wbij4IOzK2ftTaVkeecBe8uj/2e/Y/55S0jaiqdjCid5DaYHg4ezhWtmSdC8AHKXw085
 9QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=bVUKmtUKhBtPWZ2wSgp0dQEzMdILM6Patf4HDjjLg6E=;
 b=lQNw63TSAV1bmHXy3UrL/QqPLGw+LYihPBo46vq7dfSjW7f6JGLe9eoSn2PBZuNN99
 vdGib4lFDkAQmmG69pre1fABTnEIw+4pdb95vS5bP6PEZdZo3cRejv/OZRHmgQTko5Ka
 K87n5xOC5jjUQGB7YgW8ieTl2kjckH5HHk8pj0GGq9oeBTwQMZfomqH5LqTF2B4PZPOm
 uOQFqLgp3/YZWesheTv2FBETbIRkhXI4mOFgvYZAEy8OWxByXXR3oGbutYlr4xw9159N
 NKDHFrFzT2taiZNjKjxVME97QgqqtrvDj6SP/Uo9yYET/DvCdGhfMWYDEwahkbnbQWNX
 R0iw==
X-Gm-Message-State: AJcUukf+4AI/+onLJBJFB2uy2XqJZp98MhG16Ak1dPK0RHTT7DbPGqnR
 24GPUGqzvtJB3LwmOfZOCuiw
X-Google-Smtp-Source: ALg8bN76xJZmCgZnZAytif0S6Uf5Jg6imW35GjuGoRwRjasOPfin+ICEsb47Q2KQql3Uot4haNbjPg==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr3298080wmf.99.1547563431660;
 Tue, 15 Jan 2019 06:43:51 -0800 (PST)
Received: from b50.local (cpe-109-60-36-251.st4.cable.xnet.hr. [109.60.36.251])
 by smtp.gmail.com with ESMTPSA id c202sm40115276wmd.40.2019.01.15.06.43.50
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 06:43:50 -0800 (PST)
From: Vladimir Vid <vladimir.vid@sartura.hr>
To: devicetree@vger.kernel.org
Subject: [PATCH v3] arm64: dts: marvell: Add device tree for uDPU board
Date: Tue, 15 Jan 2019 15:44:22 +0100
Message-Id: <20190115144421.29968-1-vladimir.vid@sartura.hr>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20190111172055.30451-1-vladimir.vid@sartura.hr>
References: <20190111172055.30451-1-vladimir.vid@sartura.hr>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_064354_471783_6314AB0E 
X-CRM114-Status: GOOD (  18.22  )
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

v3 changes:
- update copyright year for Methode and Telus
- fix Methode copyright (use Methode Electornics instead of Methode)
- sort compatible string by relevance, remove armada-3720-db and
armada3710 to keep it generic

---
 MAINTAINERS                                   |   5 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 .../boot/dts/marvell/armada-3720-uDPU.dts     | 163 ++++++++++++++++++
 3 files changed, 169 insertions(+)
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
index 000000000000..c1f77f3ca174
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -0,0 +1,163 @@
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
