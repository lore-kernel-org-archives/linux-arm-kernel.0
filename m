Return-Path: <SRS0=niBm=QV=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80522C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:55 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA07218FF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 15:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SwY9Ou7z";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sdJWU8wK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="T32DKEna"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA07218FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zauewHMFxUoySf1sxzgNdqYFQ8XSFFaG662OypoduRw=; b=SwY9Ou7z9cEtdC
	INK9NwJDVBjn8PiGrZc/lfI7Nt9D93thUw1l/Ck0ozIUUo/rZE4ECaZjmpV02jox91Bn7Y8JMTwL5
	dw/8pKpp2qPJk6ysIcJlchtcYKIFEkjE5nPgOD0U0iQLdNMr0apgl2PyApQ5GlO5CVId6di/NqucT
	+eIgoWzvDcUMidCrWB1tfzX4ORRr55GC+q4fXyLtsZzeSopvn5xt09y8ygcqnH3OCm1Ls2vDBekkq
	SI25aSECj/LWlNyW4rfmx0YyFN8Lgz14RE/hwl3SYnPJwCIB8dM50CgK2qdwT7/xPDuyrbk1mOccD
	aZxSruNe7ouJxtygG5og==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1guIfy-0004Bx-T9; Thu, 14 Feb 2019 15:11:46 +0000
