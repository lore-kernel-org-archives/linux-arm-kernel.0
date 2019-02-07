Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA7C282C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:32:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B4421904
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="t6U2ITaP";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="f3oRCNyl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B4421904
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ilJFoG3tcC1qoE6dw7AW6xCID722kgt6RGIITzwhmYY=; b=t6U2ITaPnp6vT2
	GNMZZ1CKVeOPd9ZurbbKHJjjHDUFIdMdEMZ3HprkO5co8JnW20uNbrp8snyZAerZJBFhiY0939lL9
	WyWvJY4VVQYHUgB8G+kULPTt19IjuYZf0c+R1ecila7Pgg6o/3TdG1urxo2ZHEna2ESTR62RqoFqK
	G5HCd7c0n82dY58DBx3WBDtzYZY3sHFs7TKIwjbxkIF73qL8ouuKgTTDLvwYw3Bctg4ENBTMdjYNK
	uxBD0O9ytq0YKB7jZt/qpTuuQdKali+vbNkW6HgwNjoCBXhnN+X1AMwWSephRCAMoSWOejqLCS//f
	0/msjY1D7irD2xGmesnA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhvG-0008GP-95; Thu, 07 Feb 2019 11:32:50 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhuj-0007my-Jb
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:32:21 +0000
Received: from fllv0035.itg.ti.com ([10.64.41.0])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BWCQ0085491;
 Thu, 7 Feb 2019 05:32:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549539132;
 bh=EfD/YeSTu2V724ezrxLjWYqdmMyAEeURDfY8l96QaaY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=f3oRCNylVOuFaEFS4RDevoKwGV30QZkPX9bODfZYyzxRYRvbxbQJYk6lLJh6jjoli
 0N5XK5yQrVN9gVCJVMBde7lyfQ071RHIbF+sLG+3+Lx3xq2IhUG1J2FW7gYLjrHRYD
 J67aZef1MyWtQY2YfbJlWGnoCm2F/gVl8LOgISwE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
 by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BWCeQ067521
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 05:32:12 -0600
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:12 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:12 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxan026282;
 Thu, 7 Feb 2019 05:32:09 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 3/9] PCI: keystone: Add separate functions for configuring
 MSI and legacy interrupt
Date: Thu, 7 Feb 2019 16:39:18 +0530
Message-ID: <20190207110924.30716-4-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207110924.30716-1-kishon@ti.com>
References: <20190207110924.30716-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_033217_731138_341C76ED 
X-CRM114-Status: GOOD (  24.26  )
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

ks_pcie_get_irq_controller_info() was used to configure both MSI and
legacy interrupt. This will prevent MSI or legacy interrupt specific
intializations. Add separate functions to configure MSI and legacy
interrupts.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 188 +++++++++++-----------
 1 file changed, 96 insertions(+), 92 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 4cf9849d5a1d..b1d01751c1af 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -87,11 +87,8 @@ struct keystone_pcie {
 	struct dw_pcie		*pci;
 	/* PCI Device ID */
 	u32			device_id;
-	int			num_legacy_host_irqs;
-	int			legacy_host_irqs[PCI_NUM_INTX];
 	struct			device_node *legacy_intc_np;
 
-	int			num_msi_host_irqs;
 	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
 	int			num_lanes;
 	u32			num_viewport;
@@ -201,14 +198,6 @@ static int ks_pcie_msi_host_init(struct pcie_port *pp)
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
@@ -490,17 +479,6 @@ static int __init ks_pcie_dw_host_init(struct keystone_pcie *ks_pcie)
 
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
 
@@ -624,85 +602,117 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
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
+	int irq_count;
+	int irq;
+	int ret;
+	int i;
 
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
+		dev_WARN(dev, "msi-interrupt-controller node is absent\n");
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
+	struct device *dev = ks_pcie->pci->dev;
+	struct irq_domain *legacy_irq_domain;
+	struct device_node *np = ks_pcie->np;
+	struct device_node *intc_np;
+	int irq_count;
+	int irq;
+	int ret;
 	int i;
 
-	/* Legacy IRQ */
-	for (i = 0; i < ks_pcie->num_legacy_host_irqs; i++) {
-		irq_set_chained_handler_and_data(ks_pcie->legacy_host_irqs[i],
+	intc_np = of_get_child_by_name(np, "legacy-interrupt-controller");
+	if (!intc_np) {
+		dev_WARN(dev, "legacy-interrupt-controller node is absent\n");
+		return -EINVAL;
+	}
+
+	irq_count = of_irq_count(intc_np);
+	if (!irq_count) {
+		dev_err(dev, "No IRQ entries in legacy-interrupt-controller\n");
+		ret = -EINVAL;
+		goto err;
+	}
+
+	for (i = 0; i < irq_count; i++) {
+		irq = irq_of_parse_and_map(intc_np, i);
+		if (!irq) {
+			ret = -EINVAL;
+			goto err;
+		}
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
+	of_node_put(intc_np);
+
+	return 0;
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
@@ -756,6 +766,14 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
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
@@ -805,20 +823,6 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
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
