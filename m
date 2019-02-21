Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2C4C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AD1E214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KPub0OPc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZwLyw2vU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AD1E214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bASOh01erXtJk4AOUXwbZuYUO9HHw30kMxyuqOnbLWI=; b=KPub0OPcPKl/Uh
	Dec9wqWCjUcaECdbsJJfguF+1duxxF20IOqsIZuvHCDRXmdEzQ2/kppFiiqy3iCBQEI/4QYnvlW/Q
	9H3rizZL7NQv0p2TZEpac7zBCU52v2kaAjY7xXi/K35LeGE8FuztmvEcsHyy4EKcuVnRnM7j9CRVp
	suK+Do70ct1eVdRXnGR4NNpuV0+gGhhj4dA4IdYKV4KfbwfN6gYFlWs6uzW51ic/7N8+Ygq/P/EZ8
	LMrHk/PUbR3kTLjRio27Afz3qSD54WS/NujkA649iEgHybi10SfNbWH35F1CJ8JHYBUne1QvJRFxP
	gtwLTzhPC9YB+pvv6v8Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlRa-0003tu-49; Thu, 21 Feb 2019 10:19:06 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlR7-0003KH-Pw
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:18:42 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIXTU062543;
 Thu, 21 Feb 2019 04:18:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550744313;
 bh=nIufzSB70gu2HazdrZSknZT9JXC1w0O3QPJ/Zgw3yeg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ZwLyw2vUhAZzx9bxNKvB56hgk97vySsm+9VgDX79rVBeWnxOB2wGVQS0Uu+6xQOj2
 QM7iCpMPYDnVcu8/F7jt9YnlMpQ+gUvFDmZxEB6MONLxoQYWRtafyrbQM1XlzI0GM4
 AIQF9yOeIDY4PzURi77FL5f9CzWiXetYp3EkQ1xk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIXXX052644
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Feb 2019 04:18:33 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:33 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORH022198;
 Thu, 21 Feb 2019 04:18:30 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 2/9] PCI: keystone: Add separate functions for configuring
 MSI and legacy interrupt
Date: Thu, 21 Feb 2019 15:45:11 +0530
Message-ID: <20190221101518.22604-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221101518.22604-1-kishon@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_021838_050518_A3C3CFB4 
X-CRM114-Status: GOOD (  22.96  )
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

ks_pcie_get_irq_controller_info() is used to configure both MSI and
legacy interrupt. This will prevent MSI or legacy interrupt specific
intializations. Add separate functions to configure MSI and legacy
interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 181 +++++++++++-----------
 1 file changed, 89 insertions(+), 92 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5286a480f76b..47f0dcf638f2 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -87,11 +87,9 @@ struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
 	u32			device_id;
-	int			num_legacy_host_irqs;
 	int			legacy_host_irqs[PCI_NUM_INTX];
 	struct			device_node *legacy_intc_np;
 
-	int			num_msi_host_irqs;
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
 	int			num_lanes;
 	u32			num_viewport;
@@ -201,14 +199,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
 	return dw_pcie_allocate_domains(pp);
 }
 
-static void ks_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
-{
-	int i;
-
-	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), 0x1);
-}
-
 static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 				      int offset)
 {
@@ -495,17 +485,6 @@ static int __init ks_pcie_dw_host_init(struct keystone_pcie *ks_pcie)
 
 	ks_pcie->app = *res;
 
-	/* Create legacy IRQ domain */
-	ks_pcie->legacy_irq_domain =
-			irq_domain_add_linear(ks_pcie->legacy_intc_np,
-					      PCI_NUM_INTX,
-					      &ks_pcie_legacy_irq_domain_ops,
-					      NULL);
-	if (!ks_pcie->legacy_irq_domain) {
-		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
-		return -EINVAL;
-	}
-
 	return dw_pcie_host_init(pp);
 }
 
