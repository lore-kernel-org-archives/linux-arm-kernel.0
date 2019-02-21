Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1069C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:36 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90E9520836
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UyUSbe/B";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ulCxE0QS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90E9520836
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=PZShH8se8RoCCELT+mUOsO3Yjf1M2IWttvF4drStDG0=; b=UyUSbe/Bs+x+pB
	Q9Nu4yqTjwpQIrRS1HEZBUp/lvrAwQqWRJW0pSrkgZP5WKG2cyKq//59fCMS3FFz8TNMpETGfbSyM
	VsjtEx1fKEiE7QyTBwW3CEMJPMIYlu0AM2Yxj31VI8AeBw4ZAl/V7PmENIhDflEHwp1wXwGCXHZFB
	xfhUVwMgKFO5K+rD+t09AAlfcHQqLLBP7qSvqoeZisYYb8EJj9KdGnaptuirhrI+Phd0i4qfhUwNz
	ymVHEu+BJg6RnYE8sRibO2DxwWSAVrRA1oX7M80EsZCs/uifmDLXC9ZyEWfAaUQ6Yeux66YhGyDye
	VRbyAFCL7jzLYYpiYyJA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlRx-0004TG-9W; Thu, 21 Feb 2019 10:19:29 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlRD-0003Ru-6F
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:18:48 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIdV2053151;
 Thu, 21 Feb 2019 04:18:39 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550744319;
 bh=jj6FmrtAATey3jXJiSTKNFfft8ZueXEih9SzlA0HGn0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=ulCxE0QS++KfNd9ZaYoPlqNLYknNU4OzUSY4WPh+dB/PjGvg+c4PYTm1qB2ScdlvS
 Gvqj0gCIEc4qyAiysadySuT4lt2gmLdgEhxfHJJEsU0EGBDdwdYFBLnyzuECqVBEnL
 akcnr/oPSQbjuunEbtql9nYWKUTzWDMnaFJtPXtk=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIdf8070437
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Feb 2019 04:18:39 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:38 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:38 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORJ022198;
 Thu, 21 Feb 2019 04:18:36 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 4/9] PCI: keystone: Use hwirq to get the MSI IRQ number
 offset
Date: Thu, 21 Feb 2019 15:45:13 +0530
Message-ID: <20190221101518.22604-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221101518.22604-1-kishon@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_021844_008379_3521A2EF 
X-CRM114-Status: GOOD (  20.45  )
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

ks_pcie_msi_irq_handler() uses 'virq' to get the IRQ number offset.
This offset is used to get the correct MSI_IRQ_STATUS register
corresponding to the IRQ line that raised the interrupt.
There is no guarantee that 'virq' assigned for consecutive hardware
IRQ will be contiguous. And this might get us an incorrect IRQ number
offset.

Fix it here by using 'hwirq' to get the IRQ number offset. Since we
don't store the 'virq' numbers of all the IRQ numbers, stop checking
if irq count is greater than MAX_MSI_HOST_IRQS and remove
MAX_MSI_HOST_IRQS.

Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 24 ++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 7f1648453f54..0ebb8622fddb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -75,7 +75,6 @@
 #define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
 					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
-#define MAX_MSI_HOST_IRQS		8
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK			0xb008
 #define PCIE_RC_K2E			0xb009
@@ -90,7 +89,7 @@ struct keystone_pcie {
 	u32			device_id;
 	struct			device_node *legacy_intc_np;
 
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			msi_host_irq;
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
@@ -610,9 +609,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
-	unsigned int irq = irq_desc_get_irq(desc);
+	unsigned int irq = desc->irq_data.hwirq;
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
-	u32 offset = irq - ks_pcie->msi_host_irqs[0];
+	u32 offset = irq - ks_pcie->msi_host_irq;
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -634,6 +633,7 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
+	struct irq_data *irq_data;
 	int irq_count, irq, ret, i;
 
 	if (!IS_ENABLED(CONFIG_PCI_MSI))
@@ -652,19 +652,21 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 		goto err;
 	}
 
-	if (irq_count > MAX_MSI_HOST_IRQS) {
-		dev_warn(dev, "Too many MSI interrupt lines defined %u\n",
-			 irq_count);
-		irq_count = MAX_MSI_HOST_IRQS;
-	}
-
 	for (i = 0; i < irq_count; i++) {
 		irq = irq_of_parse_and_map(intc_np, i);
 		if (!irq) {
 			ret = -EINVAL;
 			goto err;
 		}
-		ks_pcie->msi_host_irqs[i] = irq;
+
+		if (!ks_pcie->msi_host_irq) {
+			irq_data = irq_get_irq_data(irq);
+			if (!irq_data) {
+				ret = -EINVAL;
+				goto err;
+			}
+			ks_pcie->msi_host_irq = irq_data->hwirq;
+		}
 
 		irq_set_chained_handler_and_data(irq, ks_pcie_msi_irq_handler,
 						 ks_pcie);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
