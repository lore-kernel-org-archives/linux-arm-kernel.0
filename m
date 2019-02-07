Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F140DC282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B739321904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:16:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3i32qhN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B739321904
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=0aFuqPH11lDQWpymLaaynGNZ/B/CU1aqNLgkdnHobH0=; b=f3i32qhNyCEuN6
	eVmejGUCGSQNAZn1PWT87hhi8KK32Vr2QFsclRBuue2ygvp0sn/MRpKboMdDniObYhqZncJ9Kd8Vs
	ywuBzj/Ys14Mh5rzAiiCA2+/pnx2dN7v8dbmd6tZyU6hkcEI7C5hgNbzfBIy4iNXY1qkFFPu/YRM0
	MnYkqMLlRc8IoqTbTqkXmIMGpS6rTCSoRABAWHQjF5ung885w+Q68YiCQSnzZq2JsppBO+ogwBY4o
	V3xihgCBvIDCDU95qoQ0p0vPJz1wCLmjHLPqlRtwypcsA69Gv+w/7DLAeUUtbO9BjJ2nbcX9z0pKQ
	SwJ1rNktQ+aG8B2atDHA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grgj2-0004oY-Mz; Thu, 07 Feb 2019 10:16:08 +0000
Received: from esa4.microchip.iphmx.com ([68.232.154.123])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grgj0-0004oE-E9
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 10:16:07 +0000
X-IronPort-AV: E=Sophos;i="5.58,343,1544511600"; d="scan'208";a="25952370"
Received: from smtpout.microchip.com (HELO email.microchip.com)
 ([198.175.253.82])
 by esa4.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA;
 07 Feb 2019 03:16:05 -0700
Received: from tenerife.corp.atmel.com (10.10.76.4) by
 chn-sv-exch03.mchp-main.com (10.10.76.49) with Microsoft SMTP Server id
 14.3.352.0; Thu, 7 Feb 2019 03:16:05 -0700
From: Nicolas Ferre <nicolas.ferre@microchip.com>
To: Ludovic Desroches <ludovic.desroches@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>, <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] ARM: dts: at91: sama5d2: add labels to soc dtsi for
 derivative boards
Date: Thu, 7 Feb 2019 11:15:47 +0100
Message-ID: <20190207101547.14602-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_021606_508198_FC2B1261 
X-CRM114-Status: UNSURE (   9.34  )
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
Cc: Eugen Hristev <eugen.hristev@microchip.com>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds labels to commonly used device-tree nodes so that derivative
boards can avoid ahb/apb hierarchy.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index d159ee42ef29..9519b9d5abca 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -688,13 +688,13 @@
 				ranges = <0 0xf8044000 0x1420>;
 			};
 
-			rstc@f8048000 {
+			reset_controller: rstc@f8048000 {
 				compatible = "atmel,sama5d3-rstc";
 				reg = <0xf8048000 0x10>;
 				clocks = <&clk32k>;
 			};
 
-			shdwc@f8048010 {
+			shutdown_controller: shdwc@f8048010 {
 				compatible = "atmel,sama5d2-shdwc";
 				reg = <0xf8048010 0x10>;
 				clocks = <&clk32k>;
@@ -710,7 +710,7 @@
 				clocks = <&pmc PMC_TYPE_CORE PMC_MCK2>;
 			};
 
-			watchdog@f8048040 {
+			watchdog: watchdog@f8048040 {
 				compatible = "atmel,sama5d4-wdt";
 				reg = <0xf8048040 0x10>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
