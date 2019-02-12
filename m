Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA510C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 755592075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="mRU8y0to";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="wrtE0/w9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 755592075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TLnNb+RjOUj2Iz/bvQwJf5QcjXnHSm42qGW1gkpzbDw=; b=mRU8y0toVEGOeg
	jdFSckDb2e9+ckjJ4a5WnpPrASQfIO1SpOO3rxarlczGCHdPSMcmqt4nmoAJ7drTWsNDwZ5iAr5Ub
	9BBWS8DuCp1cahpXiRMjbUvgILjmFOWDGQPXrFkmpZJkIlu5PtxnAI/bvjk7uGyz+d+uDdFpgmJIM
	bQL2rVBjaa4ITN+mism4wCfn+OlarWxkI+8wNUG0HiG8mKimDpREUklxGJSiMmO9EcjJ8MGpTafuu
	4Z+7iJrXLt/6EmpfOOKmo5rHVUeiSXvuTZ2MZ38KHeYYVG7PSY1D7tJ2UQa+Xx1YaVC0GcxGA26oC
	w2S9nI+z/VrYClp5BryA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZma-0000Kr-QR; Tue, 12 Feb 2019 15:15:37 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZlS-0006Wr-Hc
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:14:38 +0000
Received: by mail-wm1-x342.google.com with SMTP id d15so3363100wmb.3
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gX/dyjDLSpZsBP8Ako1lDKHH5OMyxQQgkLBf9iyVjDY=;
 b=wrtE0/w9XBQq4RrLyXplyeDh0NH+b53jIT/DiR68Ud7xnMkw+Bwmf+YOPQ18UtRPEK
 0UzHo8IpPf6V8Yi5Xpb6QRP8/vHnPw3uLcwCZNF+oqYoIr8RBviuLYPm7mjrSiscbgKA
 VprbXUIT8cyeskJzrppyZom5h+OJtrpBmva7+Fj+AOzMSjhbLJ5rJo6ipnJ485w31SMo
 xsE35hIQSBxLmHN59pHXoNus0ze8aRC2QGPjQ0rgDYEViYznAyM9NHe9eX983GfyxPRz
 /Znx6N8+/dp1dTvQc69+kzcrCBsvlsLG3KYbOvJZhlj76TT/HQwL0eJTP0pCqeTCRbFZ
 jx3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gX/dyjDLSpZsBP8Ako1lDKHH5OMyxQQgkLBf9iyVjDY=;
 b=ZzDbakillWL4jHn4dm6uxmf/UoN/uNe87ihNqfhsqr0cp5TAaTFoLU63wB3s/qsRh1
 zXSTI4aDeOkKNWIw/D+NNpjneE29iJwiusxNSUQTVfEn5czLNDwYYTQ/PG7YOaZut5X4
 xjRM05jrbS2NKih3lkYzsKfo2irj1pcYJJDrzDv5M9WgRHSMiGUmpNST0fZ7XKtPkaVq
 PpvAtWUPAgKldQtFDcK5UbERU66jWGmT7GANu1lDMxvdRMh4Dx+FguHWQ3jXc87k4oTM
 E4grB3xLJlIqa1QHLnCbmdK604vBJE+emN/4u4lQcayJW7ep9K4BreR7PBRMiisXFetN
 bCsw==
X-Gm-Message-State: AHQUAubiJFvkdN89ER2I6xecMdgQUMAJtQGQ5mBJEgGP5GQf4ypuSZjM
 llnZmC8TmR5ioPNwczMGoikcBw==
X-Google-Smtp-Source: AHgI3IZu6tf0SY0WQKvUQxs4uBL0ZqVZP9aea+gL8H0GFy33ML8K9VB/fc83GwnpKgwjr8jHBQAkpA==
X-Received: by 2002:a1c:ac42:: with SMTP id v63mr3213364wme.119.1549984464882; 
 Tue, 12 Feb 2019 07:14:24 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.23
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 07:14:23 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
 kishon@ti.com
Subject: [PATCH 5/8] phy: amlogic: add Amlogic G12A USB2 PHY Driver
Date: Tue, 12 Feb 2019 16:14:10 +0100
Message-Id: <20190212151413.24632-6-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_071427_190463_A42EE832 
X-CRM114-Status: GOOD (  18.89  )
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
Cc: linux-amlogic@lists.infradead.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Neil Armstrong <narmstrong@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds support for the USB2 PHY found in the Amlogic G12A SoC Family.

It supports Host and/or Peripheral mode, depending on it's position.
The first PHY is only used as Host, but the second supports Dual modes
defined by the USB Control Glue HW in front of the USB Controllers.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/Kconfig               |  12 ++
 drivers/phy/amlogic/Makefile              |   1 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c | 191 ++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 23fe1cda2f70..78d6e194dce9 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -36,3 +36,15 @@ config PHY_MESON_GXL_USB3
 	  Enable this to support the Meson USB3 PHY and OTG detection
 	  IP block found in Meson GXL and GXM SoCs.
 	  If unsure, say N.
