Return-Path: <SRS0=CPNf=QT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F641C282CA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:16:17 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0222075C
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iqZ/yH7T";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Ic+LF/+R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0222075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=6bwJqFZcGiZ1bPeAnnlAZoKQk4fcv8l1rsWty1Mh3Wg=; b=iqZ/yH7TT0IPA2
	oePYg/pOUYDLcAQ3wJfqq6b98wbkTehsdcKE1XCKdO3xVbpCuFQxL7nbKQF2McYEJvK8tzwsh9nQp
	KwbyczWQER5J5WzEW4CTpT3q/g3E2Q3BwYVc+njzEdlbUV1NTRtSLheg/ma/zdO21FISJTyAXnL1W
	bXenkVeJE1kml/voJHhZayolWf0CcJvw19o31p/WQvTOMYJnWyavPBcsXEEmcgRusONUQXbZtz038
	bfTMCe44KJQfFH0lIgNu2JXjPUc29kZjmLQ7YPuQOmzcGMzoc1VnTLKibpv1mvF50K0FWJwC+K787
	HflXaefnXvaKlIAcoUlw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtZnA-0000yq-9E; Tue, 12 Feb 2019 15:16:12 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtZlU-0006ZP-Iv
 for linux-arm-kernel@lists.infradead.org; Tue, 12 Feb 2019 15:14:40 +0000
Received: by mail-wr1-x443.google.com with SMTP id q18so3064396wrx.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 12 Feb 2019 07:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=KcipALzLGN9ADimv2gmiw8vXQG9zUG5C+CzkQJqZk+o=;
 b=Ic+LF/+R4pbWCrs8ouXmpodxYVPrTjLi889BrNn550QcxrBBlO67hT/kiuz6KRJxZv
 IftwQzjLyVPQrVWQ0ptLpBCg0k9436EMdZJ3BVI/+FiGV/7j7RtoteNJDVKAE0kgYIoG
 ocQVxJxjW6h7lQ2maGVv4V32kkAZBX89/u3HFm4s+MxlyMBpdhgEH5wz1qwI6aaQQ7Qu
 fU+xjPTdovNWY5BsIQUUrEuR/bgwlG8LvpLGg2QsoOvXWOvz27lteyBu22ooInTRoA2u
 LmuRFYS1tVd/OSPp7d5WIlYpkm+8fHDVJw5+ddAbPcdD63bIfpxnGcpdtfnssC6mqxV0
 lw/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=KcipALzLGN9ADimv2gmiw8vXQG9zUG5C+CzkQJqZk+o=;
 b=UK7Evd5hWDQpQUV/6NKgZRrDRcVqWFMcysGYyC95Ku8BsXDZplSAJkMRlE83QpC5g/
 VGg+pWbh+bDvKMRg5CZMkJ4Y5sfzjJvZupNx78vL45/ALwo/diuzYoLPoU2GanzU/qPW
 aT3LU4gXdXJfJA1F8LIxhSi5alT8azGALbnpnTY5Dwn17q6ACVbentZV3CbatKA0rtoR
 KGbDF+2J/uoX1xOv5Ar+LrLFz6/WXTFNXrB8Z/JLGEuFDYd266xdfXssP0AZSut+pyJc
 aCx1dTnwrx98OapIxKLOcQuzW4LcOQfRWLNf3OwM7fGP9eR3SprORtszp9JC7nEdzyqO
 WOIA==
X-Gm-Message-State: AHQUAuYK8gBpB6ZKRhNPPUi/xequudf7ZO45Ad29VSiYFsDCJl+OLJo1
 dDShtV5rIpFqjkiFJUvjQmoVGw==
X-Google-Smtp-Source: AHgI3IY+mjREMc0CThzuKYYhTKn22zcgXsMNLHGItL6ezLiyy4hcjMulQLGKcwSX+UYwb78naJ500w==
X-Received: by 2002:adf:8122:: with SMTP id 31mr3337473wrm.48.1549984466884;
 Tue, 12 Feb 2019 07:14:26 -0800 (PST)
