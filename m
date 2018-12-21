Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627BBC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:59:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C76021906
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 12:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FMwqUmfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C76021906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=u2Z+rMNlxkgfeLt2g5PMfi95+kxMsb8MjCZ9nho/Mzg=; b=FMwqUmfiN8x7LF
	iwnteyRVeRlfCI+Eo/BKQrgDuDn1SoAeLl+DsUyKKcA4/R1QDo6jTkw3Nn6OQweIXtlM0QjbVpGTM
	8B3Cq9jI5SFF03SzhsD9KcjAfHLWT6HsDpLKQJy2HxQeKUcfaWQQzAEu2aIm+7n0DVKDBWvoDS/Ga
	SQQoVSj3//1qQyOcAoq3adqjUjlk0lhkRZk+Fs4MCKVylJPIvgjlPlox2xhsj+9O9EdVWy8o2SW7o
	+nP6Px4L8xrhs8Ook0Wo/SAtT7sCeSKFaSDVkBghtRn7pBW/kzTihlwDYhrKJF3SqxYjdbRQLNxyC
	BeALZ3XbiCdrfjMmBexw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gaKP4-0001Xa-FA; Fri, 21 Dec 2018 12:59:46 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gaKOe-0001K5-2I; Fri, 21 Dec 2018 12:59:21 +0000
X-UUID: 42ca9e79d8af4e8fa2fc279d06fa8ea3-20181221
X-UUID: 42ca9e79d8af4e8fa2fc279d06fa8ea3-20181221
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw01.mediatek.com (envelope-from <qii.wang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 985126288; Fri, 21 Dec 2018 20:59:05 +0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 21 Dec 2018 20:59:03 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 21 Dec 2018 20:59:03 +0800
From: qii wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH 5/6] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Fri, 21 Dec 2018 20:58:30 +0800
Message-ID: <1545397111-24183-6-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
References: <1545397111-24183-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181221_045920_438920_B7DCCA2B 
X-CRM114-Status: UNSURE (   9.72  )
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
Cc: devicetree@vger.kernel.org, ryder.lee@mediatek.com, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, leilk.liu@mediatek.com,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add MT8183 i2c binding to binding file. Compare to 2712 i2c
controller, MT8183 has different registers, offsets, clock,
and multi-user function.

Signed-off-by: qii wang <qii.wang@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index ee4c324..0d29a5b 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
+++ b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
@@ -12,14 +12,15 @@ Required properties:
       "mediatek,mt7623-i2c", "mediatek,mt6577-i2c": for MediaTek MT7623
       "mediatek,mt7629-i2c", "mediatek,mt2712-i2c": for MediaTek MT7629
       "mediatek,mt8173-i2c": for MediaTek MT8173
+      "mediatek,mt8183-i2c": for MediaTek MT8183
   - reg: physical base address of the controller and dma base, length of memory
     mapped region.
   - interrupts: interrupt number to the cpu.
   - clock-div: the fixed value for frequency divider of clock source in i2c
     module. Each IC may be different.
   - clocks: clock name from clock manager
-  - clock-names: Must include "main" and "dma", if enable have-pmic need include
-    "pmic" extra.
+  - clock-names: Must include "main" and "dma", "arb" is optional, if enable
+    have-pmic need include "pmic" extra.
 
 Optional properties:
   - clock-frequency: Frequency in Hz of the bus when transfer, the default value
@@ -27,6 +28,7 @@ Optional properties:
   - mediatek,have-pmic: platform can control i2c form special pmic side.
     Only mt6589 and mt8135 support this feature.
   - mediatek,use-push-pull: IO config use push-pull mode.
+  - mediatek,share-i3c: i3c controller can share i2c function.
 
 Example:
 
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
