Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A179C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:33:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3268C21872
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 11:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nsIzR4Dq";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="zIPBan9W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268C21872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xJGigScGHh5XN5XIwR3KHCg9Z+IdqTWg7o2NqPpLI6A=; b=nsIzR4DqI42tSI
	37G59VMC4Q3cp0w8kF93zl2cOUX45U1ndNtQsOwRQlCHwA6HyUUwUcNGE3shEkEy3/Wpk/InmNiAz
	xwEAejrunHw88bGUKVBET/ev74KsEkGSODtenlZjb2Pjgh3xRdA8k+iwSV0fwbpEfVSxG8d9yK8iN
	Hu7Q7r4NnavdN/MDANTo7GsmxzbxyRzabgD2a1KEgb695TYGXbKsHjY7kgjuxWbQTkUXLk/CYxiV2
	joVO2QaW4G+CLX1DdqUN8Hn668tk5KtDIk88urNnyZG72ENVPi6E6ZAHbmKJ6jHR24jvk2my/GTJI
	R7m04PL7fLYAvTwcKV7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grhvV-00004z-7q; Thu, 07 Feb 2019 11:33:05 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grhuk-0007n2-0I
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 11:32:21 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x17BW9eU103813;
 Thu, 7 Feb 2019 05:32:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1549539129;
 bh=yikLZbiZ7XlBtVkInDXU3WW2M/89dsx2CmievSEZFwA=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=zIPBan9WFnKykaNJ3mYeGdeO1cDHMLfCuaMKjkgc/+L/VfzFiLAWvrzfk6QEMf3u5
 MU4yK3MBZ/gia0Jqan7zsVq2P0cc0u0zxJkDYZE/HJoQIrXoSk6r1KrOYGTlQM3z1K
 YblD7eFbLUOpWv/hTclyY+2lBtWUOBx4OQ74KfTw=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x17BW9iB021366
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 7 Feb 2019 05:32:09 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Thu, 7
 Feb 2019 05:32:09 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Thu, 7 Feb 2019 05:32:09 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x17BVxam026282;
 Thu, 7 Feb 2019 05:32:06 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v2 2/9] PCI: keystone: Modify legacy_irq_handler to check the
 IRQ_STATUS of INTA/B/C/D
Date: Thu, 7 Feb 2019 16:39:17 +0530
Message-ID: <20190207110924.30716-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207110924.30716-1-kishon@ti.com>
References: <20190207110924.30716-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_033218_161797_57BEFB37 
X-CRM114-Status: GOOD (  20.58  )
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

The legacy interrupt handler directly checks the IRQ_STATUS register
corresponding to a interrupt line inorder to invoke generic_handle_irq.

While this is okay for K2G platform which has separate interrupt line for
each of the 4 legacy interrupts, AM654 which uses the same PCIe wrapper
has a single interrupt line for all the legacy interrupts. So for AM654
the interrupt handler won't be able to directly check the IRQ_STATUS
register corresponding to the interrupt line.

Also the legacy interrupt handler uses 'virq' obtained from
irq_of_parse_and_map to find the correct interrupt line which raised the
interrupt. There is no guarantee that virq assigned for contiguous hardware
irq will be contiguous and the interrupt handler might end up checking
the wrong IRQ_STATUS register.

In order to overcome the above issues, read the IRQ_STATUS register of
all the 4 legacy interrupts to determine which interrupt was raised.

Link: https://lkml.kernel.org/r/bb081d21-7c03-0357-4294-7e92d95d838c@arm.com
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 5286a480f76b..4cf9849d5a1d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -214,16 +214,11 @@ static void ks_pcie_handle_legacy_irq(struct keystone_pcie *ks_pcie,
 {
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 pending;
 	int virq;
 
-	pending = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(offset));
-
-	if (BIT(0) & pending) {
-		virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
-		dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
-		generic_handle_irq(virq);
-	}
+	virq = irq_linear_revmap(ks_pcie->legacy_irq_domain, offset);
+	dev_dbg(dev, ": irq: irq_offset %d, virq %d\n", offset, virq);
+	generic_handle_irq(virq);
 
 	/* EOI the INTx interrupt */
 	ks_pcie_app_writel(ks_pcie, IRQ_EOI, offset);
@@ -607,8 +602,9 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	struct keystone_pcie *ks_pcie = irq_desc_get_handler_data(desc);
 	struct dw_pcie *pci = ks_pcie->pci;
 	struct device *dev = pci->dev;
-	u32 irq_offset = irq - ks_pcie->legacy_host_irqs[0];
 	struct irq_chip *chip = irq_desc_get_chip(desc);
+	unsigned int irq_no;
+	u32 reg;
 
 	dev_dbg(dev, ": Handling legacy irq %d\n", irq);
 
@@ -618,7 +614,13 @@ static void ks_pcie_legacy_irq_handler(struct irq_desc *desc)
 	 * ack operation.
 	 */
 	chained_irq_enter(chip, desc);
-	ks_pcie_handle_legacy_irq(ks_pcie, irq_offset);
+	for (irq_no = 0; irq_no < PCI_NUM_INTX; irq_no++) {
+		reg = ks_pcie_app_readl(ks_pcie, IRQ_STATUS(irq_no));
+		if (!(reg & INTx_EN))
+			continue;
+		ks_pcie_handle_legacy_irq(ks_pcie, irq_no);
+	}
+
 	chained_irq_exit(chip, desc);
 }
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