Received: from merlin.infradead.org ([2001:8b0:10b:1231::1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIf4-0002yt-BN
 for linux-arm-kernel@bombadil.infradead.org; Thu, 14 Feb 2019 15:10:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Es/cEXbYyznp8EfSwmv6V/WrOaOvER1k/aQsIXQBUy8=; b=sdJWU8wK9p/v4Wxoq9L1Z1QUaB
 MGUGeS8Hz8pxo9bud54Vn5rxIple9gG5Xuow7tzko0DOvaqZ3L6VKy8mqDJ+INPAO5rAXSF9NCPW0
 CkQuuEr64xBCtvF9TCAeu75tmYRCVck45Dwy0CsceC/rpTkJnsUKVbUlf95od4Z9PtEEI6hhdP/T/
 /GRv++eZ2jxNcl75caoiX2pDNrJzwtOIJiKALQGIVS/rvTSLwFg55dnGaAJ95gmB2EoPQwxI+1WO6
 Y9nXvH3lyMkHt7rOZHpRMzO+8Wl9yhdxetcQuHEYqGqO5JxMRxqALTDu6Ck9bhoMKXpP5G8O/Q3Tt
 LeTSiBqA==;
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1guIO7-00061t-C5
 for linux-arm-kernel@lists.infradead.org; Thu, 14 Feb 2019 14:53:20 +0000
Received: by mail-wr1-x443.google.com with SMTP id v16so6762122wrn.11
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 14 Feb 2019 06:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Es/cEXbYyznp8EfSwmv6V/WrOaOvER1k/aQsIXQBUy8=;
 b=T32DKEnacf/eUTfU5APkOxV1AtwhDWBnEVr0uiyv+VoA2iptvzz8AHVxorAo712rte
 SdrZbQZVSLIa15PesVepoSC0uFhrk5Z/vZgqkfSz/dWJO3ApFauRmLCeJnCSQvpt6Gwx
 JTbzIcTQqhcjjHzoPKwDc2hlRVtdGeO4R29VGpnoJ7FuaSoYnhk6HNyAJkfNMsRjlKDJ
 ZLhqNi/9HM3FLPQJH94uQ4CbzPzHAvQIV3vxN3+0PEtNhYgEp5OPYsBCFdq681frK5Z8
 45jWqh0VVQjQ7JkAsRSmCiktRuoBdLrEzJ8fOLcbjV2lrgrdyN8Y1HOXXHZyRaUYqj0H
 /KrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Es/cEXbYyznp8EfSwmv6V/WrOaOvER1k/aQsIXQBUy8=;
 b=rhzUshESd7LynH21k/QDwl9BaTvfxnL70jz9Vbu+/lzMJ2wJQezL7xlPO9m4rHI23M
 yXrBYbBDyJjY2xDs3VKJJooRVmHr5Hs7PsumcG/Pi2Z+PflmSOlE4b7DSy1Sw0BI2204
 NuxtDIpoJvLG+aQTxa9Z07hyyZvNuZRWjx7QoiznXMxW4eT1muMgwdf/a/zEmQdFLTc6
 M3pT4Q2NVok3b3AN/vO9xWGZHN7BLIhMoFzDY0f7qQFaECjduLbVjh7JpM7aLKR6rT07
 NyIPjcKsboXIDpiZ+T09GmQg3ht4FBBNICATApElvRE9Cugkj69ebV5RcJoOZCirq89b
 Gftg==
X-Gm-Message-State: AHQUAuZh0NtuJ9U4bLRgsxCaippMdTEGwPUD17bdfubRiELxV0qwBcMA
 rPSk6+v5L/8TzEPMSzp/bssqGA==
X-Google-Smtp-Source: AHgI3IbAe98IzDjQp+ZK1pveHWJQ6k8W78saNsJkSghPu1i5FcOvZ7sJVdqppct5LhvikO4hc9dzVw==
X-Received: by 2002:adf:8224:: with SMTP id 33mr3269179wrb.264.1550155997370; 
 Thu, 14 Feb 2019 06:53:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id y20sm4181005wra.51.2019.02.14.06.53.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 14 Feb 2019 06:53:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sekhar Nori <nsekhar@ti.com>,
 Kevin Hilman <khilman@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>, Marc Zyngier <marc.zyngier@arm.com>,
 David Lechner <david@lechnology.com>
Subject: [PATCH v4 29/37] ARM: davinci: cp-intc: use the new-style config
 structure
Date: Thu, 14 Feb 2019 15:52:23 +0100
Message-Id: <20190214145231.8750-30-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190214145231.8750-1-brgl@bgdev.pl>
References: <20190214145231.8750-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190214_095319_743365_7C4D93CA 
X-CRM114-Status: GOOD (  26.97  )
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

Modify the cp-intc driver to take all its configuration from the new
config structure. Stop referencing davinci_soc_info in any way.
Move the declaration for davinci_cp_intc_init() to
irq-davinci-cp-intc.h and make it take the new config structure as
parameter. Convert all users to the new version.

Also: since the two da8xx SoCs default all irq priorities to 7, just
drop the priority configuration at all and hardcode the channels to 7.

It will simplify the driver code and make our lives easier when it
comes to device-tree support.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/cp_intc.c             | 99 ++++++++++-----------
 arch/arm/mach-davinci/da830.c               |  2 +-
 arch/arm/mach-davinci/da850.c               |  2 +-
 arch/arm/mach-davinci/include/mach/common.h |  1 -
 include/linux/irqchip/irq-davinci-cp-intc.h |  2 +
 5 files changed, 50 insertions(+), 56 deletions(-)

diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index dcd43b067a6a..f56a4275083f 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/irq-davinci-cp-intc.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/of.h>
@@ -20,7 +21,6 @@
 #include <linux/of_irq.h>
 
 #include <asm/exception.h>
-#include <mach/common.h>
 
 #define DAVINCI_CP_INTC_CTRL			0x04
 #define DAVINCI_CP_INTC_HOST_CTRL		0x0c
@@ -158,22 +158,15 @@ static const struct irq_domain_ops davinci_cp_intc_irq_domain_ops = {
 	.xlate = irq_domain_xlate_onetwocell,
 };
 
-static int __init davinci_cp_intc_of_init(struct device_node *node,
-					  struct device_node *parent)
+static int __init
+davinci_cp_intc_do_init(const struct davinci_cp_intc_config *config,
+			struct device_node *node)
 {
-	u32 num_irq		= davinci_soc_info.intc_irq_num;
-	u8 *irq_prio		= davinci_soc_info.intc_irq_prios;
-	unsigned num_reg	= BITS_TO_LONGS(num_irq);
-	int i, irq_base;
-
-	if (node) {
-		davinci_cp_intc_base = of_iomap(node, 0);
-		if (of_property_read_u32(node, "ti,intc-size", &num_irq))
-			pr_warn("unable to get intc-size, default to %d\n",
-				num_irq);
-	} else {
-		davinci_cp_intc_base = ioremap(davinci_soc_info.intc_base, SZ_8K);
-	}
+	unsigned int num_regs = BITS_TO_LONGS(config->num_irqs);
+	int offset, irq_base;
+
+	davinci_cp_intc_base = ioremap(config->reg.start,
+				       resource_size(&config->reg));
 	if (WARN_ON(!davinci_cp_intc_base))
 		return -EINVAL;
 
@@ -183,51 +176,29 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_ENABLE(0));
 
 	/* Disable system interrupts */
-	for (i = 0; i < num_reg; i++)
-		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_ENABLE_CLR(i));
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(~0,
+			DAVINCI_CP_INTC_SYS_ENABLE_CLR(offset));
 
 	/* Set to normal mode, no nesting, no priority hold */
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_CTRL);
 	davinci_cp_intc_write(0, DAVINCI_CP_INTC_HOST_CTRL);
 
 	/* Clear system interrupt status */
-	for (i = 0; i < num_reg; i++)
-		davinci_cp_intc_write(~0, DAVINCI_CP_INTC_SYS_STAT_CLR(i));
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(~0,
+			DAVINCI_CP_INTC_SYS_STAT_CLR(offset));
 
 	/* Enable nIRQ (what about nFIQ?) */
 	davinci_cp_intc_write(1, DAVINCI_CP_INTC_HOST_ENABLE_IDX_SET);
 
