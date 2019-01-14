Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D2A7C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3E4952086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Tf8VAu2O";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XguTTcbM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4952086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=v5eukgvH77N1oBhNm5sKSADvwV8GR+69shSaTkfJd28=; b=Tf8VAu2OowENj2
	yzR029rm0N8BLzkIpaFQjd7ZtfGoEO+K82IGsu5+Oy5ns3kuL3Ct85VfxpV7xU6y/7YpeL574WM21
	3BsmDF2ung9LyyC3ZZLJIFY8IRnrX1vk979gO400WMl+uEsS1gcZXK6h4uEoN0d6kJrP7Sxn+HUe3
	HG0FtLbjdW3GotLZFYeBWYZadfwpzTw34EaqUmBeHQWyNxv0T/gOEIC3AFABC4cR/jnJmMBubUxgF
	MyNFacS/VpkdQf9sZvlce8XG+LDwuLuxox+/VeNmV3Ez0VKQxJhx+4IQnxCvR2FaLdbF8f9SIA7Tf
	ZiOhKPNhwkQMlAlwdzlg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2F4-0003Tv-7y; Mon, 14 Jan 2019 13:25:26 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2Eo-0003E4-Mq
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:25:12 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDP1r4041058;
 Mon, 14 Jan 2019 07:25:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472301;
 bh=/1J959qeP7cM4MKMLmkewqVjCysFTBea7AaLB6rN+lY=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=XguTTcbMlPaXHdo+Sr5XTVFMC5/hje6r8r5Xv9a5pOyUssOCHqFJA4XbVWPYtNC5t
 rcASvHisswUhUWIjU2pcf8+55STLnMyZwaNYpXRDaKrvCRJ2ZgRXjnfgZ9oYwC/9y2
 fef1j4oZ1sjnBuQEc4oWYdgwZpKhf1ProVMwNyno=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDP18W055900
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:25:01 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:25:00 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:25:00 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWN028516;
 Mon, 14 Jan 2019 07:24:56 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 01/24] PCI: keystone: Add start_link/stop_link dw_pcie_ops
Date: Mon, 14 Jan 2019 18:54:01 +0530
Message-ID: <20190114132424.6445-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052510_828353_118B0D21 
X-CRM114-Status: GOOD (  20.35  )
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 Jesper Nilsson <jesper.nilsson@axis.com>, Arnd Bergmann <arnd@arndb.de>,
 Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com,
 Kishon Vijay Abraham I <kishon@ti.com>, Murali Karicheri <m-karicheri2@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add start_link/stop_link dw_pcie_ops and invoke ks_pcie_start_link
directly from host_init. start_link/stop_link ops is required for
adding EP mode support.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/pci-keystone.c | 44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 420d30ce11f4..24c38ae570b5 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -419,18 +419,33 @@ static int ks_pcie_link_up(struct dw_pcie *pci)
 	return (val == PORT_LOGIC_LTSSM_STATE_L0);
 }
 
-static void ks_pcie_initiate_link_train(struct keystone_pcie *ks_pcie)
+static void ks_pcie_stop_link(struct dw_pcie *pci)
 {
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
 	u32 val;
 
 	/* Disable Link training */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	val &= ~LTSSM_EN_VAL;
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+}
+
+static int ks_pcie_start_link(struct dw_pcie *pci)
+{
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	struct device *dev = pci->dev;
+	u32 val;
+
+	if (dw_pcie_link_up(pci)) {
+		dev_dbg(dev, "link is already up\n");
+		return 0;
+	}
 
 	/* Initiate Link Training */
 	val = ks_pcie_app_readl(ks_pcie, CMD_STATUS);
 	ks_pcie_app_writel(ks_pcie, CMD_STATUS, LTSSM_EN_VAL | val);
+
+	return 0;
 }
 
 /**
@@ -515,26 +530,6 @@ static void ks_pcie_quirk(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_ENABLE(PCI_ANY_ID, PCI_ANY_ID, ks_pcie_quirk);
 
-static int ks_pcie_establish_link(struct keystone_pcie *ks_pcie)
-{
-	struct dw_pcie *pci = ks_pcie->pci;
-	struct device *dev = pci->dev;
-
-	if (dw_pcie_link_up(pci)) {
-		dev_info(dev, "Link already up\n");
-		return 0;
-	}
-
-	ks_pcie_initiate_link_train(ks_pcie);
-
-	/* check if the link is up or not */
-	if (!dw_pcie_wait_for_link(pci))
-		return 0;
-
-	dev_err(dev, "phy link never came up\n");
-	return -ETIMEDOUT;
-}
-
 static void ks_pcie_msi_irq_handler(struct irq_desc *desc)
 {
 	unsigned int irq = desc->irq_data.hwirq;
@@ -796,7 +791,7 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 
-	ks_pcie_establish_link(ks_pcie);
+	ks_pcie_stop_link(pci);
 	ks_pcie_setup_rc_app_regs(ks_pcie);
 	ks_pcie_setup_interrupts(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
@@ -813,6 +808,9 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	hook_fault_code(17, ks_pcie_fault, SIGBUS, 0,
 			"Asynchronous external abort");
 
+	ks_pcie_start_link(pci);
+	dw_pcie_wait_for_link(pci);
+
 	return 0;
 }
 
@@ -875,6 +873,8 @@ static const struct of_device_id ks_pcie_of_match[] = {
 };
 
 static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
+	.start_link = ks_pcie_start_link,
+	.stop_link = ks_pcie_stop_link,
 	.link_up = ks_pcie_link_up,
 };
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
