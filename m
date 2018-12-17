Return-Path: <SRS0=FFYW=O2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05200C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:40 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C75B7217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 04:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iPQ8eB5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C75B7217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nf384DAbKr3yFp28zZNR2x8/8pUXRrGnB5IjClfxk6M=; b=iPQ8eB5Tg7AQ+w
	UrvpgZeLUtQlfDyjtSksEaClThqfbG36WyALwIR5aPVpD7iUzYK94a+xEWFcEcGvssQKMB5gOxLdj
	90StX05+BpvSpAS0CXGWfsWTQGY22VVcttQIh3KFU/z6De6COSCGsvlZFSjwoqPZ+gTGdzh2WLgpv
	znUvoaNYCpwxp3kf8F8GOBvaFXs2cUU+Gg7scNtsfwy9v6PEGm6zBh05M6c9s/6qLcMiQ+BJ+RiyK
	1b9tcwxydqFEAEv2kIuTDPz2i8Yo1Utq4V5Em5VsBTKHDUrnbnw+k0igztpBk+ek4WWiJf7a9Zusn
	DZKEIqTRmcvVhwQFORHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gYkAo-0001Jz-Lm; Mon, 17 Dec 2018 04:06:30 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gYk9v-0000Ip-9W
 for linux-arm-kernel@lists.infradead.org; Mon, 17 Dec 2018 04:05:43 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id A26BE5FE0F; Mon, 17 Dec 2018 12:05:03 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH v3 14/15] ARM: dts: sunxi: Enable Broadcom-based Bluetooth for
 multiple boards
Date: Mon, 17 Dec 2018 12:04:48 +0800
Message-Id: <20181217040449.31437-15-wens@csie.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181217040449.31437-1-wens@csie.org>
References: <20181217040449.31437-1-wens@csie.org>
MIME-Version: 1.0
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
 linux-bluetooth@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Loic Poulain <loic.poulain@gmail.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This patch adds the Bluetooth node, and the underlying UART node if it's
missing, to the board device tree file for several boards. The LPO clock
is also added to the WiFi side's power sequencing node if it's missing,
to correctly represent the shared connections. There is also a PCM
connection for Bluetooth, but this is not covered in this patch.

These boards all have a WiFi+BT module from AMPAK, which contains one or
two Broadcom chips, depending on the model. The older AP6210 contains
two, while the newer AP6212 and AP6330 contain just one, as they use
two-in-one combo chips.

The Bluetooth side of the module is always connected to a UART on the
same pingroup as the SDIO pins for the WiFi side, in a 4 wire
configuration. Power to the VBAT and VDDIO pins are provided either by
the PMIC, using one or several of its regulator outputs, or other fixed
regulators on the board. The VBAT and VDDIO pins are shared with the
WiFi side, which would correspond to vmmc-supply and vqmmc-supply in the
mmc host node. A clock output from the SoC or the external X-Powers RTC
provides the LPO low power clock at 32.768 kHz.

All the boards covered in this patch are ones that do not require extra
changes to the SoC's dtsi file. For the remaining boards that I have
worked on, properties or device nodes for the LPO clock's source are
missing.

For the Cubietruck, the LPO clock is fed from CLK_OUT_A, which needs to
be muxed on pin PI12. This can be represented in multiple ways. This
patch puts the pinctrl property in the pin controller node. This is due
to limitations in Linux, where pinmux settings, even the same one, can
not be shared by multiple devices. Thus we cannot put it in both the
WiFi and Bluetooth device nodes. Putting it the CCU node is another
option, but Linux's CCU driver does not handle pinctrl. Also the pin
controller is guaranteed to be initialized after the CCU, when clocks
are available. And any other devices that use muxed pins are guaranteed
to be initialized after the pin controller. Thus having the CLK_OUT_A
pinmux reference be in the pin controller node is a good choice without
having to deal with implementation issues.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts    | 25 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 18 +++++++++++++
 .../boot/dts/sun8i-a83t-cubietruck-plus.dts   | 18 +++++++++++++
 arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts  | 14 +++++++++++
 4 files changed, 75 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 15c5eae4ca7b..99f531b8d2a7 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -99,6 +99,8 @@
 	mmc3_pwrseq: mmc3_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 7 9 GPIO_ACTIVE_LOW>; /* PH9 WIFI_EN */
+		clocks = <&ccu CLK_OUT_A>;
+		clock-names = "ext_clock";
 	};
 
 	sound {
@@ -227,6 +229,12 @@
 	status = "okay";
 };
 
+&pio {
+	/* Pin outputs low power clock for WiFi and BT */
+	pinctrl-0 = <&clk_out_a_pin>;
+	pinctrl-names = "default";
+};
+
 &pwm {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwm0_pin>, <&pwm1_pin>;
@@ -298,6 +306,23 @@
 	status = "okay";
 };
 
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pi_pins>, <&uart2_cts_rts_pi_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm20702a1";
+		clocks = <&ccu CLK_OUT_A>;
+		clock-names = "lpo";
+		device-wakeup-gpios = <&pio 7 24 GPIO_ACTIVE_LOW>; /* PH24 */
+		host-wakeup-gpios = <&pio 7 25 GPIO_ACTIVE_LOW>; /* PH25 */
+		shutdown-gpios = <&pio 7 18 GPIO_ACTIVE_HIGH>; /* PH18 */
+		max-speed = <1500000>;
+	};
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
index 583a5a01642f..7d30d3e530fb 100644
--- a/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts
@@ -363,6 +363,24 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo1>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 7 9 GPIO_ACTIVE_HIGH>; /* PH9 */
+		host-wakeup-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	status = "okay";
diff --git a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
index e5f0645e53a7..a5a9f5a0603e 100644
--- a/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-cubietruck-plus.dts
@@ -394,6 +394,24 @@
 	status = "okay";
 };
 
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm4330-bt";
+		clocks = <&ac100_rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dcdc1>;
+		vddio-supply = <&reg_sw>;
+		device-wakeup-gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+		host-wakeup-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		shutdown-gpios = <&r_pio 0 4 GPIO_ACTIVE_HIGH>; /* PL4 */
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_usb1_vbus>;
 	usb2_vbus-supply = <&reg_usb2_vbus>;
diff --git a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
index 83d32a1a2a63..e1c75f7fa3ca 100644
--- a/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
+++ b/arch/arm/boot/dts/sun8i-r16-bananapi-m2m.dts
@@ -91,6 +91,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 6 GPIO_ACTIVE_LOW>; /* PL06 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -276,7 +278,19 @@
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart1_pg_pins>, <&uart1_cts_rts_pg_pins>;
+	uart-has-rtscts;
 	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo1>;
+		vddio-supply = <&reg_aldo3>;
+		device-wakeup-gpios = <&r_pio 0 10 GPIO_ACTIVE_HIGH>; /* PL10 */
+		host-wakeup-gpios = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		shutdown-gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	};
 };
 
 &usb_otg {
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
