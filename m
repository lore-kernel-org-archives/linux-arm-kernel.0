Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86327C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:45:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCA52080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uVJ5SBvs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="B4XRHDBL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCA52080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=YzWJOfKeoq2pv8HuYoA0l3V+ANC5bBhrcTBJ6qXW9Ow=; b=uVJ5SBvsxFsyL7
	tM9cY/bRmIPXJefiXBAnNRqLuzv/wdrrO/iu2N4TdlJTcjloHiCjBgrh73FUw/lTyFgJlg8jOj2HR
	99M8fFi6m+NCKAaEzYCrS+hm944naUb3/GbfVDSwSq5G89vRjCuXWDDWxGlksX2a3xrOPpskVjCip
	u3aZHW2AHegJ5DYRnMHqUzGMAZ3wqEPkAjH3k3AG9dJz9uT2wIsO90v8kG1Mij0KLKgKRg/Qo7msx
	qC/78qYfrJZfeD8ujL6cgjVzL9NGsdRkua0BZSUeowhfcmIT6+TGS5gN85HsSONFv27hOdOCYNdH3
	vRbo8VvaLZIXoBMy2yTw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbEG-00037H-EW; Wed, 19 Dec 2018 12:45:36 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbBq-00081M-Va
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:43:17 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgqC6128202;
 Wed, 19 Dec 2018 06:42:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545223372;
 bh=s8YQTAlDMbSOqhf4u+bKfrqy75XWX+0He0qtHas8k58=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=B4XRHDBLQXnhVbGq2D9BiU8thbQgCyVJS6yPQajIZlBEoWJgiTFVRRD+Sy0Xs0ZVN
 5nUoPRPhswPYbt9oEIPgm+mHerJg+MWAUKNHZMNlgJVtssC80GmuZSaeDEGRZ+Sv5v
 o+5w1aHHwZmm8g1QwMRkDM/XVy5i5JCv9RTinX/4=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgp9j041051
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 06:42:52 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:51 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:51 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgNZr003940;
 Wed, 19 Dec 2018 06:42:48 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 08/10] PCI: keystone: Use Keystone specific msi_irq_chip
Date: Wed, 19 Dec 2018 18:12:05 +0530
Message-ID: <20181219124207.13479-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219124207.13479-1-kishon@ti.com>
References: <20181219124207.13479-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_044307_965314_26A6D0F2 
X-CRM114-Status: GOOD (  19.71  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 kishon@ti.com, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Use Keystone specific msi_irq_chip to configure the MSI controller
logic in the PCIe keystone wrapper instead of using the default
Designware msi_irq chip (dw_pci_msi_bottom_irq_chip) with
callback functions for configuring the Keystone MSI controller.
This will help to remove Keystone specific callback functions
added in dw_pcie_host_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 96 +++++++++++++++++------
 1 file changed, 72 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 05b2bd613c68..420d30ce11f4 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -104,14 +104,6 @@ struct keystone_pcie {
 	struct resource		app;
 };
 
-static phys_addr_t ks_pcie_get_msi_addr(struct pcie_port *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
-
-	return ks_pcie->app.start + MSI_IRQ;
-}
-
 static u32 ks_pcie_app_readl(struct keystone_pcie *ks_pcie, u32 offset)
 {
 	return readl(ks_pcie->va_app_base + offset);
@@ -123,11 +115,14 @@ static void ks_pcie_app_writel(struct keystone_pcie *ks_pcie, u32 offset,
 	writel(val, ks_pcie->va_app_base + offset);
 }
 
-static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
+static void ks_pcie_msi_irq_ack(struct irq_data *data)
 {
-	u32 reg_offset, bit_pos;
+	struct pcie_port *pp  = irq_data_get_irq_chip_data(data);
 	struct keystone_pcie *ks_pcie;
+	u32 irq = data->hwirq;
 	struct dw_pcie *pci;
+	u32 reg_offset;
+	u32 bit_pos;
 
 	pci = to_dw_pcie_from_pp(pp);
 	ks_pcie = to_keystone_pcie(pci);
@@ -140,34 +135,91 @@ static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
 }
 
-static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
-	u32 reg_offset, bit_pos;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct keystone_pcie *ks_pcie;
+	struct dw_pcie *pci;
+	u64 msi_target;
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
+
+	msi_target = ks_pcie->app.start + MSI_IRQ;
+	msg->address_lo = lower_32_bits(msi_target);
+	msg->address_hi = upper_32_bits(msi_target);
+	msg->data = data->hwirq;
+
+	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int ks_pcie_msi_set_affinity(struct irq_data *irq_data,
+				    const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static void ks_pcie_msi_mask(struct irq_data *data)
+{
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct keystone_pcie *ks_pcie;
+	u32 irq = data->hwirq;
+	struct dw_pcie *pci;
+	unsigned long flags;
+	u32 reg_offset;
+	u32 bit_pos;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
 
-	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
 			   BIT(bit_pos));
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
-static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
+static void ks_pcie_msi_unmask(struct irq_data *data)
 {
-	u32 reg_offset, bit_pos;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct pcie_port *pp = irq_data_get_irq_chip_data(data);
+	struct keystone_pcie *ks_pcie;
+	u32 irq = data->hwirq;
+	struct dw_pcie *pci;
+	unsigned long flags;
+	u32 reg_offset;
+	u32 bit_pos;
+
+	raw_spin_lock_irqsave(&pp->lock, flags);
+
+	pci = to_dw_pcie_from_pp(pp);
+	ks_pcie = to_keystone_pcie(pci);
 
 	reg_offset = irq % 8;
 	bit_pos = irq >> 3;
 
-	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
 			   BIT(bit_pos));
+
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
+static struct irq_chip ks_pcie_msi_irq_chip = {
+	.name = "KEYSTONE-PCI-MSI",
+	.irq_ack = ks_pcie_msi_irq_ack,
+	.irq_compose_msi_msg = ks_pcie_compose_msi_msg,
+	.irq_set_affinity = ks_pcie_msi_set_affinity,
+	.irq_mask = ks_pcie_msi_mask,
+	.irq_unmask = ks_pcie_msi_unmask,
+};
+
 static int ks_pcie_msi_host_init(struct pcie_port *pp)
 {
+	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
 	return dw_pcie_allocate_domains(pp);
 }
 
@@ -768,11 +820,7 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
 	.rd_other_conf = ks_pcie_rd_other_conf,
 	.wr_other_conf = ks_pcie_wr_other_conf,
 	.host_init = ks_pcie_host_init,
-	.msi_set_irq = ks_pcie_msi_set_irq,
-	.msi_clear_irq = ks_pcie_msi_clear_irq,
-	.get_msi_addr = ks_pcie_get_msi_addr,
 	.msi_host_init = ks_pcie_msi_host_init,
-	.msi_irq_ack = ks_pcie_msi_irq_ack,
 	.scan_bus = ks_pcie_v3_65_scan_bus,
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
