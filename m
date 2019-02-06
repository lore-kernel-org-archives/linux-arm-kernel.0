Return-Path: <SRS0=SkGj=QN=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD9BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:34:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C7ED218A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 03:34:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JbEv1/mM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C7ED218A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1G5SHjGZTfn2tbOXl1bXPShLB9Ntt9v2m1DoLYAQTU0=; b=JbEv1/mMimbGyf
	f7blTcTCjilb3L2wNeOnQLsKBB00BYF204brZGSJ/wSPyv+rW1uPvaNcAq1zcrka/2uzD2LvxyIcW
	7YL662KcQ6XeaERqNFYS6YcoQo5Sme9Ra/uuVR0zKJBCgEH/misQn/w4uItPHbeJmKvgO8vGBw83S
	hbIpnZRFAr4QA548+avTipB5ciC0LTYouoyvAI3pBS2IFLygJKySQDEyVfkMYh2MvicpUdxLla+YW
	NQZzhhe7NcsCUj9KXPcpVlSlKlwRlOZHYGN3XH9qCxfu2SQT9IdediomOAyQqtX/L4MxT3NGTKbJq
	Jc2QQSnWy29YCx8MNVvA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grDyw-0004T9-Ep; Wed, 06 Feb 2019 03:34:38 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grDxD-0002p6-4I
 for linux-arm-kernel@lists.infradead.org; Wed, 06 Feb 2019 03:32:53 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id D22B45FDB8; Wed,  6 Feb 2019 11:32:43 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>,
 Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 7/9] ARM: dts: sun9i: Add A80 GMAC RGMII pinmux setting
Date: Wed,  6 Feb 2019 11:32:37 +0800
Message-Id: <20190206033239.3619-8-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190206033239.3619-1-wens@csie.org>
References: <20190206033239.3619-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190205_193251_611987_72AAA246 
X-CRM114-Status: UNSURE (   8.92  )
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

The GMAC (gigabit ethernet controller) supports RGMII to connect to
the ethernet PHY, for gigabit network speeds.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index f0c7acf2d0a4..6fb292e0b662 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -1000,6 +1000,19 @@
 			#size-cells = <0>;
 			#gpio-cells = <3>;
 
+			gmac_rgmii_pins: gmac-rgmii-pins {
+				allwinner,pins = "PA0", "PA1", "PA2", "PA3",
+						 "PA4", "PA5", "PA7", "PA8",
+						 "PA9", "PA10", "PA12", "PA13",
+						 "PA15", "PA16", "PA17";
+				allwinner,function = "gmac";
+				/*
+				 * data lines in RGMII mode use DDR mode
+				 * and need a higher signal drive strength
+				 */
+				drive-strength = <40>;
+			};
+
 			i2c3_pins: i2c3-pins {
 				pins = "PG10", "PG11";
 				function = "i2c3";
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
