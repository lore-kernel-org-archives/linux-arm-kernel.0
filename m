Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0715C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:34:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFE852184E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Od2YbRSg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFE852184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RT9FfHe4/gsX377lG+moaLh/QwesmEmMHPts3TJnddA=; b=Od2YbRSgPfQylf
	syp4m86lmZ0zNaVOV1R3nzGMMvJf48ceTO9IMG43pqw2Vt97FIHlSkcJUzlSQsydgAiUMLKpXYsu6
	zAJQ9N2mKyI2QGlF/4oZ1QBDaUpY8JwdjZl1kjLFEmA6yvjmrihS5EgbdYhAObmDeON0Cth17fWcr
	Kbo1XpGMqQACZOwECFKtUiE/A4Mjn6mnoihaPy5iV7b1Mk01Nn6voEoIAmDP6O/AxyrVj4QRVzjW8
	r/53AqsZAryfU/yi5gVuzD4qHbeWpKrzYpGEFCGK/gTFF/OZbFoGl3+FMl6bQQSx4wQTJnh0uuQja
	cZYIBj7fPzzg1QynescA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDyj-0004H0-Uy; Wed, 06 Feb 2019 03:34:25 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxD-0002p4-58
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:55 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id DB8975FDD0; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 8/9] ARM: dts: sun9i: a80-optimus: Enable GMAC
Date: Wed,  6 Feb 2019 11:32:38 +0800
Message-Id: <20190206033239.3619-9-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193251_564926_5ADE0BF0 
X-CRM114-Status: GOOD (  11.11  )
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

The A80 Optimus has a Realtek RTL8211E ethernet PHY which uses RGMII to
talk to the MAC. The PHY is powered by 2 regulators: cldo1 for the PHY's
core logic and gpio1-ldo for I/O. The latter also powers the SoC side
pins. As there is no binding to model a second regulator supply for the
PHY, it is omitted. It is however properly modeled for the PIO.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 9c25176e69dc..864715ec3cb0 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -120,6 +120,19 @@
 	status = "okay";
 };
 
+&gmac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&gmac_rgmii_pins>;
+	phy = <&phy1>;
+	phy-mode = "rgmii";
+	phy-supply = <&reg_cldo1>;
+	status = "okay";
+
+	phy1: ethernet-phy@1 {
+		reg = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
@@ -391,6 +404,14 @@
 				 */
 				regulator-min-microvolt = <3300000>;
 				regulator-max-microvolt = <3300000>;
+				/*
+				 * The PHY requires 20ms after all voltages
+				 * are applied until core logic is ready and
+				 * 30ms after the reset pin is de-asserted.
+				 * Set a 100ms delay to account for PMIC
+				 * ramp time and board traces.
+				 */
+				regulator-enable-ramp-delay = <100000>;
 				regulator-name = "vcc-gmac-phy";
 			};
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
