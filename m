Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F66C6783B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:06:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 27D7C2082F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:06:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DKdR/VPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D7C2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZhgchDuh/JekUyLz48kStUgaHDazagtKbNyEF2VJxnI=; b=DKdR/VPNiATPm+
	Yg3ZAqCnxlUMevWUEhyGNuBYeVl79Gr7bFd/WNxbrhYc5DRkAId7AY3UNp6eFnfJyNyuRjJUisFMq
	RN3l6zHPjWtQ5+eADL1Xym07W6eBCdUFsgZvqtfNzyDqx0ILMhcu9ApBRKVP1n0PbvBAvzXkcrCvK
	UImQX5Q+UfWrBYvvi6DIUyA3kQCg1oLKTcICyS6wK8PVkMKy2GD8M0qyw1xJ4/96xTPH/sMDsMyur
	VtyeWmiAyBMxqfe3JWeVitcBXT+4s57oX9rO3J4UwT0W1tGBVr6fYZJqjqJfBhIoSlgmtii4ndRF5
	yClrl5wm9FsjAgVC2Aog==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWO4a-00025z-H9; Mon, 10 Dec 2018 16:06:20 +0000
Received: from mail-sh2.amlogic.com ([58.32.228.45])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWO4P-0001ok-IO; Mon, 10 Dec 2018 16:06:16 +0000
Received: from localhost.localdomain (10.18.11.217) by mail-sh2.amlogic.com
 (10.18.11.6) with Microsoft SMTP Server id 15.0.1320.4; Tue, 11 Dec 2018
 00:05:19 +0800
From: Jianxin Pan <jianxin.pan@amlogic.com>
To: Jerome Brunet <jbrunet@baylibre.com>, Neil Armstrong
 <narmstrong@baylibre.com>
Subject: [PATCH RESEND v7 3/4] clk: meson: add sub MMC clock controller driver
Date: Tue, 11 Dec 2018 00:04:35 +0800
Message-ID: <1544457877-51301-4-git-send-email-jianxin.pan@amlogic.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
References: <1544457877-51301-1-git-send-email-jianxin.pan@amlogic.com>
MIME-Version: 1.0
X-Originating-IP: [10.18.11.217]
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_080610_353528_437F63D6 
X-CRM114-Status: GOOD (  16.78  )
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
Cc: Rob Herring <robh@kernel.org>, Hanjie Lin <hanjie.lin@amlogic.com>,
 Victor Wan <victor.wan@amlogic.com>, Jianxin Pan <jianxin.pan@amlogic.com>,
 Stephen Boyd <sboyd@kernel.org>, Kevin Hilman <khilman@baylibre.com>,
 Michael Turquette <mturquette@baylibre.com>, Yixun Lan <yixun.lan@amlogic.com>,
 linux-kernel@vger.kernel.org, Boris Brezillon <boris.brezillon@bootlin.com>,
 Liang Yang <liang.yang@amlogic.com>, Jian Hu <jian.hu@amlogic.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, Carlo Caione <carlo@caione.org>,
 linux-amlogic@lists.infradead.org,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Qiufang Dai <qiufang.dai@amlogic.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Yixun Lan <yixun.lan@amlogic.com>

The patch will add a MMC clock controller driver which used by MMC or NAND,
It provide a mux and divider clock, and three phase clocks - core, tx, tx.

Two clocks are provided as the parent of MMC clock controller from
upper layer clock controller - eg "amlogic,axg-clkc" in AXG platform.

To specify which clock the MMC or NAND driver may consume,
the preprocessor macros in the dt-bindings/clock/amlogic,mmc-clkc.h header
can be used in the device tree sources.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
Signed-off-by: Jianxin Pan <jianxin.pan@amlogic.com>
---
 drivers/clk/meson/Kconfig    |  10 ++
 drivers/clk/meson/Makefile   |   1 +
 drivers/clk/meson/mmc-clkc.c | 313 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 324 insertions(+)
 create mode 100644 drivers/clk/meson/mmc-clkc.c

diff --git a/drivers/clk/meson/Kconfig b/drivers/clk/meson/Kconfig
index efaa70f..6bb0d44 100644
--- a/drivers/clk/meson/Kconfig
+++ b/drivers/clk/meson/Kconfig
@@ -15,6 +15,16 @@ config COMMON_CLK_MESON_AO
 	select COMMON_CLK_REGMAP_MESON
 	select RESET_CONTROLLER
 
+config COMMON_CLK_MMC_MESON
+	tristate "Meson MMC Sub Clock Controller Driver"
+	select MFD_SYSCON
+	select COMMON_CLK_AMLOGIC
+	select COMMON_CLK_AMLOGIC_AUDIO
+	help
+	  Support for the MMC sub clock controller on Amlogic Meson Platform,
+	  which include S905 (GXBB, GXL), A113D/X (AXG) devices.
+	  Say Y if you want this clock enabled.
+
 config COMMON_CLK_REGMAP_MESON
 	bool
 	select REGMAP
