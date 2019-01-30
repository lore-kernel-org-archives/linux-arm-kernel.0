Return-Path: <SRS0=csPt=QG=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF01C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDC021852
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 08:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EygGdxHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDC021852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=E1Uk7Dpv2dRBcH14S1CHs9frjur1+AKr30lFX8Qk0AA=; b=EygGdxHr4mM6VY
	M15/3Ivzfr+CuhZAQ3ol/H80iC7+7Lm2kQ3bFHgu4ztdBhYDBmZlhqYuNjt1vWtLNP/lXrWKHubHe
	viRpkvOwvTu5no9I2I4sIF/4T7QW9ty1ptdlgalsJ4ZXXM/GOzfr4VVAIjx4Vi3IwkCE5iwsLO6Rs
	akqmn6VcZYR+UHKq4B4v42gqmLPTnF3/v3TWUgjX+K9RuluI246xQrAblaYCf+Cjrh5FSLugSalAX
	SuM7lH0DHq5UHxR2vMKE5+eyW+TGabdKXKfZniOat+KMcQ/6LIuZDy34o2yGWoT5WkIsQ/nNZSumP
	mvH8CYVfLnM146WouyqA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1golSF-0002Qs-Ry; Wed, 30 Jan 2019 08:42:43 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1golRw-0002Co-T2
 for linux-arm-kernel@lists.infradead.org; Wed, 30 Jan 2019 08:42:26 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id C130D5FD01; Wed, 30 Jan 2019 16:42:17 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 02/10] ARM: dts: bananapi-m2-plus: Add CPU supply regulator
Date: Wed, 30 Jan 2019 16:41:55 +0800
Message-Id: <20190130084203.25053-3-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190130084203.25053-1-wens@csie.org>
References: <20190130084203.25053-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190130_004225_129260_3DFE956F 
X-CRM114-Status: GOOD (  11.71  )
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
Cc: devicetree@vger.kernel.org, Sergey Matyukevich <geomatsi@gmail.com>,
 Andre Przywara <andre.przywara@arm.com>, Chen-Yu Tsai <wens@csie.org>,
 linux-kernel@vger.kernel.org, Emmanuel Vadot <manu@freebsd.org>,
 linux-sunxi@googlegroups.com, Jagan Teki <jagan@amarulasolutions.com>,
 Hauke Mehrtens <hauke@hauke-m.de>, linux-arm-kernel@lists.infradead.org,
 Icenowy Zheng <icenowy@aosc.io>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The original Bananapi M2+ uses a fixed regulator to supply the CPU
cores. According to Bananapi, the retail v1.1 version is designed to
supply 1.3V. Actual measurements show 1.310V. Earlier engineering
samples had it at 1.4V, but this is not covered here.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 .../boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi | 30 +++++++------------
 arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi | 14 +++++++++
 2 files changed, 25 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
index a567567763f4..39834329b6ae 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus-v1.2.dtsi
@@ -5,27 +5,19 @@
 
 #include "sunxi-bananapi-m2-plus.dtsi"
 
-/ {
+&reg_vdd_cpux {
 	/*
 	 * Bananapi M2+ v1.2 uses a GPIO line to change the effective
 	 * resistance on the CPU regulator's feedback pin.
 	 */
-	reg_vdd_cpux: vdd-cpux {
-		compatible = "regulator-gpio";
-		regulator-name = "vdd-cpux";
-		regulator-type = "voltage";
-		regulator-boot-on;
-		regulator-always-on;
-		regulator-min-microvolt = <1108475>;
-		regulator-max-microvolt = <1308475>;
-		regulator-ramp-delay = <50>; /* 4ms */
-		gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
-		gpios-states = <0x1>;
-		states = <1108475 0x0
-			  1308475 0x1>;
-	};
-};
-
-&cpu0 {
-	cpu-supply = <&reg_vdd_cpux>;
+	compatible = "regulator-gpio";
+	regulator-type = "voltage";
+	regulator-min-microvolt = <1108475>;
+	regulator-max-microvolt = <1308475>;
+	regulator-ramp-delay = <50>; /* 4ms */
+	enable-gpios =  <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	gpios = <&r_pio 0 1 GPIO_ACTIVE_HIGH>; /* PL1 */
+	gpios-states = <0x1>;
+	states = <1108475 0x0
+		  1308475 0x1>;
 };
diff --git a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
index 3bed375b9c03..eb90f53ae958 100644
--- a/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
+++ b/arch/arm/boot/dts/sunxi-bananapi-m2-plus.dtsi
@@ -99,6 +99,16 @@
 		      gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>;
 	};
 
+	reg_vdd_cpux: vdd-cpux {
+		compatible = "regulator-fixed";
+		regulator-name = "vdd-cpux";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1310000>;
+		regulator-max-microvolt = <1310000>;
+		gpios = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		pinctrl-names = "default";
@@ -108,6 +118,10 @@
 	};
 };
 
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
 &de {
 	status = "okay";
 };
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
