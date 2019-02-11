Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCE40C282D7
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:49 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 864BB2075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oKxQV/Ax";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="EwVwtNT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 864BB2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=JTE8HX3K/+P9lDiE//boczYHs1/bPgmvlgFg3wQsNhI=; b=oKxQV/AxIogxuM
	ohbPtcF9OeV1zj4DfIVXEFFo5e2SBqOQiEAN/L2QnDAfumLJlWgC41bA3vE587/YmStf7JRdJc+I+
	2rkzI+Ux4A5DmZspBgvnwJh1mV+gskoNItt+ACb+Yrpj095DZHaUOZki4nnpxrPl3w4XeaiAoyrbA
	+KM/dsPAGsk3MnC0I9PxcSgmxuvoso7LBav/wzied9UhmBjPqrOa+ypQNvm07jp7NVwNh4+1f77eg
	Gq6zGBRxdqY6Ph1poeAv0kyAbngPzr/Sqz5lua265jL6teEcumVw4Tkr45aKQkoo1leElQ1xOuAIO
	5BjZtGSHMnebTdmfqnFg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAhV-0001I0-Hb; Mon, 11 Feb 2019 12:28:41 +0000
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfN-0007No-9X
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:40 +0000
Received: by mail-wr1-x441.google.com with SMTP id q15so4440522wro.12
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U/3nH0/IeUUXEbCh3LPmvlfc7NebsJe289jI/Ap/F+Y=;
 b=EwVwtNT82LKA9JswNNF2S8feY2p6H8jXNWJZcT2WCWs8VQq4QBae/a0GJioiTK7AdS
 6+bu3yQ61jw9/cfJleWZbGgCRO7lHmgbGAHa94IbhshpVRl9uRd9o1C82RFkTQg5HGq3
 9cu10jvkmrdowkm97xHQJ0NpHZx73R5P3f5bIyzS1K+lK2v/w4dajGa6Ot17+mZ2mTXE
 hC0OCXWHfT6vliRof97a0FqOQAR5Fciz8Oz6ik6iFQVETX2IH++I/rv5b46lAEadVrYI
 Uz5kfvp0ZCAg/SSVynkbr1iw9fXVn4V2R0bG3l/6kQTieUCw8PxXg4AxVjsBcAxVzUMH
 8TaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U/3nH0/IeUUXEbCh3LPmvlfc7NebsJe289jI/Ap/F+Y=;
 b=bD3vAP6pxWSxmU3a543ARGijCHCk+B+IECRNK+KHWMnLpOiZfQQ9/xxWxKom0z6TZE
 iVQvuVAUCWxOhVVONqn1fXziEHJxsnEIOSPKc5a5MsEpVPSF1TFJLO8v0PrQzbE8AsZw
 ib8LXOQ+IXxdzY3PZFCXnWpfNkheSTioEpswcFAw2dNawlMtKc+OIrQyl46nvwkmvQW7
 Pvc7AywtXyIBES0WsicZQXH9C54vElL683uFnkM88gOWtqbB0pPpp+z6lQK42DzhJPrJ
 i7f3E1eUbWCUS7mVXaa0hJuLlRtj7xVXRMpANWvZLb3xK/7NvwdUoRDq3YiL7DYsJXjZ
 077g==
X-Gm-Message-State: AHQUAuaqnRZCIMmO6nHZ9IXHI4rK6ioakLxJJFbT2k/GKd4fgpEMII+g
 +lRCCjWNOSrJB8oEWTP61GtlMg==
X-Google-Smtp-Source: AHgI3IZXSgZQVRkqPOybPkIaay8CFBuaoXluxLpO3qFCCKlDdJyVFrLSM0XIemphc8o4A+tOdvxReg==
X-Received: by 2002:adf:8447:: with SMTP id 65mr2422083wrf.328.1549887987334; 
 Mon, 11 Feb 2019 04:26:27 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:26 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 11/33] ARM: davinci: aintc: use a common prefix for
 symbols in the driver
Date: Mon, 11 Feb 2019 13:25:44 +0100
Message-Id: <20190211122606.8662-12-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042629_867914_7B3DA657 
X-CRM114-Status: GOOD (  16.55  )
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
 arch/arm/mach-davinci/dm355.c               |   2 +-
 arch/arm/mach-davinci/dm365.c               |   2 +-
 arch/arm/mach-davinci/dm644x.c              |   2 +-
 arch/arm/mach-davinci/dm646x.c              |   2 +-
 arch/arm/mach-davinci/include/mach/common.h |   2 +-
 arch/arm/mach-davinci/irq.c                 | 103 ++++++++++----------
 6 files changed, 58 insertions(+), 55 deletions(-)

