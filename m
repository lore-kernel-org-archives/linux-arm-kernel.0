Return-Path: <SRS0=baBj=PW=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31C4BC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:28:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E258520651
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 13:28:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uM5XcIr8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Y1KwhfVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E258520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6uZL8mzWnGYxmnmX28Sor7bPwaGvm2gBSBkizvH5lUg=; b=uM5XcIr8GU6oN+
	JbXvzaca+z9ZD9RJPlVLT37EUVu/FsNVtAGLmIBFCJo3l11osz0y6+sPQ0oT8zp2EDEF6QFpDzGKw
	9lS7IuhoNdvqDmqxzFJILop1Pa6C+oyLpxes88pEzntVHeEY3g6wAZYMJuKU7yBJcKkwqi/CcvN6A
	XoJWmN46Wp0PLP3gcu8Te1iVCIrCVBp4zkHiUxlsGZtQEW7iGybIFR/tofbtloyDPiBVXKbfkwHjW
	7ZSOwKmSZoE95ZUTYP35cS4ltAtghKXIVkmeZ54B34TaktpTsXmduSXLp9pOSZVFjxOafo8peMb3w
	82GkJA8NaAeeQkWHsChA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gj2I8-0006aD-J9; Mon, 14 Jan 2019 13:28:36 +0000
