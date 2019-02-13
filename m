Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43120C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:38 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B18820811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eQYLiFqe";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Nk93D9hw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B18820811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5nRtNKbbcmLDG+BWdT1q9OD35WWULa7luP6y8blyKFI=; b=eQYLiFqespc2C5
	DnhxrS26XZfxY7thhxppb/OKUPq/lPEfQisGAjI7TTfIbdjJWRHwM/KaV13EYrumKaw36tI17PF1+
	+W0m7teaVc01aLWs4FGFhzlU9uI0jYpVcbDJFwmswsbTBJMTmQ3ofD7iwMHKIHaGnGt0jcUi1kZbR
	CnjOutcAWsfsxjAN/sx7cLog+usArmSF4mK1wl5Y1g1psMLVspR1ndJdIJQ86yVK4+EUYGkrsyvnP
	u4Gt3Qasetne01cxJrwFyAc/ZBzX0WVam98xt/MUOuN+Y4FG/uJuvE8kOmLstFp7Hi2/IaDjTu5HF
	c5flR7pmDNwvN+iesKHg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuaZ-0005MM-0E; Wed, 13 Feb 2019 13:28:35 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuZe-0004GM-SF
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:27:44 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRY1i061134;
 Wed, 13 Feb 2019 07:27:34 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550064454;
 bh=oxiGXVbh8St1tFIygKlEVPmmPWTeAX4g8P8GE+1NpJs=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Nk93D9hw9ebciY/T2ir1UpMAHhB1ahEDD/aEN8SFTsl7xfiyGBer7yEZPb0fQGhL1
 pZ37ZSRl0SaOdauSJKt630P9vw+KJypF3IEbfXkNJltONHoHtTvZ/fvc8QJXkoy6E+
 YU8yiWC2oKgVrzCH2qiIyLY8W1c2uhIl8cjpl7NQ=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRYiv096677
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Feb 2019 07:27:34 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:34 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:34 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZf016688;
 Wed, 13 Feb 2019 07:27:31 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 5/9] PCI: keystone: Cleanup ks_pcie_msi_irq_handler and
 ks_pcie_legacy_irq_handler
Date: Wed, 13 Feb 2019 18:56:25 +0530
Message-ID: <20190213132629.24790-6-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052739_254002_DB01AA01 
X-CRM114-Status: GOOD (  20.74  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Both ks_pcie_msi_irq_handler() and ks_pcie_legacy_irq_handler() invokes
ks_pcie_handle_msi_irq() and ks_pcie_handle_legacy_irq() respectively
for handling the interrupts.

Having two functions for handling the interrupt was used when keystone
PCIe driver was implemented using two files. But with
commit b492aca35c982011500377797d2 ("PCI: keystone: Merge
pci-keystone-dw.c and pci-keystone.c"), which merged the keystone PCIe
driver to use a single file, two functions for handling the
interrupt handler is not required.

Handle both MSI interrupt and legacy interrupt in a single interrupt
handler here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 100 +++++++++-------------
 1 file changed, 42 insertions(+), 58 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 90d64507acd0..88bd029c2f03 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -105,13 +105,6 @@ struct keystone_pcie {
 	struct resource		app;
 };
 
-static inline void update_reg_offset_bit_pos(u32 offset, u32 *reg_offset,
-					     u32 *bit_pos)
-{
-	*reg_offset = offset % 8;
-	*bit_pos = offset >> 3;
-}
-
 static phys_addr_t ks_pcie_get_msi_addr(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -131,31 +124,6 @@ static void ks_pcie_app_writel(struct keystone_pcie *ks_pcie, u32 offset,
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-	struct device *dev = pci->dev;
-	u32 pending, vector;
-	int src, virq;
-
-	pending = ks_pcie_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
-
-	/*
-	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
-	 * shows 1, 9, 17, 25 and so forth
-	 */
-	for (src = 0; src < 4; src++) {
-		if (BIT(src) & pending) {
-			vector = offset + (src << 3);
-			virq = irq_linear_revmap(pp->irq_domain, vector);
-			dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n",
-				src, vector, virq);
-			generic_handle_irq(virq);
-		}
-	}
-}
-
 static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 {
 	u32 reg_offset, bit_pos;
@@ -164,7 +132,9 @@ static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
 
 	ks_pcie_app_writel(ks_pcie, MSI_IRQ_STATUS(reg_offset),
 			   BIT(bit_pos));
@@ -177,7 +147,9 @@ static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+
 	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
 			   BIT(bit_pos));
 }
@@ -188,7 +160,9 @@ static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
-	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
+	reg_offset = irq % 8;
+	bit_pos = irq >> 3;
+
 	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
 			   BIT(bit_pos));
 }
@@ -198,26 +172,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
-				      int offset)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-	u32 pending;
-	int virq;
-
-	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
-
-	/* EOI the INTx interrupt */
-	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
-}
-
 static void ks_pcie_enable_error_irq(struct keystone_pcie *ks_pcie)
 {
 	ks_pcie_app_writel(ks_pcie, ERR_IRQ_ENABLE_SET, ERR_IRQ_ALL);
@@ -556,8 +510,10 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	u32 offset = irq - ks_pcie->msi_host_irq;
 	struct dw_pcie *pci = ks_pcie->pci;
+	struct pcie_port *pp = &pci->pp;
 	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 vector, virq, reg, pos;
 
 	dev_dbg(dev, "%s, irq %d\n", __func__, irq);
 
@@ -567,7 +523,23 @@ static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_pcie_handle_msi_irq(ks_pcie, offset);
+
+	reg = ks_pcie_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
+	/*
+	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
+	 * shows 1, 9, 17, 25 and so forth
+	 */
+	for (pos = 0; pos < 4; pos++) {
+		if (!(reg & BIT(pos)))
+			continue;
+
+		vector = offset + (pos << 3);
+		virq = irq_linear_revmap(pp->irq_domain, vector);
+		dev_dbg(dev, "irq: bit %d, vector %d, virq %d\n", pos, vector,
+			virq);
+		generic_handle_irq(virq);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
@@ -585,8 +557,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irq;
+	u32 offset = irq - ks_pcie->legacy_host_irq;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	u32 pending, virq;
 
 	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
 
@@ -596,7 +569,18 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
+
+	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
+
+	if (BIT(0) & pending) {
+		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
+		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
+		generic_handle_irq(virq);
+	}
+
+	/* EOI the INTx interrupt */
+	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
