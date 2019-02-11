Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56C0C169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:30:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89751214DA
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="UhUkkQI2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="JGMyOmI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89751214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Zu2OhH58LFDa1kEAIvySvzen4nl9+XYFEul5uSW6DgI=; b=UhUkkQI2NW749v
	6f4u+Ca8Hz47ohuEioT0PDuvdtUaL5KZe9I0CWWF/dT7HiqJrsLs9dgQCE/BygvnMm8BZXyFCVNiQ
	aO0CXMt5tIlGDiGCT2InytpkNAx5OSYLjfPosbzF7TC1YuzzdA7fPvAiYNKhXbki3QyVanyCL3wHn
	IABnWnW1+X/Sl7Z8Dbs1dxD5AWrm39ID0GDv+lm0xntvOC+VZiKh6ZR/VMkV6oNWXE4KrXxcnqf7C
	/Vg1RBZak7DZpAHl7gycsoypUeklJbarKuf5uDsQTcWIgdczawjHrXmgW65UqHjrVDXBO5lJQO33B
	H7lv26+J8XI/+Y1CLorg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAjF-0003sf-C4; Mon, 11 Feb 2019 12:30:29 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfc-0007em-3W
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:27:22 +0000
Received: by mail-wr1-x443.google.com with SMTP id l9so4429577wrt.13
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZA0+dCtnpeJag/6AySdJ0Fbsz9YfvSi5EoVYD/za/84=;
 b=JGMyOmI+/InwOSk5q5nEBaKupwyhDJJ4jJRoHKIp07/L+FbNAha/YdkUgjAMdkcklM
 RQ3IPu9XCMktfmCM9M/xbEN/oBLcbEAFTTtFBx4psnptxEZpBvFbA6BemodUqy590nVF
 Vn+OZKSu62OqX4QOjPBadBxen0L6OwOpQQlXEv3CT07IJ5l5nSAYem4WoEKGb+7YqcA1
 dM/BFlmuwd8dVEqJDC72FRj6pCXXQeR4PrVURJYuZAH8Ov7mj0ip85TeunhyTiowHGYl
 mVlGnl3VIN9IbLD8G0omzBp67mJQqKyCnt0D4f5RLhz/PRVQoSQwk81+WDi+RlmFDQFe
 w8pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZA0+dCtnpeJag/6AySdJ0Fbsz9YfvSi5EoVYD/za/84=;
 b=tsFxHEfwrBpExtZhGvbBLQvx63bN1QLE+oesBTEqdHqv+i36GYsDhbw+GatcfxpH/7
 fZyh4Q7eiOHVgzyoW3F1ylKfhC2+rdg1R+n0GYaWWZx9LzNnK9a7fJ+HEcXfPeBtLCo6
 0tisBfG6KSqo7FY3umfvTgHraW4ZSpDDJxIkaFUmkRWsGNmYeoOtLNlTCcokh5OZdbNu
 qLpXLXxRDcZKAh5qENyO7zYVl+AooMrW9QPZTxL5WL7qZEkTcRNKzwmnhI7fRqZbyTNB
 GmY1K4EWDZIzB2lT41VunoV+JgRaZbzBNTRGe469UbPDeZVFtL8gX/hqNVTDG0vi0vZM
 cX5w==
X-Gm-Message-State: AHQUAuZm5C5NahnLbVLhYeFdi4GKD/EPoqZiAYBIuKhJjY4ZkWafs0bV
 HoKeHRmrWKFRydohGCxJz6fmWw==
X-Google-Smtp-Source: AHgI3IaePCQ5RsiECMeeg+tLahbnNB4racX02/cgO67p/uHHccXAgqPn4iGVTQSE1z6E89rRckbTpg==
X-Received: by 2002:adf:dfca:: with SMTP id q10mr2316754wrn.45.1549888002645; 
 Mon, 11 Feb 2019 04:26:42 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 24/33] ARM: davinci: cp-intc: use a common prefix
 for all symbols
Date: Mon, 11 Feb 2019 13:25:57 +0100
Message-Id: <20190211122606.8662-25-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042644_807129_CAF461C6 
X-CRM114-Status: GOOD (  19.66  )
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
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

