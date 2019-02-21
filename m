Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20021C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DDA9D2084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="igXHjBt7";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cm2Bmwgz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CkdfS4vB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDA9D2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u3gHSrAFkEsGRa6PeEVON4pDkeO98I+7f23JbjFnYxw=; b=igXHjBt7B/ES6+
	NmfwfvT87oQ7Pzzhf+SOs8NkoNYFgueTuIoMA6lVD9fcgxNYVfYOhAjnb3nHSFaVa8HXRCsaEZdDz
	enxZ3QABg9WU7sEwbQB4WOHNLSm70Nr3qIJadNeEsSUwkuF4tQ+SVpqi0ZyFczyHx10oHAoumQpR3
	MHLdAli7ogYq+us2WqiEpEZlbr1Wb7rfWjCYPE7Nv1DdiZDP9rfUM/5svX7QHcSUdM1xVKuGAC3x6
	tnkeF1Uln++SvKV/bL+23Z5iFl0pGLQv+UDET5YEhJkTIgJ6HUWYfQsUGxf8mSgrDpP2KPgQlaY8L
	2bkyke3Ki7WQ+mUtWpkw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqwS-0006Fn-6m; Thu, 21 Feb 2019 16:11:20 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqvw-0005aI-Jm
 for linux-arm-kernel@bombadil.infradead.org; Thu, 21 Feb 2019 16:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=DEVUqBwVCFIU2rmrXGXJl74fxTiZmB8+4DOBl79E02I=; b=Cm2Bmwgz7I8IuaQEBiN7081e2f
 0SvwWaBiJltF4Q6s91scEyX1LCsjJ9box1p+wqM7pv6l1SpzuFUf52io7D/1UoZ1ZhhIhxlQA70T0
 KRVGxmAD0UY1fDv+yktkBddENDYvYkQqUS/eMv4sebSZe5A5dAWgH3tz8YEstvmlUjmjLiEVzK/ov
 +UsuynlDYU9FATiiE1Z+fB3p5gAtnIfRAlTTZ7eun8q3+aFet+87dsX9xqAKKA3ssuc0FCBm0TPyb
 jyXZF6ppzOPefcph5kxLMC41vULpLB+NuZlw30l76FaAciS2AHKbspfZEiJe3trxfTnp9ExfY6Za2
 10m6AEZA==;
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXu-00029w-03
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:59 +0000
Received: by mail-lf1-x142.google.com with SMTP id t14so20706426lfk.7
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DEVUqBwVCFIU2rmrXGXJl74fxTiZmB8+4DOBl79E02I=;
 b=CkdfS4vB9lHH9XxEa+kiV85Z8kuWktLOkMPAui9Vsnul/mXLGpQX9+VgUu3ZZ3Mwm6
 NNoOk5HGFqbCVfFNjGARM4uo9SEATzfZ6iQXt4CSGzhJGkj4rdObISE40e6kOkePaWnc
 9i2pucPzc5T8WFe7bxW76DFRc3QbFOBfitMwLnU7FOVdoIPnMze6/6MWilSBvEtQovjM
 OJBlmJo8k/WNJnFd45kcc1Fi66Pe7nCG7wJ8zTeiVLYJ254hOPr2hl1J2xhmGxD+Des+
 4GfqCBx2nVbhzfWIwbtZQdDErt6e2Z69kPCw0JVC3D5SpzpEqiyar/zH4Ayml6Xs1Itv
 8fZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DEVUqBwVCFIU2rmrXGXJl74fxTiZmB8+4DOBl79E02I=;
 b=ouIUOJQb6+4hsolvchxmH7mF2565tEU9/8BM48Op/DhTWCF1egbiQvMlcIlubAcigi
 s+tkGui+BA+7VxIFFNkissIgYeAfZWQiDHx5hbhXDavLa22CRvVuJ3l3QR3xmP9RfTd2
 rYIAI6CLpSUydSWiTM4jdradpLsNm+aJaM8gyY1s7y6fcRRX0Le0JX4DxBW4sVaAO8RE
 gclV7rZ1/uD2BKp1XAlnqZCSqh2sQuK9VIKTDtBSJIjd86ETs44lDlqpQqS/ywei0jwQ
 njI8Q1+upBM5LKKLFVlS7flre617By/usK+npIHZS/SMIfibEVA3HQfLgoZO3SfKln0j
 MikQ==
