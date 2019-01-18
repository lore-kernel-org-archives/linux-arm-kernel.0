Return-Path: <SRS0=p0aQ=P2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD2BDC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:10:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A46620883
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 03:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YX/+oOVG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A46620883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Vkj72c85voY1uMbD2fE56tYMSS0SkrXWnZbQRFn07rE=; b=YX/+oOVG8Vu/MN
	Hr5Q/d0HEJ5pJhxB1YJR/0Mdgd7ZAVoBtszxnuOKaAEm6u+zB7Mxd/EqYgl5ikFmovEbD32gtIaBX
	J7s3MS0oyK/5vwpCEllVY5GsXt5sE2o2M5IcVmIG5Hh+z3xaEsuvwp3HtkhexJ3unmQivtILPWPuI
	6IrZK+rN2uzAdGovQd00HDKte5R4vln1WbabHgADamjKPwANYYxa3B02TDNBIsvOoyutc53VTN4/6
	U9kUtxqPJW/l0phWA8oNwfqsUO9JQTlHFoWfC2g4b0Xkrqp3K4vAO5rzsMDIcE6c+YK7qNMMa2Blx
	YK/4UVCXwMxYY1B9F+9g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gkKYQ-0006S6-JF; Fri, 18 Jan 2019 03:10:46 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gkKYA-0006Gf-Br; Fri, 18 Jan 2019 03:10:31 +0000
X-UUID: c03dfb616e124a14977f3891fd58e700-20190117
X-UUID: c03dfb616e124a14977f3891fd58e700-20190117
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <long.cheng@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 16048071; Thu, 17 Jan 2019 19:10:27 -0800
Received: from mtkmbs03n1.mediatek.inc (172.21.101.181) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 17 Jan 2019 19:10:26 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 18 Jan 2019 11:10:24 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 18 Jan 2019 11:10:23 +0800
From: Long Cheng <long.cheng@mediatek.com>
To: Vinod Koul <vkoul@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, "Rob
 Herring" <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Ryder Lee
 <ryder.lee@mediatek.com>, Sean Wang <sean.wang@kernel.org>, Nicolas Boichat
 <drinkcat@chromium.org>
Subject: [PATCH v10 3/3] dt-bindings: dma: uart: rename binding
Date: Fri, 18 Jan 2019 11:10:16 +0800
Message-ID: <1547781016-890-4-git-send-email-long.cheng@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190117_191030_409990_2B1CDDE5 
X-CRM114-Status: GOOD (  12.46  )
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
Cc: Zhenbao Liu <zhenbao.liu@mediatek.com>, devicetree@vger.kernel.org, YT
 Shen <yt.shen@mediatek.com>, srv_heupstream@mediatek.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sean Wang <sean.wang@mediatek.com>, linux-kernel@vger.kernel.org,
 dmaengine@vger.kernel.org, Long
 Cheng <long.cheng@mediatek.com>, linux-mediatek@lists.infradead.org,
 linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Yingjoe Chen <yingjoe.chen@mediatek.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The filename matches mtk-uart-apdma.c.
So using "mtk-uart-apdma.txt" should be better.

Signed-off-by: Long Cheng <long.cheng@mediatek.com>
---
 .../devicetree/bindings/dma/8250_mtk_dma.txt       |   33 --------------------
 .../devicetree/bindings/dma/mtk-uart-apdma.txt     |   33 ++++++++++++++++++++
 2 files changed, 33 insertions(+), 33 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt

diff --git a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt b/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
deleted file mode 100644
index 3fe0961..0000000
--- a/Documentation/devicetree/bindings/dma/8250_mtk_dma.txt
+++ /dev/null
@@ -1,33 +0,0 @@
-* Mediatek UART APDMA Controller
-
-Required properties:
-- compatible should contain:
-  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
-  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
-
-- reg: The base address of the APDMA register bank.
-
-- interrupts: A single interrupt specifier.
-
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: The APDMA clock for register accesses
-
-Examples:
-
-	apdma: dma-controller@11000380 {
-		compatible = "mediatek,mt2712-uart-dma";
-		reg = <0 0x11000380 0 0x400>;
-		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
-			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
-		clocks = <&pericfg CLK_PERI_AP_DMA>;
-		clock-names = "apdma";
-		#dma-cells = <1>;
-	};
-
diff --git a/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
new file mode 100644
index 0000000..3fe0961
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mtk-uart-apdma.txt
@@ -0,0 +1,33 @@
+* Mediatek UART APDMA Controller
+
+Required properties:
+- compatible should contain:
+  * "mediatek,mt2712-uart-dma" for MT2712 compatible APDMA
+  * "mediatek,mt6577-uart-dma" for MT6577 and all of the above
+
+- reg: The base address of the APDMA register bank.
+
+- interrupts: A single interrupt specifier.
+
+- clocks : Must contain an entry for each entry in clock-names.
+  See ../clocks/clock-bindings.txt for details.
+- clock-names: The APDMA clock for register accesses
+
+Examples:
+
+	apdma: dma-controller@11000380 {
+		compatible = "mediatek,mt2712-uart-dma";
+		reg = <0 0x11000380 0 0x400>;
+		interrupts = <GIC_SPI 63 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 64 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 65 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 66 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 67 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 68 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 69 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_SPI 70 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&pericfg CLK_PERI_AP_DMA>;
+		clock-names = "apdma";
+		#dma-cells = <1>;
+	};
+
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
