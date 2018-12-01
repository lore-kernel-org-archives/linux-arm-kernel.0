Return-Path: <SRS0=4WgJ=OK=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10EBCC04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:55:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D3FAC20867
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 13:55:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Cze3NP8w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3FAC20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zonque.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=TPhI/UQit9PlxMk+7OYBI3RhaZFU8057gPHzoLA8/W0=; b=Cze3NP8w5Le9s9
	omErG8yv8YVjkqUku/qXLIJorjurHuXqdbRbc74iBwegbkqaZ2k5p8WJRhPjFNLvLpHEsPwDI1ryg
	0mkjDLqBk7p1sR5KuJ0cylmzI4IXFQ9vEuZvWtPuZMNiEW9qcRP5aoHrFUImHvA/j2n4AKLHw1p1f
	LqDRv8LdDJ2Wet8RUFz624Yxg8BNtwgMJ5hq+rLdru5MNbKlk8HZ9HWpY/+ZhXQ0KHTfU+A6xmxuV
	GXRRAlcV/shgZ/5kb0sVNLSSCBQTuzVdcv7MPCzZHYzrLpaK9smdfnAJ4kZfXR/UjB9jr7ULG9DCw
	Jtx4rAlWjzK5JpY/FgFw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gT5jj-0002x5-LC; Sat, 01 Dec 2018 13:55:11 +0000
Received: from mail.bugwerft.de ([2a03:6000:1011::59])
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gT5jg-0001hs-Ix
 for linux-arm-kernel@lists.infradead.org; Sat, 01 Dec 2018 13:55:10 +0000
Received: from localhost.localdomain (p57BC9ACB.dip0.t-ipconnect.de
 [87.188.154.203])
 by mail.bugwerft.de (Postfix) with ESMTPSA id 74E962C47AF;
 Sat,  1 Dec 2018 13:54:39 +0000 (UTC)
From: Daniel Mack <daniel@zonque.org>
To: robert.jarzmik@free.fr,
	haojian.zhuang@gmail.com
Subject: [PATCH] ARM: dts: pxa: clean up USB controller nodes
Date: Sat,  1 Dec 2018 14:54:51 +0100
Message-Id: <20181201135451.3505-1-daniel@zonque.org>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181201_055508_767095_B50B1A99 
X-CRM114-Status: UNSURE (   9.61  )
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
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org,
 Daniel Mack <daniel@zonque.org>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

PXA25xx SoCs don't have a USB controller, so drop the node from the
common pxa2xx.dtsi base file. Both pxa27x and pxa3xx have a dedicated
node already anyway.

While at it, unify the names for the nodes across all pxa platforms.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Reported-by: Sergey Yanovich <ynvich@gmail.com>
Link: https://patchwork.kernel.org/patch/8375421/
---
 arch/arm/boot/dts/pxa27x.dtsi | 2 +-
 arch/arm/boot/dts/pxa2xx.dtsi | 7 -------
 arch/arm/boot/dts/pxa3xx.dtsi | 2 +-
 3 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 3228ad5fb725..ccbecad9c5c7 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -35,7 +35,7 @@
 			clocks = <&clks CLK_NONE>;
 		};
 
-		pxa27x_ohci: usb@4c000000 {
+		usb0: usb@4c000000 {
 			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
diff --git a/arch/arm/boot/dts/pxa2xx.dtsi b/arch/arm/boot/dts/pxa2xx.dtsi
index 30e77ebbcc4d..e83879d97aea 100644
--- a/arch/arm/boot/dts/pxa2xx.dtsi
+++ b/arch/arm/boot/dts/pxa2xx.dtsi
@@ -134,13 +134,6 @@
 			status = "disabled";
 		};
 
-		usb0: ohci@4c000000 {
-			compatible = "marvell,pxa-ohci";
-			reg = <0x4c000000 0x10000>;
-			interrupts = <3>;
-			status = "disabled";
-		};
-
 		mmc0: mmc@41100000 {
 			compatible = "marvell,pxa-mmc";
 			reg = <0x41100000 0x1000>;
diff --git a/arch/arm/boot/dts/pxa3xx.dtsi b/arch/arm/boot/dts/pxa3xx.dtsi
index d9f7c68479ab..e1e607f53ce6 100644
--- a/arch/arm/boot/dts/pxa3xx.dtsi
+++ b/arch/arm/boot/dts/pxa3xx.dtsi
@@ -202,7 +202,7 @@
 			status = "disabled";
 		};
 
-		pxa3xx_ohci: usb@4c000000 {
+		usb0: usb@4c000000 {
 			compatible = "marvell,pxa-ohci";
 			reg = <0x4c000000 0x10000>;
 			interrupts = <3>;
-- 
2.19.2


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
