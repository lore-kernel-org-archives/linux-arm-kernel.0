Return-Path: <SRS0=7SPH=QW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D27C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:52:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06B221B18
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 11:52:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VgqBoYgN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06B221B18
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=olimex.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=JFugdJIFsf3lfEbtxviefiERkDulxxZh0nVOvRULRug=; b=VgqBoYgNA1U+vjftVqrbIe6icp
	Ts25UZrutT0L4T5uZ4aFIbYBzO1JJ6BB8/K97+JLUVgNuIn6omnpzDCNlxVGk7XLJeKBQiDbm3bhE
	WGmrd1iQjHNaFVn3nKm96nB/tdUke7w9stiOa5T2GPunAjf+YFozvUdYTsv4kDTwnTKZEyq63RL8+
	a3s//dszRQ+PaEzjw8nGeeNFhi/6fN0AlyDKGJCU61kDZftz5+1qI28EiP7Zm4+rmX6JToyF0MUvR
	kYICPmuXpMx9NU23oEJN7XJ7jgrYvnoxK8lLCqnKsZGpaxt6f1vvNEI0Q2XP9DLV9CJksY+VUt71V
	RXYokghw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guc2H-0000Dm-Uu; Fri, 15 Feb 2019 11:52:05 +0000
Received: from olimex.com ([184.105.72.32])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guc1M-0007ev-Aq
 for linux-arm-kernel@lists.infradead.org; Fri, 15 Feb 2019 11:51:24 +0000
Received: from localhost.localdomain ([195.238.85.143])
 by olimex.com with ESMTPSA
 (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD)
 (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
 for <linux-arm-kernel@lists.infradead.org>; Fri, 15 Feb 2019 03:50:57 -0800
From: Stefan Mavrodiev <stefan@olimex.com>
To: Jacek Anaszewski <jacek.anaszewski@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@bootlin.com>,
 Lee Jones <lee.jones@linaro.org>,
 linux-leds@vger.kernel.org (open list:LED SUBSYSTEM),
 devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE
 BINDINGS), 
 linux-kernel@vger.kernel.org (open list:X-POWERS MULTIFUNCTION PMIC DEVICE
 DRIVERS), 
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Allwinner sunXi SoC
 support)
Subject: [PATCH v2 7/8] ARM: dts: sun7i: Enable AXP209 CHGLED for Olimex boards
Date: Fri, 15 Feb 2019 13:50:12 +0200
Message-Id: <20190215115013.11098-8-stefan@olimex.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190215115013.11098-1-stefan@olimex.com>
References: <20190215115013.11098-1-stefan@olimex.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190215_035108_596060_012E0F03 
X-CRM114-Status: GOOD (  10.73  )
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
Cc: Stefan Mavrodiev <stefan@olimex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Olimex A20-OLinuXino based boards (MICRO, SOM, SOM204, LIME2)
commes with populated LED connected to AXP209.

By default the LED is controlled by AXP209, so this binding
actually doesn't modify any registers. However this can can be
used as general purpose LED, if the control mode is overridden.

Also this binding is enabled only for OLIMEX boards, since I have
no knowlegde if the other manifactures are populating this LED.

Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
---
 arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts    | 6 ++++++
 arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts | 6 ++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts   | 6 ++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts   | 6 ++++++
 4 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
index f0e6a96e5785..677ee1c2795a 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
@@ -243,6 +243,12 @@
 
 #include "axp209.dtsi"
 
+&axp_led {
+	label = "a20-olimex-som-evb:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
index 823aabce0462..31a3ab5ad4e3 100644
--- a/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olimex-som204-evb.dts
@@ -205,6 +205,12 @@
 	status = "okay";
 };
 
+&axp_led {
+	label = "a20-som204-evb:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &battery_power_supply {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
index 4e1c590eb098..66dd80ced1fa 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-lime2.dts
@@ -200,6 +200,12 @@
 
 #include "axp209.dtsi"
 
+&axp_led {
+	label = "a20-olinuxino-lime2:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 840ae1194a66..700de909eb49 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -272,6 +272,12 @@
 	status = "okay";
 };
 
+&axp_led {
+	label = "a20-olinuxino-micro:yellow:chgled";
+	status = "okay";
+	x-powers,charger-mode = <0>;
+};
+
 &battery_power_supply {
 	status = "okay";
 };
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