diff --git a/arch/arm/mach-davinci/dm355.c b/arch/arm/mach-davinci/dm355.c
index 6c65699cb074..e2b680e9944b 100644
--- a/arch/arm/mach-davinci/dm355.c
+++ b/arch/arm/mach-davinci/dm355.c
@@ -794,7 +794,7 @@ int __init dm355_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm355_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm355_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index e1c223c6031f..76507dcbcb3a 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -1053,7 +1053,7 @@ int __init dm365_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm365_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm365_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm644x.c b/arch/arm/mach-davinci/dm644x.c
index 2b18c134ee15..27c73bc54069 100644
--- a/arch/arm/mach-davinci/dm644x.c
+++ b/arch/arm/mach-davinci/dm644x.c
@@ -730,7 +730,7 @@ int __init dm644x_init_video(struct vpfe_config *vpfe_cfg,
 
 void __init dm644x_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 void __init dm644x_init_devices(void)
diff --git a/arch/arm/mach-davinci/dm646x.c b/arch/arm/mach-davinci/dm646x.c
index 75a9f80317ca..98fc5e3815b9 100644
--- a/arch/arm/mach-davinci/dm646x.c
+++ b/arch/arm/mach-davinci/dm646x.c
@@ -691,7 +691,7 @@ void __init dm646x_register_clocks(void)
 
 void __init dm646x_init_irq(void)
 {
-	davinci_irq_init();
+	davinci_aintc_init();
 }
 
 static int __init dm646x_init_devices(void)
diff --git a/arch/arm/mach-davinci/include/mach/common.h b/arch/arm/mach-davinci/include/mach/common.h
index 1ceed0345988..8c9c011f96f6 100644
--- a/arch/arm/mach-davinci/include/mach/common.h
+++ b/arch/arm/mach-davinci/include/mach/common.h
@@ -24,7 +24,7 @@
 
 void davinci_timer_init(struct clk *clk);
 
-extern void davinci_irq_init(void);
+extern void davinci_aintc_init(void);
 
 struct davinci_timer_instance {
 	u32		base;
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 1301adc569e2..145fda7e5a35 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -19,39 +19,39 @@
 
 #include "irqs.h"
 
-#define FIQ_REG0_OFFSET		0x0000
-#define FIQ_REG1_OFFSET		0x0004
-#define IRQ_REG0_OFFSET		0x0008
-#define IRQ_REG1_OFFSET		0x000C
-#define IRQ_IRQENTRY_OFFSET	0x0014
-#define IRQ_ENT_REG0_OFFSET	0x0018
-#define IRQ_ENT_REG1_OFFSET	0x001C
-#define IRQ_INCTL_REG_OFFSET	0x0020
-#define IRQ_EABASE_REG_OFFSET	0x0024
-#define IRQ_INTPRI0_REG_OFFSET	0x0030
-#define IRQ_INTPRI7_REG_OFFSET	0x004C
-
-static void __iomem *davinci_intc_base;
-static struct irq_domain *davinci_irq_domain;
-
-static inline void davinci_irq_writel(unsigned long value, int offset)
+#define DAVINCI_AINTC_FIQ_REG0		0x0000
+#define DAVINCI_AINTC_FIQ_REG1		0x0004
+#define DAVINCI_AINTC_IRQ_REG0		0x0008
+#define DAVINCI_AINTC_IRQ_REG1		0x000C
+#define DAVINCI_AINTC_IRQ_IRQENTRY	0x0014
+#define DAVINCI_AINTC_IRQ_ENT_REG0	0x0018
+#define DAVINCI_AINTC_IRQ_ENT_REG1	0x001C
+#define DAVINCI_AINTC_IRQ_INCTL_REG	0x0020
+#define DAVINCI_AINTC_IRQ_EABASE_REG	0x0024
+#define DAVINCI_AINTC_IRQ_INTPRI0_REG	0x0030
+#define DAVINCI_AINTC_IRQ_INTPRI7_REG	0x004C
+
+static void __iomem *davinci_aintc_base;
+static struct irq_domain *davinci_aintc_irq_domain;
+
+static inline void davinci_aintc_writel(unsigned long value, int offset)
 {
-	__raw_writel(value, davinci_intc_base + offset);
+	__raw_writel(value, davinci_aintc_base + offset);
 }
 
-static inline unsigned long davinci_irq_readl(int offset)
+static inline unsigned long davinci_aintc_readl(int offset)
 {
-	return __raw_readl(davinci_intc_base + offset);
+	return __raw_readl(davinci_aintc_base + offset);
 }
 
 static __init void
-davinci_irq_setup_gc(void __iomem *base,
-		     unsigned int irq_start, unsigned int num)
+davinci_aintc_setup_gc(void __iomem *base,
+		       unsigned int irq_start, unsigned int num)
 {
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 
-	gc = irq_get_domain_generic_chip(davinci_irq_domain, irq_start);
+	gc = irq_get_domain_generic_chip(davinci_aintc_irq_domain, irq_start);
 	gc->reg_base = base;
 	gc->irq_base = irq_start;
 
@@ -60,16 +60,16 @@ davinci_irq_setup_gc(void __iomem *base,
 	ct->chip.irq_mask = irq_gc_mask_clr_bit;
 	ct->chip.irq_unmask = irq_gc_mask_set_bit;
 
-	ct->regs.ack = IRQ_REG0_OFFSET;
-	ct->regs.mask = IRQ_ENT_REG0_OFFSET;
+	ct->regs.ack = DAVINCI_AINTC_IRQ_REG0;
+	ct->regs.mask = DAVINCI_AINTC_IRQ_ENT_REG0;
 	irq_setup_generic_chip(gc, IRQ_MSK(num), IRQ_GC_INIT_MASK_CACHE,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
 static asmlinkage void __exception_irq_entry
-davinci_handle_irq(struct pt_regs *regs)
+davinci_aintc_handle_irq(struct pt_regs *regs)
 {
-	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
+	int irqnr = davinci_aintc_readl(DAVINCI_AINTC_IRQ_IRQENTRY);
 
 	/*
 	 * Use the formula for entry vector index generation from section
@@ -78,70 +78,73 @@ davinci_handle_irq(struct pt_regs *regs)
 	irqnr >>= 2;
 	irqnr -= 1;
 
-	handle_domain_irq(davinci_irq_domain, irqnr, regs);
+	handle_domain_irq(davinci_aintc_irq_domain, irqnr, regs);
 }
 
 /* ARM Interrupt Controller Initialization */
-void __init davinci_irq_init(void)
+void __init davinci_aintc_init(void)
 {
 	unsigned i, j;
 	const u8 *davinci_def_priorities = davinci_soc_info.intc_irq_prios;
 	int rv, irq_base;
 
-	davinci_intc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
-	if (WARN_ON(!davinci_intc_base))
+	davinci_aintc_base = ioremap(davinci_soc_info.intc_base, SZ_4K);
+	if (WARN_ON(!davinci_aintc_base))
 		return;
 
 	/* Clear all interrupt requests */
-	davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, FIQ_REG1_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG1_OFFSET);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG1);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
 
 	/* Disable all interrupts */
-	davinci_irq_writel(0x0, IRQ_ENT_REG0_OFFSET);
-	davinci_irq_writel(0x0, IRQ_ENT_REG1_OFFSET);
+	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_ENT_REG0);
+	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_ENT_REG1);
 
 	/* Interrupts disabled immediately, IRQ entry reflects all */
-	davinci_irq_writel(0x0, IRQ_INCTL_REG_OFFSET);
+	davinci_aintc_writel(0x0, DAVINCI_AINTC_IRQ_INCTL_REG);
 
 	/* we don't use the hardware vector table, just its entry addresses */
-	davinci_irq_writel(0, IRQ_EABASE_REG_OFFSET);
+	davinci_aintc_writel(0, DAVINCI_AINTC_IRQ_EABASE_REG);
 
 	/* Clear all interrupt requests */
-	davinci_irq_writel(~0x0, FIQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, FIQ_REG1_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG0_OFFSET);
-	davinci_irq_writel(~0x0, IRQ_REG1_OFFSET);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_FIQ_REG1);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG0);
+	davinci_aintc_writel(~0x0, DAVINCI_AINTC_IRQ_REG1);
 
-	for (i = IRQ_INTPRI0_REG_OFFSET; i <= IRQ_INTPRI7_REG_OFFSET; i += 4) {
+	for (i = DAVINCI_AINTC_IRQ_INTPRI0_REG;
+	     i <= DAVINCI_AINTC_IRQ_INTPRI7_REG; i += 4) {
 		u32		pri;
 
 		for (j = 0, pri = 0; j < 32; j += 4, davinci_def_priorities++)
 			pri |= (*davinci_def_priorities & 0x07) << j;
-		davinci_irq_writel(pri, i);
+		davinci_aintc_writel(pri, i);
 	}
 
 	irq_base = irq_alloc_descs(-1, 0, davinci_soc_info.intc_irq_num, 0);
 	if (WARN_ON(irq_base < 0))
 		return;
 
-	davinci_irq_domain = irq_domain_add_legacy(NULL,
+	davinci_aintc_irq_domain = irq_domain_add_legacy(NULL,
 					davinci_soc_info.intc_irq_num,
 					irq_base, 0, &irq_domain_simple_ops,
 					NULL);
-	if (WARN_ON(!davinci_irq_domain))
+	if (WARN_ON(!davinci_aintc_irq_domain))
 		return;
 
-	rv = irq_alloc_domain_generic_chips(davinci_irq_domain, 32, 1,
+	rv = irq_alloc_domain_generic_chips(davinci_aintc_irq_domain, 32, 1,
 					    "AINTC", handle_edge_irq,
 					    IRQ_NOREQUEST | IRQ_NOPROBE, 0, 0);
 	if (WARN_ON(rv))
 		return;
 
-	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num; i += 32, j += 0x04)
-		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
+	for (i = 0, j = 0; i < davinci_soc_info.intc_irq_num;
+	     i += 32, j += 0x04)
+		davinci_aintc_setup_gc(davinci_aintc_base + j,
+				       irq_base + i, 32);
 
 	irq_set_handler(DAVINCI_INTC_IRQ(IRQ_TINT1_TINT34), handle_level_irq);
-	set_handle_irq(davinci_handle_irq);
+	set_handle_irq(davinci_aintc_handle_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
