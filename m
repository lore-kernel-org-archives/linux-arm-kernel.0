Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 827C2C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C6C720823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:46:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YnHJUeLw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cntTMUXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C6C720823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3pALDxl3HENLISeftgkdK7Hj3oILeD4SkoS0/J/nq7Y=; b=YnHJUeLwj5TM+9
	YnVbU51LF8B0ZMxBAWVnzAVsb4CcuE2DfhX4qsmWxPqD/AWlboxtmyHR0lG7tDJsP/6uXuh1yb3Ib
	HZvyonz0MT34JiQFGjc9MdPC4PKXZVTh268rXpuZXid/h950ylI6oJY3bvAFN6S00E1W4GQe7IRTC
	sqS+5CANw04H9Vtka4zSjZ3aRnyxmf6oL77SDsr5CunkFBtMIXYenS2e9UPkVsVgSHptXIjXVJKhA
	Ju+CGOUySOS7cdP9NGGNjH4G6WlMHGQblUqkUDl2HJ200huV1IIMKd+YtDPeH4ju4DhRmwT1ks8dr
	M6iVjylqF1LGC2p2XPUw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqYB-00062v-PP; Thu, 21 Feb 2019 15:46:15 +0000
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXL-0004wL-LJ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:28 +0000
Received: by mail-lf1-x142.google.com with SMTP id q12so20737155lfm.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ydtr9kS0jBdprA0griqlZhz/r8SHgp5tMSx95q9fwc8=;
 b=cntTMUXetJ4dZVI4MED/bINKmsdMB77bNMmsivrRYXxvjjU9hi7d2UMVMi3Z/Q07UH
 fFIgSk1JC49KWn+1rsEiTLb245fSPVCHDXQJjwq0afbLZt6NaflqBPE+3u0DiDqY79sU
 NbSFWjlHpPIdsKLU7dOniM++MMp5qgQsWbJ/Bw6aVeGPUHyP+zJ2dLVTlduXjVbvhXcm
 uVJO/f+xbTuUxkgI/yQKBjalqwyst/7weEoYoh6UHSxsRZsTao1JyI6aH6PsXX8Twfa1
 cQRSu9RhpI4A+T0LJNaK4IUs9vmSDAdIpu0I9ZRS/CteSKq4QIxe8ay9zAOBiLRgVJFx
 TFxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ydtr9kS0jBdprA0griqlZhz/r8SHgp5tMSx95q9fwc8=;
 b=tLlSrcTQrnsDH093dOPAodCXLJo9ag/4UFBnoovkOu8AjtUFevlxBF20fKdD8oik6f
 NLWZxeIjd6GdNXUq3/89rwMjDLX/HftXNHfjSwx0neFIKrUMscaWdRFldxSwiNH72vtl
 tzEfESAuKjnPGksIwFy12RsUEVYIEYhZc5NucIF5ju/exht3Cztz9lQtsopKCiveXlqM
 2IXuSh0e3OFMsx+7cD8uEoJf6d4LrrFW8upkXhxrtDCrzmYd05AkmNObsDwqqSmj1Kl0
 PFXWsfLanYqu45kstlbJYANki3s/SrnaizSZG+lXYJEqdJJb5KMQqgbxYkX98Izk38/2
 z8bQ==
X-Gm-Message-State: AHQUAubzJzuRZDpsTKKTLy7o/DtSbiJWdt2uA5V/hO9SxXlZk1SfKGHo
 86f2BRQz4OSMXXoOxwAwaZkF8MV91rM=
X-Google-Smtp-Source: AHgI3IbD4VoulOessIXVshFSBiSsosQrbFcAZCvIt/3OYJr2d4sk/OrWiaTBOssJkWNbGp8c3hcc7g==
X-Received: by 2002:a19:d83:: with SMTP id 125mr23426782lfn.159.1550763921118; 
 Thu, 21 Feb 2019 07:45:21 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.19
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:20 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 05/30 v2] gpio: ixp4xx: Add driver for the IXP4xx GPIO
Date: Thu, 21 Feb 2019 16:44:33 +0100
Message-Id: <20190221154458.23763-6-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074524_446333_0A449877 
X-CRM114-Status: GOOD (  29.45  )
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
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a driver for the IXP4xx GPIO block found in
the Intel XScale IXP4xx systems.