-	/*
-	 * Priority is determined by host channel: lower channel number has
-	 * higher priority i.e. channel 0 has highest priority and channel 31
-	 * had the lowest priority.
-	 */
-	num_reg = (num_irq + 3) >> 2;	/* 4 channels per register */
-	if (irq_prio) {
-		unsigned j, k;
-		u32 val;
-
-		for (k = i = 0; i < num_reg; i++) {
-			for (val = j = 0; j < 4; j++, k++) {
-				val >>= 8;
-				if (k < num_irq)
-					val |= irq_prio[k] << 24;
-			}
-
-			davinci_cp_intc_write(val, DAVINCI_CP_INTC_CHAN_MAP(i));
-		}
-	} else	{
-		/*
-		 * Default everything to channel 15 if priority not specified.
-		 * Note that channel 0-1 are mapped to nFIQ and channels 2-31
-		 * are mapped to nIRQ.
-		 */
-		for (i = 0; i < num_reg; i++)
-			davinci_cp_intc_write(0x0f0f0f0f,
-					      DAVINCI_CP_INTC_CHAN_MAP(i));
-	}
+	/* Default all priorities to channel 7. */
+	num_regs = (config->num_irqs + 3) >> 2;	/* 4 channels per register */
+	for (offset = 0; offset < num_regs; offset++)
+		davinci_cp_intc_write(0x07070707,
+			DAVINCI_CP_INTC_CHAN_MAP(offset));
 
-	irq_base = irq_alloc_descs(-1, 0, num_irq, 0);
+	irq_base = irq_alloc_descs(-1, 0, config->num_irqs, 0);
 	if (irq_base < 0) {
 		pr_warn("Couldn't allocate IRQ numbers\n");
 		irq_base = 0;
@@ -235,7 +206,7 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 
 	/* create a legacy host */
 	davinci_cp_intc_irq_domain = irq_domain_add_legacy(
-					node, num_irq, irq_base, 0,
+					node, config->num_irqs, irq_base, 0,
 					&davinci_cp_intc_irq_domain_ops, NULL);
 
 	if (!davinci_cp_intc_irq_domain) {
@@ -251,9 +222,31 @@ static int __init davinci_cp_intc_of_init(struct device_node *node,
 	return 0;
 }
 
-void __init davinci_cp_intc_init(void)
+int __init davinci_cp_intc_init(const struct davinci_cp_intc_config *config)
 {
-	davinci_cp_intc_of_init(NULL, NULL);
+	return davinci_cp_intc_do_init(config, NULL);
 }
 
+static int __init davinci_cp_intc_of_init(struct device_node *node,
+					  struct device_node *parent)
+{
+	struct davinci_cp_intc_config config = { };
+	int ret;
+
+	ret = of_address_to_resource(node, 0, &config.reg);
+	if (ret) {
+		pr_err("%s: unable to get the register range from device-tree\n",
+		       __func__);
+		return ret;
+	}
+
+	ret = of_property_read_u32(node, "ti,intc-size", &config.num_irqs);
+	if (ret) {
+		pr_err("%s: unable to read the 'ti,intc-size' property\n",
+		       __func__);
+		return ret;
+	}
+
+	return davinci_cp_intc_do_init(&config, node);
+}
 IRQCHIP_DECLARE(cp_intc, "ti,cp-intc", davinci_cp_intc_of_init);
diff --git a/arch/arm/mach-davinci/da830.c b/arch/arm/mach-davinci/da830.c
index 0eb48ed2d423..7ce0b5f1200d 100644
--- a/arch/arm/mach-davinci/da830.c
+++ b/arch/arm/mach-davinci/da830.c
@@ -833,7 +833,7 @@ static const struct davinci_cp_intc_config da830_cp_intc_config = {
 
 void __init da830_init_irq(void)
 {
-	davinci_cp_intc_init();
+	davinci_cp_intc_init(&da830_cp_intc_config);
 }
 
 void __init da830_init_time(void)
diff --git a/arch/arm/mach-davinci/da850.c b/arch/arm/mach-davinci/da850.c
index fe274ab63fc8..62a00fa94696 100644
--- a/arch/arm/mach-davinci/da850.c
+++ b/arch/arm/mach-davinci/da850.c
@@ -771,7 +771,7 @@ static const struct davinci_cp_intc_config da850_cp_intc_config = {
 
 void __init da850_init_irq(void)
 {
-	davinci_cp_intc_init();
+	davinci_cp_intc_init(&da850_cp_intc_config);
 }
 
 void __init da850_init_time(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 7ad79171b4b5..14e0e1c40611 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -22,7 +22,6 @@
 #define DAVINCI_INTC_START		NR_IRQS
 #define DAVINCI_INTC_IRQ(_irqnum)	(DAVINCI_INTC_START + (_irqnum))
 
-void davinci_cp_intc_init(void);
 void davinci_timer_init(struct clk *clk);
 
 struct davinci_timer_instance {
diff --git a/include/linux/irqchip/irq-davinci-cp-intc.h b/include/linux/irqchip/irq-davinci-cp-intc.h
index 2270a6167b98..8d71ed5b5a61 100644
--- a/include/linux/irqchip/irq-davinci-cp-intc.h
+++ b/include/linux/irqchip/irq-davinci-cp-intc.h
@@ -20,4 +20,6 @@ struct davinci_cp_intc_config {
 	unsigned int num_irqs;
 };
 
+int davinci_cp_intc_init(const struct davinci_cp_intc_config *config);
+
 #endif /* _LINUX_IRQ_DAVINCI_CP_INTC_ */
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