diff --git a/drivers/clk/meson/Makefile b/drivers/clk/meson/Makefile
index 39ce566..31c16d5 100644
--- a/drivers/clk/meson/Makefile
+++ b/drivers/clk/meson/Makefile
@@ -9,4 +9,5 @@ obj-$(CONFIG_COMMON_CLK_MESON8B) += meson8b.o
 obj-$(CONFIG_COMMON_CLK_GXBB)	 += gxbb.o gxbb-aoclk.o gxbb-aoclk-32k.o
 obj-$(CONFIG_COMMON_CLK_AXG)	 += axg.o axg-aoclk.o
 obj-$(CONFIG_COMMON_CLK_AXG_AUDIO)	+= axg-audio.o
+obj-$(CONFIG_COMMON_CLK_MMC_MESON) 	+= mmc-clkc.o
 obj-$(CONFIG_COMMON_CLK_REGMAP_MESON)	+= clk-regmap.o
diff --git a/drivers/clk/meson/mmc-clkc.c b/drivers/clk/meson/mmc-clkc.c
new file mode 100644
index 0000000..f5a79a4
--- /dev/null
+++ b/drivers/clk/meson/mmc-clkc.c
@@ -0,0 +1,313 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Amlogic Meson MMC Sub Clock Controller Driver
+ *
+ * Copyright (c) 2017 Baylibre SAS.
+ * Author: Jerome Brunet <jbrunet@baylibre.com>
+ *
+ * Copyright (c) 2018 Amlogic, inc.
+ * Author: Yixun Lan <yixun.lan@amlogic.com>
+ * Author: Jianxin Pan <jianxin.pan@amlogic.com>
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/of_device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/amlogic,mmc-clkc.h>
+
+#include "clkc.h"
+#include "clkc-audio.h"
+
+/* clock ID used by internal driver */
+#define CLKID_MMC_MUX			0
+
+#define   SD_EMMC_CLOCK		0
+#define   CLK_DELAY_STEP_PS		200
+
+#define MUX_CLK_NUM_PARENTS		2
+#define MMC_MAX_CLKS			5
+
+struct mmc_clkc_data {
+	struct meson_clk_phase_delay_data	tx;
+	struct meson_clk_phase_delay_data	rx;
+};
+
+static struct clk_regmap_mux_data mmc_clkc_mux_data = {
+	.offset		= SD_EMMC_CLOCK,
+	.mask		= 0x3,
+	.shift		= 6,
+};
+
+static const struct meson_sclk_div_data mmc_clkc_div_data = {
+	.div = {
+		.reg_off = SD_EMMC_CLOCK,
+		.shift   = (0),
+		.width   = (6),
+	},
+	.hi = {
+		.width   = 0,
+	},
+	.flags = CLK_DIVIDER_ONE_BASED,
+};
+
+static struct meson_clk_phase_data mmc_clkc_core_phase = {
+	.ph = {
+		.reg_off	= SD_EMMC_CLOCK,
+		.shift	= 8,
+		.width	= 2,
+	}
+};
+
+static const struct mmc_clkc_data mmc_clkc_gx_data = {
+	.tx = {
+		.phase = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 10,
+			.width	= 2,
+		},
+		.delay = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 16,
+			.width	= 4,
+		},
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+	.rx = {
+		.phase = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 12,
+			.width	= 2,
+		},
+		.delay = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 20,
+			.width	= 4,
+		},
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+};
+
+static const struct mmc_clkc_data mmc_clkc_axg_data = {
+	.tx = {
+		.phase = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 10,
+			.width	= 2,
+		},
+		.delay = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 16,
+			.width	= 6,
+		},
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+	.rx = {
+		.phase = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 12,
+			.width	= 2,
+		},
+		.delay = {
+			.reg_off	= SD_EMMC_CLOCK,
+			.shift	= 22,
+			.width	= 6,
+		},
+		.delay_step_ps	= CLK_DELAY_STEP_PS,
+	},
+};
+
+static const struct of_device_id mmc_clkc_match_table[] = {
+	{
+		.compatible	= "amlogic,gx-mmc-clkc",
+		.data		= &mmc_clkc_gx_data
+	},
+	{
+		.compatible	= "amlogic,axg-mmc-clkc",
+		.data		= &mmc_clkc_axg_data
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mmc_clkc_match_table);
+
+static struct clk_regmap *
+mmc_clkc_register_clk(struct device *dev, struct regmap *map,
+		      struct clk_init_data *init,
+		      const char *suffix, void *data)
+{
+	struct clk_regmap *clk;
+	char *name;
+	int ret;
+
+	clk = devm_kzalloc(dev, sizeof(*clk), GFP_KERNEL);
+	if (!clk)
+		return ERR_PTR(-ENOMEM);
+
+	name = kasprintf(GFP_KERNEL, "%s#%s", dev_name(dev), suffix);
+	if (!name)
+		return ERR_PTR(-ENOMEM);
+
+	init->name = name;
+
+	clk->map = map;
+	clk->data = data;
+	clk->hw.init = init;
+
+	ret = devm_clk_hw_register(dev, &clk->hw);
+	if (ret)
+		clk = ERR_PTR(ret);
+
+	kfree(name);
+	return clk;
+}
+
+static struct clk_regmap *mmc_clkc_register_mux(struct device *dev,
+						struct regmap *map)
+{
+	const char *parent_names[MUX_CLK_NUM_PARENTS];
+	struct clk_init_data init;
+	struct clk_regmap *mux;
+	struct clk *clk;
+	int i;
+
+	for (i = 0; i < MUX_CLK_NUM_PARENTS; i++) {
+		char name[8];
+
+		snprintf(name, sizeof(name), "clkin%d", i);
+		clk = devm_clk_get(dev, name);
+		if (IS_ERR(clk)) {
+			if (clk != ERR_PTR(-EPROBE_DEFER))
+				dev_err(dev, "Missing clock %s\n", name);
+			return ERR_PTR((long)clk);
+		}
+
+		parent_names[i] = __clk_get_name(clk);
+	}
+
+	init.ops = &clk_regmap_mux_ops;
+	init.flags = CLK_SET_RATE_PARENT;
+	init.parent_names = parent_names;
+	init.num_parents = MUX_CLK_NUM_PARENTS;
+
+	mux = mmc_clkc_register_clk(dev, map, &init, "mux", &mmc_clkc_mux_data);
+	if (IS_ERR(mux))
+		dev_err(dev, "Mux clock registration failed\n");
+
+	return mux;
+}
+
+static struct clk_regmap *
+mmc_clkc_register_clk_with_parent(struct device *dev, struct regmap *map,
+				  char *suffix, const struct clk_hw *hw,
+				  unsigned long flags,
+				  const struct clk_ops *ops, void *data)
+{
+	struct clk_init_data init;
+	struct clk_regmap *clk;
+	const char *parent_name = clk_hw_get_name(hw);
+
+	init.ops = ops;
+	init.flags = flags;
+	init.parent_names = &parent_name;
+	init.num_parents = 1;
+
+	clk = mmc_clkc_register_clk(dev, map, &init, suffix, data);
+	if (IS_ERR(clk))
+		dev_err(dev, "Core %s clock registration failed\n", suffix);
+
+	return clk;
+}
+
+static int mmc_clkc_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *onecell_data;
+	struct device *dev = &pdev->dev;
+	struct mmc_clkc_data *data;
+	struct regmap *map;
+	struct clk_regmap *clk, *core;
+	struct meson_sclk_div_data *div_data;
+
+	/*cast to drop the const in match->data*/
+	data = (struct mmc_clkc_data *)of_device_get_match_data(dev);
+	if (!data)
+		return -ENODEV;
+
+	map = syscon_node_to_regmap(dev->of_node);
+	if (IS_ERR(map)) {
+		dev_err(dev, "could not find mmc clock controller\n");
+		return PTR_ERR(map);
+	}
+
+	onecell_data = devm_kzalloc(dev, sizeof(*onecell_data) +
+				    sizeof(*onecell_data->hws) * MMC_MAX_CLKS,
+				    GFP_KERNEL);
+	if (!onecell_data)
+		return -ENOMEM;
+
+	clk = mmc_clkc_register_mux(dev, map);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	onecell_data->hws[CLKID_MMC_MUX]		= &clk->hw,
+
+	div_data = devm_kzalloc(dev, sizeof(*div_data), GFP_KERNEL);
+	if (!div_data)
+		return -ENOMEM;
+	*div_data = mmc_clkc_div_data;
+
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "div",
+						&clk->hw,
+						CLK_SET_RATE_PARENT,
+						&meson_sclk_div_ops,
+						div_data);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	onecell_data->hws[CLKID_MMC_DIV]		= &clk->hw,
+
+	core = mmc_clkc_register_clk_with_parent(dev, map, "core",
+						 &clk->hw,
+						 CLK_SET_RATE_PARENT,
+						 &meson_clk_phase_ops,
+						 &mmc_clkc_core_phase);
+	if (IS_ERR(core))
+		return PTR_ERR(core);
+	onecell_data->hws[CLKID_MMC_PHASE_CORE]		= &core->hw,
+
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "rx",
+						&core->hw,  0,
+						&meson_clk_phase_delay_ops,
+						&data->rx);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	onecell_data->hws[CLKID_MMC_PHASE_RX]		= &clk->hw,
+
+	clk = mmc_clkc_register_clk_with_parent(dev, map, "tx",
+						&core->hw,  0,
+						&meson_clk_phase_delay_ops,
+						&data->tx);
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+	onecell_data->hws[CLKID_MMC_PHASE_TX]		= &clk->hw,
+
+	onecell_data->num				= MMC_MAX_CLKS;
+
+	return devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get,
+					   onecell_data);
+}
+
+static struct platform_driver mmc_clkc_driver = {
+	.probe		= mmc_clkc_probe,
+	.driver		= {
+		.name	= "meson-mmc-clkc",
+		.of_match_table = of_match_ptr(mmc_clkc_match_table),
+	},
+};
+
+module_platform_driver(mmc_clkc_driver);
+
+MODULE_DESCRIPTION("Amlogic AXG MMC clock driver");
+MODULE_AUTHOR("Jianxin Pan <jianxin.pan@amlogic.com>");
+MODULE_LICENSE("GPL v2");
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