The GPIO part of this block is pretty straight-forward and
just uses the generic MMIO GPIO library.

The irqchip side of this driver is hierarchical where
the main irqchip will receive a processed level trigger
in response to the edge detector of the GPIO block,
so for this reason the v2 version of the irqdomain API
is used (as well as in the parent IXP4xx irqchip) and
masking, unmasking and setting up the type on IRQ
happens on several levels.

Currently this GPIO controller will grab the parent
irqdomain using a special function, but as the platform
move toward device tree probing, this will not be needed:
we can just look up the parent irqdomain from the device
tree.

Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Fix comment style in header
- Fix register naming to be more intuitive
---
 MAINTAINERS                |   1 +
 drivers/gpio/Kconfig       |  12 +
 drivers/gpio/Makefile      |   1 +
 drivers/gpio/gpio-ixp4xx.c | 444 +++++++++++++++++++++++++++++++++++++
 4 files changed, 458 insertions(+)
 create mode 100644 drivers/gpio/gpio-ixp4xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 0d48faa3e635..6c161bd82238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,6 +1651,7 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ixp4xx/
+F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
 F:	include/linux/irqchip/irq-ixp4xx.h
 
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 699a8118c433..fe4a47e49a24 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -286,6 +286,18 @@ config GPIO_IOP
 
 	  If unsure, say N.
 
+config GPIO_IXP4XX
+	bool "Intel IXP4xx GPIO"
+	depends on ARCH_IXP4XX || COMPILE_TEST
+	select GPIO_GENERIC
+	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
+	help
+	  Say yes here to support the GPIO functionality of a number of Intel
+	  IXP4xx series of chips.
+
+	  If unsure, say N.
+
 config GPIO_LOONGSON
 	bool "Loongson-2/3 GPIO support"
 	depends on CPU_LOONGSON2 || CPU_LOONGSON3
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 0568bbe6fe68..cf66523b5eec 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_GPIO_HLWD)		+= gpio-hlwd.o
 obj-$(CONFIG_HTC_EGPIO)		+= gpio-htc-egpio.o
 obj-$(CONFIG_GPIO_ICH)		+= gpio-ich.o
 obj-$(CONFIG_GPIO_IOP)		+= gpio-iop.o
+obj-$(CONFIG_GPIO_IXP4XX)	+= gpio-ixp4xx.o
 obj-$(CONFIG_GPIO_IT87)		+= gpio-it87.o
 obj-$(CONFIG_GPIO_JANZ_TTL)	+= gpio-janz-ttl.o
 obj-$(CONFIG_GPIO_KEMPLD)	+= gpio-kempld.o
