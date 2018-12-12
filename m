Return-Path: <SRS0=fRgi=OV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 909B7C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5702A2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 09:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VBoTgJJZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5702A2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=h5d6LBWKhXZCHe7uD8gwN5OYI3VtH0ScH9Nxw69X6VI=; b=VBoTgJJZGmPfkO
	fvHzDDrHOMkfcUD6vJK4rklhSO7oXvmu45NowhOHK3GII2lNzdVdX+4fYReQ5FaCRHVpcBBqVooA2
	u0gG+vRq9D+bhTAB458/0oEb9uQWlzjPFGJju31lajJPBFJkph66ld3SgZSIyE8TtOQ+9TgweQz6d
	zTRvY1QZkZKTwkozVBB9EsuYWx0QHWrgCNZc1Qf85fPZuGtJPlgFlYIDNWfn2MEUbQtGIuA9eRPUA
	ZuNuXeRntW1SDvNRBjm3pPiyXffQ9c3mFyjZPH+Mst2TWpUYTj0OlhDYE8W/msdugGfM4Xb7QzwgG
	G2OgFK5gK2WKHY2ujB1w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gX1IU-00082k-3C; Wed, 12 Dec 2018 09:59:18 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gX1IR-000826-Aj; Wed, 12 Dec 2018 09:59:16 +0000
X-UUID: 17f31f2f67324714a4f79407f16a066d-20181212
X-UUID: 17f31f2f67324714a4f79407f16a066d-20181212
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by
 mailgw01.mediatek.com (envelope-from <ryder.lee@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 646566370; Wed, 12 Dec 2018 17:59:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Dec 2018 17:58:59 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Wed, 12 Dec 2018 17:58:59 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Linus Walleij <linus.walleij@linaro.org>, Sean Wang <sean.wang@kernel.org>
Subject: [PATCH] pinctrl: mediatek: improve dependencies for PINCTRL_MTK_MOORE
Date: Wed, 12 Dec 2018 17:58:52 +0800
Message-ID: <d80dd05f6dbfc8fe7e85509cc00ebd8ec739b4d2.1544608681.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_015915_491896_D666F5AD 
X-CRM114-Status: UNSURE (   7.05  )
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
Cc: devicetree@vger.kernel.org, Ryder Lee <ryder.lee@mediatek.com>,
 Weijie Gao <weijie.gao@mediatek.com>, linux-kernel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Improve dependencies for the pinctrl drivers which select
PINCTRL_MTK_MOORE as its core layer.
---
 drivers/pinctrl/mediatek/Kconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index d8cb584..3a41dc8 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -23,6 +23,7 @@ config PINCTRL_MTK_MOORE
 	select GENERIC_PINCTRL_GROUPS
 	select GENERIC_PINMUX_FUNCTIONS
 	select GPIOLIB
+	select EINT_MTK
 	select OF_GPIO
 
 config PINCTRL_MTK_PARIS
@@ -45,14 +46,14 @@ config PINCTRL_MT2701
 config PINCTRL_MT7623
 	bool "Mediatek MT7623 pin control with generic binding"
 	depends on MACH_MT7623 || COMPILE_TEST
-	depends on PINCTRL_MTK_MOORE
-	default y
+	default MACH_MT7623
+	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT7629
 	bool "Mediatek MT7629 pin control"
 	depends on MACH_MT7629 || COMPILE_TEST
-	depends on PINCTRL_MTK_MOORE
-	default y
+	default MACH_MT7629
+	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT8135
 	bool "Mediatek MT8135 pin control"
@@ -93,8 +94,8 @@ config PINCTRL_MT6797
 config PINCTRL_MT7622
 	bool "MediaTek MT7622 pin control"
 	depends on ARM64 || COMPILE_TEST
-	depends on PINCTRL_MTK_MOORE
-	default y
+	default ARM64 && ARCH_MEDIATEK
+	select PINCTRL_MTK_MOORE
 
 config PINCTRL_MT8173
 	bool "Mediatek MT8173 pin control"
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
