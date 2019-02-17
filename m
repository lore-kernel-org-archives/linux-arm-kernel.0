Return-Path: <SRS0=tnMb=QY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B772CC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:50 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84E5A217F5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 13:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uOhtBmGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84E5A217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=aN+faxhJA7eGRGUaNMahnUgY26Ovev2DLbSImOkSCM0=; b=uOhtBmGc0B4jaC
	Xeoivb22xazNyjIyOYUmMRrMmm9UW5E7aipG0TOanC+ZD661DK7FYL9rGwuulm2qZfiJe3P3PA5WD
	afCO19zfgb9vksEzn5GHW5r+EKN8rUVYGivbCCU3P/j3wRtAPvcrBbiRTihb329tM9xxpUfLraKBi
	DEZN6b/1hJtDWFWMIVFHd+fvJE80qg8Aksot53+QqB8dp0Kp2NXsN1D0EFuhqzlGACGGi+6y9FmN7
	Gc42cUg/e9Ln+9dky7ZyTsnhDHtk1zlX6B9ld58nCyO4zQbVOI/ArdL4oRlmMu9p8DQ57x2bCG84F
	/Yuu6kd+gMBKlmUN6t0Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvMrD-0004Zn-Ir; Sun, 17 Feb 2019 13:51:47 +0000
Received: from mailgw01.mediatek.com ([216.200.240.184])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvMqf-0003tZ-Am; Sun, 17 Feb 2019 13:51:14 +0000
X-UUID: b1e93026c9ec4654a535182c2581b8bc-20190217
X-UUID: b1e93026c9ec4654a535182c2581b8bc-20190217
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw01.mediatek.com
 (envelope-from <ryder.lee@kernel.org>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1593091205; Sun, 17 Feb 2019 05:51:07 -0800
Received: from MTKMBS01N2.mediatek.inc (172.21.101.79) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 05:51:05 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n2.mediatek.inc (172.21.101.79) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Sun, 17 Feb 2019 21:50:51 +0800
Received: from mtkslt306.mediatek.inc (10.21.14.136) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Sun, 17 Feb 2019 21:50:51 +0800
From: Ryder Lee <ryder.lee@kernel.org>
To: Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/3] dt-bindings: mediatek: update bindings for MT7629 SoC
Date: Sun, 17 Feb 2019 21:50:30 +0800
Message-ID: <56a2c38c9efa41be940858e19501fe07fbd5120e.1550233614.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
X-TM-SNTS-SMTP: 62F34D0A1C1C7C9016F1E28AA7EAB233CBB20A03B91CD1E06D80D7E9F0D71AC62000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190217_055113_371058_26097479 
X-CRM114-Status: UNSURE (   8.57  )
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
 Marc Zyngier <marc.zyngier@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Ryder Lee <ryder.lee@mediatek.com>

This updates bindings for MT7629 SoC, which includes very basic items
such as system timer, UART, sysirq and scpsys unit.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/interrupt-controller/mediatek,sysirq.txt     | 5 +++--
 Documentation/devicetree/bindings/serial/mtk-uart.txt                | 3 ++-
 Documentation/devicetree/bindings/soc/mediatek/scpsys.txt            | 3 ++-
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
index c5d5891..e8b3688 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,sysirq.txt
@@ -1,6 +1,6 @@
-+Mediatek MT65xx/MT67xx/MT81xx sysirq
+MediaTek sysirq
 
-Mediatek SOCs sysirq support controllable irq inverter for each GIC SPI
+MediaTek SOCs sysirq support controllable irq inverter for each GIC SPI
 interrupt.
 
 Required properties:
@@ -10,6 +10,7 @@ Required properties:
 	"mediatek,mt8127-sysirq", "mediatek,mt6577-sysirq": for MT8127
 	"mediatek,mt7622-sysirq", "mediatek,mt6577-sysirq": for MT7622
 	"mediatek,mt7623-sysirq", "mediatek,mt6577-sysirq": for MT7623
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
index d6fe16f..9a88d418 100644
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
@@ -33,7 +34,7 @@ Required properties:
 	Required clocks for MT2701 or MT7623: "mm", "mfg", "ethif"
 	Required clocks for MT2712: "mm", "mfg", "venc", "jpgdec", "audio", "vdec"
 	Required clocks for MT6797: "mm", "mfg", "vdec"
-	Required clocks for MT7622: "hif_sel"
+	Required clocks for MT7622 or MT7629: "hif_sel"
 	Required clocks for MT7622A: "ethif"
 	Required clocks for MT8173: "mm", "mfg", "venc", "venc_lt"
 
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
