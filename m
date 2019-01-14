Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81099C43612
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4F24C2086D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gjUpyzTp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="i9hTjCS/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F24C2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=kuGBHAsVpq7IO/DTbzAZOwJ9jaC3edT9y3e3DkYlBPU=; b=gjUpyzTpuxKfXs
	IqKvBiSMEAmiwERweyqqi72k+w/DbySbesbk77uvgrXspheb8q2HwhzZKT7ri8DamS77NU9cGyyGF
	05RTO8ZL5ieTWC9Slm2Vt4bKW/KqLd7trCIHovXHzHF34fNSwU/bIBg+6pyPLNpm3wga5xsNDzEEv
	McPs8xCwS3d8VhR+DmPJdkHgCYZ2sI+AU459dS6MrkdWlIhf8X3Kdr4UWDHcbr5zH+N/aiPvSy6ZB
	2dV08IghVB/7zhHauO4NKG1Rg87kMYBY28UhfnouEK9E+PYDx1dUE+KHpHNt1A5e1XMPV3yom+RHz
	yVfBwWWy0hcVNiPtlrBg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj0EN-0000QW-P8; Mon, 14 Jan 2019 11:16:35 +0000
Received: from lelv0143.ext.ti.com ([198.47.23.248])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj0Dl-0008DS-IU; Mon, 14 Jan 2019 11:16:00 +0000
Received: from lelv0265.itg.ti.com ([10.180.67.224])
 by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EBFmA1112623;
 Mon, 14 Jan 2019 05:15:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547464548;
 bh=7zfWfnCQeG4SmqHvA26Y+pmRNPO6bCuT02zsP3l4mz4=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=i9hTjCS/NUPQO4ZstIx+7yGt3pVQWFkwD3rmw6yWgqWtxRt6ME/fkhZINKNuh51l9
 fBbq9DuhWKCMeg9BOIUBfukGT3OWaEkauKys5wSvN+mMme1DQMdtZy5lAzXDFVfV0c
 5xuszTFS43yYbeyMUGY+1yP42P1ghep3Mg5HEJmw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
 by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EBFmRZ107813
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 05:15:48 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 05:15:47 -0600
Received: from dflp32.itg.ti.com (10.64.6.15) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 05:15:47 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dflp32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EBFd1T011560;
 Mon, 14 Jan 2019 05:15:44 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>, Lorenzo Pieralisi
 <lorenzo.pieralisi@arm.com>, Gustavo Pimentel
 <gustavo.pimentel@synopsys.com>, Alan Douglas <adouglas@cadence.com>, Shawn
 Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 01/15] PCI: endpoint: Add new pci_epc_ops to get EPC
 features
Date: Mon, 14 Jan 2019 16:44:59 +0530
Message-ID: <20190114111513.21618-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114111513.21618-1-kishon@ti.com>
References: <20190114111513.21618-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_031557_730037_05ADC2D7 
X-CRM114-Status: GOOD (  19.07  )
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
 linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add a new pci_epc_ops ->get_features() to get the features
supported by EPC. Since EPC can provide different features to
different functions, the ->get_features() ops takes _func_no_ as
an argument.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/pci-epc-core.c | 30 +++++++++++++++++++++++++++++
 include/linux/pci-epc.h             | 22 +++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 094dcc3203b8..5a099479d9ab 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -83,6 +83,36 @@ struct pci_epc *pci_epc_get(const char *epc_name)
 }
 EXPORT_SYMBOL_GPL(pci_epc_get);
 
+/**
+ * pci_epc_get_features() - get the features supported by EPC
+ * @epc: the features supported by *this* EPC device will be returned
+ * @func_no: the features supported by the EPC device specific to the
+ *	     endpoint function with func_no will be returned
+ *
+ * Invoke to get the features provided by the EPC which may be
+ * specific to an endpoint function. Returns pci_epc_features on success
+ * and NULL for any failures.
+ */
+const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
+						    u8 func_no)
+{
+	const struct pci_epc_features *epc_features;
+	unsigned long flags;
+
+	if (IS_ERR_OR_NULL(epc) || func_no >= epc->max_functions)
+		return NULL;
+
+	if (!epc->ops->get_features)
+		return NULL;
+
+	spin_lock_irqsave(&epc->lock, flags);
+	epc_features = epc->ops->get_features(epc, func_no);
+	spin_unlock_irqrestore(&epc->lock, flags);
+
+	return epc_features;
+}
+EXPORT_SYMBOL_GPL(pci_epc_get_features);
+
 /**
  * pci_epc_stop() - stop the PCI link
  * @epc: the link of the EPC device that has to be stopped
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 37dab8116901..79fbcf94e14d 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -59,6 +59,8 @@ struct pci_epc_ops {
 			     enum pci_epc_irq_type type, u16 interrupt_num);
 	int	(*start)(struct pci_epc *epc);
 	void	(*stop)(struct pci_epc *epc);
+	const struct pci_epc_features* (*get_features)(struct pci_epc *epc,
+						       u8 func_no);
 	struct module *owner;
 };
 
@@ -100,6 +102,24 @@ struct pci_epc {
 	unsigned int			features;
 };
 
+/**
+ * struct pci_epc_features - features supported by a EPC device per function
+ * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
+ * @msi_capable: indicate if the endpoint function has MSI capability
+ * @msix_capable: indicate if the endpoint function has MSI-X capability
+ * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
+ * @bar_fixed_64bit: bitmap to indicate fixed 64bit BARs
+ * @bar_fixed_size: Array specifying the size supported by each BAR
+ */
+struct pci_epc_features {
+	unsigned int	linkup_notifier : 1;
+	unsigned int	msi_capable : 1;
+	unsigned int	msix_capable : 1;
+	u8	reserved_bar;
+	u8	bar_fixed_64bit;
+	u64	bar_fixed_size[BAR_5 + 1];
+};
+
 #define EPC_FEATURE_NO_LINKUP_NOTIFIER		BIT(0)
 #define EPC_FEATURE_BAR_MASK			(BIT(1) | BIT(2) | BIT(3))
 #define EPC_FEATURE_MSIX_AVAILABLE		BIT(4)
@@ -158,6 +178,8 @@ int pci_epc_raise_irq(struct pci_epc *epc, u8 func_no,
 		      enum pci_epc_irq_type type, u16 interrupt_num);
 int pci_epc_start(struct pci_epc *epc);
 void pci_epc_stop(struct pci_epc *epc);
+const struct pci_epc_features *pci_epc_get_features(struct pci_epc *epc,
+						    u8 func_no);
 struct pci_epc *pci_epc_get(const char *epc_name);
 void pci_epc_put(struct pci_epc *epc);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