X-Gm-Message-State: AHQUAuZJAYjcB/7f3ARiyeBb+7AkCrD/LQsSR1uVNhbn5yxDN3I0JXY0
 vX1180TngYNpt6D3Kl/13aulTVP64cE=
X-Google-Smtp-Source: AHgI3IZ+XaSSEuOR5VGi2RN2ewneoCzLU0D7neX+7fbTKwe+TPqA0FaRynf6fi4qKmeNSf1OO610FQ==
X-Received: by 2002:ac2:518e:: with SMTP id u14mr23207965lfi.76.1550763951736; 
 Thu, 21 Feb 2019 07:45:51 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:50 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 17/30 v2] ARM: dts: Add some initial IXP4xx device trees
Date: Thu, 21 Feb 2019 16:44:45 +0100
Message-Id: <20190221154458.23763-18-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_104558_435558_96F7FB04 
X-CRM114-Status: GOOD (  23.13  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a device tree for the IXP4xx-based Linksys
NSLU2 and Gateworks GW2358 which encompass the Gateworks
Cambria family.

These will be the first IXP4xx device tree platforms.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog RFC->v2:
- Take out of RFC
- Use ISC license on the files, *BSD likes this license
---
 arch/arm/boot/dts/Makefile                    |   3 +
 .../boot/dts/intel-ixp42x-linksys-nslu2.dts   | 109 ++++++++++++++++++
 arch/arm/boot/dts/intel-ixp42x.dtsi           |  25 ++++
 .../dts/intel-ixp43x-gateworks-gw2358.dts     |  94 +++++++++++++++
 arch/arm/boot/dts/intel-ixp43x.dtsi           |  15 +++
 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi    |  34 ++++++
 arch/arm/boot/dts/intel-ixp4xx.dtsi           |  58 ++++++++++
 7 files changed, 338 insertions(+)
 create mode 100644 arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
 create mode 100644 arch/arm/boot/dts/intel-ixp42x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
 create mode 100644 arch/arm/boot/dts/intel-ixp43x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi
 create mode 100644 arch/arm/boot/dts/intel-ixp4xx.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index bd40148a15b2..272d39317a1b 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -227,6 +227,9 @@ dtb-$(CONFIG_ARCH_HIX5HD2) += \
 dtb-$(CONFIG_ARCH_INTEGRATOR) += \
 	integratorap.dtb \
 	integratorcp.dtb
+dtb-$(CONFIG_ARCH_IXP4XX) += \
+	intel-ixp42x-linksys-nslu2.dtb \
+	intel-ixp43x-gateworks-gw2358.dtb
 dtb-$(CONFIG_ARCH_KEYSTONE) += \
 	keystone-k2hk-evm.dtb \
 	keystone-k2l-evm.dtb \
diff --git a/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts b/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
new file mode 100644
index 000000000000..8fcd95805ff4
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp42x-linksys-nslu2.dts
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for Linksys NSLU2
+ */
+
+/dts-v1/;
+
+#include "intel-ixp42x.dtsi"
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "Linksys NSLU2 (Network Storage Link for USB 2.0 Disk Drives)";
+	compatible = "linksys,nslu2", "intel,ixp42x";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory@0 {
+		/* 32 MB SDRAM */
+		device_type = "memory";
+		reg = <0x00000000 0x2000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 root=/dev/mtdblock2 rw rootfstype=squashfs,jffs2 rootwait";
+		stdout-path = "uart0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-status {
+			label = "nslu2:red:status";
+			gpios = <&gpio0 0 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+		led-ready {
+			label = "nslu2:green:ready";
+			gpios = <&gpio0 1 GPIO_ACTIVE_HIGH>;
+			default-state = "on";
+		};
+		led-disk-1 {
+			label = "nslu2:green:disk-1";
+			gpios = <&gpio0 3 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+		led-disk-2 {
+			label = "nslu2:green:disk-2";
+			gpios = <&gpio0 2 GPIO_ACTIVE_LOW>;
+			default-state = "off";
+		};
+	};
+
+	gpio_keys {
+		compatible = "gpio-keys";
+
+		button-power {
+			wakeup-source;
+			linux,code = <KEY_POWER>;
+			label = "power";
+			gpios = <&gpio0 5 GPIO_ACTIVE_HIGH>;
+		};
+		button-reset {
+			wakeup-source;
+			linux,code = <KEY_ESC>;
+			label = "reset";
+			gpios = <&gpio0 12 GPIO_ACTIVE_LOW>;
+		};
+	};
+
+	i2c {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpio0 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio0 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@6f {
+			compatible = "xicor,x1205";
+			reg = <0x6f>;
+		};
+	};
+
+	gpio-poweroff {
+		compatible = "gpio-poweroff";
+		gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
+		timeout-ms = <5000>;
+	};
+
+	/* The first 16MB region on the expansion bus */
+	flash@50000000 {
+		compatible = "intel,ixp4xx-flash", "cfi-flash";
+		bank-width = <2>;
+		/*
+		 * 8 MB of Flash in 0x20000 byte blocks
+		 * mapped in at 0x50000000
+		 */
+		reg = <0x50000000 0x800000>;
+
+		partitions {
+			compatible = "redboot-fis";
+			/* Eraseblock at 0x7e0000 */
+			fis-index-block = <0x3f>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/intel-ixp42x.dtsi b/arch/arm/boot/dts/intel-ixp42x.dtsi
new file mode 100644
index 000000000000..a9622ca850cc
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp42x.dtsi
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for Intel XScale Network Processors
+ * in the IXP 42x series. This series has 32 interrupts.
+ */
+#include "intel-ixp4xx.dtsi"
+
+/ {
+	soc {
+		interrupt-controller@c8003000 {
+			compatible = "intel,ixp42x-interrupt";
+		};
+
+		/*
+		 * This is the USB Device Mode (UDC) controller, which is used
+		 * to present the IXP4xx as a device on a USB bus.
+		 */
+		usb@c800b000 {
+			compatible = "intel,ixp4xx-udc";
+			reg = <0xc800b000 0x1000>;
+			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts b/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
new file mode 100644
index 000000000000..ba1163a1e1e7
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp43x-gateworks-gw2358.dts
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for Gateworks IXP43x-based Cambria GW2358
+ */
+
+/dts-v1/;
+
+#include "intel-ixp43x.dtsi"
+
+/ {
+	model = "Gateworks Cambria GW2358";
+	compatible = "gateworks,gw2358", "intel,ixp43x";
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	memory@0 {
+		/* 128 MB SDRAM */
+		device_type = "memory";
+		reg = <0x00000000 0x8000000>;
+	};
+
+	chosen {
+		bootargs = "console=ttyS0,115200n8 root=/dev/mtdblock2 rw rootfstype=squashfs,jffs2 rootwait";
+		stdout-path = "uart0:115200n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+	};
+
+	leds {
+		compatible = "gpio-leds";
+		led-user {
+			label = "gw2358:green:LED";
+			gpios = <&pld1 0 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+			linux,default-trigger = "heartbeat";
+		};
+	};
+
+
+	i2c {
+		compatible = "i2c-gpio";
+		sda-gpios = <&gpio0 7 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		scl-gpios = <&gpio0 6 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hwmon@28 {
+			compatible = "adi,ad7418";
+			reg = <0x28>;
+		};
+		rtc: ds1672@68 {
+			compatible = "dallas,ds1672";
+			reg = <0x68>;
+		};
+		eeprom@51 {
+			compatible = "atmel,24c08";
+			reg = <0x51>;
+			pagesize = <16>;
+			size = <1024>;
+			read-only;
+		};
+		pld0: pld@56 {
+			compatible = "gateworks,pld-gpio";
+			reg = <0x56>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+		/* This PLD just handles the LED and user button */
+		pld1: pld@57 {
+			compatible = "gateworks,pld-gpio";
+			reg = <0x57>;
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+	};
+
+	flash@50000000 {
+		compatible = "intel,ixp4xx-flash", "cfi-flash";
+		bank-width = <2>;
+		/*
+		 * 32 MB of Flash in 0x20000 byte blocks
+		 * mapped in at 0x50000000
+		 */
+		reg = <0x50000000 0x2000000>;
+
+		partitions {
+			compatible = "redboot-fis";
+			/* Eraseblock at 0x1fe0000 */
+			fis-index-block = <0xff>;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/intel-ixp43x.dtsi b/arch/arm/boot/dts/intel-ixp43x.dtsi
new file mode 100644
index 000000000000..494fb2ff57a0
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp43x.dtsi
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for Intel XScale Network Processors
+ * in the IXP 43x series. This series has 64 interrupts and adds a few more
+ * peripherals over the 42x series.
+ */
+#include "intel-ixp4xx.dtsi"
+
+/ {
+	soc {
+		interrupt-controller@c8003000 {
+			compatible = "intel,ixp43x-interrupt";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi b/arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi
new file mode 100644
index 000000000000..f8cd506659dc
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp45x-ixp46x.dtsi
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for Intel XScale Network Processors
+ * in the IXP45x and IXP46x series. This series has 64 interrupts and adds a
+ * few more peripherals over the 42x and 43x series so this extends the
+ * basic IXP4xx DTSI.
+ */
+#include "intel-ixp4xx.dtsi"
+
+/ {
+	soc {
+		interrupt-controller@c8003000 {
+			compatible = "intel,ixp43x-interrupt";
+		};
+
+		/*
+		 * This is the USB Device Mode (UDC) controller, which is used
+		 * to present the IXP4xx as a device on a USB bus.
+		 */
+		usb@c800b000 {
+			compatible = "intel,ixp4xx-udc";
+			reg = <0xc800b000 0x1000>;
+			interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		i2c@c8011000 {
+			compatible = "intel,ixp4xx-i2c";
+			reg = <0xc8011000 0x18>;
+			interrupts = <33 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/intel-ixp4xx.dtsi b/arch/arm/boot/dts/intel-ixp4xx.dtsi
new file mode 100644
index 000000000000..9edd49509af8
--- /dev/null
+++ b/arch/arm/boot/dts/intel-ixp4xx.dtsi
@@ -0,0 +1,58 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Device Tree file for Intel XScale Network Processors
+ * in the IXP 4xx series.
+ */
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/gpio/gpio.h>
+
+/ {
+	soc {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+		compatible = "simple-bus";
+		interrupt-parent = <&intcon>;
+
+		uart0: serial@c8000000 {
+			compatible = "intel,xscale-uart";
+			reg = <0xc8000000 0x1000>;
+			/*
+			 * The reg-offset and reg-shift is a side effect
+			 * of running the platform in big endian mode.
+			 */
+			reg-offset = <3>;
+			reg-shift = <2>;
+			interrupts = <15 IRQ_TYPE_LEVEL_HIGH>;
+			clock-frequency = <14745600>;
+			no-loopback-test;
+		};
+
+		gpio0: gpio@c8004000 {
+			compatible = "intel,ixp4xx-gpio";
+			reg = <0xc8004000 0x1000>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		intcon: interrupt-controller@c8003000 {
+			/*
+			 * Note: no compatible string. The subvariant of the
+			 * chip needs to define what version it is. The
+			 * location of the interrupt controller is fixed in
+			 * memory across all variants.
+			 */
+			reg = <0xc8003000 0x100>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		timer@c8005000 {
+			compatible = "intel,ixp4xx-timer";
+			reg = <0xc8005000 0x100>;
+			interrupts = <5 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+};
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
