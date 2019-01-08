Return-Path: <SRS0=tBLO=PQ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DFDEC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:58:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 256182146F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:58:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FxE8J9A1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 256182146F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=u/EDIcqQ6BUaKTrUkQ0oAmLtlAaPGfcfk81/3NEo8ug=; b=FxE8J9A1YDRQqKlmpHBnKcWus5
	s66XPnN9XANlkGNhIoFxWYEIg9QEC+hcsW4srWO1mlrLhAgsdYPKtmV5Do6A+4E9BA9qCCD67biFG
	DrR9k9CCWFtbBuipo8Q34DXnbTZ8B/E1d8wlUitfV4ycnScz6AkAs4Wkof1+ZXSorz+ZqRBL+t8Np
	HH+MuOrIOZ7dzofiDUCgtcQ0vlrdQ71plQ9g373bMj6/lt+35XkS/guHVbydHm5uQN4VWAelBJa8c
	2lV4h9ajXYaJGS6QGhExOUbuVw0CpxNmz8Wcf7ywfu9csWtkr3+YkXDnuXiHpwVLixU4kREjn3TIC
	0bV7soig==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ggzO2-0004LL-8s; Tue, 08 Jan 2019 21:58:14 +0000
Received: from foss.arm.com ([217.140.101.70])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ggzNc-0003tY-J7; Tue, 08 Jan 2019 21:57:58 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C23915AB;
 Tue,  8 Jan 2019 13:57:48 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (usa-sjc-mx-foss1.foss.arm.com
 [217.140.101.70])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B7DC53F5AF;
 Tue,  8 Jan 2019 13:57:46 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: heiko@sntech.de
Subject: [PATCH 3/5] arm64: dts: rockchip: Refine nanopi4 differences
Date: Tue,  8 Jan 2019 21:57:25 +0000
Message-Id: <2123f6ef0bc4429fc48709af822289c82a63d46f.1546981251.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1546981251.git.robin.murphy@arm.com>
References: <cover.1546981251.git.robin.murphy@arm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190108_135749_248628_9B3ED34C 
X-CRM114-Status: GOOD (  14.37  )
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
Cc: linux-rockchip@lists.infradead.org, tomeu.vizoso@collabora.com,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The nanopi4 boards differ primarily in their power trees, with the main
5V and 3.3V rails having very different topologies on the smaller USB-C
powered boards vs. the 12V-powered T4, as well as minor variation in
other regulators related to various external connectors.

Additionally, the recovery key is only present on the T4 - ADC_IN1 is
simply pulled high and not exposed on the other boards - and the lowest
common denominator for MMC speed is actually HS200 according to the
vendor DTs.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 .../boot/dts/rockchip/rk3399-nanopc-t4.dts    | 58 +++++++++++++++++++
 .../boot/dts/rockchip/rk3399-nanopi-m4.dts    | 48 +++++++++++++++
 .../boot/dts/rockchip/rk3399-nanopi4.dtsi     | 55 +-----------------
 3 files changed, 107 insertions(+), 54 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
