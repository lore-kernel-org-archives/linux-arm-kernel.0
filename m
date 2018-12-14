Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC9B5C67839
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64D392075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 01:26:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YAcVTKMC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64D392075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aWjmmnzPeiGxJ2cTe1TfP2c66V4r3dYGzJzoTcu0JMA=; b=YAcVTKMCbQSC1s
	L8N6fKLlNuQgrq9fN6ZcYwi5Ect68MTRZHyUe2iXRCEYTDgu7LAZYpdWUyDY5+UX+FnVaMofWc+le
	5idPcHX2sC4GLdxhuk/6HPEkyLaAx3qh4Hi0qAGG7WD+GJcK/Z9u5ASfYpFg3eE0wJQ2X+ejLKU87
	JiBs3c5kgLGFXYTa7LPOE4vwinJl4kD29g0dA83sFdSapAKNxFCqICLipTpU9e6Lt++nTLmlaFnK8
	C+BrcoxUfggijXahQwgQyOEkjjfhMTHdwwUiDJZWeWoLQYyQJ1/gD5bbztt6q4sTyE363JjGOvF+9
	8pTeCUY7q4PnEtaEq4VA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXcFB-0004H5-0L; Fri, 14 Dec 2018 01:26:21 +0000
Received: from [210.61.82.183] (helo=mailgw01.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXcEu-00042I-BQ; Fri, 14 Dec 2018 01:26:06 +0000
X-UUID: 01e388c211be4746a3e9218d664d41fa-20181214
X-UUID: 01e388c211be4746a3e9218d664d41fa-20181214
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
 (envelope-from <honghui.zhang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2026839957; Fri, 14 Dec 2018 09:25:47 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Fri, 14 Dec 2018 09:25:46 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Fri, 14 Dec 2018 09:25:44 +0800
From: <honghui.zhang@mediatek.com>
To: <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
 <linux-arm-kernel@lists.infradead.org>, <linux-mediatek@lists.infradead.org>, 
 <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <ryder.lee@mediatek.com>, <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
 <robh@kernel.org>
Subject: [PATCH 1/4] PCI: mediatek: Remove un-used variant in struct
 mtk_pcie_port
Date: Fri, 14 Dec 2018 09:25:39 +0800
Message-ID: <1544750742-31419-2-git-send-email-honghui.zhang@mediatek.com>
X-Mailer: git-send-email 2.6.4
In-Reply-To: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
References: <1544750742-31419-1-git-send-email-honghui.zhang@mediatek.com>
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181213_172604_563198_7821BBA9 
X-CRM114-Status: UNSURE (   7.50  )
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
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 jianjun.wang@mediatek.com, Honghui Zhang <honghui.zhang@mediatek.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Honghui Zhang <honghui.zhang@mediatek.com>

The "lane" variant in struct mtk_pcie_port is not used, remove it.

Signed-off-by: Honghui Zhang <honghui.zhang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 6917aec..e307166 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -161,7 +161,6 @@ struct mtk_pcie_soc {
  * @obff_ck: pointer to OBFF functional block operating clock
  * @pipe_ck: pointer to LTSSM and PHY/MAC layer operating clock
  * @phy: pointer to PHY control block
- * @lane: lane count
  * @slot: port slot
  * @irq: GIC irq
  * @irq_domain: legacy INTx IRQ domain
@@ -182,7 +181,6 @@ struct mtk_pcie_port {
 	struct clk *obff_ck;
 	struct clk *pipe_ck;
 	struct phy *phy;
-	u32 lane;
 	u32 slot;
 	int irq;
 	struct irq_domain *irq_domain;
@@ -895,12 +893,6 @@ static int mtk_pcie_parse_port(struct mtk_pcie *pcie,
 	if (!port)
 		return -ENOMEM;
 
-	err = of_property_read_u32(node, "num-lanes", &port->lane);
-	if (err) {
-		dev_err(dev, "missing num-lanes property\n");
-		return err;
-	}
-
 	snprintf(name, sizeof(name), "port%d", slot);
 	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, name);
 	port->base = devm_ioremap_resource(dev, regs);
-- 
2.6.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
