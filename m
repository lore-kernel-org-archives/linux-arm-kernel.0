Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F5DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9BB1206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="HfIV9Yw6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9BB1206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=DpJcZG47hxCQzngwhcKFtJ84LcYbaB4xInKxQ7AapjQ=; b=HfIV9Yw63pZoN0
	eBH81HBkneY4GNu07Nkq7aOaZfLmRu2Sld/0Pe9Tw1z/EXJZ71zq6c7wJmSBF9dn8DLBrKILYObNS
	BtWOKDS1KjMmNJf5zCjpsumXnaQydF/I1o4o9i8bMdYHfmK2BIsFCsp02pQKI34m4K4B9Q+iLA0gu
	TDPU53xhEMJA4ZTZfN/gsgG/Usdt0XZIqqwZ7D8d6EWS7P40zCE4ccE+X7bQKr6L7nSmbVBm8VN/1
	kIUDl9/NuZTdppz6lSFHnXTywor5PQoj9g3hwQXI8wc7itKVUYTIoes59LRScN+9Km73fbawwToxK
	15c+rwCme87GAKnxtsaw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFO2-0001jA-E0; Wed, 09 Jan 2019 15:03:18 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFNo-0001WV-IW
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 15:03:06 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 5BBFB5FD40; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 4/5] ARM: dts: sun8i: r40: bananapi-m2-ultra: Add Bluetooth
 device node
Date: Wed,  9 Jan 2019 23:02:56 +0800
Message-Id: <20190109150257.12602-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_070304_753886_4FF14F84 
X-CRM114-Status: GOOD (  16.51  )
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
Cc: devicetree@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The AP6212 is based on the Broadcom BCM43430 or BCM43438. The WiFi side
identifies as BCM43430, while the Bluetooth side identifies as BCM43438.

The Bluetooth side is connected to UART3 in a 4 wire configuration. Same
as the WiFi side, due to being the same chip and package, DLDO1 and
DLDO2 regulator outputs from the PMIC provide overall power via VBAT and
I/O power via VDDIO. The CLK_OUT_A clock output from the SoC provides
the LPO low power clock at 32.768 kHz.

This patch enables Bluetooth on this board, and also adds the missing
LPO clock on the WiFi side. There is also a PCM connection for
Bluetooth, but this is not covered here.

The LPO clock is fed from CLK_OUT_A, which needs to be muxed on pin
PI12. This can be represented in multiple ways. This patch puts the
pinctrl property in the pin controller node. This is due to limitations
in Linux, where pinmux settings, even the same one, can not be shared
by multiple devices. Thus we cannot put it in both the WiFi and
Bluetooth device nodes. Putting it the CCU node is another option, but
Linux's CCU driver does not handle pinctrl. Also the pin controller is
guaranteed to be initialized after the CCU, when clocks are available.
And any other devices that use muxed pins are guaranteed to be
initialized after the pin controller. Thus having the CLK_OUT_A pinmux
reference be in the pin controller node is a good choice without having
to deal with implementation issues.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 1a6794e63b90..c488aaacbd68 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -102,6 +102,8 @@
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&pio 6 10 GPIO_ACTIVE_LOW>; /* PG10 WIFI_EN */
+		clocks = <&ccu CLK_OUTA>;
+		clock-names = "ext_clock";
 	};
 };
 
@@ -196,6 +198,11 @@
 	status = "okay";
 };
 
+&pio {
+	pinctrl-names = "default";
+	pinctrl-0 = <&clk_out_a_pin>;
+};
+
 &reg_aldo2 {
 	regulator-always-on;
 	regulator-min-microvolt = <2500000>;
@@ -293,6 +300,25 @@
 	status = "okay";
 };
 
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pg_pins>, <&uart3_rts_cts_pg_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&ccu CLK_OUTA>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_dldo2>;
+		vddio-supply = <&reg_dldo1>;
+		device-wakeup-gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+		/* TODO host wake line connected to PMIC GPIO pins */
+		shutdown-gpios = <&pio 7 12 GPIO_ACTIVE_HIGH>; /* PH12 */
+		max-speed = <1500000>;
+	};
+};
+
 &usbphy {
 	usb1_vbus-supply = <&reg_vcc5v0>;
 	usb2_vbus-supply = <&reg_vcc5v0>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
