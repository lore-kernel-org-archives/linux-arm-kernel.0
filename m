Return-Path: <SRS0=g9E6=Q2=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D722FC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:24:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A603221903
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:24:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="NaN2Mwsn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A603221903
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=noBWrct34+UIPVSoTQELmbmlNoi6WgaU8WvQSjGoB8Y=; b=NaN2MwsnzZ3/Fw
	KpsIYrZf35D94nebpV4WAoa5k8W4uj0l9FZKAzj3OiFdvDpPqVMyzOk9L6Gg3YSEcB3OJp8n8UG9p
	a1qYvsf9jfhjQdjuQsy3lT+GW92BmVVWsKnDycBDxmndjmdNh8ZH/fo2+h7VeYOd9nIm/jhDzYMwo
	NtC3u1crm5lGU/k1CWZFKf+zjKkVF+5VJ63KtC6dSH7A+Bt92MbPqdwDAUaK5AFEOL/1C9INUo7dM
	WdJsjDG8D/1fuOkro3GloEH78SEN+3Fly3udFRqZzcqSutRyoMH1Mm4hEFTsZ/Q6l4dlwtWHmOCaH
	4lxGzl9UfmtdEJA/Ktng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gvzld-0002wH-Ga; Tue, 19 Feb 2019 07:24:37 +0000
