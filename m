Return-Path: <SRS0=LcWp=QO=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD52C282C2
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:19:54 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AE2E20863
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 16:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Px6CHVwn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MmXS36VI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AE2E20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Date:Message-Id:MIME-Version:Subject:To
	:From:References:In-Reply-To:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4Q6Ak8X0xacVn4g3W/5Hr0qnIdmPmXhz4we09zRkKVQ=; b=Px6CHVwnQ1H/rS
	trTMU7bW4ITHfRR5a7stKg76W2rksAnO/VTGjppwRCby/p6WXRIvBfEhGmABqomdN5hJs1OZI+A6h
	x4aYjCy18qfgzJTAVsDTSlYB3jj9U+MXAjUBHGZ2MEhGPFeTMAiBEKk9JVxU0nKsSLv2/Pg0olBuM
	GNmYJ8ts781NDlH9XuwCnT6CIj+ItGrTtNLq+NIZmMY65VWmBK2sx3alu1S9CJV6ZtNmL/Uyqwl+3
	gg4Tls5xczWJBBHxOsRsl8SbQlgfvYFKyIYTPenj1u1NpRTj7w50PXwYQUIKmFNBuiuzyUtn3U1I7
	d81Ri3DxcqNeLDnQLmFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1grmOz-0000oH-SB; Thu, 07 Feb 2019 16:19:49 +0000
Received: from pandora.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1grmOm-0000YE-HD
 for linux-arm-kernel@lists.infradead.org; Thu, 07 Feb 2019 16:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Date:Sender:Message-Id:Content-Type:
 Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
 In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=p5OS984isDjZ3ZUtFlPpz8JoFNv5AeZqucIabi+Ckmw=; b=MmXS36VI+Wwb0klPr62SUGdibm
 IgBrkfLQEx9bKCG/9XCbk7SvmmimbbGo3kUxu121dkLIG7hIo3R4z0VH/eACynI1wfYETtAqj0uyM
 yrHILmRXeXgay2SeLehEGbzYSVogy4qjr6coCFbo0urOROD8Sm8qD6NSbQTmyUy/RtPU=;
Received: from e0022681537dd.dyn.armlinux.org.uk
 ([2002:4e20:1eda:1:222:68ff:fe15:37dd]:55814 helo=rmk-PC.armlinux.org.uk)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <rmk@armlinux.org.uk>)
 id 1grmON-0002SS-W0; Thu, 07 Feb 2019 16:19:12 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim
 4.82_1-5b7a7c0-XX) (envelope-from <rmk@armlinux.org.uk>)
 id 1grmOM-0000MF-PS; Thu, 07 Feb 2019 16:19:10 +0000
In-Reply-To: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
References: <20190207161825.ueinmyf6ygjiqzzy@shell.armlinux.org.uk>
From: Russell King <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Jason Cooper <jason@lakedaemon.net>, Kishon Vijay Abraham I <kishon@ti.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next v2 2/6] phy: armada38x: add common phy support
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <E1grmOM-0000MF-PS@rmk-PC.armlinux.org.uk>
Date: Thu, 07 Feb 2019 16:19:10 +0000
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190207_081937_330653_5513B2CD 
X-CRM114-Status: GOOD (  20.53  )
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
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the Armada 38x common phy to allow us to change the
speed of the Ethernet serdes lane.  This driver only supports
manipulation of the speed, it does not support configuration of the
common phy.

Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 drivers/phy/marvell/Kconfig                |  10 ++
 drivers/phy/marvell/Makefile               |   1 +
 drivers/phy/marvell/phy-armada38x-comphy.c | 237 +++++++++++++++++++++++++++++
 3 files changed, 248 insertions(+)
 create mode 100644 drivers/phy/marvell/phy-armada38x-comphy.c

diff --git a/drivers/phy/marvell/Kconfig b/drivers/phy/marvell/Kconfig
index 6fb4b56e4c14..224ea4e6a46d 100644
--- a/drivers/phy/marvell/Kconfig
+++ b/drivers/phy/marvell/Kconfig
@@ -21,6 +21,16 @@ config PHY_BERLIN_USB
 	help
 	  Enable this to support the USB PHY on Marvell Berlin SoCs.
 
+config PHY_MVEBU_A38X_COMPHY
+	tristate "Marvell Armada 38x comphy driver"
+	depends on ARCH_MVEBU || COMPILE_TEST
+	depends on OF
+	select GENERIC_PHY
+	help
+	  This driver allows to control the comphy, an hardware block providing
+	  shared serdes PHYs on Marvell Armada 38x. Its serdes lanes can be
+	  used by various controllers (Ethernet, sata, usb, PCIe...).
+
 config PHY_MVEBU_CP110_COMPHY
 	tristate "Marvell CP110 comphy driver"
 	depends on ARCH_MVEBU || COMPILE_TEST
