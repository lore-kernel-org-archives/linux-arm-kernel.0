Return-Path: <SRS0=P47x=QF=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9691BC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:32:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B744217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="AJph3ckD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B744217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=O1QzFJ0dGF5kN01fG1LqMl4a2fd4+im5QaASbGF4kxc=; b=AJph3ckD711g37
	MbNXmNJ3M9LNdU+FdUqV0KLtzvMoMqciokqzjYcpoObMAWUvgcMRRsfTMieQ6upFVYiNDpmlcFeU3
	GfI39Cr1ueTetqK6lat/raC5z0w4JfGyHupI7shxrV5DtwdRxr5Ng1kpvV2FlL0cm+TzGBdolflhg
	hb2AmMKkAkRuhy3hflqUt7g17D0kbXVDcvCyd9J+PbKdL8u+lYGX9rd4F59hwfLZPTT+q34XKBh/4
	dJi/v+XTefiplHfy/7ejaDWr4tYALd8LaaMbiQZb9R2by1QCSIJaa67cBQBSr3Ga3rOR1HWJcSgYc
	h1Qga2o//1pNXhgwT+dQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1goL4i-0002PV-Tp; Tue, 29 Jan 2019 04:32:40 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1goL3m-0001hg-8i; Tue, 29 Jan 2019 04:31:53 +0000
X-UUID: f282c357e34245fb885fc06b8bbbb2d6-20190128
X-UUID: f282c357e34245fb885fc06b8bbbb2d6-20190128
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <ryder.lee@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1957105892; Mon, 28 Jan 2019 20:31:39 -0800
Received: from mtkmbs08n2.mediatek.inc (172.21.101.56) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 28 Jan 2019 20:31:38 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 29 Jan 2019 12:31:24 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Tue, 29 Jan 2019 12:31:24 +0800
From: Ryder Lee <ryder.lee@mediatek.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
Subject: [PATCH 4/7] dt-bindings: mediatek: update bindings for MT7629 SoC
Date: Tue, 29 Jan 2019 12:31:16 +0800
Message-ID: <30465fff4cfe17cceddc5d468627c11f1a3935b7.1548735271.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
References: <d1ab6c89b115ad0582815816490fa0c13ea83178.1548735271.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: 0EC819A4E0D3EEC2B079731522C67541109E3BA318E19A86676D25C3D587D0472000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190128_203142_610187_5BD9661C 
X-CRM114-Status: UNSURE (   9.25  )
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
 Sean Wang <sean.wang@kernel.org>, Weijie Gao <weijie.gao@mediatek.com>,
 Roy Luo <roychl666@gmail.com>, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This updates bindings for MT7629 SoC, which includes very basic items
such as system timer, UART, sysirq and scpsys unit.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt   | 5 +++--
 Documentation/devicetree/bindings/serial/mtk-uart.txt              | 3 ++-
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt          | 5 +++--
 Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt     | 7 ++++---
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index 33a98eb..8da481c 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -1,6 +1,6 @@
-+Mediatek MT65xx/MT67xx/MT81xx sysirq
+MediaTek sysirq
 
-Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
+MediaTek SOCs sysirq support controllable irq inverter for each GIC SPI
 interrupt.
 
 Required properties:
@@ -9,6 +9,7 @@ Required properties:
 	"mediatek,mt8135-sysirq", "mediatek,mt6577-sysirq": for MT8135
 	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
 	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
+	"mediatek,mt7629-sysirq", "mediatek,mt6577-sysirq": for MT7629
 	"mediatek,mt6795-sysirq", "mediatek,mt6577-sysirq": for MT6795
 	"mediatek,mt6797-sysirq", "mediatek,mt6577-sysirq": for MT6797
 	"mediatek,mt6765-sysirq", "mediatek,mt6577-sysirq": for MT6765
diff --git a/Documentation/devicetree/bindings/serial/mtk-uart.txt b/Documentation/devicetree/bindings/serial/mtk-uart.txt
index 742cb47..4910f63 100644
--- a/Documentation/devicetree/bindings/serial/mtk-uart.txt
+++ b/Documentation/devicetree/bindings/serial/mtk-uart.txt
@@ -1,4 +1,4 @@
-* Mediatek Universal Asynchronous Receiver/Transmitter (UART)
+* MediaTek Universal Asynchronous Receiver/Transmitter (UART)
 
 Required properties:
 - compatible should contain:
@@ -13,6 +13,7 @@ Required properties:
   * "mediatek,mt6797-uart" for MT6797 compatible UARTS
   * "mediatek,mt7622-uart" for MT7622 compatible UARTS
   * "mediatek,mt7623-uart" for MT7623 compatible UARTS
+  * "mediatek,mt7629-uart" for MT7629 compatible UARTS
   * "mediatek,mt8127-uart" for MT8127 compatible UARTS
   * "mediatek,mt8135-uart" for MT8135 compatible UARTS
   * "mediatek,mt8173-uart" for MT8173 compatible UARTS
diff --git a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
index d6fe16f..876693a 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
+++ b/Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
@@ -23,6 +23,7 @@ Required properties:
 	- "mediatek,mt7622-scpsys"
 	- "mediatek,mt7623-scpsys", "mediatek,mt2701-scpsys": For MT7623 SoC
 	- "mediatek,mt7623a-scpsys": For MT7623A SoC
+	- "mediatek,mt7629-scpsys", "mediatek,mt7622-scpsys": For MT7629 SoC
 	- "mediatek,mt8173-scpsys"
 - #power-domain-cells: Must be 1
 - reg: Address range of the SCPSYS unit
@@ -33,8 +34,8 @@ Required properties:
 	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
-	Required clocks for MT7622: "hif_sel"
-	Required clocks for MT7622A: "ethif"
+	Required clocks for MT7622 or MT7629: "hif_sel"
+	Required clocks for MT7623A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
 Optional properties:
diff --git a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
index 18d4d01..12b6d06 100644
--- a/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
+++ b/Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt
@@ -1,7 +1,7 @@
-Mediatek Timers
+MediaTek Timers
 ---------------
 
-Mediatek SoCs have two different timers on different platforms,
+MediaTek SoCs have two different timers on different platforms,
 - GPT (General Purpose Timer)
 - SYST (System Timer)
 
@@ -17,7 +17,8 @@ Required properties:
 	* "mediatek,mt8135-timer" for MT8135 compatible timers (GPT)
 	* "mediatek,mt8173-timer" for MT8173 compatible timers (GPT)
 	* "mediatek,mt6577-timer" for MT6577 and all above compatible timers (GPT)
-	* "mediatek,mt6765-timer" for MT6765 compatible timers (SYST)
+	* "mediatek,mt7629-timer" for MT7629 compatible timers (SYST)
+	* "mediatek,mt6765-timer" for MT6765 and all above compatible timers (SYST)
 - reg: Should contain location and length for timer register.
 - clocks: Should contain system clock.
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
