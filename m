Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F29C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:51 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B34214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 01:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KkMAHzhO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19B34214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XE+vgQsYh0Atu+/jRX4auN47X1N+ilwx0Ocd3ALY00U=; b=KkMAHzhOE5O0Y3
	+ztXABDhx2P1gWj5LbmSyNAuQCjfyvLPGlpO00IqKF7OKCU9vF22NBwnzCARzO3odLn6tzAZQhET0
	LUSf0yNoaYVWcLzSiuVmP540zOTYnT5raKRCQYwqEjM5w1a2GrdhynoLUBMhMsOUbg2oFaAOel49z
	tWsemCuaUYKP/nsj47RMcvjyafg2Rx32YWFcydH8ZZZu74zp7cB8GLC3Vwy6qpDSyQiptex4b4jR1
	CA4/IDu6M7V8Ur7d2FizgC0dKwh7xxH0+HrWi5FzlG7M6cHxboeGn37cmTe2aCMX6jqZQm4PH7vsM
	fMvsfH0/rsv/mBwaOePA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUiAi-0001kk-Or; Thu, 06 Dec 2018 01:09:44 +0000
Received: from [210.61.82.184] (helo=mailgw02.mediatek.com)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUiAc-0001hq-DL; Thu, 06 Dec 2018 01:09:42 +0000
X-UUID: f925863b2cee4e619ee0f4992650c4a3-20181206
X-UUID: f925863b2cee4e619ee0f4992650c4a3-20181206
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by
 mailgw02.mediatek.com (envelope-from <jianjun.wang@mediatek.com>)
 (mhqrelay.mediatek.com ESMTP with TLS)
 with ESMTP id 2003207512; Thu, 06 Dec 2018 09:09:21 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 6 Dec 2018 09:09:20 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 6 Dec 2018 09:09:19 +0800
From: Jianjun Wang <jianjun.wang@mediatek.com>
To: <ryder.lee@mediatek.com>, <bhelgaas@google.com>, <robh+dt@kernel.org>,
 <lorenzo.pieralisi@arm.com>, <matthias.bgg@gmail.com>,
 <linux-pci@vger.kernel.org>
Subject: [PATCH 2/2] PCI: mediatek: Add controller support for MT7629
Date: Thu, 6 Dec 2018 09:09:13 +0800
Message-ID: <1544058553-10936-3-git-send-email-jianjun.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
References: <1544058553-10936-1-git-send-email-jianjun.wang@mediatek.com>
MIME-Version: 1.0
X-TM-SNTS-SMTP: A023BCEA8D70FAFF7E6DD84C093D03E3E7BD40AA7C98361D308535D6AD2714F52000:8
X-MTK: N
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181205_170938_712610_3E6E284F 
X-CRM114-Status: GOOD (  13.70  )
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org, youlin.pei@mediatek.com,
 linux-kernel@vger.kernel.org, Jianjun Wang <jianjun.wang@mediatek.com>,
 linux-mediatek@lists.infradead.org, honghui.zhang@mediatek.com,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

MT7629 is an arm platform SoC which has the same PCIe IP with MT7622.

The read value of BAR0 is 0xffff_ffff, it's size will be calculated as 4GB
in arm64 but bogus alignment values at arm32, the pcie device and devices
behind this bridge will not be enabled. Fix it's BAR0 resource size to
guarantee the pcie devices will be enabled correctly.

The HW default value of its device id is invalid, fix it's device id to
match the hardware implementation.

Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
---
 drivers/pci/controller/pcie-mediatek.c | 26 ++++++++++++++++++++++++++
 include/linux/pci_ids.h                |  1 +
 2 files changed, 27 insertions(+)

diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
index d20cf461ba00..f8937cc3c87c 100644
--- a/drivers/pci/controller/pcie-mediatek.c
+++ b/drivers/pci/controller/pcie-mediatek.c
@@ -73,6 +73,7 @@
 #define PCIE_MSI_VECTOR		0x0c0
 
 #define PCIE_CONF_VEND_ID	0x100
+#define PCIE_CONF_DEVICE_ID	0x102
 #define PCIE_CONF_CLASS_ID	0x106
 
 #define PCIE_INT_MASK		0x420
@@ -135,12 +136,14 @@ struct mtk_pcie_port;
 /**
  * struct mtk_pcie_soc - differentiate between host generations
  * @need_fix_class_id: whether this host's class ID needed to be fixed or not
+ * @need_fix_device_id: whether this host's device ID needed to be fixed or not
  * @ops: pointer to configuration access functions
  * @startup: pointer to controller setting functions
  * @setup_irq: pointer to initialize IRQ functions
  */
 struct mtk_pcie_soc {
 	bool need_fix_class_id;
+	bool need_fix_device_id;
 	struct pci_ops *ops;
 	int (*startup)(struct mtk_pcie_port *port);
 	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
@@ -692,6 +695,11 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
 		writew(val, port->base + PCIE_CONF_CLASS_ID);
 	}
 
+	if (soc->need_fix_device_id) {
+		val = PCI_DEVICE_ID_MEDIATEK_7629;
+		writew(val, port->base + PCIE_CONF_DEVICE_ID);
+	}
+
 	/* 100ms timeout value should be enough for Gen1/2 training */
 	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
 				 !!(val & PCIE_PORT_LINKUP_V2), 20,
@@ -1238,11 +1246,29 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
 	.setup_irq = mtk_pcie_setup_irq,
 };
 
+static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
+	.need_fix_class_id = true,
+	.need_fix_device_id = true,
+	.ops = &mtk_pcie_ops_v2,
+	.startup = mtk_pcie_startup_port_v2,
+	.setup_irq = mtk_pcie_setup_irq,
+};
+
+static void mtk_fixup_bar_size(struct pci_dev *dev)
+{
+	struct resource *dev_res = &dev->resource[0];
+	/* 32bit resource length will calculate size to 0, set it smaller */
+	dev_res->end = 0xfffffffe;
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_MEDIATEK, PCI_DEVICE_ID_MEDIATEK_7629,
+			 mtk_fixup_bar_size);
+
 static const struct of_device_id mtk_pcie_ids[] = {
 	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
 	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
 	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
+	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
 	{},
 };
 
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 69f0abe1ba1a..77b278bac3a8 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2126,6 +2126,7 @@
 #define PCI_VENDOR_ID_MYRICOM		0x14c1
 
 #define PCI_VENDOR_ID_MEDIATEK		0x14c3
+#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
 
 #define PCI_VENDOR_ID_TITAN		0x14D2
 #define PCI_DEVICE_ID_TITAN_010L	0x8001
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
