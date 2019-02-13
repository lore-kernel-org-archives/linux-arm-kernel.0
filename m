Return-Path: <SRS0=x1Tr=QU=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79676C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41021222B5
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 13:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ey0Tdrv2";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GA2tpQC5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41021222B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ma1AMZXtCWahJyvNm84s6qjXM37ILuj2o7zeBEJ+tsM=; b=Ey0Tdrv2jBwjEs
	pYjoN7z2m6S7F+KscAjiyBhrNrCY1ZOqHuFU5arkrnzq4eOQwFiN0f7JDaAb82L/Qca2MviK56G48
	ISSE9zfXcNl/QRX40Ob+tZwvaA7M4ng2D25PO+0LsW5O8Sr4Sf4QHPicR+F2in8V4RvwGlcyYqaEZ
	k4GQYX2B76cY8+QG75OVOcsSDepOJK6Ca79C8rxWu9rx4R22v8J1F61HWifkSJbbS5i/8inlJJhsp
	uDN5aBJuoki+3z56z1htY4JGljC3P+6GMGqPlBevX1aEt5hBIY0+Sq++6f1MKLqbiEZUUOM65Bgjt
	ni4gfAdLldMOWWT2NzUA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtub8-00063H-1e; Wed, 13 Feb 2019 13:29:10 +0000
Received: from lelv0142.ext.ti.com ([198.47.23.249])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtuZn-0004TS-Fg
 for linux-arm-kernel@lists.infradead.org; Wed, 13 Feb 2019 13:28:06 +0000
Received: from fllv0034.itg.ti.com ([10.64.40.246])
 by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id x1DDRhgf057465;
 Wed, 13 Feb 2019 07:27:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1550064463;
 bh=Ej0lCLHXKBX9aO4eODglMcOw0plQLus3t2DBx8MCw90=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=GA2tpQC54vRHmhSCJi7kZzxWmXJkQs/TRt62QCcTgH7nQSnpPNHhGnYraiTt1UUAx
 NcwwCeeUfnXay3Lje7wBe2cua0DqLFjphLTCNmrUCN76nnYswg+Xwym3DLMFgSObHa
 GvvP6K7Qk0T5MGwQzmcvsvPKhUkslNCJBoqnh3S0=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
 by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x1DDRhNg025597
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 13 Feb 2019 07:27:43 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 13
 Feb 2019 07:27:42 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 13 Feb 2019 07:27:43 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x1DDRGZi016688;
 Wed, 13 Feb 2019 07:27:40 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>
Subject: [PATCH v3 8/9] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Date: Wed, 13 Feb 2019 18:56:28 +0530
Message-ID: <20190213132629.24790-9-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190213132629.24790-1-kishon@ti.com>
References: <20190213132629.24790-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190213_052748_091169_CE23FE28 
X-CRM114-Status: GOOD (  18.79  )
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

Now that Keystone started using its own msi_irq_chip, remove
Keystone specific callback functions defined in dw_pcie_host_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  5 --
 2 files changed, 14 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 72cfedce5af1..781735f06dea 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -126,18 +126,12 @@ static void dw_pci_setup_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	u64 msi_target;
 
-	if (pp->ops->get_msi_addr)
-		msi_target = pp->ops->get_msi_addr(pp);
-	else
-		msi_target = (u64)pp->msi_data;
+	msi_target = (u64)pp->msi_data;
 
 	msg->address_lo = lower_32_bits(msi_target);
 	msg->address_hi = upper_32_bits(msi_target);
 
-	if (pp->ops->get_msi_data)
-		msg->data = pp->ops->get_msi_data(pp, data->hwirq);
-	else
-		msg->data = data->hwirq;
+	msg->data = data->hwirq;
 
 	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
 		(int)data->hwirq, msg->address_hi, msg->address_lo);
@@ -157,17 +151,13 @@ static void dw_pci_bottom_mask(struct irq_data *data)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	if (pp->ops->msi_clear_irq) {
-		pp->ops->msi_clear_irq(pp, data->hwirq);
-	} else {
-		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
-		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
+	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] &= ~(1 << bit);
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
-	}
+	pp->irq_status[ctrl] &= ~(1 << bit);
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+			    ~pp->irq_status[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -180,17 +170,13 @@ static void dw_pci_bottom_unmask(struct irq_data *data)
 
 	raw_spin_lock_irqsave(&pp->lock, flags);
 
-	if (pp->ops->msi_set_irq) {
-		pp->ops->msi_set_irq(pp, data->hwirq);
-	} else {
-		ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
-		res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-		bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
+	ctrl = data->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = data->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-		pp->irq_status[ctrl] |= 1 << bit;
-		dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
-				    ~pp->irq_status[ctrl]);
-	}
+	pp->irq_status[ctrl] |= 1 << bit;
+	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_MASK + res, 4,
+			    ~pp->irq_status[ctrl]);
 
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
@@ -199,20 +185,12 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 {
 	struct pcie_port *pp  = irq_data_get_irq_chip_data(d);
 	unsigned int res, bit, ctrl;
-	unsigned long flags;
 
 	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
 	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
 	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
 
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
-
-	if (pp->ops->msi_irq_ack)
-		pp->ops->msi_irq_ack(d->hwirq, pp);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
 static struct irq_chip dw_pci_msi_bottom_irq_chip = {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index cb6eeb062f47..ac75cde80a0c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -142,14 +142,9 @@ struct dw_pcie_host_ops {
 	int (*wr_other_conf)(struct pcie_port *pp, struct pci_bus *bus,
 			     unsigned int devfn, int where, int size, u32 val);
 	int (*host_init)(struct pcie_port *pp);
-	void (*msi_set_irq)(struct pcie_port *pp, int irq);
-	void (*msi_clear_irq)(struct pcie_port *pp, int irq);
-	phys_addr_t (*get_msi_addr)(struct pcie_port *pp);
-	u32 (*get_msi_data)(struct pcie_port *pp, int pos);
 	void (*scan_bus)(struct pcie_port *pp);
 	void (*set_num_vectors)(struct pcie_port *pp);
 	int (*msi_host_init)(struct pcie_port *pp);
-	void (*msi_irq_ack)(int irq, struct pcie_port *pp);
 };
 
 struct pcie_port {
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
