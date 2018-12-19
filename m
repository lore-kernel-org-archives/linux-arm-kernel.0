Return-Path: <SRS0=AchV=O4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4C11C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:46:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 288022080D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 19 Dec 2018 12:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pe0xj2QH";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="OXMtqA3D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 288022080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=80yEIPalw13Lsz5jsK258ooNkr7bW+BJ5SGvAxr1b6U=; b=pe0xj2QHxuiQ+z
	Qg+RgS+f6qrurFtLaff5iChGKFe4LIKhEZiC5+Ngd6G1MHA759IcnAh95I40nTYVNRgrFVv0r+kwK
	7o77zC6cSwI+eEduR/qtFfpcfVxiBP0y8AUy+1Dnx0vAf50oq7qPk0P8GmQee9LQTFAGwdEn+FMwb
	YyEmT/5uOLtDq3veUATqho325sraOMilSaGF2RDFykdOJ6uqdapCGYtPrpzRob1tgFP3tdfsdxTTA
	K+FzdlWQ70mZ/DAnJQdB0+byRZTBP82yfRC47jxAuV+zBwifv0a+mQ6QbW1OX4xxD6pyswG2w83aV
	O2xzAUaKiycnm+9NIipg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gZbEX-0003PV-05; Wed, 19 Dec 2018 12:45:53 +0000
Received: from fllv0016.ext.ti.com ([198.47.19.142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gZbBt-00083u-2v
 for linux-arm-kernel@lists.infradead.org; Wed, 19 Dec 2018 12:43:17 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id wBJCgsUI098529;
 Wed, 19 Dec 2018 06:42:54 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1545223374;
 bh=eHM305ms/kyJ8xNolT8aiU6XbuWp3EwzvsUreGR0ytM=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=OXMtqA3DShZcGrfBZkxGH/k0RKJHMNP2gD5G9Vw/gXivBogGDImELbYat3/5SNKQi
 a4OaCiLEvsFFJzCNJic4vTaQXpu7pqHKnwYPghWeu7BWuSMUey0Qcm8X2QliHimRZ6
 5w5ssocZzC19Fax7b4lFCcxmWQg8IDgdF5VcKsS4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id wBJCgs9R062459
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Wed, 19 Dec 2018 06:42:54 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Wed, 19
 Dec 2018 06:42:54 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Wed, 19 Dec 2018 06:42:54 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id wBJCgNZs003940;
 Wed, 19 Dec 2018 06:42:52 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Murali Karicheri <m-karicheri2@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 09/10] PCI: dwc: Remove Keystone specific dw_pcie_host_ops
Date: Wed, 19 Dec 2018 18:12:06 +0530
Message-ID: <20181219124207.13479-10-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181219124207.13479-1-kishon@ti.com>
References: <20181219124207.13479-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181219_044310_046061_60752526 
X-CRM114-Status: GOOD (  18.92  )
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
Cc: Jingoo Han <jingoohan1@gmail.com>, linux-kernel@vger.kernel.org,
 kishon@ti.com, linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Now that Keystone started using it's own msi_irq_chip, remove
Keystone specific callback function defined in dw_pcie_host_ops.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 45 ++++++-------------
 drivers/pci/controller/dwc/pcie-designware.h  |  5 ---
 2 files changed, 14 insertions(+), 36 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index db21bd11f153..dbc94f3be3d5 100644
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
@@ -209,9 +195,6 @@ static void dw_pci_bottom_ack(struct irq_data *d)
 
 	dw_pcie_wr_own_conf(pp, PCIE_MSI_INTR0_STATUS + res, 4, 1 << bit);
 
-	if (pp->ops->msi_irq_ack)
-		pp->ops->msi_irq_ack(d->hwirq, pp);
-
 	raw_spin_unlock_irqrestore(&pp->lock, flags);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0873ee4084aa..53cb6ab405b5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -134,14 +134,9 @@ struct dw_pcie_host_ops {
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
