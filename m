Return-Path: <SRS0=7qzz=O6=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18C9C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D84421907
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 01:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aO065Q+k";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/F1IbSq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D84421907
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ROsRMoLzox0R+ksl3rWBUrYRaBo6tVahxHzSYR0MDJg=; b=aO065Q+k7vLsE28cSUcMgrWfxI
	HdFF5DkirB/QGt52TbpLEH4W75l5cpLv8LM1r+xy6ou4XL2C4WLdIuKzQKdO2Dl0jCR/x8bn+KGTm
	rDBai3RAougZS9fiSo5egTclV7n/9iANJWuEwd1tLIpetlhMR02gBkkZBrwP3uI9aB2roch43E9Ed
	zWKyjo/sZben6itwQT7PAOIapPF6/J8/6ISz3f2CU5HWTna7nAwk1t7CpZ9FEseqvjO4EsDlawzOv
	xk1XCoeTg2naVbDLo+lbuu3sv/jZeS+lOP5N1DggZyBBK29sHN1W57mn/4BWNbmMMe8M58TfbjE97
	eLYgVfNw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1ga9j0-0000u3-QK; Fri, 21 Dec 2018 01:35:38 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1ga9ic-0007u3-Q7
 for linux-arm-kernel@lists.infradead.org; Fri, 21 Dec 2018 01:35:17 +0000
Received: by mail-pl1-x643.google.com with SMTP id t13so1694715ply.13
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 20 Dec 2018 17:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=lvNiz1sJUN3u4plyiJIU8RxNvE8IqOxkEmcLaSL2s9E=;
 b=I/F1IbSqypDVMmpm8s6j1LcPFTXJVOZW2zuejfnZiDSqFjQjsjiUXYZAPEk7SekDM3
 9i9rNGjui+cV5pYQ9sYZkUbxuiGrR0UBbJmkKXbK2qYKxpPDM1Ee7dc0qvPBunFBiwYj
 21UkHnWqxm70qknUyldt6QcCgydjfyOZkTnYCCjEotT4JJPxoxH8/++DwggzNX7rgCg5
 aPf51nceW6JphEYmRHeGOJqdnUGhzr2Aa8Au+QdGTLSslplv5FJGwSxSrJoTpq9VNnPZ
 Md7XsIrYPwX+6zcAoG+WGPFmvHfka79r+AUN5YjPY/QwtKvpJsB/SByvubkGmH33uzdw
 TLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=lvNiz1sJUN3u4plyiJIU8RxNvE8IqOxkEmcLaSL2s9E=;
 b=eyBG9pS7ZiMypKAci6qpmxtxREA5ksU8jrG6faTOavwufNZ0MLe44E/y4MFSb54FBT
 +y4enB7vN+Xueh0608+IrMF94l7nQJQlx6J6IMJhls1GN4ltBewv+yU/Gu90m1Gyllxy
 XfWNY0+u7p+9iyCWGFLMOrY/o3M7aB3+rAjX1Tar3mCF5yPew+7/cf8s/kvOiD3+lS7z
 /nNAVZ+BQlkCRH6PUxGlBQ/oZ50W6wc/aou9vhH9XHgHzHE0qUcoxBVnMCnKealexrrm
 LntFW91D5oPM42orXVZ80dg87Vbrd2fyxyV2yW1lAiIIMzf2B5aN2Ntuk9mCNxuJd6YM
 q8+g==
X-Gm-Message-State: AJcUukfUcZF2VDi2Dvblf2iOfqc3MR5jUqs4ttSDvrIUTCerz48qE7QA
 nKlVp57pW6FL4Bg/CWOlz+0=
X-Google-Smtp-Source: ALg8bN4DewViTg+GKJQ0oCcmcZCNie0uw4RNm1NwGuvwRV5jIG2NgGWSwXsAY6WYMP/jhcWVJkSX1Q==
X-Received: by 2002:a17:902:5601:: with SMTP id
 h1mr557187pli.160.1545356103605; 
 Thu, 20 Dec 2018 17:35:03 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id g70sm36590854pfg.98.2018.12.20.17.35.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 20 Dec 2018 17:35:02 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: p.zabel@pengutronix.de,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] reset: Add Broadcom STB SW_INIT reset controller driver
Date: Thu, 20 Dec 2018 17:34:09 -0800
Message-Id: <20181221013409.14324-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181221013409.14324-1-f.fainelli@gmail.com>
References: <20181221013409.14324-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181220_173514_928176_F38E98C2 
X-CRM114-Status: GOOD (  18.93  )
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
Cc: Mark Rutland <mark.rutland@arm.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Florian Fainelli <f.fainelli@gmail.com>,
 Rob Herring <robh+dt@kernel.org>,
 "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <bcm-kernel-feedback-list@broadcom.com>, Gregory Fong <gregory.0xf0@gmail.com>,
 Brian Norris <computersforpeace@gmail.com>,
 "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for resetting blocks through the Linux reset controller
subsystem when reset lines are provided through a SW_INIT-style reset
controller on Broadcom STB SoCs.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/reset/Kconfig         |   7 ++
 drivers/reset/Makefile        |   1 +
 drivers/reset/reset-brcmstb.c | 121 ++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/reset/reset-brcmstb.c

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index 2e01bd833ffd..1ca03c57e049 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -40,6 +40,13 @@ config RESET_BERLIN
 	help
 	  This enables the reset controller driver for Marvell Berlin SoCs.
 
