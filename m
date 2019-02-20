Return-Path: <SRS0=0Bxu=Q3=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCF4C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:34:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1B52086C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="G8s46qDC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1B52086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=o8SHAge64635AApqmsaE43OAwOOE/1TIFVeIVMSEDp8=; b=G8s46qDCTzYWHW
	uVRDS1M4L6w4V55WCMnBZmXdwIAdOjm8RbYfcIhHoj57DStvSAH52kr9JXqHSu7tB2XI+eivpDnNY
	2UF/K91RfKHjaHv3y7OGvYEydV56ArZDckLGx5nRN2wynhes+eE0NtK0CDhle5V2no+MucAr4OIFq
	3PkemlP14mDhYkdR1aDHcrU//RisYdl8i1oAShzW3LMXR3xJl8twlGfat1cNev5pQeSS+XBvkHR29
	NVfd1vU+/8uuZDbNvZzo++v2dvvcO3kmU7F/Hrhw+kvZ17SIGP2NwWuKb2cRIJ1CVEmDY13I1M57H
	rFQ8DzhhZtLCKsJv79rg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwR5G-0002cv-CJ; Wed, 20 Feb 2019 12:34:42 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwR4w-0002IN-9J; Wed, 20 Feb 2019 12:34:23 +0000
X-UUID: 0583a4046542400cbd147084dd3b318d-20190220
X-UUID: 0583a4046542400cbd147084dd3b318d-20190220
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw01.mediatek.com
 (envelope-from <qii.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1301745843; Wed, 20 Feb 2019 04:34:08 -0800
Received: from mtkmbs03n2.mediatek.inc (172.21.101.182) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 04:34:07 -0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs03n2.mediatek.inc (172.21.101.182) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 20 Feb 2019 20:34:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 20 Feb 2019 20:34:05 +0800
From: Qii Wang <qii.wang@mediatek.com>
To: <wsa@the-dreams.de>
Subject: [PATCH v4 2/3] dt-bindings: i2c: Add Mediatek MT8183 i2c binding
Date: Wed, 20 Feb 2019 20:33:49 +0800
Message-ID: <1550666030-30211-3-git-send-email-qii.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
References: <1550666030-30211-1-git-send-email-qii.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 268D3C975B3C30F8E6D6788EC07EF70938B455D6E0F386A5B60362569CB7C92B2000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_043422_325745_5902ECC0 
X-CRM114-Status: GOOD (  10.00  )
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
Cc: devicetree@vger.kernel.org, qii.wang@mediatek.com,
 srv_heupstream@mediatek.com, robh@kernel.org, leilk.liu@mediatek.com,
 xinping.qian@mediatek.com, linux-kernel@vger.kernel.org,
 liguo.zhang@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-i2c@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add MT8183 i2c binding to binding file. Compare to MT2712 i2c
controller, MT8183 has different registers, offsets, and clock.

Signed-off-by: Qii Wang <qii.wang@mediatek.com>
---
 Documentation/devicetree/bindings/i2c/i2c-mtk.txt |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/i2c/i2c-mtk.txt b/Documentation/devicetree/bindings/i2c/i2c-mtk.txt
index ee4c324..da2fa60 100644
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
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