Received: from fllv0015.ext.ti.com ([198.47.19.141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gj2GI-0004kd-QG
 for linux-arm-kernel@lists.infradead.org; Mon, 14 Jan 2019 13:27:10 +0000
Received: from lelv0266.itg.ti.com ([10.180.67.225])
 by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x0EDQXCi107005;
 Mon, 14 Jan 2019 07:26:33 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
 s=ti-com-17Q1; t=1547472393;
 bh=bw0Ut73XkbaUy4HNJPK+MOEGDGM+u+KTb6J5j94keH0=;
 h=From:To:CC:Subject:Date:In-Reply-To:References;
 b=Y1KwhfVka4uJtVqH+UZHTB9MPmcv9JfFP6wAJu8GqYdjYmcd/CrnP73a/WEE8g4yI
 xXOIvQBTHY5Js79l9EAGvDCb+FwxMgyY/GR1Vm89mdYUAYQ1UuaMFrSkeDC3BEqtK6
 VVG3jttxejlFOX4LnasxKwQKUfRlSIxtRZmS3tP0=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
 by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x0EDQXC5012727
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
 Mon, 14 Jan 2019 07:26:33 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1591.10; Mon, 14
 Jan 2019 07:26:33 -0600
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1591.10 via Frontend Transport;
 Mon, 14 Jan 2019 07:26:33 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com
 [10.172.224.153])
 by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id x0EDOoWg028516;
 Mon, 14 Jan 2019 07:26:28 -0600
From: Kishon Vijay Abraham I <kishon@ti.com>
To: Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Rob Herring
 <robh+dt@kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [PATCH 20/24] PCI: keystone: Add support for PCIe EP in AM654x
 Platforms
Date: Mon, 14 Jan 2019 18:54:20 +0530
Message-ID: <20190114132424.6445-21-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190114132424.6445-1-kishon@ti.com>
References: <20190114132424.6445-1-kishon@ti.com>
MIME-Version: 1.0
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190114_052643_162791_0B13E3F9 
X-CRM114-Status: GOOD (  27.37  )
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

Add PCIe EP support for AM654x Platforms in pci-keystone.c

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/controller/dwc/Kconfig        |  23 ++-
 drivers/pci/controller/dwc/pci-keystone.c | 216 ++++++++++++++++++++--
 2 files changed, 223 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 0bb19e268a8a..ae3465fd194b 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -105,14 +105,33 @@ config PCIE_SPEAR13XX
 config PCI_KEYSTONE
 	bool "TI Keystone PCIe controller"
 	depends on ARCH_KEYSTONE || ARCH_K3 || ((ARM || ARM64) && COMPILE_TEST)
-	depends on PCI_MSI_IRQ_DOMAIN
-	select PCIE_DW_HOST
 	help
 	  Say Y here if you want to enable PCI controller support on Keystone
 	  SoCs. The PCI controller on Keystone is based on DesignWare hardware
 	  and therefore the driver re-uses the DesignWare core functions to
 	  implement the driver.
 
+if PCI_KEYSTONE
+
+config PCI_KEYSTONE_HOST
+	bool "PCI Keystone Host Mode"
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_DW_HOST
+	default y
+	help
+	 Enables support for the PCIe controller in the Keystone SoC to work in
+	 host mode.
+
+config PCI_KEYSTONE_EP
+	bool "PCI Keystone Endpoint Mode"
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	 Enables support for the PCIe controller in the Keystone SoC to work in
+	 endpoint mode.
+
+endif
+
 config PCI_LAYERSCAPE
 	bool "Freescale Layerscape PCIe controller"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index e2f4e7c01b5a..adeb3565c11d 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -50,6 +50,12 @@
 #define OB_ENABLEN			BIT(0)
 #define OB_WIN_SIZE			8	/* 8MB */
 
+#define PCIE_LEGACY_IRQ_ENABLE_SET(n)	(0x188 + (0x10 * ((n) - 1)))
+#define PCIE_LEGACY_IRQ_ENABLE_CLR(n)	(0x18c + (0x10 * ((n) - 1)))
+#define PCIE_EP_IRQ_SET			0x64
+#define PCIE_EP_IRQ_CLR			0x68
+#define INT_ENABLE			BIT(0)
+
 /* IRQ register defines */
 #define IRQ_EOI				0x050
 
@@ -90,11 +96,16 @@
 #define KS_PCIE_SYSCLOCKOUTEN		BIT(0)
 
 #define AM654_PCIE_DEV_TYPE_MASK	0x3
+#define AM654_WIN_SIZE			SZ_64K
+
+#define APP_ADDR_SPACE_0		(16 * SZ_1K)
 
 #define to_keystone_pcie(x)		dev_get_drvdata((x)->dev)
 
 struct ks_pcie_of_data {
+	enum dw_pcie_device_mode mode;
 	const struct dw_pcie_host_ops *host_ops;
+	const struct dw_pcie_ep_ops *ep_ops;
 	unsigned int version;
 };
 
@@ -850,12 +861,139 @@ static int __init ks_pcie_add_pcie_port(struct keystone_pcie *ks_pcie,
 	return 0;
 }
 
+static u32 ks_pcie_am654_read_dbi2(struct dw_pcie *pci, void __iomem *base,
+				   u32 reg, size_t size)
+{
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+	u32 val;
+
+	ks_pcie_set_dbi_mode(ks_pcie);
+	dw_pcie_read(base + reg, size, &val);
+	ks_pcie_clear_dbi_mode(ks_pcie);
+	return val;
+}
+
+static void ks_pcie_am654_write_dbi2(struct dw_pcie *pci, void __iomem *base,
+				     u32 reg, size_t size, u32 val)
+{
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	ks_pcie_set_dbi_mode(ks_pcie);
+	dw_pcie_write(base + reg, size, val);
+	ks_pcie_clear_dbi_mode(ks_pcie);
+}
+
 static const struct dw_pcie_ops ks_pcie_dw_pcie_ops = {
 	.start_link = ks_pcie_start_link,
 	.stop_link = ks_pcie_stop_link,
 	.link_up = ks_pcie_link_up,
+	.read_dbi2 = ks_pcie_am654_read_dbi2,
+	.write_dbi2 = ks_pcie_am654_write_dbi2,
 };
 
+static void ks_pcie_am654_ep_init(struct dw_pcie_ep *ep)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	int flags;
+
+	ep->page_size = AM654_WIN_SIZE;
+	flags = PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_32;
+	dw_pcie_writel_dbi2(pci, PCI_BASE_ADDRESS_0, APP_ADDR_SPACE_0 - 1);
+	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, flags);
+}
+
+static void ks_pcie_am654_raise_legacy_irq(struct keystone_pcie *ks_pcie)
+{
+	struct dw_pcie *pci = ks_pcie->pci;
+	u8 int_pin;
+
+	int_pin = dw_pcie_readb_dbi(pci, PCI_INTERRUPT_PIN);
+	if (int_pin == 0 || int_pin > 4)
+		return;
+
+	ks_pcie_app_writel(ks_pcie, PCIE_LEGACY_IRQ_ENABLE_SET(int_pin),
+			   INT_ENABLE);
+	ks_pcie_app_writel(ks_pcie, PCIE_EP_IRQ_SET, INT_ENABLE);
+	mdelay(1);
+	ks_pcie_app_writel(ks_pcie, PCIE_EP_IRQ_CLR, INT_ENABLE);
+	ks_pcie_app_writel(ks_pcie, PCIE_LEGACY_IRQ_ENABLE_CLR(int_pin),
+			   INT_ENABLE);
+}
+
+static int ks_pcie_am654_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
+				   enum pci_epc_irq_type type,
+				   u16 interrupt_num)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
+	struct keystone_pcie *ks_pcie = to_keystone_pcie(pci);
+
+	switch (type) {
+	case PCI_EPC_IRQ_LEGACY:
+		ks_pcie_am654_raise_legacy_irq(ks_pcie);
+		break;
+	case PCI_EPC_IRQ_MSI:
+		dw_pcie_ep_raise_msi_irq(ep, func_no, interrupt_num);
+		break;
+	default:
+		dev_err(pci->dev, "UNKNOWN IRQ type\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static const struct pci_epc_features ks_pcie_am654_epc_features = {
+	.linkup_notifier = false,
+	.msi_capable = true,
+	.msix_capable = true,
+	.reserved_bar = 1 << BAR_0 | 1 << BAR_1,
+	.bar_fixed_64bit = 1 << BAR_0,
+	.bar_fixed_size[2] = SZ_1M,
+	.bar_fixed_size[3] = SZ_64K,
+	.bar_fixed_size[4] = 256,
+	.bar_fixed_size[5] = SZ_1M,
+	.align = SZ_1M,
+};
+
+static const struct pci_epc_features*
+ks_pcie_am654_get_features(struct dw_pcie_ep *ep)
+{
+	return &ks_pcie_am654_epc_features;
+}
+
+static const struct dw_pcie_ep_ops ks_pcie_am654_ep_ops = {
+	.ep_init = ks_pcie_am654_ep_init,
+	.raise_irq = ks_pcie_am654_raise_irq,
+	.get_features = &ks_pcie_am654_get_features,
+};
+
+static int __init ks_pcie_add_pcie_ep(struct keystone_pcie *ks_pcie,
+				      struct platform_device *pdev)
+{
+	int ret;
+	struct dw_pcie_ep *ep;
+	struct resource *res;
+	struct device *dev = &pdev->dev;
+	struct dw_pcie *pci = ks_pcie->pci;
+
+	ep = &pci->ep;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
+	if (!res)
+		return -EINVAL;
+
+	ep->phys_base = res->start;
+	ep->addr_size = resource_size(res);
+
+	ret = dw_pcie_ep_init(ep);
+	if (ret) {
+		dev_err(dev, "failed to initialize endpoint\n");
+		return ret;
+	}
+
+	return 0;
+}
+
 static void ks_pcie_disable_phy(struct keystone_pcie *ks_pcie)
 {
 	int num_lanes = ks_pcie->num_lanes;
@@ -923,7 +1061,8 @@ static int ks_pcie_set_mode(struct device *dev)
 	return 0;
 }
 
-static int ks_pcie_am654_set_mode(struct device *dev)
+static int ks_pcie_am654_set_mode(struct device *dev,
+				  enum dw_pcie_device_mode mode)
 {
 	struct device_node *np = dev->of_node;
 	struct regmap *syscon;
@@ -936,7 +1075,18 @@ static int ks_pcie_am654_set_mode(struct device *dev)
 		return 0;
 
 	mask = AM654_PCIE_DEV_TYPE_MASK;
-	val = RC;
+
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		val = RC;
+		break;
+	case DW_PCIE_EP_TYPE:
+		val = EP;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+		return -EINVAL;
+	}
 
 	ret = regmap_update_bits(syscon, 0, mask, val);
 	if (ret) {
@@ -954,6 +1104,13 @@ static const struct ks_pcie_of_data ks_pcie_rc_of_data = {
 
 static const struct ks_pcie_of_data ks_pcie_am654_rc_of_data = {
 	.host_ops = &ks_pcie_am654_host_ops,
+	.mode = DW_PCIE_RC_TYPE,
+	.version = 0x490A,
+};
+
+static const struct ks_pcie_of_data ks_pcie_am654_ep_of_data = {
+	.ep_ops = &ks_pcie_am654_ep_ops,
+	.mode = DW_PCIE_EP_TYPE,
 	.version = 0x490A,
 };
 
@@ -967,16 +1124,22 @@ static const struct of_device_id ks_pcie_of_match[] = {
 		.data = &ks_pcie_am654_rc_of_data,
 		.compatible = "ti,am654-pcie-rc",
 	},
+	{
+		.data = &ks_pcie_am654_ep_of_data,
+		.compatible = "ti,am654-pcie-ep",
+	},
 	{ },
 };
 
 static int __init ks_pcie_probe(struct platform_device *pdev)
 {
 	const struct dw_pcie_host_ops *host_ops;
+	const struct dw_pcie_ep_ops *ep_ops;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
 	const struct ks_pcie_of_data *data;
 	const struct of_device_id *match;
+	enum dw_pcie_device_mode mode;
 	struct dw_pcie *pci;
 	struct keystone_pcie *ks_pcie;
 	struct device_link **link;
@@ -999,6 +1162,8 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 	version = data->version;
 	host_ops = data->host_ops;
+	ep_ops = data->ep_ops;
+	mode = data->mode;
 
 	ks_pcie = devm_kzalloc(dev, sizeof(*ks_pcie), GFP_KERNEL);
 	if (!ks_pcie)
@@ -1021,16 +1186,11 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 		return PTR_ERR(base);
 
 	pci->dbi_base = base;
+	pci->dbi_base2 = base;
 	pci->dev = dev;
 	pci->ops = &ks_pcie_dw_pcie_ops;
 	pci->version = version;
 
-	ret = of_property_read_u32(np, "num-viewport", &num_viewport);
-	if (ret < 0) {
-		dev_err(dev, "unable to read *num-viewport* property\n");
-		return ret;
-	}
-
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
 		dev_err(dev, "missing IRQ resource: %d\n", irq);
@@ -1079,7 +1239,6 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 	ks_pcie->pci = pci;
 	ks_pcie->link = link;
 	ks_pcie->num_lanes = num_lanes;
-	ks_pcie->num_viewport = num_viewport;
 	ks_pcie->phy = phy;
 
 	ret = ks_pcie_enable_phy(ks_pcie);
@@ -1106,7 +1265,7 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 
 		pci->atu_base = atu_base;
 
-		ret = ks_pcie_am654_set_mode(dev);
+		ret = ks_pcie_am654_set_mode(dev, mode);
 		if (ret < 0)
 			goto err_get_sync;
 	} else {
@@ -1115,10 +1274,39 @@ static int __init ks_pcie_probe(struct platform_device *pdev)
 			goto err_get_sync;
 	}
 
-	pci->pp.ops = host_ops;
-	ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
-	if (ret < 0)
-		goto err_get_sync;
+	switch (mode) {
+	case DW_PCIE_RC_TYPE:
+		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_HOST)) {
+			ret = -ENODEV;
+			goto err_get_sync;
+		}
+
+		ret = of_property_read_u32(np, "num-viewport", &num_viewport);
+		if (ret < 0) {
+			dev_err(dev, "unable to read *num-viewport* property\n");
+			return ret;
+		}
+
+		ks_pcie->num_viewport = num_viewport;
+		pci->pp.ops = host_ops;
+		ret = ks_pcie_add_pcie_port(ks_pcie, pdev);
+		if (ret < 0)
+			goto err_get_sync;
+		break;
+	case DW_PCIE_EP_TYPE:
+		if (!IS_ENABLED(CONFIG_PCI_KEYSTONE_EP)) {
+			ret = -ENODEV;
+			goto err_get_sync;
+		}
+
+		pci->ep.ops = ep_ops;
+		ret = ks_pcie_add_pcie_ep(ks_pcie, pdev);
+		if (ret < 0)
+			goto err_get_sync;
+		break;
+	default:
+		dev_err(dev, "INVALID device type %d\n", mode);
+	}
 
 	ks_pcie_enable_error_irq(ks_pcie);
 
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
