Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27DAC43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:18:58 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9804C20855
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:18:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FYMPnaVr";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rGcgScG9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9804C20855
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=tdbvR2XAH3AwLuK97DXJlqyHzdx4rfnztlFQ/NBZSwY=; b=FYMPnaVrBff8yB
	+Kf6gSkq6d4+Iitob+R4g4OsCEH2KODw+x/zz+/8DaTgmt9xQpCsTBlqVGxPiTJ2z0bKtpnYiUR4p
	OgHVG0Tq63OGZdr4HfOkDt3/wGAAmHVsVG/IxRhx0phMGJQZBehjB7//WynA7wlMjiin6WQVY+ppd
	fQS04ZO3rNRlrsRO7QnQaVpFQsYl0ck2UYm6rJ6w/ec1Bmk1gQeer5zo8ORp+/T2PYtwCsKO5Odw2
	oNBKWGFU7bdhDnbetZ0FIoWQ08GH7tQl7HVC0w6VyACU7Ra2glOz5lLT0KPWYnBHSzQ35L5Nej9NJ
	GI/6kLfV354LCc3I3jqQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwlRQ-0003hD-2W; Thu, 21 Feb 2019 10:18:56 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwlR5-0003Ji-1z
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 10:18:36 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1LAIUjV062496;
 Thu, 21 Feb 2019 04:18:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550744310;
 bh=GmaChAagvvR3BKGTtUPZxsSHjPP8U/j4RxXcXLkz7sg=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=rGcgScG9w2KngadT7i7DrpImMJwNvdju4GpR5bvvrfN4Hb69eYRcmS3SLhcIgcQLw
 kyTm96MkdOTYEOxx10G7PU1aH1njXyQzF1+/94NU+VXajbb9JyLTdK+oWS2QxaeweR
 8nS+DIO+EIOA3AFMwsQ9ruWFz2/wp+FpIFBKt9Fo=
Received: from DFLE102.ent.ti.com (dfle102.ent.ti.com [10.64.6.23])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1LAIUnD070311
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 21 Feb 2019 04:18:30 -0600
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE102.ent.ti.com
 (10.64.6.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 21
 Feb 2019 04:18:30 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 21 Feb 2019 04:18:30 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1LAIORG022198;
 Thu, 21 Feb 2019 04:18:27 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v4 1/9] PCI: keystone: Cleanup interrupt related macros
Date: Thu, 21 Feb 2019 15:45:10 +0530
Message-ID: <20190221101518.22604-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190221101518.22604-1-kishon@ti.com>
References: <20190221101518.22604-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_021835_176245_EF709824 
X-CRM114-Status: GOOD (  16.54  )
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

No functional change. Change both MSI interrupt and legacy interrupt
related macros to take an additional argument in order to return the
correct register offset.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 26 +++++++++++------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 14f2b0b4ed5e..5286a480f76b 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -52,17 +52,17 @@
 
 /* IRQ register defines */
 #define IRQ_EOI				0x050
-#define IRQ_STATUS			0x184
-#define IRQ_ENABLE_SET			0x188
-#define IRQ_ENABLE_CLR			0x18c
 
 #define MSI_IRQ				0x054
-#define MSI0_IRQ_STATUS			0x104
-#define MSI0_IRQ_ENABLE_SET		0x108
-#define MSI0_IRQ_ENABLE_CLR		0x10c
-#define IRQ_STATUS			0x184
+#define MSI_IRQ_STATUS(n)		(0x104 + ((n) << 4))
+#define MSI_IRQ_ENABLE_SET(n)		(0x108 + ((n) << 4))
+#define MSI_IRQ_ENABLE_CLR(n)		(0x10c + ((n) << 4))
 #define MSI_IRQ_OFFSET			4
 
+#define IRQ_STATUS(n)			(0x184 + ((n) << 4))
+#define IRQ_ENABLE_SET(n)		(0x188 + ((n) << 4))
+#define INTx_EN				BIT(0)
+
 #define ERR_IRQ_STATUS			0x1c4
 #define ERR_IRQ_ENABLE_SET		0x1c8
 #define ERR_AER				BIT(5)	/* ECRC error */
@@ -142,7 +142,7 @@ static void ks_pcie_handle_msi_irq(struct keystone_pcie *ks_pcie, int offset)
 	u32 pending, vector;
 	int src, virq;
 
-	pending = ks_pcie_app_readl(ks_pcie, MSI0_IRQ_STATUS + (offset << 4));
+	pending = ks_pcie_app_readl(ks_pcie, MSI_IRQ_STATUS(offset));
 
 	/*
 	 * MSI0 status bit 0-3 shows vectors 0, 8, 16, 24, MSI1 status bit
@@ -169,7 +169,7 @@ static void ks_pcie_msi_irq_ack(int irq, struct pcie_port *pp)
 	ks_pcie = to_keystone_pcie(pci);
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
 
-	ks_pcie_app_writel(ks_pcie, MSI0_IRQ_STATUS + (reg_offset << 4),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_STATUS(reg_offset),
 			   BIT(bit_pos));
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, reg_offset + MSI_IRQ_OFFSET);
 }
@@ -181,7 +181,7 @@ static void ks_pcie_msi_set_irq(struct pcie_port *pp, int irq)
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_pcie_app_writel(ks_pcie, MSI0_IRQ_ENABLE_SET + (reg_offset << 4),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_SET(reg_offset),
 			   BIT(bit_pos));
 }
 
@@ -192,7 +192,7 @@ static void ks_pcie_msi_clear_irq(struct pcie_port *pp, int irq)
 	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 
 	update_reg_offset_bit_pos(irq, &reg_offset, &bit_pos);
-	ks_pcie_app_writel(ks_pcie, MSI0_IRQ_ENABLE_CLR + (reg_offset << 4),
+	ks_pcie_app_writel(ks_pcie, MSI_IRQ_ENABLE_CLR(reg_offset),
 			   BIT(bit_pos));
 }
 
@@ -206,7 +206,7 @@ static void ks_pcie_enable_legacy_irqs(struct keystone_pcie *ks_pcie)
 	int i;
 
 	for (i = 0; i < PCI_NUM_INTX; i++)
-		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET + (i << 4), 0x1);
+		ks_pcie_app_writel(ks_pcie, IRQ_ENABLE_SET(i), 0x1);
 }
 
 static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
@@ -217,7 +217,7 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 	u32 pending;
 	int virq;
 
-	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS + (offset << 4));
+	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
 
 	if (BIT(0) & pending) {
 		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
