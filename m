Return-Path: <SRS0=3lKL=PX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A48C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:45:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 991DE20675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 18:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dncbJ+Pl";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kGpgehLl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 991DE20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5SlSM61ChxIUySKXyCVAzGhYCgJgP7VE5vZpncCkssw=; b=dncbJ+Pl26XuWbXM2E2aCrO0DN
	HVJLPCGqm5CugvWhHwtoOgyMZn18og1sBFRGDGOMcWZculZMAeIMfv8Af58M/uA9W5oWQaNfA7exE
	7IzjUZXw/pz6shKGz2hKlYuKgnxXBjpAZbjbOSdjzZgXgWD4wqDuEd08hTDS01Wt1jzsKnyp2TNbF
	4RcOKwhd1DhvZYrGA6N3NumtFc7nr70J9rkWJQsA94J2ZRLmZk6OMRdrj4q8WWWKtqMjEkAP3j1Wx
	79pBL9IWDRrwmDZyDEgEyW18jHLdz4KQsjohCKuJ002i0k+blYlz/Q4b+1kXnv4KxckKcme4q+vcG
	xJf0Uo/A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjTi1-0004ci-55; Tue, 15 Jan 2019 18:45:09 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjThQ-0003ke-G0
 for linux-arm-kernel@lists.infradead.org; Tue, 15 Jan 2019 18:44:34 +0000
Received: by mail-pf1-x444.google.com with SMTP id 64so1712713pfr.9
 for <linux-arm-kernel@lists.infradead.org>;
 Tue, 15 Jan 2019 10:44:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=dd2b6Wp07ztM3upxMne23DJmTJF6xZ37NCqZQmiWWso=;
 b=kGpgehLlSde+XYKt3NxzMtK8hYBBPqrHhMwq3QSenMF9aOjkj2sZwD1fgpB3Zq54Jv
 cVXsf0mPnZsKOrrZ71r6rKnaLc4DA3H5hVmZ7PTBFxmO9A85107JPCzlDEYtH+P/WRXE
 /6mEGWXfJd7OR0z0FYVRZ6E3cbwVgr7qAPoAdD6LVHTRP9mqsLUGEvguA00GP7aQilbZ
 sqQHZRn6SiTpPfuaxhQsUu+jN20Dybq6rbgcJfHBlVhaON2XBWqUo7aKagCwYhjp3YyM
 iFb2Hv2uHCmWE5LUxpYqm+KB2XAH5D3LtnH0R0OFTmpS75ygXWs9LrHy9HUPndN2aW9+
 UswQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=dd2b6Wp07ztM3upxMne23DJmTJF6xZ37NCqZQmiWWso=;
 b=t3HBrc9c4nGh7neSWHdxCLzLOM4MvaOi4NJkfcwh0d7pwQRdWTuBRSvuk+t/jVccbg
 haiczBKzC3JHuDleGZf3u7cXvX8ZIHr3Z7uRyR08UdNjbwxw+pQafTgcnHzK1/h8oxGF
 Bq5fAeFnKgUFelgEO4EQnwF8wAkK+jthR6eWVhJVP5o+aKNEuJpHLWuRMSXTz0jvafOP
 iLg8LrqruNYMD+Y10iEDlR7RHFUNIKOHjcae7oCbyf6IA0x+EowwYftzRqJKm0K8g+mV
 54HHYZBX1ZCWiRE+cAFTcF71mxROuAZpJYQjVThBTiK2k6VyLPUpja2PS7MY6VtGN6b8
 38aQ==
X-Gm-Message-State: AJcUukcn3B9PaGKbJEvrOQXHFvfxJbs7IW6FfrhIODrGUzcptrcSUoAM
 W1AV3DU8NoZHdtdsdOgVu7M=
X-Google-Smtp-Source: ALg8bN7+22N/obt6fEsQqkH33J6KAF1ii14A22RJmOr57aKF8HRElelaq4/wnXGtuF1+b/0Cy5wgQA==
X-Received: by 2002:a63:4d66:: with SMTP id n38mr5076909pgl.270.1547577871473; 
 Tue, 15 Jan 2019 10:44:31 -0800 (PST)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.250])
 by smtp.gmail.com with ESMTPSA id m67sm9156950pfb.25.2019.01.15.10.44.29
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 15 Jan 2019 10:44:30 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] reset: Add Broadcom STB SW_INIT reset controller driver
Date: Tue, 15 Jan 2019 10:44:06 -0800
Message-Id: <20190115184406.3164-3-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115184406.3164-1-f.fainelli@gmail.com>
References: <20190115184406.3164-1-f.fainelli@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190115_104432_533898_305B7761 
X-CRM114-Status: GOOD (  20.38  )
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
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>,
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
 drivers/reset/reset-brcmstb.c | 130 ++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
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
index 000000000000..01ab1f71518b
--- /dev/null
+++ b/drivers/reset/reset-brcmstb.c
@@ -0,0 +1,130 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Broadcom STB generic reset controller for SW_INIT style reset controller
+ *
+ * Author: Florian Fainelli <f.fainelli@gmail.com>
+ * Copyright (C) 2018 Broadcom
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
+	struct reset_controller_dev rcdev;
+};
+
+#define SW_INIT_SET		0x00
+#define SW_INIT_CLEAR		0x04
+#define SW_INIT_STATUS		0x08
+
+#define SW_INIT_BIT(id)		BIT((id) & 0x1f)
+#define SW_INIT_BANK(id)	((id) >> 5)
+
+/* A full bank contains extra registers that we are not utilizing but still
+ * qualify as a single bank.
+ */
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
+	/* Maximum reset delay after de-asserting a line and seeing block
+	 * operation is typically 14us for the worst case, build some slack
+	 * here.
+	 */
+	usleep_range(100, 200);
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
+	return readl_relaxed(priv->base + off + SW_INIT_STATUS) &
+			     SW_INIT_BIT(id);
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
+	if (resource_size(res) % SW_INIT_BANK_SIZE) {
+		dev_err(kdev, "incorrect register range\n");
+		return -EINVAL;
+	}
+
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