diff --git a/drivers/phy/marvell/Makefile b/drivers/phy/marvell/Makefile
index 3975b144f8ec..59b6c03ef756 100644
--- a/drivers/phy/marvell/Makefile
+++ b/drivers/phy/marvell/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_ARMADA375_USBCLUSTER_PHY)	+= phy-armada375-usb2.o
 obj-$(CONFIG_PHY_BERLIN_SATA)		+= phy-berlin-sata.o
 obj-$(CONFIG_PHY_BERLIN_USB)		+= phy-berlin-usb.o
+obj-$(CONFIG_PHY_MVEBU_A38X_COMPHY)	+= phy-armada38x-comphy.o
 obj-$(CONFIG_PHY_MVEBU_CP110_COMPHY)	+= phy-mvebu-cp110-comphy.o
 obj-$(CONFIG_PHY_MVEBU_SATA)		+= phy-mvebu-sata.o
 obj-$(CONFIG_PHY_PXA_28NM_HSIC)		+= phy-pxa-28nm-hsic.o
diff --git a/drivers/phy/marvell/phy-armada38x-comphy.c b/drivers/phy/marvell/phy-armada38x-comphy.c
new file mode 100644
index 000000000000..3e00bc679d4e
--- /dev/null
+++ b/drivers/phy/marvell/phy-armada38x-comphy.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 Russell King, Deep Blue Solutions Ltd.
+ *
+ * Partly derived from CP110 comphy driver by Antoine Tenart
+ * <antoine.tenart@bootlin.com>
+ */
+#include <linux/delay.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/phy/phy.h>
+#include <linux/phy.h>
+#include <linux/platform_device.h>
+
+#define MAX_A38X_COMPHY	6
+#define MAX_A38X_PORTS	3
+
+#define COMPHY_CFG1		0x00
+#define  COMPHY_CFG1_GEN_TX(x)		((x) << 26)
+#define  COMPHY_CFG1_GEN_TX_MSK		COMPHY_CFG1_GEN_TX(15)
+#define  COMPHY_CFG1_GEN_RX(x)		((x) << 22)
+#define  COMPHY_CFG1_GEN_RX_MSK		COMPHY_CFG1_GEN_RX(15)
+#define  GEN_SGMII_1_25GBPS		6
+#define  GEN_SGMII_3_125GBPS		8
+
+#define COMPHY_STAT1		0x18
+#define  COMPHY_STAT1_PLL_RDY_TX	BIT(3)
+#define  COMPHY_STAT1_PLL_RDY_RX	BIT(2)
+
+#define COMPHY_SELECTOR		0xfc
+
+struct a38x_comphy;
+
+struct a38x_comphy_lane {
+	void __iomem *base;
+	struct a38x_comphy *priv;
+	unsigned int n;
+
+	int port;
+};
+
+struct a38x_comphy {
+	void __iomem *base;
+	struct device *dev;
+	struct a38x_comphy_lane lane[MAX_A38X_COMPHY];
+};
+
+static const u8 gbe_mux[MAX_A38X_COMPHY][MAX_A38X_PORTS] = {
+	{ 0, 0, 0 },
+	{ 4, 5, 0 },
+	{ 0, 4, 0 },
+	{ 0, 0, 4 },
+	{ 0, 3, 0 },
+	{ 0, 0, 3 },
+};
+
+static void a38x_comphy_set_reg(struct a38x_comphy_lane *lane,
+				unsigned int offset, u32 mask, u32 value)
+{
+	u32 val;
+
+	val = readl_relaxed(lane->base + offset) & ~mask;
+	writel(val | value, lane->base + offset);
+}
+
+static void a38x_comphy_set_speed(struct a38x_comphy_lane *lane,
+				  unsigned int gen_tx, unsigned int gen_rx)
+{
+	a38x_comphy_set_reg(lane, COMPHY_CFG1,
+			    COMPHY_CFG1_GEN_TX_MSK | COMPHY_CFG1_GEN_RX_MSK,
+			    COMPHY_CFG1_GEN_TX(gen_tx) |
+		            COMPHY_CFG1_GEN_RX(gen_rx));
+}
+
+static int a38x_comphy_poll(struct a38x_comphy_lane *lane,
+			    unsigned int offset, u32 mask, u32 value)
+{
+	u32 val;
+	int ret;
+
+	ret = readl_relaxed_poll_timeout_atomic(lane->base + offset, val,
+						(val & mask) == value,
+						1000, 150000);
+
+	if (ret)
+		dev_err(lane->priv->dev,
+			"comphy%u: timed out waiting for status\n", lane->n);
+
+	return ret;
+}
+
+/*
+ * We only support changing the speed for comphys configured for GBE.
+ * Since that is all we do, we only poll for PLL ready status.
+ */
+static int a38x_comphy_set_mode(struct phy *phy, enum phy_mode mode, int sub)
+{
+	struct a38x_comphy_lane *lane = phy_get_drvdata(phy);
+	unsigned int gen;
+
+	if (mode != PHY_MODE_ETHERNET)
+		return -EINVAL;
+
+	switch (sub) {
+	case PHY_INTERFACE_MODE_SGMII:
+	case PHY_INTERFACE_MODE_1000BASEX:
+		gen = GEN_SGMII_1_25GBPS;
+		break;
+
+	case PHY_INTERFACE_MODE_2500BASEX:
+		gen = GEN_SGMII_3_125GBPS;
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	a38x_comphy_set_speed(lane, gen, gen);
+
+	return a38x_comphy_poll(lane, COMPHY_STAT1,
+				COMPHY_STAT1_PLL_RDY_TX |
+				COMPHY_STAT1_PLL_RDY_RX,
+				COMPHY_STAT1_PLL_RDY_TX |
+				COMPHY_STAT1_PLL_RDY_RX);
+}
+
+static const struct phy_ops a38x_comphy_ops = {
+	.set_mode	= a38x_comphy_set_mode,
+	.owner		= THIS_MODULE,
+};
+
+static struct phy *a38x_comphy_xlate(struct device *dev,
+				     struct of_phandle_args *args)
+{
+	struct a38x_comphy_lane *lane;
+	struct phy *phy;
+	u32 val;
+
+	if (WARN_ON(args->args[0] >= MAX_A38X_PORTS))
+		return ERR_PTR(-EINVAL);
+
+	phy = of_phy_simple_xlate(dev, args);
+	if (IS_ERR(phy))
+		return phy;
+
+	lane = phy_get_drvdata(phy);
+	if (lane->port >= 0)
+		return ERR_PTR(-EBUSY);
+
+	lane->port = args->args[0];
+
+	val = readl_relaxed(lane->priv->base + COMPHY_SELECTOR);
+	val = (val >> (4 * lane->n)) & 0xf;
+
+	if (!gbe_mux[lane->n][lane->port] ||
+	    val != gbe_mux[lane->n][lane->port]) {
+		dev_warn(lane->priv->dev,
+			 "comphy%u: not configured for GBE\n", lane->n);
+		phy = ERR_PTR(-EINVAL);
+	}
+
+	return phy;
+}
+
+static int a38x_comphy_probe(struct platform_device *pdev)
+{
+	struct phy_provider *provider;
+	struct device_node *child;
+	struct a38x_comphy *priv;
+	struct resource *res;
+	void __iomem *base;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->dev = &pdev->dev;
+	priv->base = base;
+
+	for_each_available_child_of_node(pdev->dev.of_node, child) {
+		struct phy *phy;
+		int ret;
+		u32 val;
+
+		ret = of_property_read_u32(child, "reg", &val);
+		if (ret < 0) {
+			dev_err(&pdev->dev, "missing 'reg' property (%d)\n",
+				ret);
+			continue;
+		}
+
+		if (val >= MAX_A38X_COMPHY || priv->lane[val].base) {
+			dev_err(&pdev->dev, "invalid 'reg' property\n");
+			continue;
+		}
+
+		phy = devm_phy_create(&pdev->dev, child, &a38x_comphy_ops);
+		if (IS_ERR(phy))
+			return PTR_ERR(phy);
+
+		priv->lane[val].base = base + 0x28 * val;
+		priv->lane[val].priv = priv;
+		priv->lane[val].n = val;
+		priv->lane[val].port = -1;
+		phy_set_drvdata(phy, &priv->lane[val]);
+	}
+
+	dev_set_drvdata(&pdev->dev, priv);
+
+	provider = devm_of_phy_provider_register(&pdev->dev, a38x_comphy_xlate);
+
+	return PTR_ERR_OR_ZERO(provider);
+}
+
+static const struct of_device_id a38x_comphy_of_match_table[] = {
+	{ .compatible = "marvell,armada-380-comphy" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, a38x_comphy_of_match_table);
+
+static struct platform_driver a38x_comphy_driver = {
+	.probe	= a38x_comphy_probe,
+	.driver	= {
+		.name = "armada-38x-comphy",
+		.of_match_table = a38x_comphy_of_match_table,
+	},
+};
+module_platform_driver(a38x_comphy_driver);
+
+MODULE_AUTHOR("Russell King <rmk+kernel@armlinux.org.uk>");
+MODULE_DESCRIPTION("Common PHY driver for Armada 38x SoCs");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