In preparation for moving the driver to drivers/irqchip do some
cleanup: use a common prefix for all symbols.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Reviewed-by: David Lechner <david@lechnology.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 144 ++++++++++----------
 arch/arm/mach-davinci/da830.c               |   2 +-
 arch/arm/mach-davinci/da850.c               |   2 +-
 arch/arm/mach-davinci/include/mach/common.h |   2 +-
 4 files changed, 77 insertions(+), 73 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 82110d332c82..bf77b6950273 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -22,63 +22,67 @@
 #include <asm/exception.h>
 #include <mach/common.h>
 
-#define CP_INTC_CTRL			0x04
-#define CP_INTC_HOST_CTRL		0x0C
-#define CP_INTC_GLOBAL_ENABLE		0x10
-#define CP_INTC_SYS_STAT_IDX_CLR	0x24
-#define CP_INTC_SYS_ENABLE_IDX_SET	0x28
-#define CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
-#define CP_INTC_HOST_ENABLE_IDX_SET	0x34
-#define CP_INTC_HOST_ENABLE_IDX_CLR	0x38
-#define CP_INTC_PRIO_IDX		0x80
-#define CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
-#define CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
-#define CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
-#define CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
-#define CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
-#define CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
-
+#define DAVINCI_CP_INTC_CTRL			0x04
+#define DAVINCI_CP_INTC_HOST_CTRL		0x0C
+#define DAVINCI_CP_INTC_GLOBAL_ENABLE		0x10
+#define DAVINCI_CP_INTC_SYS_STAT_IDX_CLR	0x24
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET	0x28
+#define DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR	0x2C
+#define DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET	0x34
+#define DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR	0x38
+#define DAVINCI_CP_INTC_PRIO_IDX		0x80
+#define DAVINCI_CP_INTC_SYS_STAT_CLR(n)		(0x0280 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_ENABLE_CLR(n)	(0x0380 + (n << 2))
+#define DAVINCI_CP_INTC_CHAN_MAP(n)		(0x0400 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_POLARITY(n)		(0x0D00 + (n << 2))
+#define DAVINCI_CP_INTC_SYS_TYPE(n)		(0x0D80 + (n << 2))
+#define DAVINCI_CP_INTC_HOST_ENABLE(n)		(0x1500 + (n << 2))
 #define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
 #define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
 
-static void __iomem *davinci_intc_base;
+static void __iomem *davinci_cp_intc_base;
+static struct irq_domain *davinci_cp_intc_irq_domain;
 
-static inline unsigned int cp_intc_read(unsigned offset)
+static inline unsigned int davinci_cp_intc_read(unsigned int offset)
 {
-	return __raw_readl(davinci_intc_base + offset);
+	return __raw_readl(davinci_cp_intc_base + offset);
 }
 
-static inline void cp_intc_write(unsigned long value, unsigned offset)
+static inline void davinci_cp_intc_write(unsigned long value,
+					 unsigned int offset)
 {
-	__raw_writel(value, davinci_intc_base + offset);
+	__raw_writel(value, davinci_cp_intc_base + offset);
 }
 
-static void cp_intc_ack_irq(struct irq_data *d)
+static void davinci_cp_intc_ack_irq(struct irq_data *d)
 {
-	cp_intc_write(d->hwirq, CP_INTC_SYS_STAT_IDX_CLR);
+	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_STAT_IDX_CLR);
 }
 
 /* Disable interrupt */
-static void cp_intc_mask_irq(struct irq_data *d)
+static void davinci_cp_intc_mask_irq(struct irq_data *d)
 {
 	/* XXX don't know why we need to disable nIRQ here... */
-	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_CLR);
-	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_CLR);
-	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_SET);
+	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_CLR);
+	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_CLR);
+	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 }
 
 /* Enable interrupt */
-static void cp_intc_unmask_irq(struct irq_data *d)
+static void davinci_cp_intc_unmask_irq(struct irq_data *d)
 {
-	cp_intc_write(d->hwirq, CP_INTC_SYS_ENABLE_IDX_SET);
+	davinci_cp_intc_write(d->hwirq, DAVINCI_CP_INTC_SYS_ENABLE_IDX_SET);
 }
 