+
+config PHY_MESON_G12A_USB2
+	tristate "Meson G12A USB2 PHY drivers"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Enable this to support the Meson USB2 PHYs found in Meson
+	  G12A SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 4fd8848c194d..7d4d10f5a6b3 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
+obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb2.c b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
new file mode 100644
index 000000000000..3b6271a8be02
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb2.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Meson G12A USB2 PHY driver
+ *
+ * Copyright (C) 2017 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
+ * Copyright (C) 2017 Amlogic, Inc. All rights reserved
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/syscon.h>
+#include <linux/reset.h>
+#include <linux/phy/phy.h>
+#include <linux/usb/otg.h>
+#include <linux/platform_device.h>
+
+#define PHY_CTRL_R0						0x0
+#define PHY_CTRL_R1						0x4
+#define PHY_CTRL_R2						0x8
+#define PHY_CTRL_R3						0xc
+#define PHY_CTRL_R4						0x10
+#define PHY_CTRL_R5						0x14
+#define PHY_CTRL_R6						0x18
+#define PHY_CTRL_R7						0x1c
+#define PHY_CTRL_R8						0x20
+#define PHY_CTRL_R9						0x24
+#define PHY_CTRL_R10						0x28
+#define PHY_CTRL_R11						0x2c
+#define PHY_CTRL_R12						0x30
+#define PHY_CTRL_R13						0x34
+#define PHY_CTRL_R14						0x38
+#define PHY_CTRL_R15						0x3c
+#define PHY_CTRL_R16						0x40
+#define PHY_CTRL_R17						0x44
+#define PHY_CTRL_R18						0x48
+#define PHY_CTRL_R19						0x4c
+#define PHY_CTRL_R20						0x50
+#define PHY_CTRL_R21						0x54
+#define PHY_CTRL_R22						0x58
+#define PHY_CTRL_R23						0x5c
+
+#define RESET_COMPLETE_TIME					1000
+#define PLL_RESET_COMPLETE_TIME					100
+
+struct phy_meson_g12a_usb2_priv {
+	struct device		*dev;
+	struct regmap		*regmap;
+	struct clk		*clk;
+	struct reset_control	*reset;
+};
+
+static const struct regmap_config phy_meson_g12a_usb2_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = PHY_CTRL_R23,
+};
+
+static int phy_meson_g12a_usb2_init(struct phy *phy)
+{
+	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
+	udelay(RESET_COMPLETE_TIME);
+
+	/* usb2_otg_aca_en == 0 */
+	regmap_update_bits(priv->regmap, PHY_CTRL_R21, BIT(2), 0);
+
+	/* PLL Setup : 24MHz * 20 / 1 = 480MHz */
+	regmap_write(priv->regmap, PHY_CTRL_R16, 0x39400414);
+	regmap_write(priv->regmap, PHY_CTRL_R17, 0x927e0000);
+	regmap_write(priv->regmap, PHY_CTRL_R18, 0xac5f49e5);
+
+	udelay(PLL_RESET_COMPLETE_TIME);
+
+	/* UnReset PLL */
+	regmap_write(priv->regmap, PHY_CTRL_R16, 0x19400414);
+
+	/* PHY Tuning */
+	regmap_write(priv->regmap, PHY_CTRL_R20, 0xfe18);
+	regmap_write(priv->regmap, PHY_CTRL_R4, 0x8000fff);
+
+	/* Tuning Disconnect Threshold */
+	regmap_write(priv->regmap, PHY_CTRL_R3, 0x34);
+
+	/* Analog Settings */
+	regmap_write(priv->regmap, PHY_CTRL_R14, 0);
+	regmap_write(priv->regmap, PHY_CTRL_R13, 0x78000);
+
+	return 0;
+}
+
+static int phy_meson_g12a_usb2_exit(struct phy *phy)
+{
+	struct phy_meson_g12a_usb2_priv *priv = phy_get_drvdata(phy);
+
+	return reset_control_reset(priv->reset);
+}
+
+/* set_mode is not needed, mode setting is handled via the UTMI bus */
+static const struct phy_ops phy_meson_g12a_usb2_ops = {
+	.init		= phy_meson_g12a_usb2_init,
+	.exit		= phy_meson_g12a_usb2_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int phy_meson_g12a_usb2_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct phy_provider *phy_provider;
+	struct resource *res;
+	struct phy_meson_g12a_usb2_priv *priv;
+	struct phy *phy;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	platform_set_drvdata(pdev, priv);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &phy_meson_g12a_usb2_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->clk = devm_clk_get(dev, "xtal");
+	if (IS_ERR(priv->clk))
+		return PTR_ERR(priv->clk);
+
+	priv->reset = devm_reset_control_get(dev, "phy");
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	ret = reset_control_deassert(priv->reset);
+	if (ret)
+		return ret;
+
+	phy = devm_phy_create(dev, NULL, &phy_meson_g12a_usb2_ops);
+	if (IS_ERR(phy)) {
+		ret = PTR_ERR(phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+
+		return ret;
+	}
+
+	phy_set_bus_width(phy, 8);
+	phy_set_drvdata(phy, priv);
+
+	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+}
+
+static const struct of_device_id phy_meson_g12a_usb2_of_match[] = {
+	{ .compatible = "amlogic,g12a-usb2-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phy_meson_g12a_usb2_of_match);
+
+static struct platform_driver phy_meson_g12a_usb2_driver = {
+	.probe	= phy_meson_g12a_usb2_probe,
+	.driver	= {
+		.name		= "phy-meson-g12a-usb2",
+		.of_match_table	= phy_meson_g12a_usb2_of_match,
+	},
+};
+module_platform_driver(phy_meson_g12a_usb2_driver);
+
+MODULE_AUTHOR("Martin Blumenstingl <martin.blumenstingl@googlemail.com>");
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Meson G12A USB2 PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