Received: from bender.baylibre.local
 (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
 by smtp.gmail.com with ESMTPSA id c1sm1589515wmb.14.2019.02.12.07.14.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 12 Feb 2019 07:14:25 -0800 (PST)
From: Neil Armstrong <narmstrong@baylibre.com>
To: gregkh@linuxfoundation.org, hminas@synopsys.com, balbi@kernel.org,
 kishon@ti.com
Subject: [PATCH 6/8] phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY
 Driver
Date: Tue, 12 Feb 2019 16:14:11 +0100
Message-Id: <20190212151413.24632-7-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190212151413.24632-1-narmstrong@baylibre.com>
References: <20190212151413.24632-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190212_071429_278639_1E3019BF 
X-CRM114-Status: GOOD (  20.95  )
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

This adds support for the shared USB3 + PCIE PHY found in the
Amlogic G12A SoC Family.

It supports USB3 Host mode or PCIE 2.0 mode, depending on the layout of
the board.

Selection is done by the #phy-cells, making the mode static and exclusive.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/phy/amlogic/Kconfig                   |  12 +
 drivers/phy/amlogic/Makefile                  |   1 +
 .../phy/amlogic/phy-meson-g12a-usb3-pcie.c    | 414 ++++++++++++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c

diff --git a/drivers/phy/amlogic/Kconfig b/drivers/phy/amlogic/Kconfig
index 78d6e194dce9..7ccb9a756aba 100644
--- a/drivers/phy/amlogic/Kconfig
+++ b/drivers/phy/amlogic/Kconfig
@@ -48,3 +48,15 @@ config PHY_MESON_G12A_USB2
 	  Enable this to support the Meson USB2 PHYs found in Meson
 	  G12A SoCs.
 	  If unsure, say N.
+
+config PHY_MESON_G12A_USB3_PCIE
+	tristate "Meson G12A USB3+PCIE Combo PHY drivers"
+	default ARCH_MESON
+	depends on OF && (ARCH_MESON || COMPILE_TEST)
+	depends on USB_SUPPORT
+	select GENERIC_PHY
+	select REGMAP_MMIO
+	help
+	  Enable this to support the Meson USB3 + PCIE Combi PHY found
+	  in Meson G12A SoCs.
+	  If unsure, say N.
diff --git a/drivers/phy/amlogic/Makefile b/drivers/phy/amlogic/Makefile
index 7d4d10f5a6b3..fdd008e1b19b 100644
--- a/drivers/phy/amlogic/Makefile
+++ b/drivers/phy/amlogic/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_PHY_MESON8B_USB2)		+= phy-meson8b-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB2)	+= phy-meson-gxl-usb2.o
 obj-$(CONFIG_PHY_MESON_G12A_USB2)	+= phy-meson-g12a-usb2.o
 obj-$(CONFIG_PHY_MESON_GXL_USB3)	+= phy-meson-gxl-usb3.o