-static int cp_intc_set_irq_type(struct irq_data *d, unsigned int flow_type)
+static int davinci_cp_intc_set_irq_type(struct irq_data *d,
+					unsigned int flow_type)
 {
 	unsigned reg		= BIT_WORD(d->hwirq);
 	unsigned mask		= BIT_MASK(d->hwirq);
-	unsigned polarity	= cp_intc_read(CP_INTC_SYS_POLARITY(reg));
-	unsigned type		= cp_intc_read(CP_INTC_SYS_TYPE(reg));
+	unsigned polarity	= davinci_cp_intc_read(
+					DAVINCI_CP_INTC_SYS_POLARITY(reg));
+	unsigned type		= davinci_cp_intc_read(
+					DAVINCI_CP_INTC_SYS_TYPE(reg));
 
 	switch (flow_type) {
 	case IRQ_TYPE_EDGE_RISING:
@@ -101,25 +105,23 @@ static int cp_intc_set_irq_type(struct irq_data *d, unsigned int flow_type)
 		return -EINVAL;
 	}
 
-	cp_intc_write(polarity, CP_INTC_SYS_POLARITY(reg));
-	cp_intc_write(type, CP_INTC_SYS_TYPE(reg));
+	davinci_cp_intc_write(polarity, DAVINCI_CP_INTC_SYS_POLARITY(reg));
+	davinci_cp_intc_write(type, DAVINCI_CP_INTC_SYS_TYPE(reg));
 
 	return 0;
 }
 
-static struct irq_chip cp_intc_irq_chip = {
+static struct irq_chip davinci_cp_intc_irq_chip = {
 	.name		= "cp_intc",
-	.irq_ack	= cp_intc_ack_irq,
-	.irq_mask	= cp_intc_mask_irq,
-	.irq_unmask	= cp_intc_unmask_irq,
-	.irq_set_type	= cp_intc_set_irq_type,
+	.irq_ack	= davinci_cp_intc_ack_irq,
+	.irq_mask	= davinci_cp_intc_mask_irq,
+	.irq_unmask	= davinci_cp_intc_unmask_irq,
+	.irq_set_type	= davinci_cp_intc_set_irq_type,
 	.flags		= IRQCHIP_SKIP_SET_WAKE,
 };
 
-static struct irq_domain *cp_intc_domain;
-
 static asmlinkage void __exception_irq_entry
-cp_intc_handle_irq(struct pt_regs *regs)
+davinci_cp_intc_handle_irq(struct pt_regs *regs)
 {
 	int gpir, irqnr, none;
 
@@ -128,7 +130,7 @@ cp_intc_handle_irq(struct pt_regs *regs)
 	 * indicates a spurious irq.
 	 */
 
-	gpir = cp_intc_read(CP_INTC_PRIO_IDX);
+	gpir = davinci_cp_intc_read(DAVINCI_CP_INTC_PRIO_IDX);
 	irqnr = gpir & DAVINCI_CP_INTC_PRI_INDX_MASK;
 	none = gpir & DAVINCI_CP_INTC_GPIR_NONE;
 
@@ -137,27 +139,27 @@ cp_intc_handle_irq(struct pt_regs *regs)
 		return;
 	}
 
-	handle_domain_irq(cp_intc_domain, irqnr, regs);
+	handle_domain_irq(davinci_cp_intc_irq_domain, irqnr, regs);
 }
 
-static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
+static int davinci_cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
 	pr_debug("cp_intc_host_map(%d, 0x%lx)\n", virq, hw);
 
-	irq_set_chip(virq, &cp_intc_irq_chip);
+	irq_set_chip(virq, &davinci_cp_intc_irq_chip);
 	irq_set_probe(virq);
 	irq_set_handler(virq, handle_edge_irq);
 	return 0;
 }
 
