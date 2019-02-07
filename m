Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF4D3C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:34:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B81282084D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J/YMhSYt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="FK8eW5io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B81282084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=a+sQzKITC6fkRlQoLS+5xeJaE1+eTiXUvSAtvgFezyw=; b=J/YMhSYtqtBqsZ
	Ma+QQERyRWAQVoODowLwpr7T6R3byogwmQshS2j/Nu2iCXh+MFRkpOOAMeZKpbZhRTOJDgo9uQ6Uu
	bMlhfvSbtuQb1BlylX5yQwWSOZ1sxFhj4FCwnEyRJ+7HHELQgycaGlDT3lzDMRkUWXlA/zaeoKbBX
	z4QQvuzAmCdGVaHb4t1UEJ6jR98zhNA8rTrkL6ODxbzlrqKyLntw44DNCkEc58W5fdOKLzffAki4M
	bR8x/UsrKljI0jqIzzYQ1V1XOdHjoXrutXxVrpsAh5QDdRcbJ5xrKHzDPP4kgFFH32Anv+gOrSmIq
	twUmUxGkcWhXwV8/JRjw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhwU-000137-BY; Thu, 07 Feb 2019 11:34:06 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhuv-0007wn-PD
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:32:43 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BWOMF085641;
 Thu, 7 Feb 2019 05:32:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549539144;
 bh=mvQ4LuillFqXvxg71gFR7S4jEmgc2bXgTs+yh2AUVNc=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=FK8eW5ioutqHnKVUDUWHBJR5F7uiWnXdT5wT1K9mgHShJ167tG9WW2jMNqhO3ET5F
 SvxoEewl1RUsUXrheMrSJRsXsEUSHNbr0rulS9IXeJmT0twQnoaUbDrv+BdRC/6/37
 BKqHvwpyDUWot7aqsZdGFIcKhMfwd8gS8V+D3D7A=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BWOk9017167
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 05:32:24 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:24 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:24 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxar026282;
 Thu, 7 Feb 2019 05:32:21 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 7/9] PCI: keystone: Use Keystone specific msi_irq_chip
Date: Thu, 7 Feb 2019 16:39:22 +0530
Message-ID: <20190207110924.30716-8-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207110924.30716-1-kishon@ti.com>
References: <20190207110924.30716-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_033230_961458_CCD60814 
X-CRM114-Status: GOOD (  19.15  )
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
index 3d1abc99fd08..94eb5830967e 100644
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
 
@@ -788,11 +840,7 @@ static const struct dw_pcie_host_ops ks_pcie_host_ops = {
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
