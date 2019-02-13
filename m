Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CEAC282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9FCB20811
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Mo+76QQj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CYgLadR1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FCB20811
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T0wzcf8erKgutLPzvt+jdsv1Coyzq0tBEeHLf/yz71o=; b=Mo+76QQjbsYS+A
	bZDzRIMTne6Pwj7sABD9wdEbhMjE0zYiwRnufDOVRxKFRfJp2P3BmVV1kQLNr6DostM9CCdhlEF76
	6sx4val8KQFUXMfJpUr4KgK/BpNZ7a3aeoKPYfKZMgikt01WSAjs5DDNC8WCDGd7laI3L8DfFXmnL
	HsMoVF80V9G7p8/2PDp9SNcHXAQkgGZaxJ+vWUDk0hvHIUREtNO4mfeNvN3gIpMMp5cf2HpMPeAoz
	G8DLuAVxcJ+VroIvxgJoC4rLU2qXdJDzAKoKO1flr1bmOcSBX0MezU9pUjgM3GNdU5r91oYMBTJjY
	aZxM5tyOx+aqsS4HRHbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtuam-0005bM-2W; Wed, 13 Feb 2019 13:28:48 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuZi-0004LF-1Y
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:27:51 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRb8h071661;
 Wed, 13 Feb 2019 07:27:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550064457;
 bh=Go6T+1CivfbPMLGs7e9/cCiN7G9c2oxS2QLNAmkij9s=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=CYgLadR1QUBl5g6hirnwgb4U9P2VZjdRRf4Czs/K4dOrmiNIQhAhUIVZIO4thjPbJ
 PpDPFUloM/jHfltnhis2GEq0OntuFHb6Z7dh6FYzgoI6FygqtpHx1nBJjjaMn7M5nJ
 QVT/Q5jvQc+G0Nmy+4ryl5pgMzocC6IC2HF6PhGs=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRb5g117513
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Feb 2019 07:27:37 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:37 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:37 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZg016688;
 Wed, 13 Feb 2019 07:27:34 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 6/9] PCI: dwc: Add support to use non default msi_irq_chip
Date: Wed, 13 Feb 2019 18:56:26 +0530
Message-ID: <20190213132629.24790-7-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052742_195411_1F653709 
X-CRM114-Status: GOOD (  18.46  )
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

Platforms using DesignWare IP use dw_pci_msi_bottom_irq_chip for
configuring the MSI controller logic within the DesignWare IP. However
certain platforms like Keystone (K2G) which uses DesignWare IP have
their own MSI controller logic. For handling such platforms,
the irqchip ops use msi_irq_ack(), msi_set_irq(), msi_clear_irq()
callback functions.

Add support to use different msi_irq_chip with default as
dw_pci_msi_bottom_irq_chip. This is in preparation to get rid of
msi_irq_ack(), msi_set_irq(), msi_clear_irq() and other Keystone
specific dw_pcie_host_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 5 ++++-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 721d60a5d9e4..042de09b0451 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -245,7 +245,7 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_set_info(domain, virq + i, bit + i,
-				    &dw_pci_msi_bottom_irq_chip,
+				    pp->msi_irq_chip,
 				    pp, handle_edge_irq,
 				    NULL, NULL);
 
@@ -277,6 +277,9 @@ int dw_pcie_allocate_domains(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
 
+	if (!pp->msi_irq_chip)
+		pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
+
 	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
 					       &dw_pcie_msi_domain_ops, pp);
 	if (!pp->irq_domain) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 9943d8c68335..cb6eeb062f47 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -176,6 +176,7 @@ struct pcie_port {
 	struct irq_domain	*irq_domain;
 	struct irq_domain	*msi_domain;
 	dma_addr_t		msi_data;
+	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
 	u32			irq_status[MAX_MSI_CTRLS];
 	raw_spinlock_t		lock;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