+config RESET_BRCMSTB
+	bool "Broadcom STB reset controller" if COMPILE_TEST
+	default ARCH_BRCMSTB
+	help
+	  This enables the reset controller driver for Broadcom STB SoCs using
+	  a SUN_TOP_CTRL_SW_INIT style controller.
+
 config RESET_HSDK
 	bool "Synopsys HSDK Reset Driver"
 	depends on HAS_IOMEM
diff --git a/drivers/reset/Makefile b/drivers/reset/Makefile
index dc7874df78d9..7395db2cb1dd 100644
--- a/drivers/reset/Makefile
+++ b/drivers/reset/Makefile
@@ -7,6 +7,7 @@ obj-$(CONFIG_RESET_A10SR) += reset-a10sr.o
 obj-$(CONFIG_RESET_ATH79) += reset-ath79.o
 obj-$(CONFIG_RESET_AXS10X) += reset-axs10x.o
 obj-$(CONFIG_RESET_BERLIN) += reset-berlin.o
+obj-$(CONFIG_RESET_BRCMSTB) += reset-brcmstb.o
 obj-$(CONFIG_RESET_HSDK) += reset-hsdk.o
 obj-$(CONFIG_RESET_IMX7) += reset-imx7.o
 obj-$(CONFIG_RESET_LANTIQ) += reset-lantiq.o
diff --git a/drivers/reset/reset-brcmstb.c b/drivers/reset/reset-brcmstb.c
new file mode 100644
index 000000000000..17a0bcdd6c9a
--- /dev/null
+++ b/drivers/reset/reset-brcmstb.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller for SW_INIT style reset controller
+ *
+ * Copyright (C) 2018 Broadcom
+ *
+ */
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset-controller.h>
+#include <linux/types.h>
+
+struct brcmstb_reset {
+	void __iomem *base;
+	unsigned int n_words;
+	struct device *dev;
+	struct reset_controller_dev rcdev;
+};
+
+#define SW_INIT_SET		0x00
+#define SW_INIT_CLEAR		0x04
+#define SW_INIT_STATUS		0x08
+
+#define SW_INIT_BIT(id)		BIT((id) & 0x1f)
+#define SW_INIT_BANK(id)	(id >> 5)
+
+#define SW_INIT_BANK_SIZE	0x18
+
+static inline
+struct brcmstb_reset *to_brcmstb(struct reset_controller_dev *rcdev)
+{
+	return container_of(rcdev, struct brcmstb_reset, rcdev);
+}
+
+static int brcmstb_reset_assert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = to_brcmstb(rcdev);
+
+	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_SET);
+	msleep(10);
+
+	return 0;
+}
+
+static int brcmstb_reset_deassert(struct reset_controller_dev *rcdev,
+				  unsigned long id)
+{
+	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = to_brcmstb(rcdev);
+
+	writel_relaxed(SW_INIT_BIT(id), priv->base + off + SW_INIT_CLEAR);
+	msleep(10);
+
+	return 0;
+}
+
+static int brcmstb_reset_status(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	unsigned int off = SW_INIT_BANK(id) * SW_INIT_BANK_SIZE;
+	struct brcmstb_reset *priv = to_brcmstb(rcdev);
+
+	return readl_relaxed(priv->base + off + SW_INIT_STATUS);
+}
+
+static const struct reset_control_ops brcmstb_reset_ops = {
+	.assert	= brcmstb_reset_assert,
+	.deassert = brcmstb_reset_deassert,
+	.status = brcmstb_reset_status,
+};
+
+static int brcmstb_reset_probe(struct platform_device *pdev)
+{
+	struct device *kdev = &pdev->dev;
+	struct brcmstb_reset *priv;
+	struct resource *res;
+
+	priv = devm_kzalloc(kdev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	priv->base = devm_ioremap_resource(kdev, res);
+	if (IS_ERR(priv->base))
+		return PTR_ERR(priv->base);
+
+	dev_set_drvdata(kdev, priv);
+
+	priv->rcdev.owner = THIS_MODULE;
+	priv->rcdev.nr_resets = (resource_size(res) / SW_INIT_BANK_SIZE) * 32;
+	priv->rcdev.ops = &brcmstb_reset_ops;
+	priv->rcdev.of_node = kdev->of_node;
+	/* Use defaults: 1 cell and simple xlate function */
+	priv->dev = kdev;
+
+	return devm_reset_controller_register(kdev, &priv->rcdev);
+}
+
+static const struct of_device_id brcmstb_reset_of_match[] = {
+	{ .compatible = "brcm,brcmstb-reset" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver brcmstb_reset_driver = {
+	.probe	= brcmstb_reset_probe,
+	.driver	= {
+		.name = "brcmstb-reset",
+		.of_match_table = brcmstb_reset_of_match,
+	},
+};
+module_platform_driver(brcmstb_reset_driver);
+
+MODULE_AUTHOR("Broadcom");
+MODULE_DESCRIPTION("Broadcom STB reset controller");
+MODULE_LICENSE("GPL");
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
