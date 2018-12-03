Return-Path: <SRS0=0OAT=OM=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FAA6C04EB9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:24:16 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6152120878
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aFv7SDC4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6152120878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/VuToHyTkWGTWXpdIIQdwnPWVoIXQvI4T56hUc95aYM=; b=aFv7SDC4sVKtF4
	wgEa8i2FfHDPL1nq6PtLNgJjTNqbFYRG5VZ5Y4thIE4uAVAAViYH+TPajcM0Gj808s656aPlQYOnK
	Y0keaabLBeJOx4XCtBLk9sMUCWtggZysKJ2yxSFI9/j3mvatlENkZtlASzHfop0P26Aoash7HvHuA
	Dlz7o/moLH/g83Va+6+6o/RttfsQX5Jt1nDO20VtvntSsa5g5L4cbmlvEbI5Mk3XP9jZccJZHX1bE
	KOzQJ4ni3VCm3eCSeH4MEi2GUcCNhayf73oOtzoQZmroymYmcqNqHGiHHC/O7zpWQC/sijryruh7g
	JT+2CurwtejIrmS+r1gA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gTnGp-0002tE-FW; Mon, 03 Dec 2018 12:24:15 +0000
Received: from mail-lj1-f193.google.com ([209.85.208.193])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gTnGj-0002rx-3i
 for linux-arm-kernel@lists.infradead.org; Mon, 03 Dec 2018 12:24:13 +0000
Received: by mail-lj1-f193.google.com with SMTP id v1-v6so11183473ljd.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 03 Dec 2018 04:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=L3IcBOcMebSegDE2suDRtzdIfDfjoFDzHLWatOf7pRc=;
 b=j8n1TR2edzsHJGnQu1Z6SI8f4f4qaJovqUzYrxRRBWnN/3r/CSLPvMkvGuWdK9WW2y
 qGm1AjQyybuTzLqNrZnqNcbP6e9A+joalD+bsX5BxoE8vR3xB1xZGrD8cBJPKOLB3XYs
 nGGKYhaJxgQw4IVqH2odSYKp02Opc1q2Ff99eOCxJRpqzFU6rkUzBieKiZdsYZyRS+Pp
 rNjttJEsMChR7KEtD3l9uUa2hu3Zv+vHCQwSAjfAESABbtouvfqVBFvzn0+zKTj7/QsS
 nEVwkipi+fwQxE93pPQ0KgtZoOKbahgk1sC9PqL46FtiuaqJiwiQjUxu13WsFMuGJkOc
 Fyqw==
X-Gm-Message-State: AA+aEWYNmFn+x0pI4bGwh3mZpnQln98e7gf+GNKY6EpXQI9YIFQjl5RS
 mJRBpkdDZ1UbARMzz1M3NAY=
X-Google-Smtp-Source: AFSGD/W+ahtDp3KH0WT3OuHcaqjTmG8XYhWE4G4B62ekVjbHPEE1Vbep23gig1Bmq5eHfclZDz4PuQ==
X-Received: by 2002:a2e:8ec8:: with SMTP id
 e8-v6mr9863359ljl.162.1543839837418; 
 Mon, 03 Dec 2018 04:23:57 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
 by smtp.gmail.com with ESMTPSA id v5-v6sm2477864lje.78.2018.12.03.04.23.55
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 03 Dec 2018 04:23:56 -0800 (PST)
Date: Mon, 3 Dec 2018 14:23:43 +0200
From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To: mazziesaccount@gmail.com, matti.vaittinen@fi.rohmeurope.com
Subject: [PATCH v5 9/9] clk: bd718x7: Initial support for ROHM
 bd71837/bd71847 PMIC clock
Message-ID: <3bb96772e26833fe121fd99ea53eca616c2955be.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cover.1543837442.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181203_042409_148274_88448FAD 
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
Cc: david.brown@linaro.org, linux-clk@vger.kernel.org, b.zolnierkie@samsung.com,
 sboyd@kernel.org, linux-kernel@vger.kernel.org, mturquette@baylibre.com,
 rafael.j.wysocki@intel.com, linux-doc@vger.kernel.org, linux@armlinux.org.uk,
 krzk@kernel.org, akshu.agrawal@amd.com, cw00.choi@samsung.com,
 djkurtz@chromium.org, pavel@ucw.cz, pombredanne@nexb.com,
 andy.gross@linaro.org, andrew.smirnov@gmail.com, lee.jones@linaro.org,
 sjhuang@iluvatar.ai, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

ROHM bd71837 and bd71847 contain 32768Hz clock gate. Support the clock
using generic clock framework. Note, only bd71837 is tested but bd71847
should be identical what comes to clk parts.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/clk/Kconfig       |   7 +++
 drivers/clk/Makefile      |   1 +
 drivers/clk/clk-bd718x7.c | 131 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 139 insertions(+)
 create mode 100644 drivers/clk/clk-bd718x7.c

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 81cdb4eaca07..2dc12bf75b1b 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -283,6 +283,13 @@ config COMMON_CLK_STM32H7
 	---help---
 	  Support for stm32h7 SoC family clocks
 
+config COMMON_CLK_BD718XX
+	tristate "Clock driver for ROHM BD718x7 PMIC"
+	depends on MFD_ROHM_BD718XX
+	help
+	  This driver supports ROHM BD71837 and ROHM BD71847
+	  PMICs clock gates.
+
 source "drivers/clk/actions/Kconfig"
 source "drivers/clk/bcm/Kconfig"
 source "drivers/clk/hisilicon/Kconfig"
diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index 72be7a38cff1..a47430b387db 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -21,6 +21,7 @@ endif
 obj-$(CONFIG_MACH_ASM9260)		+= clk-asm9260.o
 obj-$(CONFIG_COMMON_CLK_AXI_CLKGEN)	+= clk-axi-clkgen.o
 obj-$(CONFIG_ARCH_AXXIA)		+= clk-axm5516.o
+obj-$(CONFIG_COMMON_CLK_BD718XX)	+= clk-bd718x7.o
 obj-$(CONFIG_COMMON_CLK_CDCE706)	+= clk-cdce706.o
 obj-$(CONFIG_COMMON_CLK_CDCE925)	+= clk-cdce925.o
 obj-$(CONFIG_ARCH_CLPS711X)		+= clk-clps711x.o
diff --git a/drivers/clk/clk-bd718x7.c b/drivers/clk/clk-bd718x7.c
new file mode 100644
index 000000000000..df5f1068ce8e
--- /dev/null
+++ b/drivers/clk/clk-bd718x7.c
@@ -0,0 +1,131 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2018 ROHM Semiconductors
+// bd71837.c  -- ROHM BD71837MWV clock driver
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/mfd/rohm-bd718x7.h>
+#include <linux/clk-provider.h>
+#include <linux/clkdev.h>
+#include <linux/regmap.h>
+
+struct bd718xx_clk {
+	struct clk_hw hw;
+	u8 reg;
+	u8 mask;
+	struct platform_device *pdev;
+	struct bd718xx *mfd;
+};
+
+static int bd71837_clk_set(struct clk_hw *hw, int status)
+{
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	return regmap_update_bits(c->mfd->regmap, c->reg, c->mask, status);
+}
+
+static void bd71837_clk_disable(struct clk_hw *hw)
+{
+	int rv;
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	rv = bd71837_clk_set(hw, 0);
+	if (rv)
+		dev_dbg(&c->pdev->dev, "Failed to disable 32K clk (%d)\n", rv);
+}
+
+static int bd71837_clk_enable(struct clk_hw *hw)
+{
+	return bd71837_clk_set(hw, 1);
+}
+
+static int bd71837_clk_is_enabled(struct clk_hw *hw)
+{
+	int enabled;
+	int rval;
+	struct bd718xx_clk *c = container_of(hw, struct bd718xx_clk, hw);
+
+	rval = regmap_read(c->mfd->regmap, c->reg, &enabled);
+
+	if (rval)
+		return rval;
+
+	return enabled & c->mask;
+}
+
+static const struct clk_ops bd71837_clk_ops = {
+	.prepare = &bd71837_clk_enable,
+	.unprepare = &bd71837_clk_disable,
+	.is_prepared = &bd71837_clk_is_enabled,
+};
+
+static int bd71837_clk_probe(struct platform_device *pdev)
+{
+	struct bd718xx_clk *c;
+	int rval = -ENOMEM;
+	const char *parent_clk;
+	struct device *parent = pdev->dev.parent;
+	struct bd718xx *mfd = dev_get_drvdata(parent);
+	struct clk_init_data init = {
+		.name = "bd718xx-32k-out",
+		.ops = &bd71837_clk_ops,
+	};
+
+	c = devm_kzalloc(&pdev->dev, sizeof(*c), GFP_KERNEL);
+	if (!c)
+		return -ENOMEM;
+
+	init.num_parents = 1;
+	parent_clk = of_clk_get_parent_name(parent->of_node, 0);
+
+	init.parent_names = &parent_clk;
+	if (!parent_clk) {
+		dev_err(&pdev->dev, "No parent clk found\n");
+		return -EINVAL;
+	}
+
+	c->reg = BD718XX_REG_OUT32K;
+	c->mask = BD718XX_OUT32K_EN;
+	c->mfd = mfd;
+	c->pdev = pdev;
+	c->hw.init = &init;
+
+	of_property_read_string_index(parent->of_node,
+				      "clock-output-names", 0, &init.name);
+
+	rval = devm_clk_hw_register(&pdev->dev, &c->hw);
+	if (!rval) {
+		rval = devm_clk_hw_register_clkdev(&pdev->dev,
+						   &c->hw, init.name, NULL);
+		if (rval)
+			dev_warn(&pdev->dev, "Failed to register clkdev\n");
+		if (parent->of_node) {
+			rval = devm_of_clk_add_parent_hw_provider(&pdev->dev,
+					     of_clk_hw_simple_get, &c->hw);
+			if (rval)
+				dev_err(&pdev->dev,
+					"adding clk provider failed\n");
+		}
+	} else {
+		dev_err(&pdev->dev, "failed to register 32K clk");
+	}
+
+	return rval;
+}
+
+static struct platform_driver bd71837_clk = {
+	.driver = {
+		.name = "bd718xx-clk",
+	},
+	.probe = bd71837_clk_probe,
+};
+
+module_platform_driver(bd71837_clk);
+
+MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
+MODULE_DESCRIPTION("BD71837 chip clk driver");
+MODULE_LICENSE("GPL");
-- 
2.14.3


-- 
Matti Vaittinen
ROHM Semiconductors

~~~ "I don't think so," said Rene Descartes.  Just then, he vanished ~~~

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