diff --git a/drivers/gpio/gpio-ixp4xx.c b/drivers/gpio/gpio-ixp4xx.c
new file mode 100644
index 000000000000..eaf317f73f75
--- /dev/null
+++ b/drivers/gpio/gpio-ixp4xx.c
@@ -0,0 +1,444 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// IXP4 GPIO driver
+// Copyright (C) 2019 Linus Walleij <linus.walleij@linaro.org>
+//
+// based on previous work and know-how from:
+// Deepak Saxena <dsaxena@plexity.net>
+
+#include <linux/gpio/driver.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqdomain.h>
+#include <linux/irqchip.h>
+#include <linux/platform_device.h>
+#include <linux/bitops.h>
+/* Include that go away with DT transition */
+#include <linux/irqchip/irq-ixp4xx.h>
+
+#include <asm/mach-types.h>
+
+#define IXP4XX_REG_GPOUT	0x00
+#define IXP4XX_REG_GPOE		0x04
+#define IXP4XX_REG_GPIN		0x08
+#define IXP4XX_REG_GPIS		0x0C
+#define IXP4XX_REG_GPIT1	0x10
+#define IXP4XX_REG_GPIT2	0x14
+#define IXP4XX_REG_GPCLK	0x18
+#define IXP4XX_REG_GPDBSEL	0x1C
+
+/*
+ * The hardware uses 3 bits to indicate interrupt "style".
+ * we clear and set these three bits accordingly. The lower 24
+ * bits in two registers (GPIT1 and GPIT2) are used to set up
+ * the style for 8 lines each for a total of 16 GPIO lines.
+ */
+#define IXP4XX_GPIO_STYLE_ACTIVE_HIGH	0x0
+#define IXP4XX_GPIO_STYLE_ACTIVE_LOW	0x1
+#define IXP4XX_GPIO_STYLE_RISING_EDGE	0x2
+#define IXP4XX_GPIO_STYLE_FALLING_EDGE	0x3
+#define IXP4XX_GPIO_STYLE_TRANSITIONAL	0x4
+#define IXP4XX_GPIO_STYLE_MASK		GENMASK(2, 0)
+#define IXP4XX_GPIO_STYLE_SIZE		3
+
+/**
+ * struct ixp4xx_gpio - IXP4 GPIO state container
+ * @dev: containing device for this instance
+ * @fwnode: the fwnode for this GPIO chip
+ * @gc: gpiochip for this instance
+ * @domain: irqdomain for this chip instance
+ * @base: remapped I/O-memory base
+ * @irq_edge: Each bit represents an IRQ: 1: edge-triggered,
+ * 0: level triggered
+ */
+struct ixp4xx_gpio {
+	struct device *dev;
+	struct fwnode_handle *fwnode;
+	struct gpio_chip gc;
+	struct irq_domain *domain;
+	void __iomem *base;
+	unsigned long long irq_edge;
+};
+
+/**
+ * struct ixp4xx_gpio_map - IXP4 GPIO to parent IRQ map
+ * @gpio_offset: offset of the IXP4 GPIO line
+ * @parent_hwirq: hwirq on the parent IRQ controller
+ */
+struct ixp4xx_gpio_map {
+	int gpio_offset;
+	int parent_hwirq;
+};
+
+/* GPIO lines 0..12 have corresponding IRQs, GPIOs 13..15 have no IRQs */
+const struct ixp4xx_gpio_map ixp4xx_gpiomap[] = {
+	{ .gpio_offset = 0, .parent_hwirq = 6 },
+	{ .gpio_offset = 1, .parent_hwirq = 7 },
+	{ .gpio_offset = 2, .parent_hwirq = 19 },
+	{ .gpio_offset = 3, .parent_hwirq = 20 },
+	{ .gpio_offset = 4, .parent_hwirq = 21 },
+	{ .gpio_offset = 5, .parent_hwirq = 22 },
+	{ .gpio_offset = 6, .parent_hwirq = 23 },
+	{ .gpio_offset = 7, .parent_hwirq = 24 },
+	{ .gpio_offset = 8, .parent_hwirq = 25 },
+	{ .gpio_offset = 9, .parent_hwirq = 26 },
+	{ .gpio_offset = 10, .parent_hwirq = 27 },
+	{ .gpio_offset = 11, .parent_hwirq = 28 },
+	{ .gpio_offset = 12, .parent_hwirq = 29 },
+};
+
+static void ixp4xx_gpio_irq_ack(struct irq_data *d)
+{
+	struct ixp4xx_gpio *g = irq_data_get_irq_chip_data(d);
+
+	__raw_writel(BIT(d->hwirq), g->base + IXP4XX_REG_GPIS);
+}
+
+static void ixp4xx_gpio_irq_unmask(struct irq_data *d)
+{
+	struct ixp4xx_gpio *g = irq_data_get_irq_chip_data(d);
+
+	/* ACK when unmasking if not edge-triggered */
+	if (!(g->irq_edge & BIT(d->hwirq)))
+		ixp4xx_gpio_irq_ack(d);
+
+	irq_chip_unmask_parent(d);
+}
+
+static int ixp4xx_gpio_irq_set_type(struct irq_data *d, unsigned int type)
+{
+	struct ixp4xx_gpio *g = irq_data_get_irq_chip_data(d);
+	int line = d->hwirq;
+	unsigned long flags;
+	u32 int_style;
+	u32 int_reg;
+	u32 val;
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_BOTH:
+		irq_set_handler_locked(d, handle_edge_irq);
+		int_style = IXP4XX_GPIO_STYLE_TRANSITIONAL;
+		g->irq_edge |= BIT(d->hwirq);
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		irq_set_handler_locked(d, handle_edge_irq);
+		int_style = IXP4XX_GPIO_STYLE_RISING_EDGE;
+		g->irq_edge |= BIT(d->hwirq);
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		irq_set_handler_locked(d, handle_edge_irq);
+		int_style = IXP4XX_GPIO_STYLE_FALLING_EDGE;
+		g->irq_edge |= BIT(d->hwirq);
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+		irq_set_handler_locked(d, handle_level_irq);
+		int_style = IXP4XX_GPIO_STYLE_ACTIVE_HIGH;
+		g->irq_edge &= ~BIT(d->hwirq);
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		irq_set_handler_locked(d, handle_level_irq);
+		int_style = IXP4XX_GPIO_STYLE_ACTIVE_LOW;
+		g->irq_edge &= ~BIT(d->hwirq);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (line >= 8) {
+		/* pins 8-15 */
+		line -= 8;
+		int_reg = IXP4XX_REG_GPIT2;
+	} else {
+		/* pins 0-7 */
+		int_reg = IXP4XX_REG_GPIT1;
+	}
+
+	spin_lock_irqsave(&g->gc.bgpio_lock, flags);
+
+	/* Clear the style for the appropriate pin */
+	val = __raw_readl(g->base + int_reg);
+	val &= ~(IXP4XX_GPIO_STYLE_MASK << (line * IXP4XX_GPIO_STYLE_SIZE));
+	__raw_writel(val, g->base + int_reg);
+
+	__raw_writel(BIT(line), g->base + IXP4XX_REG_GPIS);
+
+	/* Set the new style */
+	val = __raw_readl(g->base + int_reg);
+	val |= (int_style << (line * IXP4XX_GPIO_STYLE_SIZE));
+	__raw_writel(val, g->base + int_reg);
+
+	/* Force-configure this line as an input */
+	val = __raw_readl(g->base + IXP4XX_REG_GPOE);
+	val |= BIT(d->hwirq);
+	__raw_writel(val, g->base + IXP4XX_REG_GPOE);
+
+	spin_unlock_irqrestore(&g->gc.bgpio_lock, flags);
+
+	/* This parent only accept level high (asserted) */
+	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
+}
+
+static struct irq_chip ixp4xx_gpio_irqchip = {
+	.name = "IXP4GPIO",
+	.irq_ack = ixp4xx_gpio_irq_ack,
+	.irq_mask = irq_chip_mask_parent,
+	.irq_unmask = ixp4xx_gpio_irq_unmask,
+	.irq_set_type = ixp4xx_gpio_irq_set_type,
+};
+
+static int ixp4xx_gpio_to_irq(struct gpio_chip *gc, unsigned int offset)
+{
+	struct ixp4xx_gpio *g = gpiochip_get_data(gc);
+	struct irq_fwspec fwspec;
+
+	fwspec.fwnode = g->fwnode;
+	fwspec.param_count = 2;
+	fwspec.param[0] = offset;
+	fwspec.param[1] = IRQ_TYPE_NONE;
+
+	return irq_create_fwspec_mapping(&fwspec);
+}
+
+static int ixp4xx_gpio_irq_domain_translate(struct irq_domain *domain,
+					    struct irq_fwspec *fwspec,
+					    unsigned long *hwirq,
+					    unsigned int *type)
+{
+
+	/* We support standard DT translation */
+	if (is_of_node(fwspec->fwnode) && fwspec->param_count == 2) {
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+		return 0;
+	}
+
+	/* This goes away when we transition to DT */
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+		if (fwspec->param_count != 2)
+			return -EINVAL;
+		*hwirq = fwspec->param[0];
+		*type = fwspec->param[1];
+		WARN_ON(*type == IRQ_TYPE_NONE);
+		return 0;
+	}
+	return -EINVAL;
+}
+
+static int ixp4xx_gpio_irq_domain_alloc(struct irq_domain *d,
+					unsigned int irq, unsigned int nr_irqs,
+					void *data)
+{
+	struct ixp4xx_gpio *g = d->host_data;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = data;
+	int ret;
+	int i;
+
+	ret = ixp4xx_gpio_irq_domain_translate(d, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	dev_dbg(g->dev, "allocate IRQ %d..%d, hwirq %lu..%lu\n",
+		irq, irq + nr_irqs - 1,
+		hwirq, hwirq + nr_irqs - 1);
+
+	for (i = 0; i < nr_irqs; i++) {
+		struct irq_fwspec parent_fwspec;
+		const struct ixp4xx_gpio_map *map;
+		int j;
+
+		/* Not all lines support IRQs */
+		for (j = 0; j < ARRAY_SIZE(ixp4xx_gpiomap); j++) {
+			map = &ixp4xx_gpiomap[j];
+			if (map->gpio_offset == hwirq)
+				break;
+		}
+		if (j == ARRAY_SIZE(ixp4xx_gpiomap)) {
+			dev_err(g->dev, "can't look up hwirq %lu\n", hwirq);
+			return -EINVAL;
+		}
+		dev_dbg(g->dev, "found parent hwirq %u\n", map->parent_hwirq);
+
+		/*
+		 * We set handle_bad_irq because the .set_type() should
+		 * always be invoked and set the right type of handler.
+		 */
+		irq_domain_set_info(d,
+				    irq + i,
+				    hwirq + i,
+				    &ixp4xx_gpio_irqchip,
+				    g,
+				    handle_bad_irq,
+				    NULL, NULL);
+		irq_set_probe(irq + i);
+
+		/*
+		 * Create a IRQ fwspec to send up to the parent irqdomain:
+		 * specify the hwirq we address on the parent and tie it
+		 * all together up the chain.
+		 */
+		parent_fwspec.fwnode = d->parent->fwnode;
+		parent_fwspec.param_count = 2;
+		parent_fwspec.param[0] = map->parent_hwirq;
+		/* This parent only handles asserted level IRQs */
+		parent_fwspec.param[1] = IRQ_TYPE_LEVEL_HIGH;
+		dev_dbg(g->dev, "alloc_irqs_parent for %d parent hwirq %d\n",
+			irq + i, map->parent_hwirq);
+		ret = irq_domain_alloc_irqs_parent(d, irq + i, 1,
+						   &parent_fwspec);
+		if (ret)
+			dev_err(g->dev,
+				"failed to allocate parent hwirq %d for hwirq %lu\n",
+				map->parent_hwirq, hwirq);
+	}
+
+	return 0;
+}
+
+static const struct irq_domain_ops ixp4xx_gpio_irqdomain_ops = {
+	.translate = ixp4xx_gpio_irq_domain_translate,
+	.alloc = ixp4xx_gpio_irq_domain_alloc,
+	.free = irq_domain_free_irqs_common,
+};
+
+static int ixp4xx_gpio_probe(struct platform_device *pdev)
+{
+	unsigned long flags;
+	struct device *dev = &pdev->dev;
+	struct irq_domain *parent;
+	struct resource *res;
+	struct ixp4xx_gpio *g;
+	int ret;
+	int i;
+
+	g = devm_kzalloc(dev, sizeof(*g), GFP_KERNEL);
+	if (!g)
+		return -ENOMEM;
+	g->dev = dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	g->base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(g->base)) {
+		dev_err(dev, "ioremap error\n");
+		return PTR_ERR(g->base);
+	}
+
+	/*
+	 * Make sure GPIO 14 and 15 are NOT used as clocks but GPIO on
+	 * specific machines.
+	 */
+	if (machine_is_dsmg600() || machine_is_nas100d())
+		__raw_writel(0x0, g->base + IXP4XX_REG_GPCLK);
+
+	/*
+	 * This is a very special big-endian ARM issue: when the IXP4xx is
+	 * run in big endian mode, all registers in the machine are switched
+	 * around to the CPU-native endianness. As you see mostly in the
+	 * driver we use __raw_readl()/__raw_writel() to access the registers
+	 * in the appropriate order. With the GPIO library we need to specify
+	 * byte order explicitly, so this flag needs to be set when compiling
+	 * for big endian.
+	 */
+#if defined(CONFIG_CPU_BIG_ENDIAN)
+	flags = BGPIOF_BIG_ENDIAN_BYTE_ORDER;
+#else
+	flags = 0;
+#endif
+
+	/* Populate and register gpio chip */
+	ret = bgpio_init(&g->gc, dev, 4,
+			 g->base + IXP4XX_REG_GPIN,
+			 g->base + IXP4XX_REG_GPOUT,
+			 NULL,
+			 NULL,
+			 g->base + IXP4XX_REG_GPOE,
+			 flags);
+	if (ret) {
+		dev_err(dev, "unable to init generic GPIO\n");
+		return ret;
+	}
+	g->gc.to_irq = ixp4xx_gpio_to_irq;
+	g->gc.ngpio = 16;
+	g->gc.label = "IXP4XX_GPIO_CHIP";
+	/*
+	 * TODO: when we have migrated to device tree and all GPIOs
+	 * are fetched using phandles, set this to -1 to get rid of
+	 * the fixed gpiochip base.
+	 */
+	g->gc.base = 0;
+	g->gc.parent = &pdev->dev;
+	g->gc.owner = THIS_MODULE;
+
+	ret = devm_gpiochip_add_data(dev, &g->gc, g);
+	if (ret) {
+		dev_err(dev, "failed to add SoC gpiochip\n");
+		return ret;
+	}
+
+	/*
+	 * When we convert to device tree we will simply look up the
+	 * parent irqdomain using irq_find_host(parent) as parent comes
+	 * from IRQCHIP_DECLARE(), then use of_node_to_fwnode() to get
+	 * the fwnode. For now we need this boardfile style code.
+	 */
+	parent = ixp4xx_get_irq_domain();
+	g->fwnode = irq_domain_alloc_fwnode(g->base);
+	if (!g->fwnode) {
+		dev_err(dev, "no domain base\n");
+		return -ENODEV;
+	}
+	g->domain = irq_domain_create_hierarchy(parent,
+						IRQ_DOMAIN_FLAG_HIERARCHY,
+						ARRAY_SIZE(ixp4xx_gpiomap),
+						g->fwnode,
+						&ixp4xx_gpio_irqdomain_ops,
+						g);
+	if (!g->domain) {
+		irq_domain_free_fwnode(g->fwnode);
+		dev_err(dev, "no hierarchical irq domain\n");
+		return ret;
+	}
+
+	/*
+	 * After adding OF support, this is no longer needed: irqs
+	 * will be allocated for the respective fwnodes.
+	 */
+	for (i = 0; i < ARRAY_SIZE(ixp4xx_gpiomap); i++) {
+		const struct ixp4xx_gpio_map *map = &ixp4xx_gpiomap[i];
+		struct irq_fwspec fwspec;
+
+		fwspec.fwnode = g->fwnode;
+		/* This is the hwirq for the GPIO line side of things */
+		fwspec.param[0] = map->gpio_offset;
+		fwspec.param[1] = IRQ_TYPE_EDGE_RISING;
+		fwspec.param_count = 2;
+		ret = __irq_domain_alloc_irqs(g->domain,
+					      -1, /* just pick something */
+					      1,
+					      NUMA_NO_NODE,
+					      &fwspec,
+					      false,
+					      NULL);
+		if (ret < 0) {
+			irq_domain_free_fwnode(g->fwnode);
+			dev_err(dev,
+				"can not allocate irq for GPIO line %d parent hwirq %d in hierarchy domain: %d\n",
+				map->gpio_offset, map->parent_hwirq, ret);
+			return ret;
+		}
+	}
+
+	platform_set_drvdata(pdev, g);
+	dev_info(dev, "IXP4 GPIO @%p registered\n", g->base);
+
+	return 0;
+}
+
+static struct platform_driver ixp4xx_gpio_driver = {
+	.driver = {
+		.name		= "ixp4xx-gpio",
+	},
+	.probe = ixp4xx_gpio_probe,
+};
+builtin_platform_driver(ixp4xx_gpio_driver);
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
