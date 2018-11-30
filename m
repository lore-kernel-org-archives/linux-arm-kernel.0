Return-Path: <SRS0=AWyS=OJ=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D05C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:01:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFC7A2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 08:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Wo25MdLO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFC7A2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XE6pPRkS6jLG8h3lUh8wJIB/BBZ+hpL8m5dSfAV/pXk=; b=Wo25MdLOQTqjMR
	uRYcv96QLl8+KqsFaEFaJfaQIsA9Ov9gyco6CntQ3B5vUQ2+EdeczZejanA4wqXS6jMZl9QTTkjIq
	KMB9dVog6QwKWOgdkL88PiV7J7Eu116Y95R3K9owxwlt8NB095KOAFLhO91TE9U/HgEdZS/2fqg3+
	or5klF9TfkSYbsSWjasVD0M6xvE1FrLoacVfWUcKvH65+b3QoCU20wVsl+PSjEVkBrJeNxIkeP3l+
	7p9SYiNezXOeFUXGy6J/nc4T2yTp512jAqIAknVMTyAt4To5Uld/6Lik8zpyZmG6D2Sx7s13b1Eh4
	oi1WZ362EmSa54kXYv/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSdjL-00035L-I3; Fri, 30 Nov 2018 08:00:55 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSdhq-0000Ub-CZ
 for linux-arm-kernel@lists.infradead.org; Fri, 30 Nov 2018 07:59:24 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 5AD065FDD9; Fri, 30 Nov 2018 15:58:55 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Yong Deng <yong.deng@magewell.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <maxime.ripard@bootlin.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 5/6] [DO NOT MERGE] ARM: dts: sunxi: bananapi-m2p: Add HDF5640
 camera module
Date: Fri, 30 Nov 2018 15:58:48 +0800
Message-Id: <20181130075849.16941-6-wens@csie.org>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <20181130075849.16941-1-wens@csie.org>
References: <20181130075849.16941-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_235922_785561_3C297EE0 
X-CRM114-Status: GOOD (  11.86  )
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

The Bananapi M2+ comes with an optional sensor based on the ov5640 from
Omnivision. Enable the support for it in the DT.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index b3283aeb5b7d..d97a98acf378 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -89,6 +89,42 @@
 		};
 	};
 
+	reg_cam_avdd: cam-avdd {
+		compatible = "regulator-fixed";
+		regulator-name = "csi-avdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		startup-delay-us = <200>; /* 50 us + board delays */
+		enable-active-high;
+		gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
+	};
+
+	reg_cam_dovdd: cam-dovdd {
+		compatible = "regulator-fixed";
+		regulator-name = "csi-dovdd";
+		regulator-min-microvolt = <2800000>;
+		regulator-max-microvolt = <2800000>;
+		/*
+		 * This regulator also powers the pull-ups for the I2C bus.
+		 * For some reason, if this is turned off, subsequent use
+		 * of the I2C bus, even when turned on, does not work.
+		 */
+		startup-delay-us = <200>; /* 50 us + board delays */
+		regulator-always-on;
+		enable-active-high;
+		gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
+	};
+
+	reg_cam_dvdd: cam-dvdd {
+		compatible = "regulator-fixed";
+		regulator-name = "csi-dvdd";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		startup-delay-us = <200>; /* 50 us + board delays */
+		enable-active-high;
+		gpio = <&pio 3 14 GPIO_ACTIVE_HIGH>; /* PD14 */
+	};
+
 	reg_gmac_3v3: gmac-3v3 {
 		      compatible = "regulator-fixed";
 		      regulator-name = "gmac-3v3";
@@ -106,6 +142,26 @@
 	};
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
@@ -149,6 +205,37 @@
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
+		reset-gpios = <&pio 4 14 GPIO_ACTIVE_LOW>; /* PE14 */
+		powerdown-gpios = <&pio 4 15 GPIO_ACTIVE_HIGH>; /* PE15 */
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