+obj-$(CONFIG_PHY_MESON_G12A_USB3_PCIE)	+= phy-meson-g12a-usb3-pcie.o
diff --git a/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
new file mode 100644
index 000000000000..59eae98928e9
--- /dev/null
+++ b/drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
@@ -0,0 +1,414 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Amlogic G12A USB3 + PCIE Combo PHY driver
+ *
+ * Copyright (C) 2017 Amlogic, Inc. All rights reserved
+ * Copyright (C) 2019 BayLibre, SAS
+ * Author: Neil Armstrong <narmstrong@baylibre.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/phy/phy.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/phy/phy.h>
+
+#define PHY_R0							0x00
+	#define PHY_R0_PCIE_POWER_STATE				GENMASK(4, 0)
+	#define PHY_R0_PCIE_USB3_SWITCH				GENMASK(6, 5)
+
+#define PHY_R1							0x04
+	#define PHY_R1_PHY_TX1_TERM_OFFSET			GENMASK(4, 0)
+	#define PHY_R1_PHY_TX0_TERM_OFFSET			GENMASK(9, 5)
+	#define PHY_R1_PHY_RX1_EQ				GENMASK(12, 10)
+	#define PHY_R1_PHY_RX0_EQ				GENMASK(15, 13)
+	#define PHY_R1_PHY_LOS_LEVEL				GENMASK(20, 16)
+	#define PHY_R1_PHY_LOS_BIAS				GENMASK(23, 21)
+	#define PHY_R1_PHY_REF_CLKDIV2				BIT(24)
+	#define PHY_R1_PHY_MPLL_MULTIPLIER			GENMASK(31, 25)
+
+#define PHY_R2							0x08
+	#define PHY_R2_PCS_TX_DEEMPH_GEN2_6DB			GENMASK(5, 0)
+	#define PHY_R2_PCS_TX_DEEMPH_GEN2_3P5DB			GENMASK(11, 6)
+	#define PHY_R2_PCS_TX_DEEMPH_GEN1			GENMASK(17, 12)
+	#define PHY_R2_PHY_TX_VBOOST_LVL			GENMASK(20, 18)
+
+#define PHY_R4							0x10
+	#define PHY_R4_PHY_CR_WRITE				BIT(0)
+	#define PHY_R4_PHY_CR_READ				BIT(1)
+	#define PHY_R4_PHY_CR_DATA_IN				GENMASK(17, 2)
+	#define PHY_R4_PHY_CR_CAP_DATA				BIT(18)
+	#define PHY_R4_PHY_CR_CAP_ADDR				BIT(19)
+
+#define PHY_R5							0x14
+	#define PHY_R5_PHY_CR_DATA_OUT				GENMASK(15, 0)
+	#define PHY_R5_PHY_CR_ACK				BIT(16)
+	#define PHY_R5_PHY_BS_OUT				BIT(17)
+
+struct phy_g12a_usb3_pcie_priv {
+	struct regmap		*regmap;
+	struct regmap		*regmap_cr;
+	struct clk		*clk_ref;
+	struct reset_control	*reset;
+	struct phy		*phy;
+	unsigned int		mode;
+};
+
+static const struct regmap_config phy_g12a_usb3_pcie_regmap_conf = {
+	.reg_bits = 8,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = PHY_R5,
+};
+
+static int phy_g12a_usb3_pcie_cr_bus_addr(struct phy_g12a_usb3_pcie_priv *priv,
+					  unsigned int addr)
+{
+	unsigned int val, reg;
+	int ret;
+
+	reg = FIELD_PREP(PHY_R4_PHY_CR_DATA_IN, addr);
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	regmap_write(priv->regmap, PHY_R4, reg | PHY_R4_PHY_CR_CAP_ADDR);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       !(val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_cr_bus_read(void *context, unsigned int addr,
+					  unsigned int *data)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = context;
+	unsigned int val;
+	int ret;
+
+	ret = phy_g12a_usb3_pcie_cr_bus_addr(priv, addr);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, 0);
+	regmap_write(priv->regmap, PHY_R4, PHY_R4_PHY_CR_READ);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	*data = FIELD_GET(PHY_R5_PHY_CR_DATA_OUT, val);
+
+	regmap_write(priv->regmap, PHY_R4, 0);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       !(val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_cr_bus_write(void *context, unsigned int addr,
+					   unsigned int data)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = context;
+	unsigned int val, reg;
+	int ret;
+
+	ret = phy_g12a_usb3_pcie_cr_bus_addr(priv, addr);
+	if (ret)
+		return ret;
+
+	reg = FIELD_PREP(PHY_R4_PHY_CR_DATA_IN, data);
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	regmap_write(priv->regmap, PHY_R4, reg | PHY_R4_PHY_CR_CAP_DATA);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK) == 0,
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	regmap_write(priv->regmap, PHY_R4, reg | PHY_R4_PHY_CR_WRITE);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK),
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	regmap_write(priv->regmap, PHY_R4, reg);
+
+	ret = regmap_read_poll_timeout(priv->regmap, PHY_R5, val,
+				       (val & PHY_R5_PHY_CR_ACK) == 0,
+				       5, 1000);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static const struct regmap_config phy_g12a_usb3_pcie_cr_regmap_conf = {
+	.reg_bits = 16,
+	.val_bits = 16,
+	.reg_read = phy_g12a_usb3_pcie_cr_bus_read,
+	.reg_write = phy_g12a_usb3_pcie_cr_bus_write,
+	.max_register = 0xffff,
+	.fast_io = true,
+};
+
+static int phy_g12a_usb3_init(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+	int data, ret;
+
+	/* Switch PHY to USB3 */
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_USB3_SWITCH,
+			   PHY_R0_PCIE_USB3_SWITCH);
+
+	/*
+	 * WORKAROUND: There is SSPHY suspend bug due to
+	 * which USB enumerates
+	 * in HS mode instead of SS mode. Workaround it by asserting
+	 * LANE0.TX_ALT_BLOCK.EN_ALT_BUS to enable TX to use alt bus
+	 * mode
+	 */
+	ret = regmap_update_bits(priv->regmap_cr, 0x102d, BIT(7), BIT(7));
+	if (ret)
+		return ret;
+
+	ret = regmap_update_bits(priv->regmap_cr, 0x1010, 0xff0, 20);
+	if (ret)
+		return ret;
+
+	/*
+	 * Fix RX Equalization setting as follows
+	 * LANE0.RX_OVRD_IN_HI. RX_EQ_EN set to 0
+	 * LANE0.RX_OVRD_IN_HI.RX_EQ_EN_OVRD set to 1
+	 * LANE0.RX_OVRD_IN_HI.RX_EQ set to 3
+	 * LANE0.RX_OVRD_IN_HI.RX_EQ_OVRD set to 1
+	 */
+	ret = regmap_read(priv->regmap_cr, 0x1006, &data);
+	if (ret)
+		return ret;
+
+	data &= ~BIT(6);
+	data |= BIT(7);
+	data &= ~(0x7 << 8);
+	data |= (0x3 << 8);
+	data |= (1 << 11);
+	ret = regmap_write(priv->regmap_cr, 0x1006, data);
+	if (ret)
+		return ret;
+
+	/*
+	 * Set EQ and TX launch amplitudes as follows
+	 * LANE0.TX_OVRD_DRV_LO.PREEMPH set to 22
+	 * LANE0.TX_OVRD_DRV_LO.AMPLITUDE set to 127
+	 * LANE0.TX_OVRD_DRV_LO.EN set to 1.
+	 */
+	ret = regmap_read(priv->regmap_cr, 0x1002, &data);
+	if (ret)
+		return ret;
+
+	data &= ~0x3f80;
+	data |= (0x16 << 7);
+	data &= ~0x7f;
+	data |= (0x7f | BIT(14));
+	ret = regmap_write(priv->regmap_cr, 0x1002, data);
+	if (ret)
+		return ret;
+
+	/*
+	 * MPLL_LOOP_CTL.PROP_CNTRL = 8
+	 */
+	ret = regmap_update_bits(priv->regmap_cr, 0x30, 0xf << 4, 8 << 4);
+	if (ret)
+		return ret;
+
+	regmap_update_bits(priv->regmap, PHY_R2,
+			PHY_R2_PHY_TX_VBOOST_LVL,
+			FIELD_PREP(PHY_R2_PHY_TX_VBOOST_LVL, 0x4));
+
+	regmap_update_bits(priv->regmap, PHY_R1,
+			PHY_R1_PHY_LOS_BIAS | PHY_R1_PHY_LOS_LEVEL,
+			FIELD_PREP(PHY_R1_PHY_LOS_BIAS, 4) |
+			FIELD_PREP(PHY_R1_PHY_LOS_LEVEL, 9));
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_init(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
+	if (priv->mode == PHY_TYPE_USB3)
+		return phy_g12a_usb3_init(phy);
+
+	/* Power UP PCIE */
+	regmap_update_bits(priv->regmap, PHY_R0,
+			   PHY_R0_PCIE_POWER_STATE,
+			   FIELD_PREP(PHY_R0_PCIE_POWER_STATE, 0x1c));
+
+	return 0;
+}
+
+static int phy_g12a_usb3_pcie_exit(struct phy *phy)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = phy_get_drvdata(phy);
+	int ret;
+
+	return reset_control_reset(priv->reset);
+}
+
+static struct phy *phy_g12a_usb3_pcie_xlate(struct device *dev,
+					    struct of_phandle_args *args)
+{
+	struct phy_g12a_usb3_pcie_priv *priv = dev_get_drvdata(dev);
+	unsigned int mode;
+
+	if (args->args_count < 1) {
+		dev_err(dev, "invalid number of arguments\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	mode = args->args[0];
+
+	if (mode != PHY_TYPE_USB3 && mode != PHY_TYPE_PCIE) {
+		dev_err(dev, "invalid phy mode select argument\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	priv->mode = mode;
+
+	return priv->phy;
+}
+
+static const struct phy_ops phy_g12a_usb3_pcie_ops = {
+	.init		= phy_g12a_usb3_pcie_init,
+	.exit		= phy_g12a_usb3_pcie_exit,
+	.owner		= THIS_MODULE,
+};
+
+static int phy_g12a_usb3_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct phy_g12a_usb3_pcie_priv *priv;
+	struct resource *res;
+	struct phy_provider *phy_provider;
+	void __iomem *base;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	priv->regmap = devm_regmap_init_mmio(dev, base,
+					     &phy_g12a_usb3_pcie_regmap_conf);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
+
+	priv->regmap_cr = devm_regmap_init(dev, NULL, priv,
+					   &phy_g12a_usb3_pcie_cr_regmap_conf);
+	if (IS_ERR(priv->regmap_cr))
+		return PTR_ERR(priv->regmap_cr);
+
+	priv->clk_ref = devm_clk_get(dev, "ref_clk");
+	if (IS_ERR(priv->clk_ref))
+		return PTR_ERR(priv->clk_ref);
+
+	ret = clk_prepare_enable(priv->clk_ref);
+	if (ret)
+		goto err_disable_clk_ref;
+
+	priv->reset = devm_reset_control_array_get(dev, false, false);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
+	priv->phy = devm_phy_create(dev, np, &phy_g12a_usb3_pcie_ops);
+	if (IS_ERR(priv->phy)) {
+		ret = PTR_ERR(priv->phy);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "failed to create PHY\n");
+
+		return ret;
+	}
+
+	phy_set_drvdata(priv->phy, priv);
+	dev_set_drvdata(dev, priv);
+
+	phy_provider = devm_of_phy_provider_register(dev,
+						     phy_g12a_usb3_pcie_xlate);
+
+	return PTR_ERR_OR_ZERO(phy_provider);
+
+err_disable_clk_ref:
+	clk_disable_unprepare(priv->clk_ref);
+
+	return ret;
+}
+
+static const struct of_device_id phy_g12a_usb3_pcie_of_match[] = {
+	{ .compatible = "amlogic,g12a-usb3-pcie-phy", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, phy_g12a_usb3_pcie_of_match);
+
+static struct platform_driver phy_g12a_usb3_pcie_driver = {
+	.probe	= phy_g12a_usb3_pcie_probe,
+	.driver	= {
+		.name		= "phy-g12a-usb3-pcie",
+		.of_match_table	= phy_g12a_usb3_pcie_of_match,
+	},
+};
+module_platform_driver(phy_g12a_usb3_pcie_driver);
+
+MODULE_AUTHOR("Neil Armstrong <narmstrong@baylibre.com>");
+MODULE_DESCRIPTION("Amlogic G12A USB3 + PCIE Combo PHY driver");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
