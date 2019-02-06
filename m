Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ED52C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:32:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C4BC2184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:32:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="N7ZQ2K5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C4BC2184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=BXRYWEJUrAGGG/KNoqsrjPO3JPyrQhZNMl4AHzhYlFs=; b=N7ZQ2K5eBP1Erx
	HXdN3hHhdH5VGOJ5Gl9ptDdNQD6by+7yYJd0n9aIk/NFc/zBRv1AcEqzyBSSaIVrE5XjKauPR0rxt
	BaK17g0hOFdJELj+aLZwM7+LfHupMcK+B1blHcLq97i2Fl/KjFssIOBpaqpbYmWssAP+H89F5Djbv
	2Tqb3AayfFvDN3KXd1P9nrhxTWQalmP59kSun7Vr1J0IkKVEovNpl6bFgj4j6QOAzKRDI46JCsdCo
	n/p7g4fq8ThZ6Eg0rW9vf3SCUS7McNLlMZx4hiwxei76L5q/ozLgRyZefDeE3njSJ2249aEXknm6E
	Zx04I2aexTBsWIRR9yVg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDxD-0002p7-G2; Wed, 06 Feb 2019 03:32:51 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxA-0002nu-56
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:49 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id A783E5FD06; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/9] ARM: dts: sun9i: a80-optimus: Add GPIO pin-bank regulator
 supplies
Date: Wed,  6 Feb 2019 11:32:33 +0800
Message-Id: <20190206033239.3619-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193248_324537_F26D5347 
X-CRM114-Status: UNSURE (   9.44  )
X-CRM114-Notice: Please train this message.
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
Cc: devicetree@vger.kernel.org, linux-sunxi@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The A80 Optimus has the PMIC providing voltage to all the pin-bank
supply rails from its various regulator outputs. All pin-banks that
have supply rails are accounted for. PN pin-bank does not have a
supply rail.

Also remove any "regulator-always-on" properties from regulators that
were only marked to provide pin-bank power.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 1ee2792b3a27..9c25176e69dc 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -172,10 +172,26 @@
 	clocks = <&ac100_rtc 0>;
 };
 
+&pio {
+	vcc-pa-supply = <&reg_ldo_io1>;
+	vcc-pb-supply = <&reg_aldo2>;
+	vcc-pc-supply = <&reg_dcdc1>;
+	vcc-pd-supply = <&reg_dcdc1>;
+	vcc-pe-supply = <&reg_eldo2>;
+	vcc-pf-supply = <&reg_dcdc1>;
+	vcc-pg-supply = <&reg_ldo_io0>;
+	vcc-ph-supply = <&reg_dcdc1>;
+};
+
 &r_ir {
 	status = "okay";
 };
 
+&r_pio {
+	vcc-pl-supply = <&reg_dldo2>;
+	vcc-pm-supply = <&reg_eldo3>;
+};
+
 &r_rsb {
 	status = "okay";
 
@@ -264,7 +280,6 @@
 			};
 
 			reg_dldo2: dldo2 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pl";
@@ -283,14 +298,12 @@
 			};
 
 			reg_eldo3: eldo3 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pm-codec-io1";
 			};
 
 			reg_ldo_io0: ldo_io0 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pg";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