-static const struct irq_domain_ops cp_intc_host_ops = {
-	.map = cp_intc_host_map,
+static const struct irq_domain_ops davinci_cp_intc_irq_domain_ops = {
+	.map = davinci_cp_intc_host_map,
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static int __init cp_intc_of_init(struct device_node *node,
-				  struct device_node *parent)
+static int __init davinci_cp_intc_of_init(struct device_node *node,
+					  struct device_node *parent)
 {
 	u32 num_irq		= davinci_soc_info.intc_irq_num;
 	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
@@ -165,35 +167,35 @@ static int __init cp_intc_of_init(struct device_node *node,
 	int i, irq_base;
 
 	if (node) {
-		davinci_intc_base = of_iomap(node, 0);
+		davinci_cp_intc_base = of_iomap(node, 0);
 		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
 			pr_warn("unable to get intc-size, default to %d\n",
 				num_irq);
 	} else {
-		davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
+		davinci_cp_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
 	}
-	if (WARN_ON(!davinci_intc_base))
+	if (WARN_ON(!davinci_cp_intc_base))
 		return -EINVAL;
 
-	cp_intc_write(0, CP_INTC_GLOBAL_ENABLE);
+	davinci_cp_intc_write(0, DAVINCI_CP_INTC_GLOBAL_ENABLE);
 
 	/* Disable all host interrupts */
-	cp_intc_write(0, CP_INTC_HOST_ENABLE(0));
+	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_ENABLE(0));
 
 	/* Disable system interrupts */
 	for (i = 0; i < num_reg; i++)
-		cp_intc_write(~0, CP_INTC_SYS_ENABLE_CLR(i));
+		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_ENABLE_CLR(i));
 
 	/* Set to normal mode, no nesting, no priority hold */
-	cp_intc_write(0, CP_INTC_CTRL);
-	cp_intc_write(0, CP_INTC_HOST_CTRL);
+	davinci_cp_intc_write(0, DAVINCI_CP_INTC_CTRL);
+	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_CTRL);
 
 	/* Clear system interrupt status */
 	for (i = 0; i < num_reg; i++)
-		cp_intc_write(~0, CP_INTC_SYS_STAT_CLR(i));
+		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_STAT_CLR(i));
 
 	/* Enable nIRQ (what about nFIQ?) */
-	cp_intc_write(1, CP_INTC_HOST_ENABLE_IDX_SET);
+	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 
 	/*
 	 * Priority is determined by host channel: lower channel number has
@@ -212,7 +214,7 @@ static int __init cp_intc_of_init(struct device_node *node,
 					val |= irq_prio[k] << 24;
 			}
 
-			cp_intc_write(val, CP_INTC_CHAN_MAP(i));
+			davinci_cp_intc_write(val, DAVINCI_CP_INTC_CHAN_MAP(i));
 		}
 	} else	{
 		/*
@@ -221,7 +223,8 @@ static int __init cp_intc_of_init(struct device_node *node,
 		 * are mapped to nIRQ.
 		 */
 		for (i = 0; i < num_reg; i++)
-			cp_intc_write(0x0f0f0f0f, CP_INTC_CHAN_MAP(i));
+			davinci_cp_intc_write(0x0f0f0f0f,
+					      DAVINCI_CP_INTC_CHAN_MAP(i));
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
@@ -231,25 +234,26 @@ static int __init cp_intc_of_init(struct device_node *node,
 	}
 
 	/* create a legacy host */
-	cp_intc_domain = irq_domain_add_legacy(node, num_irq,
-					irq_base, 0, &cp_intc_host_ops, NULL);
+	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
+					node, num_irq, irq_base, 0,
+					&davinci_cp_intc_irq_domain_ops, NULL);
 
-	if (!cp_intc_domain) {
+	if (!davinci_cp_intc_irq_domain) {
 		pr_err("cp_intc: failed to allocate irq host!\n");
 		return -EINVAL;
 	}
 
-	set_handle_irq(cp_intc_handle_irq);
+	set_handle_irq(davinci_cp_intc_handle_irq);
 
 	/* Enable global interrupt */
-	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
+	davinci_cp_intc_write(1, DAVINCI_CP_INTC_GLOBAL_ENABLE);
 
 	return 0;
 }
 
-void __init cp_intc_init(void)
+void __init davinci_cp_intc_init(void)
 {
-	cp_intc_of_init(NULL, NULL);
+	davinci_cp_intc_of_init(NULL, NULL);
 }
 
-IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", cp_intc_of_init);
+IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 38af72be1a85..0eb48ed2d423 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -833,7 +833,7 @@ static const struct davinci_cp_intc_config da830_cp_intc_config = {
 
 void __init da830_init_irq(void)
 {
-	cp_intc_init();
+	davinci_cp_intc_init();
 }
 
 void __init da830_init_time(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index 9a3ce68c0de4..fe274ab63fc8 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -771,7 +771,7 @@ static const struct davinci_cp_intc_config da850_cp_intc_config = {
 
 void __init da850_init_irq(void)
 {
-	cp_intc_init();
+	davinci_cp_intc_init();
 }
 
 void __init da850_init_time(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 3f3f1169d47e..7ad79171b4b5 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -22,7 +22,7 @@
 #define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
-void cp_intc_init(void);
+void davinci_cp_intc_init(void);
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
