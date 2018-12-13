Return-Path: <SRS0=qRPW=OW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39CDC6786C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:28:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7435B20870
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 02:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="TWeIh1ua"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7435B20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=xzkOpSiWRyt3trh8bs5fp0v4X4eXbscqo35kxTU6Wxw=; b=TWeIh1ua5L0kSX
	Z0GBWgLtHV315kmJnVWt4HkkCGCcg9gau0sxyNUGHwOIntSe/gIF1CRnhSFYuG7jQ8OsUfxD6fqsM
	ife/1eqS0ILNf3Xd3GWj9Ez2IYIRjFi0ZYK6zuEzGfrr0VqwzFmXUDnIhvfai1BqthQemZs6nsxm5
	QzgRK+IeX6aX6xEL/pxn4YRiz3PH7WLPTxGBVLzzifL07+kUeSul1L0J8eP09dEMvswGMm1QAh6q+
	7zeyx0VkP8i6KO5Pjv0ufeFTRVGU5EWqYSinCMuUppRD7MyMql0uzDXx22ATNd1sFVrasfmhN/6ix
	GZ2ISs3xyeGHwIh8qPkg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXGjf-0001ui-Cg; Thu, 13 Dec 2018 02:28:23 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXGjc-0001t9-9V; Thu, 13 Dec 2018 02:28:21 +0000
X-UUID: c0a92660643d46bdae0eddd384e92c5a-20181213
X-UUID: c0a92660643d46bdae0eddd384e92c5a-20181213
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 61952231; Thu, 13 Dec 2018 10:27:56 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 13 Dec 2018 10:27:54 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 13 Dec 2018 10:27:54 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Linus Walleij <linus.walleij@linaro.org>, Sean Wang <sean.wang@kernel.org>
Subject: [PATCH v1] pinctrl: mediatek: improve Kconfig dependencies
Date: Thu, 13 Dec 2018 10:27:50 +0800
Message-ID: <e4eb66dec2901016e01767932461c5d560762f66.1544666839.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 74EC1AB088B4CA87EB1FB2653C89E3A127430D56A4982A245F8657EB419E777A2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181212_182820_457022_F1666D66 
X-CRM114-Status: UNSURE (   7.36  )
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

Remove prompts to make all pinctrl cores to non-visible symbols and
make sure the target SoCs would be coupled with the corresponding
cores.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
Changes since v1:
- Revise commit message
- Change all pinctrl cores to non-visible symbols
- Drop EINT_MTK in PINCTRL_MTK_MOORE
---
 drivers/pinctrl/mediatek/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pinctrl/mediatek/Kconfig b/drivers/pinctrl/mediatek/Kconfig
index d8cb584..1817786 100644
--- a/drivers/pinctrl/mediatek/Kconfig
+++ b/drivers/pinctrl/mediatek/Kconfig
@@ -17,7 +17,7 @@ config PINCTRL_MTK
 	select OF_GPIO
 
 config PINCTRL_MTK_MOORE
-	bool "MediaTek Moore Core that implements generic binding"
+	bool
 	depends on OF
 	select GENERIC_PINCONF
 	select GENERIC_PINCTRL_GROUPS
@@ -26,7 +26,7 @@ config PINCTRL_MTK_MOORE
 	select OF_GPIO
 
 config PINCTRL_MTK_PARIS
-	bool "MediaTek Paris Core that implements vendor binding"
+	bool
 	depends on OF
 	select PINMUX
 	select GENERIC_PINCONF
@@ -45,14 +45,14 @@ config PINCTRL_MT2701
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
@@ -93,8 +93,8 @@ config PINCTRL_MT6797
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