Received: from mailgw02.mediatek.com ([216.200.240.185])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gvzlZ-0002vF-4F; Tue, 19 Feb 2019 07:24:34 +0000
X-UUID: 1008a8ea9358477c88f02582f175ac41-20190218
X-UUID: 1008a8ea9358477c88f02582f175ac41-20190218
Received: from mtkcas68.mediatek.inc [(172.29.94.19)] by mailgw02.mediatek.com
 (envelope-from <jianjun.wang@mediatek.com>)
 (musrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 1044566844; Mon, 18 Feb 2019 23:24:11 -0800
Received: from mtkmbs08n1.mediatek.inc (172.21.101.55) by
 MTKMBS62N2.mediatek.inc (172.29.193.42) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Mon, 18 Feb 2019 23:24:09 -0800
Received: from mtkcas09.mediatek.inc (172.21.101.178) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 19 Feb 2019 15:24:02 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas09.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 19 Feb 2019 15:24:02 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: <marc.zyngier@arm.com>, <ryder.lee@mediatek.com>,
 <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>, <matthias.bgg@gmail.com>
Subject: [v2] PCI: mediatek: Remove MSI inner domain
Date: Tue, 19 Feb 2019 15:24:00 +0800
Message-ID: <1550561040-30892-1-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190218_232433_170026_8AE96336 
X-CRM114-Status: GOOD (  13.39  )
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
Cc: youlin.pei@mediatek.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, jianjun.wang@mediatek.com,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

There is no need to create the inner domain as a parent for MSI domian,
some feature has been implemented by MSI framework.

Remove the inner domain and its irq chip, it will be more closer to the
hardware implementation.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 83 +++++++++++---------------
 1 file changed, 36 insertions(+), 47 deletions(-)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index 8d05df56158b..cd55c8ae392e 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -169,7 +169,6 @@ struct mtk_pcie_soc {
  * @slot: port slot
  * @irq: GIC irq
  * @irq_domain: legacy INTx IRQ domain
- * @inner_domain: inner IRQ domain
  * @msi_domain: MSI IRQ domain
  * @lock: protect the msi_irq_in_use bitmap
  * @msi_irq_in_use: bit map for assigned MSI IRQ
@@ -190,7 +189,6 @@ struct mtk_pcie_port {
 	u32 slot;
 	int irq;
 	struct irq_domain *irq_domain;
-	struct irq_domain *inner_domain;
 	struct irq_domain *msi_domain;
 	struct mutex lock;
 	DECLARE_BITMAP(msi_irq_in_use, MTK_MSI_IRQS_NUM);
@@ -420,20 +418,12 @@ static void mtk_msi_ack_irq(struct irq_data *data)
 	writel(1 << hwirq, port->base + PCIE_IMSI_STATUS);
 }
 
-static struct irq_chip mtk_msi_bottom_irq_chip = {
-	.name			= "MTK MSI",
-	.irq_compose_msi_msg	= mtk_compose_msi_msg,
-	.irq_set_affinity	= mtk_msi_set_affinity,
-	.irq_ack		= mtk_msi_ack_irq,
-};
-
-static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
-				     unsigned int nr_irqs, void *args)
+static irq_hw_number_t mtk_pcie_msi_get_hwirq(struct msi_domain_info *info,
+					      msi_alloc_info_t *arg)
 {
-	struct mtk_pcie_port *port = domain->host_data;
-	unsigned long bit;
+	struct mtk_pcie_port *port = info->chip_data;
+	irq_hw_number_t bit;
 
-	WARN_ON(nr_irqs != 1);
 	mutex_lock(&port->lock);
 
 	bit = find_first_zero_bit(port->msi_irq_in_use, MTK_MSI_IRQS_NUM);
@@ -446,18 +436,14 @@ static int mtk_pcie_irq_domain_alloc(struct irq_domain *domain, unsigned int vir
 
 	mutex_unlock(&port->lock);
 
-	irq_domain_set_info(domain, virq, bit, &mtk_msi_bottom_irq_chip,
-			    domain->host_data, handle_edge_irq,
-			    NULL, NULL);
-
-	return 0;
+	return bit;
 }
 
-static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
-				     unsigned int virq, unsigned int nr_irqs)
+static void mtk_pcie_msi_free(struct irq_domain *domain,
+			      struct msi_domain_info *info, unsigned int virq)
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct mtk_pcie_port *port = irq_data_get_irq_chip_data(d);
+	struct mtk_pcie_port *port = info->chip_data;
 
 	mutex_lock(&port->lock);
 
@@ -468,46 +454,50 @@ static void mtk_pcie_irq_domain_free(struct irq_domain *domain,
 		__clear_bit(d->hwirq, port->msi_irq_in_use);
 
 	mutex_unlock(&port->lock);
-
-	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
-static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= mtk_pcie_irq_domain_alloc,
-	.free	= mtk_pcie_irq_domain_free,
+static struct msi_domain_ops mtk_msi_domain_ops = {
+	.get_hwirq	= mtk_pcie_msi_get_hwirq,
+	.msi_free	= mtk_pcie_msi_free,
 };
 
 static struct irq_chip mtk_msi_irq_chip = {
-	.name		= "MTK PCIe MSI",
-	.irq_ack	= irq_chip_ack_parent,
-	.irq_mask	= pci_msi_mask_irq,
-	.irq_unmask	= pci_msi_unmask_irq,
+	.name			= "MTK PCIe",
+	.irq_compose_msi_msg	= mtk_compose_msi_msg,
+	.irq_write_msi_msg	= pci_msi_domain_write_msg,
+	.irq_set_affinity	= mtk_msi_set_affinity,
+	.irq_ack		= mtk_msi_ack_irq,
+	.irq_mask		= pci_msi_mask_irq,
+	.irq_unmask		= pci_msi_unmask_irq,
 };
 
 static struct msi_domain_info mtk_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX),
-	.chip	= &mtk_msi_irq_chip,
+	.flags		= (MSI_FLAG_USE_DEF_DOM_OPS |
+			   MSI_FLAG_USE_DEF_CHIP_OPS | MSI_FLAG_PCI_MSIX),
+	.ops		= &mtk_msi_domain_ops,
+	.chip		= &mtk_msi_irq_chip,
+	.handler	= handle_edge_irq,
+	.handler_name	= "MSI",
 };
 
 static int mtk_pcie_allocate_msi_domains(struct mtk_pcie_port *port)
 {
-	struct fwnode_handle *fwnode = of_node_to_fwnode(port->pcie->dev->of_node);
+	struct device *dev = port->pcie->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct msi_domain_info *info;
 
 	mutex_init(&port->lock);
 
-	port->inner_domain = irq_domain_create_linear(fwnode, MTK_MSI_IRQS_NUM,
-						      &msi_domain_ops, port);
-	if (!port->inner_domain) {
-		dev_err(port->pcie->dev, "failed to create IRQ domain\n");
+	info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
+	if (!info)
 		return -ENOMEM;
-	}
 
-	port->msi_domain = pci_msi_create_irq_domain(fwnode, &mtk_msi_domain_info,
-						     port->inner_domain);
+	memcpy(info, &mtk_msi_domain_info, sizeof(*info));
+	info->chip_data = port;
+
+	port->msi_domain = pci_msi_create_irq_domain(fwnode, info, NULL);
 	if (!port->msi_domain) {
-		dev_err(port->pcie->dev, "failed to create MSI domain\n");
-		irq_domain_remove(port->inner_domain);
+		dev_err(dev, "failed to create MSI domain\n");
 		return -ENOMEM;
 	}
 
@@ -541,8 +531,6 @@ static void mtk_pcie_irq_teardown(struct mtk_pcie *pcie)
 		if (IS_ENABLED(CONFIG_PCI_MSI)) {
 			if (port->msi_domain)
 				irq_domain_remove(port->msi_domain);
-			if (port->inner_domain)
-				irq_domain_remove(port->inner_domain);
 		}
 
 		irq_dispose_mapping(port->irq);
@@ -619,7 +607,8 @@ static void mtk_pcie_intr_handler(struct irq_desc *desc)
 
 			while ((imsi_status = readl(port->base + PCIE_IMSI_STATUS))) {
 				for_each_set_bit(bit, &imsi_status, MTK_MSI_IRQS_NUM) {
-					virq = irq_find_mapping(port->inner_domain, bit);
+					virq = irq_find_mapping(
+							port->msi_domain, bit);
 					generic_handle_irq(virq);
 				}
 			}
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
