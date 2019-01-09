Return-Path: <SRS0=Odjb=PR=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92444C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63058206BB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 15:03:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Jx+aO+on"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63058206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csie.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=iUS6a1R/io8IHi6OAbOMF9nQmRAE9hHMPbMXfvUIfEM=; b=Jx+aO+onJNBR0B
	z+veCl/kaZdabc07o8CJbq0U6Q8sIvGBsrYf9iAK4k2VWV/bnr1HZNsY7D6l7sXcfU3T2C/nRL7jR
	wM0cxTzzNqzoqfYsoEp9E8NN8fKbVpImnzX4e09npPbwTKLF26ifa+DMrZHVUknneS8emIzEmTQHq
	/sNABhfsdeCvYwvAqQ0uVV3xqNRSINOthDXHzzLM2bBs61iz+fo9JwW4IFTv43CiNVDVBGtgXbFP2
	wqVm0mIQcmTTgUA+aoUW4H0AchIIGwSgYjJzWnb666QgBfLhV9RhyZwUS/dTcEsgOEzyAmgOXAirW
	9wuscLuKFnvh2Tc0PsJg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ghFOP-00027H-18; Wed, 09 Jan 2019 15:03:41 +0000
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76] helo=wens.csie.org)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ghFNo-0001WX-Qf
 for linux-arm-kernel@lists.infradead.org; Wed, 09 Jan 2019 15:03:07 +0000
Received: by wens.csie.org (Postfix, from userid 1000)
 id 523375FCE1; Wed,  9 Jan 2019 23:03:00 +0800 (CST)
From: Chen-Yu Tsai <wens@csie.org>
To: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: [PATCH 3/5] ARM: dts: sun8i: r40: bananapi-m2-ultra: Fix WiFi
 regulator definitions
Date: Wed,  9 Jan 2019 23:02:55 +0800
Message-Id: <20190109150257.12602-4-wens@csie.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190109150257.12602-1-wens@csie.org>
References: <20190109150257.12602-1-wens@csie.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190109_070304_999592_1EAD71E9 
X-CRM114-Status: GOOD (  13.22  )
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
 linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The design of the Bananapi M2 Ultra has both DLDO1 and DLDO2 regulators
provide power to the WiFi+BT module, which is based on the Broadcom
BCM43438 or BCM43430 chip. Each regulator output from the PMIC can supply
up to 200 mA. The datasheet of the chip suggests a maximum power draw of
up to 360 mA when transmitting, thus requiring two outputs from the PMIC
to handle the load. However the device tree only references one of them,
leaving the other unused and possibly turned off.

This patch marks both as always-on, since we don't have a proper binding
to specify two regulators as "bound together". The name and constraints
of DLDO2 are also added.

Fixes: da7ac948fa93 ("ARM: dts: sun8i: Add board dts file for Banana Pi M2
		      Ultra")
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index 438b7b44dab3..1a6794e63b90 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -250,12 +250,27 @@
 	regulator-name = "vcc-wifi-io";
 };
 
+/*
+ * Our WiFi chip needs both DLDO2 and DLDO3 to be powered at the same
+ * time, with the two being in sync, to be able to meet maximum power
+ * consumption during transmits. Since this is not really supported
+ * right now, just use the two as always on, and we will fix it later.
+ */
+
 &reg_dldo2 {
+	regulator-always-on;
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
 	regulator-name = "vcc-wifi";
 };
 
+&reg_dldo3 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi-2";
+};
+
 &reg_dldo4 {
 	regulator-min-microvolt = <2500000>;
 	regulator-max-microvolt = <2500000>;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
