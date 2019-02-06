Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281AEC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC4472184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mHw8C/nV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC4472184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TadzEQwbZjiA3FOnBrnnYF2wf9rYchg1uULyirDjRac=; b=mHw8C/nVUY7CBC
	ub8Zqp/8f3hO732hwK9Jy3mQOdkP6S25uT8LfR9EOYsFL7/TPup9Ux3a5poRyBIFuk4FXZDWOGC1f
	YeLJsdxVkx0ToF3hOpYZT8NyUlLl62Dxg2afrE7xNL9IKDAsYWbuU+R7wgr22OKp7adsoS0w/qHhb
	ik+i/2jes1I/MFv+RRH2tlsRlCMhH6LJKcLox3/hU4pnGIkIjrhgyHTsyyiVemC5FEtoquPv7Sx7y
	Gq6Z3uK6lLvLXYL/UptaNxHnQw/py+mw/JyxNqVWSpb7qL/1xXqSfq6DZN/2N0GDtU3aYhpIpr7a1
	7JX6+/ROpivWfhAl4V/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDyD-0003mm-1X; Wed, 06 Feb 2019 03:33:53 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxA-0002nv-55
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:51 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id B85305FD5D; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 4/9] ARM: dts: sun9i: cubieboard4: Add GPIO pin-bank regulator
 supplies
Date: Wed,  6 Feb 2019 11:32:34 +0800
Message-Id: <20190206033239.3619-5-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193248_356241_A8DF4B29 
X-CRM114-Status: UNSURE (   9.57  )
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

The Cubieboard 4 has the PMIC providing voltage to all the pin-bank
supply rails from its various regulator outputs. All pin-banks that
have supply rails are accounted for. PN pin-bank does not have a
supply rail.

Also remove any "regulator-always-on" properties from regulators that
were only marked to provide pin-bank power.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-cubieboard4.dts | 23 ++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
index 85da85faf869..0daab9b374e6 100644
--- a/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
+++ b/arch/arm/boot/dts/sun9i-a80-cubieboard4.dts
@@ -183,10 +183,26 @@
 	clocks = <&ac100_rtc 0>;
 };
 
+&pio {
+	vcc-pa-supply = <&reg_ldo_io1>;
+	vcc-pb-supply = <&reg_aldo2>;
+	vcc-pc-supply = <&reg_dcdc1>;
+	vcc-pd-supply = <&reg_dc1sw>;
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
 
@@ -217,6 +233,10 @@
 				/* unused */
 			};
 
+			reg_dc1sw: dc1sw {
+				regulator-name = "vcc-pd";
+			};
+
 			reg_dc5ldo: dc5ldo {
 				regulator-always-on;
 				regulator-min-microvolt = <800000>;
@@ -271,7 +291,6 @@
 			};
 
 			reg_dldo2: dldo2 {
-				regulator-always-on;
 				regulator-min-microvolt = <3000000>;
 				regulator-max-microvolt = <3000000>;
 				regulator-name = "vcc-pl";
@@ -290,14 +309,12 @@
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
