Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50679C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2241F2070B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="O4FlcBp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2241F2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=odpbSZ6mKHVm1vyoMshjf2JhaCGwpRr3yLFVAaSepnA=; b=O4FlcBp0d5Nsyy
	DeG4qKqg/5Mu9XqWRAhMk2A2Ejde3cWpGP9PBrc8OrbZnpouNOS+iY+WH7vhCzJhKaPFUoEqSW5vT
	ITa3GChrAu7+SCobAJi1MQEBwF98gPJcuNLmTByLHUOHIJi2wOOh1aBOQAYYnQmOtm+IgqQ1zHIVA
	OH3J+1zaPidOhiieQ6GoaT/raK8SpZC078o3D7h2RtGBYBVbTwEBimJocnMdRRzFJ0TxbliIL64ZS
	X/3Lu4/9if2Yx7ZSnU21Qr7U6ITEAjiUaW7i2+dsvCdi24TN7LrsLe/AHZsdu106xO/xqMGObVFkQ
	wMITucH2tATRiFl1kbCQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gty1u-0007rN-Bi; Wed, 13 Feb 2019 17:09:02 +0000
Received: from relay1.mentorg.com ([192.94.38.131])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gty1o-0007jn-4w; Wed, 13 Feb 2019 17:08:58 +0000
Received: from nat-ies.mentorg.com ([192.94.31.2]
 helo=SVR-IES-MBX-04.mgc.mentorg.com)
 by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
 id 1gty1m-000478-I0 from Akash_Gajjar@mentor.com ;
 Wed, 13 Feb 2019 09:08:54 -0800
Received: from eyas.local (137.202.0.90) by SVR-IES-MBX-04.mgc.mentorg.com
 (139.181.222.4) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 13 Feb
 2019 17:08:48 +0000
From: Akash Gajjar <Akash_Gajjar@mentor.com>
To: <heiko@sntech.de>
Subject: [PATCH 1/4] arm64: dts: rockchip: rockpro64 dts make regulator more
 readable
Date: Wed, 13 Feb 2019 22:36:37 +0530
Message-ID: <20190213170651.3210-2-Akash_Gajjar@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_090856_516400_8C9003FC 
X-CRM114-Status: GOOD (  15.06  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 Shohei Maruyama <cheat.sc.linux@outlook.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rob Herring <robh+dt@kernel.org>, Oskari Lemmela <oskari@lemmela.net>,
 Levin Du <djw@t-chip.com.cn>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

rename dc12, vcc_sys, vcc1v8_pmu regulators and make it more redable as per the
schematic of rk3399-rockpro64.

Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
---
 .../boot/dts/rockchip/rk3399-rockpro64.dts    | 62 +++++++++----------
 1 file changed, 31 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
index be78172abc09..49e83ba64045 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
@@ -25,15 +25,6 @@
 		#clock-cells = <0>;
 	};
 
-	dc_12v: dc-12v {
-		compatible = "regulator-fixed";
-		regulator-name = "dc_12v";
-		regulator-always-on;
-		regulator-boot-on;
-		regulator-min-microvolt = <12000000>;
-		regulator-max-microvolt = <12000000>;
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
@@ -83,6 +74,15 @@
 		reset-gpios = <&gpio0 RK_PB2 GPIO_ACTIVE_LOW>;
 	};
 
+	vcc12v_dcin: vcc12v-dcin {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc12v_dcin";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+	};
+
 	/* switched by pmic_sleep */
 	vcc1v8_s3: vcca1v8_s3: vcc1v8-s3 {
 		compatible = "regulator-fixed";
@@ -103,7 +103,7 @@
 		regulator-name = "vcc3v3_pcie";
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vcc3v3_sys: vcc3v3-sys {
@@ -113,7 +113,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
 	/* Actually 3 regulators (host0, 1, 2) controlled by the same gpio */
@@ -125,7 +125,7 @@
 		pinctrl-0 = <&vcc5v0_host_en>;
 		regulator-name = "vcc5v0_host";
 		regulator-always-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
 	vcc5v0_typec: vcc5v0-typec-regulator {
@@ -136,17 +136,17 @@
 		pinctrl-0 = <&vcc5v0_typec_en>;
 		regulator-name = "vcc5v0_typec";
 		regulator-always-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 
-	vcc_sys: vcc-sys {
+	vcc5v0_sys: vcc5v0-sys {
 		compatible = "regulator-fixed";
-		regulator-name = "vcc_sys";
+		regulator-name = "vcc5v0_sys";
 		regulator-always-on;
 		regulator-boot-on;
 		regulator-min-microvolt = <5000000>;
 		regulator-max-microvolt = <5000000>;
-		vin-supply = <&dc_12v>;
+		vin-supply = <&vcc12v_dcin>;
 	};
 
 	vdd_log: vdd-log {
@@ -157,7 +157,7 @@
 		regulator-boot-on;
 		regulator-min-microvolt = <800000>;
 		regulator-max-microvolt = <1400000>;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 	};
 };
 
@@ -230,18 +230,18 @@
 		rockchip,system-power-controller;
 		wakeup-source;
 
-		vcc1-supply = <&vcc_sys>;
-		vcc2-supply = <&vcc_sys>;
-		vcc3-supply = <&vcc_sys>;
-		vcc4-supply = <&vcc_sys>;
-		vcc6-supply = <&vcc_sys>;
-		vcc7-supply = <&vcc_sys>;
+		vcc1-supply = <&vcc5v0_sys>;
+		vcc2-supply = <&vcc5v0_sys>;
+		vcc3-supply = <&vcc5v0_sys>;
+		vcc4-supply = <&vcc5v0_sys>;
+		vcc6-supply = <&vcc5v0_sys>;
+		vcc7-supply = <&vcc5v0_sys>;
 		vcc8-supply = <&vcc3v3_sys>;
-		vcc9-supply = <&vcc_sys>;
-		vcc10-supply = <&vcc_sys>;
-		vcc11-supply = <&vcc_sys>;
+		vcc9-supply = <&vcc5v0_sys>;
+		vcc10-supply = <&vcc5v0_sys>;
+		vcc11-supply = <&vcc5v0_sys>;
 		vcc12-supply = <&vcc3v3_sys>;
-		vddio-supply = <&vcc1v8_pmu>;
+		vddio-supply = <&vcca_1v8>;
 
 		regulators {
 			vdd_center: DCDC_REG1 {
@@ -311,8 +311,8 @@
 				};
 			};
 
-			vcc1v8_pmu: LDO_REG3 {
-				regulator-name = "vcc1v8_pmu";
+			vcca_1v8: LDO_REG3 {
+				regulator-name = "vcca_1v8";
 				regulator-always-on;
 				regulator-boot-on;
 				regulator-min-microvolt = <1800000>;
@@ -413,7 +413,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
@@ -432,7 +432,7 @@
 		regulator-ramp-delay = <1000>;
 		regulator-always-on;
 		regulator-boot-on;
-		vin-supply = <&vcc_sys>;
+		vin-supply = <&vcc5v0_sys>;
 
 		regulator-state-mem {
 			regulator-off-in-suspend;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
