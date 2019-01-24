Return-Path: <SRS0=pdKw=QA=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE3EC282C6
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:15:08 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C06821872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 07:15:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S6HVWd3F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C06821872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=KtVseRDbhL1MqCIAzd3xndmC73HGX9VHP2JFphEHd/g=; b=S6HVWd3FSnc9jQ
	n6oAPKOtyBFJfLtWcycEfHVhkJE3yee46iBBc4eIrfEhrzE/7yfseXifhPl4vKaxEKIiaK11n5Neu
	LrC5igzObuRqUhllsYbL4uBzB4bWm7tRS8AYSvsiXw4ZZM7dxdo2qoToK3jBSxHox98B+WlRd+tmF
	aGnmrTnjzQq21S6L5AWhzi/fcHopfnWGrtEISR5JGB3R61vP4Q+UbhBpXAAtOk5y+dJHLxRW5mwFn
	ykuhbVeWgKCcr6eg9f5RdI7vt0Qg6wTlFsAIJEv9Zk2RFoIhMcNCQAHR3bb920qXuBFacSvtA2UFt
	119GU/X+ffVdbOcIkXGQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gmZEA-0001UI-Dn; Thu, 24 Jan 2019 07:15:06 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gmZE6-0000ux-6B; Thu, 24 Jan 2019 07:15:03 +0000
X-UUID: c8f56ddd7c2e4791a3130b40b088c0b3-20190123
X-UUID: c8f56ddd7c2e4791a3130b40b088c0b3-20190123
Received: from mtkcas66.mediatek.inc [(172.29.193.44)] by mailgw02.mediatek.com
 (envelope-from <shun-chih.yu@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 539259340; Wed, 23 Jan 2019 23:14:59 -0800
Received: from MTKMBS01N1.mediatek.inc (172.21.101.68) by
 MTKMBS62N1.mediatek.inc (172.29.193.41) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 23 Jan 2019 23:14:58 -0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 24 Jan 2019 15:14:56 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via
 Frontend Transport; Thu, 24 Jan 2019 15:14:56 +0800
From: <shun-chih.yu@mediatek.com>
To: Sean Wang <sean.wang@mediatek.com>, Vinod Koul <vkoul@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v5 1/2] dt-bindings: dmaengine: Add MediaTek Command-Queue DMA
 controller bindings
Date: Thu, 24 Jan 2019 15:14:19 +0800
Message-ID: <1548314060-4833-2-git-send-email-shun-chih.yu@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
References: <1548314060-4833-1-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190123_231502_280939_8817956F 
X-CRM114-Status: GOOD (  10.61  )
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
