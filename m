Return-Path: <SRS0=3RVO=RB=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56C0C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:47:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732A2217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 06:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="OS9msIAq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732A2217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tkos.co.il
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Q2Ybw8oCOoI2eFZ5MLMidarF76L5TPByrLFpqVJQFts=; b=OS9msIAqKbmzow
	WLtzA6k+vmLoxBjV9G9PiqR5B8oW7URNt4FO8JIdH2EE+aotj4Vay/xPADJur74cEZmhUb8E5A/AI
	Qquwf4UcA4FuAZlIEKkEBz1KXFczrWpoy4995af2MzayCrTSd6lbJU/eJuN+x2hyzULl90j1LRStY
	VbmlPS6FhoYZ4zFW/rri8SBtZdgU2oOanWLbRBgsEj7/EKDO77W5+O/2xAlhLoIDdVBc4J26efVA1
	sNganEoBj4LpwakaWD2xihmC9uYh+RsqbuRX5pBBr6en+johODWSPMXens7EQlIv/UV4+ncYNy0dk
	uMWGxh3u2Xis/UjXB7pw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gyWW8-00016S-Rr; Tue, 26 Feb 2019 06:47:04 +0000
Received: from guitar.tcltek.co.il ([192.115.133.116] helo=mx.tkos.co.il)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gyWW4-000164-VH
 for linux-arm-kernel@lists.infradead.org; Tue, 26 Feb 2019 06:47:03 +0000
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx.tkos.co.il (Postfix) with ESMTPS id 98A1F4403CA;
 Tue, 26 Feb 2019 08:46:56 +0200 (IST)
From: Baruch Siach <baruch@tkos.co.il>
To: Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: [PATCH] arm64: dts: clearfog-gt-8k: add wlan_disable signal hog
Date: Tue, 26 Feb 2019 08:46:11 +0200
Message-Id: <936a9930fee3f285ee5538205181ca2ef1f5cbe5.1551163571.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190225_224701_232554_76EA1629 
X-CRM114-Status: GOOD (  11.40  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Baruch Siach <baruch@tkos.co.il>, Thomas Schreiber <tschreibe@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Thomas Schreiber <tschreibe@gmail.com>

There is currently no DT binding for GPIO rfkill signals. To make
mini-PCIe attached WiFi devices work, use gpio-hog to hold the
wlan_disable signal de-asserted.

Signed-off-by: Thomas Schreiber <tschreibe@gmail.com>
[baruch: add pinctrl node; rename tag]
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 .../boot/dts/marvell/armada-8040-clearfog-gt-8k.dts | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
index 2468762283a5..9143aa13ceb1 100644
--- a/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
+++ b/arch/arm64/boot/dts/marvell/armada-8040-clearfog-gt-8k.dts
@@ -226,6 +226,11 @@
 		marvell,function = "gpio";
 	};
 
+	cp0_wlan_disable_pins: wlan-disable-pins {
+		marvell,pins = "mpp51";
+		marvell,function = "gpio";
+	};
+
 	cp0_sdhci_pins: sdhci-pins {
 		marvell,pins = "mpp55", "mpp56", "mpp57", "mpp58", "mpp59",
 			       "mpp60", "mpp61";
@@ -235,7 +240,7 @@
 
 &cp0_pcie0 {
 	pinctrl-names = "default";
-	pinctrl-0 = <&cp0_pci0_reset_pins>;
+	pinctrl-0 = <&cp0_pci0_reset_pins &cp0_wlan_disable_pins>;
 	reset-gpios = <&cp0_gpio2 0 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
@@ -253,6 +258,12 @@
 		output-low;
 	};
 
+	wlan_disable {
+		gpio-hog;
+		gpios = <19 GPIO_ACTIVE_LOW>;
+		output-low;
+	};
+
 	lte_disable {
 		gpio-hog;
 		gpios = <21 GPIO_ACTIVE_LOW>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
