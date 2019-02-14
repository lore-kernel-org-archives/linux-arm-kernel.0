Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A57C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:55:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD04E222A4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 07:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="sTgcbHFy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD04E222A4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=OKFzRUCHo41IeLDDVRKfJ6Hd7+QXlN6GO/ZA90p99Nc=; b=sTgcbHFy6JzwKD
	/5KLWO5ihB4Y15UB8/ocXw76ttx0vEdbIfMtIP5bQGYpUSzlz2uEAsnKZB4vnbSQ1PoyHgG6HZopC
	FRSO2A0yADaXSLRYet0AiMpFr+Od/E5bxXwo7ZR5c8VyTYNiSaxmXcy5fP0g+wy1TrmX2XayWBzHN
	iG6iPTVXABa9xcVNBShcDVliBu1JsSt9+S2TBPN+exSc29bCIFN6Kzc/wOpVuxMuKrZExJ3JQTrEr
	zw7rcwyfn9LqKZzsXQxX4i7a+qOeOTtdxI5hXcs7CdIm66i+9mVHisPDdbN4nta2WJusTJDo4KBfm
	uPNCljKB2cwPxnkAUwnQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guBrh-00050p-3B; Thu, 14 Feb 2019 07:55:25 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guBrU-0004p8-Ev; Thu, 14 Feb 2019 07:55:14 +0000
X-UUID: 4ca01e3c65724abf89a0e8417894d165-20190213
X-UUID: 4ca01e3c65724abf89a0e8417894d165-20190213
Received: from mtkcas67.mediatek.inc [(172.29.193.45)] by mailgw02.mediatek.com
 (envelope-from <shun-chih.yu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 554464294; Wed, 13 Feb 2019 23:55:07 -0800
Received: from MTKMBS02N1.mediatek.inc (172.21.101.77) by
 MTKMBS62DR.mediatek.inc (172.29.94.18) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 13 Feb 2019 23:55:06 -0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 14 Feb 2019 15:55:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 14 Feb 2019 15:55:04 +0800
From: <shun-chih.yu@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v2 1/1] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA
 controller bindings
Date: Thu, 14 Feb 2019 15:54:52 +0800
Message-ID: <1550130892-19488-2-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1550130892-19488-1-git-send-email-shun-chih.yu@mediatek.com>
References: <1550130892-19488-1-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_235512_836533_89472189 
X-CRM114-Status: GOOD (  10.25  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 srv_wsdupstream@mediatek.com, linux-mediatek@lists.infradead.org,
 Shun-Chih Yu <shun-chih.yu@mediatek.com>, dmaengine@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Shun-Chih Yu <shun-chih.yu@mediatek.com>

Document the devicetree bindings for MediaTek Command-Queue DMA controller
which could be found on MT6765 SoC or other similar Mediatek SoCs.

Signed-off-by: Shun-Chih Yu <shun-chih.yu@mediatek.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Sean Wang <sean.wang@kernel.org>
---
 .../devicetree/bindings/dma/mtk-cqdma.txt          |   31 ++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/dma/mtk-cqdma.txt

diff --git a/Documentation/devicetree/bindings/dma/mtk-cqdma.txt b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
new file mode 100644
index 0000000..fb12927
--- /dev/null
+++ b/Documentation/devicetree/bindings/dma/mtk-cqdma.txt
@@ -0,0 +1,31 @@
+MediaTek Command-Queue DMA Controller
+==================================
+
+Required properties:
+
+- compatible:	Must be "mediatek,mt6765-cqdma" for MT6765.
+- reg:		Should contain the base address and length for each channel.
+- interrupts:	Should contain references to the interrupts for each channel.
+- clocks:	Should be the clock specifiers corresponding to the entry in
+		clock-names property.
+- clock-names:	Should contain "cqdma" entries.
+- dma-channels: The number of DMA channels supported by the controller.
+- dma-requests: The number of DMA request supported by the controller.
+- #dma-cells: 	The length of the DMA specifier, must be <1>. This one cell
+		in dmas property of a client device represents the channel
+		number.
+Example:
+
+        cqdma: dma-controller@10212000 {
+		compatible = "mediatek,mt6765-cqdma";
+		reg = <0 0x10212000 0 0x1000>;
+		interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_LOW>,
+			<GIC_SPI 114 IRQ_TYPE_LEVEL_LOW>;
+		clocks = <&infracfg CLK_IFR_CQ_DMA>;
+		clock-names = "cqdma";
+		dma-channels = <2>;
+		dma-requests = <32>;
+		#dma-cells = <1>;
+	};
+
+DMA clients must use the format described in dma/dma.txt file.
-- 
1.7.9.5


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
