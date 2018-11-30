Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64D2C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 94DA02082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BGWqTKeP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94DA02082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=GYH1m2KqOF5p7QXfve/e9tHnEyQKtZvhOiMyug9DtEk=; b=BGWqTKePKxeEEF
	cND/ERRyu8q9mmTPb1JCOP8IO8VXaUjv8FqUVTaL+7c2Oem8gVndP7oEpnRbGEQ1rqqKwlQUTF9s9
	fOIpIppD1Qn0LrkmjrsX1KNLrLSlrtN4abXpQMQKFS9dy0CV/+NLQgyBpnJ5WCHq00SVmXQ0RGjw7
	lzQ5ylNlOwnmqEPspqtars0ZqbVGYZSC0rmq4zYz/0PTDFY7nwxRPmvMRip/bRbLAGz/ovZTottWd
	/Kim1ST2NCHQ8vH7iYtV4mLeH/0tcHbm5KgIX8xyz4NdsSBuJbioHvp2woZlY6HsEHDad4Na+7Cz5
	8NRAS3ZsXBgfCYgUxmkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdje-0003La-DS; Fri, 30 Nov 2018 08:01:14 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdhq-0000Uj-CY
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:59:24 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 60E0F5FDF9; Fri, 30 Nov 2018 15:58:55 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 6/6] [DO NOT MERGE] ARM: dts: sunxi: libretech-all-h3-cc: Add
 HDF5640 camera module
Date: Fri, 30 Nov 2018 15:58:49 +0800
Message-Id: <20181130075849.16941-7-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181130075849.16941-1-wens@csie.org>
References: <20181130075849.16941-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_235923_309710_867C7610 
X-CRM114-Status: GOOD (  11.51  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The Libretech ALL-H3-CC is compatible with the Orange Pi's camera sensor
module. This module itself features a detachable camera sensor module
ribbon connector, which is populated with a GC2035 sensor by default.
The connector is also compatible with Bananapi's HDF5640 camera module,
which features an OV5640 sensor. The Orange Pi module however does not
activate the auto focus feature of the HDF5640 module.

Enable the camera by enabling the CSI controller, I2C control bus, and
adding needed regulator supplies. As the schematics for the module are
not available, the regulators and GPIO lines controlling them are just
an educated guess.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sunxi-libretech-all-h3-cc.dtsi   | 81 +++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
index 1eadc132390c..3252e1af59cd 100644
--- a/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
+++ b/arch/arm/boot/dts/sunxi-libretech-all-h3-cc.dtsi
@@ -52,6 +52,36 @@
 		};
 	};
 
+	reg_cam_avdd: cam-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "csi-avdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <200>; /* 50 us + board delays */
+		enable-active-high;
+		gpio = <&r_pio 0 0 GPIO_ACTIVE_HIGH>; /* PL0 */
+	};
+
+	reg_cam_dovdd: cam-dovdd {
+		compatible = "regulator-fixed";
+		regulator-name = "csi-dovdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <200>; /* 50 us + board delays */
+		enable-active-high;
+		gpio = <&r_pio 0 0 GPIO_ACTIVE_HIGH>; /* PL0 */
+	};
+
+	reg_cam_dvdd: cam-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "csi-dvdd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		startup-delay-us = <200>; /* 50 us + board delays */
+		enable-active-high;
+		gpio = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
+	};
+
 	reg_vcc1v2: vcc1v2 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc1v2";
@@ -128,6 +158,26 @@
 	cpu-supply = <&reg_vdd_cpux>;
 };
 
+&csi {
+	status = "okay";
+
+	port {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		/* Parallel bus endpoint */
+		csi_from_ov5640: endpoint {
+			remote-endpoint = <&ov5640_to_csi>;
+			bus-width = <8>;
+			data-shift = <2>;
+			hsync-active = <1>; /* Active high */
+			vsync-active = <0>; /* Active low */
+			data-active = <1>;  /* Active high */
+			pclk-sample = <1>;  /* Rising */
+		};
+	};
+};
+
 &de {
 	status = "okay";
 };
@@ -165,6 +215,37 @@
 	};
 };
 
+&i2c2 {
+	status = "okay";
+
+	ov5640: camera@3c {
+		compatible = "ovti,ov5640";
+		reg = <0x3c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&csi_mclk_pin>;
+		clocks = <&ccu CLK_CSI_MCLK>;
+		clock-names = "xclk";
+
+		powerdown-gpios = <&pio 4 14 GPIO_ACTIVE_HIGH>; /* PE14 */
+		reset-gpios = <&pio 4 15 GPIO_ACTIVE_LOW>; /* PE15 */
+		AVDD-supply = <&reg_cam_avdd>;
+		DOVDD-supply = <&reg_cam_dovdd>;
+		DVDD-supply = <&reg_cam_dvdd>;
+
+		port {
+			ov5640_to_csi: endpoint {
+				remote-endpoint = <&csi_from_ov5640>;
+				bus-width = <8>;
+				data-shift = <2>;
+				hsync-active = <1>; /* Active high */
+				vsync-active = <0>; /* Active low */
+				data-active = <1>;  /* Active high */
+				pclk-sample = <1>;  /* Rising */
+			};
+		};
+	};
+};
+
 &ir {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir_pins_a>;
-- 
2.20.0.rc1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