@@ -622,85 +601,109 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static int ks_pcie_get_irq_controller_info(struct keystone_pcie *ks_pcie,
-					   char *controller, int *num_irqs)
+static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 {
-	int temp, max_host_irqs, legacy = 1, *host_irqs;
 	struct device *dev = ks_pcie->pci->dev;
-	struct device_node *np_pcie = dev->of_node, **np_temp;
-
-	if (!strcmp(controller, "msi-interrupt-controller"))
-		legacy = 0;
-
-	if (legacy) {
-		np_temp = &ks_pcie->legacy_intc_np;
-		max_host_irqs = PCI_NUM_INTX;
-		host_irqs = &ks_pcie->legacy_host_irqs[0];
-	} else {
-		np_temp = &ks_pcie->msi_intc_np;
-		max_host_irqs = MAX_MSI_HOST_IRQS;
-		host_irqs =  &ks_pcie->msi_host_irqs[0];
-	}
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count, irq, ret, i;
 
-	/* interrupt controller is in a child node */
-	*np_temp = of_get_child_by_name(np_pcie, controller);
-	if (!(*np_temp)) {
-		dev_err(dev, "Node for %s is absent\n", controller);
-		return -EINVAL;
-	}
+	if (!IS_ENABLED(CONFIG_PCI_MSI))
+		return 0;
 
-	temp = of_irq_count(*np_temp);
-	if (!temp) {
-		dev_err(dev, "No IRQ entries in %s\n", controller);
-		of_node_put(*np_temp);
+	intc_np = of_get_child_by_name(np, "msi-interrupt-controller");
+	if (!intc_np) {
+		dev_warn(dev, "msi-interrupt-controller node is absent\n");
 		return -EINVAL;
 	}
 
-	if (temp > max_host_irqs)
-		dev_warn(dev, "Too many %s interrupts defined %u\n",
-			(legacy ? "legacy" : "MSI"), temp);
+	irq_count = of_irq_count(intc_np);
+	if (!irq_count) {
+		dev_err(dev, "No IRQ entries in msi-interrupt-controller\n");
+		ret = -EINVAL;
+		goto err;
+	}
 
-	/*
-	 * support upto max_host_irqs. In dt from index 0 to 3 (legacy) or 0 to
-	 * 7 (MSI)
-	 */
-	for (temp = 0; temp < max_host_irqs; temp++) {
-		host_irqs[temp] = irq_of_parse_and_map(*np_temp, temp);
-		if (!host_irqs[temp])
-			break;
+	if (irq_count > MAX_MSI_HOST_IRQS) {
+		dev_warn(dev, "Too many MSI interrupt lines defined %u\n",
+			 irq_count);
+		irq_count = MAX_MSI_HOST_IRQS;
 	}
 
-	of_node_put(*np_temp);
+	for (i = 0; i < irq_count; i++) {
+		irq = irq_of_parse_and_map(intc_np, i);
+		if (!irq) {
+			ret = -EINVAL;
+			goto err;
+		}
+		ks_pcie->msi_host_irqs[i] = irq;
 
-	if (temp) {
-		*num_irqs = temp;
-		return 0;
+		irq_set_chained_handler_and_data(irq, ks_pcie_msi_irq_handler,
+						 ks_pcie);
 	}
 
-	return -EINVAL;
+	of_node_put(intc_np);
+	return 0;
+
+err:
+	of_node_put(intc_np);
+	return ret;
 }
 
-static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
+static int ks_pcie_config_legacy_irq(struct keystone_pcie *ks_pcie)
 {
-	int i;
+	struct device *dev = ks_pcie->pci->dev;
+	struct irq_domain *legacy_irq_domain;
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count, irq, ret = 0, i;
+
+	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
+	if (!intc_np) {
+		dev_warn(dev, "legacy-interrupt-controller node is absent\n");
+		return -EINVAL;
+	}
+
+	irq_count = of_irq_count(intc_np);
+	if (!irq_count) {
+		dev_err(dev, "No IRQ entries in legacy-interrupt-controller\n");
+		ret = -EINVAL;
+		goto err;
+	}
 
-	/* Legacy IRQ */
-	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
-		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
+	for (i = 0; i < irq_count; i++) {
+		irq = irq_of_parse_and_map(intc_np, i);
+		if (!irq) {
+			ret = -EINVAL;
+			goto err;
+		}
+		ks_pcie->legacy_host_irqs[i] = irq;
+
+		irq_set_chained_handler_and_data(irq,
 						 ks_pcie_legacy_irq_handler,
 						 ks_pcie);
 	}
-	ks_pcie_enable_legacy_irqs(ks_pcie);
-
-	/* MSI IRQ */
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		for (i = 0; i < ks_pcie->num_msi_host_irqs; i++) {
-			irq_set_chained_handler_and_data(ks_pcie->msi_host_irqs[i],
-							 ks_pcie_msi_irq_handler,
-							 ks_pcie);
-		}
+
+	legacy_irq_domain =
+		irq_domain_add_linear(intc_np, PCI_NUM_INTX,
+				      &ks_pcie_legacy_irq_domain_ops, NULL);
+	if (!legacy_irq_domain) {
+		dev_err(dev, "Failed to add irq domain for legacy irqs\n");
+		ret = -EINVAL;
+		goto err;
 	}
+	ks_pcie->legacy_irq_domain = legacy_irq_domain;
+
+	for (i = 0; i < PCI_NUM_INTX; i++)
+		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), INTx_EN);
+
+err:
+	of_node_put(intc_np);
+	return ret;
+}
 
+static void ks_pcie_setup_interrupts(struct keystone_pcie *ks_pcie)
+{
 	if (ks_pcie->error_irq > 0)
 		ks_pcie_enable_error_irq(ks_pcie);
 }
@@ -754,6 +757,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	int ret;
 
+	ret = ks_pcie_config_legacy_irq(ks_pcie);
+	if (ret)
+		return ret;
+
+	ret = ks_pcie_config_msi_irq(ks_pcie);
+	if (ret)
+		return ret;
+
 	dw_pcie_setup_rc(pp);
 
 	ks_pcie_establish_link(ks_pcie);
@@ -803,20 +814,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	struct device *dev = &pdev->dev;
 	int ret;
 
-	ret = ks_pcie_get_irq_controller_info(ks_pcie,
-					"legacy-interrupt-controller",
-					&ks_pcie->num_legacy_host_irqs);
-	if (ret)
-		return ret;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI)) {
-		ret = ks_pcie_get_irq_controller_info(ks_pcie,
-						"msi-interrupt-controller",
-						&ks_pcie->num_msi_host_irqs);
-		if (ret)
-			return ret;
-	}
-
 	/*
 	 * Index 0 is the platform interrupt for error interrupt
 	 * from RC.  This is optional.
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
