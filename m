Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9747BC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5017120811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s0J3iRa/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="YuUBJZma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5017120811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZVAah6yIYo1x6fwPtYuTL6fROVLJGm1KvqZ1K1aeaLc=; b=s0J3iRa/vdAhsE
	+KSdy43NyS9pWpwJbNAb5mPo7tzOCAz+LHt1MyGXmi0Qt4SQpijiAVCGjoPtAT3JSyGU/KLc0i6hJ
	2fwjXOFgrYvA6pjFd6GDjlIQlRJ8NR9ACzHP9/uEEOLm7Xi1x3PWcO27nftAf5XUHNGI3IUvOeDwg
	yoJkB8fzSxU47eButhP3q6qnhDjAHNmB4qzrBqK+XlPOuFsKbwOBl54zHvv+5AVgZEfdG8rpJc1uW
	bATKrYo5Vk6hT6/Y3+MYr9LJXeaf3F7EobP2hwfli7oULsCaUBZKui7JABU2nJGvEd1svEzJrGX8f
	Z5nlV646dKQhm7pfcoNg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuaB-000503-ER; Wed, 13 Feb 2019 13:28:11 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuZc-0004Bj-B9
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:27:42 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRVQi071631;
 Wed, 13 Feb 2019 07:27:31 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550064451;
 bh=7MdHPJ7rWOh896bss+DBXdVKPNNaFRcm80DCZwUWhMw=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=YuUBJZmator+G9d4zU9DTKCVF1hz9N7KBv6rv8YUc5KwTVW3ZiEMzR1NYKPDZoDm0
 ClQ7sKz8NRK5Eh4VWyadE5VSKXU0H1iZrfjf2a2HfwAE/feWFOAZFY6BkuXNArbeYO
 ySqDiSHoxaKAPR98LVvt9fgFoU/nTBW/zfg0/jBU=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRVNH117469
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Feb 2019 07:27:31 -0600
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:31 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:31 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZe016688;
 Wed, 13 Feb 2019 07:27:29 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 4/9] PCI: keystone: Use hwirq to get the MSI IRQ number
 offset
Date: Wed, 13 Feb 2019 18:56:24 +0530
Message-ID: <20190213132629.24790-5-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052737_085498_905148D8 
X-CRM114-Status: GOOD (  21.50  )
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
index d35ac712a9f8..90d64507acd0 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -74,7 +74,6 @@
 #define ERR_IRQ_ALL			(ERR_AER | ERR_AXI | ERR_CORR | \
 					 ERR_NONFATAL | ERR_FATAL | ERR_SYS)
 
-#define MAX_MSI_HOST_IRQS		8
 /* PCIE controller device IDs */
 #define PCIE_RC_K2HK			0xb008
 #define PCIE_RC_K2E			0xb009
@@ -90,7 +89,7 @@ struct keystone_pcie {
 	int			legacy_host_irq;
 	struct			device_node *legacy_intc_np;
 
-	int			msi_host_irqs[MAX_MSI_HOST_IRQS];
+	int			msi_host_irq;
 	int			num_lanes;
 	u32			num_viewport;
 	struct phy		**phy;
@@ -553,9 +552,9 @@ static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
 
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
@@ -606,6 +605,7 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
 	struct device *dev = ks_pcie->pci->dev;
 	struct device_node *np = ks_pcie->np;
 	struct device_node *intc_np;
+	struct irq_data *irq_data;
 	int irq_count, irq, ret, i;
 
 	if (!IS_ENABLED(CONFIG_PCI_MSI))
@@ -624,19 +624,21 @@ static int ks_pcie_config_msi_irq(struct keystone_pcie *ks_pcie)
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