index af0bb2544709..623a03f2548a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopc-t4.dts
@@ -14,4 +14,62 @@
 / {
 	model = "FriendlyElec NanoPC-T4";
 	compatible = "friendlyarm,nanopc-t4", "rockchip,rk3399";
+
+	vcc12v0_sys: vcc12v0-sys {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-max-microvolt = <12000000>;
+		regulator-min-microvolt = <12000000>;
+		regulator-name = "vcc12v0_sys";
+	};
+
+	vcc5v0_host0: vcc5v0-host0 {
+		compatible = "regulator-fixed";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-name = "vcc5v0_host0";
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	adc-keys {
+		compatible = "adc-keys";
+		io-channels = <&saradc 1>;
+		io-channel-names = "buttons";
+		keyup-threshold-microvolt = <1800000>;
+		poll-interval = <100>;
+
+		recovery {
+			label = "Recovery";
+			linux,code = <KEY_VENDOR>;
+			press-threshold-microvolt = <18000>;
+		};
+	};
+};
+
+&sdhci {
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_host0>;
+};
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_host0>;
+};
+
+&vcc5v0_sys {
+	vin-supply = <&vcc12v0_sys>;
+};
+
+&vcc3v3_sys {
+	vin-supply = <&vcc12v0_sys>;
+};
+
+&vbus_typec {
+	enable-active-high;
+	gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
+	vin-supply = <&vcc5v0_sys>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
index 8d3f0ba29c72..60358ab8c7df 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi-m4.dts
@@ -15,4 +15,52 @@
 / {
 	model = "FriendlyElec NanoPi M4";
 	compatible = "friendlyarm,nanopi-m4", "rockchip,rk3399";
+
+	vdd_5v: vdd-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd_5v";
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	vcc5v0_core: vcc5v0-core {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_core";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vdd_5v>;
+	};
+
+	vcc5v0_usb1: vcc5v0-usb1 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb1";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+
+	vcc5v0_usb2: vcc5v0-usb2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc5v0_usb2";
+		regulator-always-on;
+		regulator-boot-on;
+		vin-supply = <&vcc5v0_sys>;
+	};
+};
+
+&vcc3v3_sys {
+	vin-supply = <&vcc5v0_core>;
+};
+
+&u2phy0_host {
+	phy-supply = <&vcc5v0_usb1>;
+};
+
+&u2phy1_host {
+	phy-supply = <&vcc5v0_usb2>;
+};
+
+&vbus_typec {
+	regulator-always-on;
+	vin-supply = <&vdd_5v>;
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
index 3e8f1c10ba4f..9c723038d8f8 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399-nanopi4.dtsi
@@ -28,21 +28,6 @@
 		#clock-cells = <0>;
 	};
 
-	vdd_5v: vdd-5v {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-name = "vdd_5v";
-	};
-
-	vcc5v0_core: vcc5v0-core {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-name = "vcc5v0_core";
-		vin-supply = <&vdd_5v>;
-	};
-
 	vcc3v3_sys: vcc3v3-sys {
 		compatible = "regulator-fixed";
 		regulator-always-on;
@@ -50,7 +35,6 @@
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		regulator-name = "vcc3v3_sys";
-		vin-supply = <&vcc5v0_core>;
 	};
 
 	vcc5v0_sys: vcc5v0-sys {
@@ -63,22 +47,6 @@
 		vin-supply = <&vdd_5v>;
 	};
 
-	vcc5v0_usb1: vcc5v0-usb1 {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-name = "vcc5v0_usb1";
-		vin-supply = <&vcc5v0_sys>;
-	};
-
-	vcc5v0_usb2: vcc5v0-usb2 {
-		compatible = "regulator-fixed";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-name = "vcc5v0_usb2";
-		vin-supply = <&vcc5v0_sys>;
-	};
-
 	/* switched by pmic_sleep */
 	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		compatible = "regulator-fixed";
@@ -105,27 +73,9 @@
 
 	vbus_typec: vbus-typec {
 		compatible = "regulator-fixed";
-		enable-active-high;
-		gpios = <&gpio4 RK_PD2 GPIO_ACTIVE_HIGH>;
-		regulator-always-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
 		regulator-name = "vbus_typec";
-		vin-supply = <&vdd_5v>;
-	};
-
-	adc-keys {
-		compatible = "adc-keys";
-		io-channels = <&saradc 1>;
-		io-channel-names = "buttons";
-		keyup-threshold-microvolt = <1800000>;
-		poll-interval = <100>;
-
-		recovery {
-			label = "Recovery";
-			linux,code = <KEY_VENDOR>;
-			press-threshold-microvolt = <18000>;
-		};
 	};
 
 	gpio-keys {
@@ -590,8 +540,7 @@
 
 &sdhci {
 	bus-width = <8>;
-	mmc-hs400-1_8v;
-	mmc-hs400-enhanced-strobe;
+	mmc-hs200-1_8v;
 	non-removable;
 	status = "okay";
 };
@@ -644,7 +593,6 @@
 };
 
 &u2phy0_host {
-	phy-supply = <&vcc5v0_usb1>;
 	status = "okay";
 };
 
@@ -657,7 +605,6 @@
 };
 
 &u2phy1_host {
-	phy-supply = <&vcc5v0_usb2>;
 	status = "okay";
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
