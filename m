Return-Path: <SRS0=sKCI=QH=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A5FFC282D9
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1EDE4218AC
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 13:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GBrceO3o";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="xH1swiOa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EDE4218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Ujn6MRHHtDuLqmVEXy/BNfJ3Jae03zSvKBONp6+0bOM=; b=GBrceO3oQIUn2G
	yJCBunP3qrnARjQ/M+sCf5wftdN1vMhQlcRQKeaNvbNGcbfKPaAZk16Au6hAs8dtDkAf1plO5TIpu
	Jqws6NmewK5hWny+fucU1Y3bcyww4COvwde/2Mf20SOaxK9984XBPSBgRM1AuOXloouvKNJ98yAY1
	ZLx+y3zh49ctYJwnz8/0PaQDUGaQ0NXr3nFpFMHUy4sP5uHw1VIGpf5RDxb2AV2LnFSyK/B/r3rta
	rVyUNyTVoXlNUU33/50Hl8c/OqNB7oD2N2z80XbSgteOhvXhMGsB7oRpHYsr/hyYwZ4CUB9uyB34w
	zAGmP/S5UjPPVk50sf4w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gpCaF-0006Xg-F3; Thu, 31 Jan 2019 13:40:47 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gpCZE-0004Vy-F6
 for linux-arm-kernel@lists.infradead.org; Thu, 31 Jan 2019 13:39:52 +0000
Received: by mail-wr1-x443.google.com with SMTP id p7so3380270wru.0
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 31 Jan 2019 05:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5X77WcQ60mqtfJVB+WwYLABh83PR6pOA8m2PXMgwFcg=;
 b=xH1swiOa4RczcuMoR3Lxo733EPEknZ6C/zYldttIK3Abr6t8wjUroF/hrx4zQL7mWj
 5IfDh2jMdtUHGlCmIB3s9z2MCovHefOT+NshILcYymLv3qnhaCjdJ5PAxizUoj6ZYeq6
 KLRQQqC0i//AE+nba07I/JVZpdyQVfA0dnOgbrxWJXa5OMcUSjlDQabcZzErbI03c8SV
 YY0VEk2ReNILuf0zUvXLk/ooUFeRPefE/naFH+yg8yjJc6uwhPTlh+kso75ihEQF+mwS
 8WlG2fCufcy9iI3kdhpmw7rpWD25s6XgQleMyRnw7BkZAuhPV74OhoVfuBZvXfBhrZX6
 1+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5X77WcQ60mqtfJVB+WwYLABh83PR6pOA8m2PXMgwFcg=;
 b=oTld+aU3zEdk/rd9J0yEg5dowtcUdaQzpyTP/QeaT+EvVTL/aXZm7HXPsj13eo1n8J
 xpWFqSIQFHQD8FIe4NsR0y5SzmEfeUOvbWvQ9uqCFtD+CpMK6/xW+Khd57mA0dBOKhOE
 8Me8xSg207Ovuec0jgs9brxdAudsAjc6nDKzhvIzaW8ylN+XMpi8/2+5JIBMBsxThAdS
 cspc9sDno/4oYpNN1IsiqEOLp6PNeiokUn/tvEFvbTxBl6YgdIw7XVPMKmNkEnDmJt+u
 bwaYpKgsCYUhUcmSC9Jjf0llQXgU3EUy0ERHI07GOwgUOPoGWPonThEDbDF7UJ/xRlCB
 6qgQ==
X-Gm-Message-State: AJcUukcF8PL+yxBQ/YJKcF0FoZTaaPn8NZYG7XXHe+4HY5l+RVlZqYHe
 21yyDRjiq3h3Mxp3juOGu2AWuw==
X-Google-Smtp-Source: ALg8bN4lLGeIz/4xBx5SG7ISq6LF7eqnTZj9/OljxiiAqNRnLzoAy74tv1kNLZERE71s49xFPgLh1g==
X-Received: by 2002:adf:b102:: with SMTP id l2mr33375505wra.296.1548941983116; 
 Thu, 31 Jan 2019 05:39:43 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id h10sm5479768wmf.44.2019.01.31.05.39.41
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 31 Jan 2019 05:39:42 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>
Subject: [PATCH 02/35] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
Date: Thu, 31 Jan 2019 14:38:55 +0100
Message-Id: <20190131133928.17985-3-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190131133928.17985-1-brgl@bgdev.pl>
References: <20190131133928.17985-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190131_053944_625459_EB6AB772 
X-CRM114-Status: GOOD (  17.25  )
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

In order to support SPARSE_IRQ we first need to make davinci use the
generic irq handler for ARM. Translate the legacy assembly to C and
put the irq handlers into their respective drivers (aintc and cp-intc).

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/Kconfig                              |  1 +
 arch/arm/mach-davinci/cp_intc.c               | 13 +++++++
 .../mach-davinci/include/mach/entry-macro.S   | 39 -------------------
 arch/arm/mach-davinci/irq.c                   | 21 ++++++++++
 4 files changed, 35 insertions(+), 39 deletions(-)
 delete mode 100644 arch/arm/mach-davinci/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..f7770fdcad68 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -589,6 +589,7 @@ config ARCH_DAVINCI
 	select GENERIC_ALLOCATOR
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_IDE
 	select PM_GENERIC_DOMAINS if PM
diff --git a/arch/arm/mach-davinci/cp_intc.c b/arch/arm/mach-davinci/cp_intc.c
index 67805ca74ff8..b9aec3c48a6a 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -19,6 +19,7 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/exception.h>
 #include <mach/common.h>
 #include "cp_intc.h"
 
@@ -97,6 +98,16 @@ static struct irq_chip cp_intc_irq_chip = {
 
 static struct irq_domain *cp_intc_domain;
 
+static asmlinkage void __exception_irq_entry
+cp_intc_handle_irq(struct pt_regs *regs)
+{
+	int irqnr = cp_intc_read(CP_INTC_PRIO_IDX);
+
+	irqnr &= 0xff;
+
+	handle_domain_irq(cp_intc_domain, irqnr, regs);
+}
+
 static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
@@ -196,6 +207,8 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
 		return -EINVAL;
 	}
 
+	set_handle_irq(cp_intc_handle_irq);
+
 	/* Enable global interrupt */
 	cp_intc_write(1, CP_INTC_GLOBAL_ENABLE);
 
diff --git a/arch/arm/mach-davinci/include/mach/entry-macro.S b/arch/arm/mach-davinci/include/mach/entry-macro.S
deleted file mode 100644
index cf5f573eb5fd..000000000000
--- a/arch/arm/mach-davinci/include/mach/entry-macro.S
+++ /dev/null
@@ -1,39 +0,0 @@
-/*
- * Low-level IRQ helper macros for TI DaVinci-based platforms
- *
- * Author: Kevin Hilman, MontaVista Software, Inc. <source@mvista.com>
- *
- * 2007 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-#include <mach/irqs.h>
-
-		.macro  get_irqnr_preamble, base, tmp
-		ldr \base, =davinci_intc_base
-		ldr \base, [\base]
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-#if defined(CONFIG_AINTC) && defined(CONFIG_CP_INTC)
-		ldr \tmp, =davinci_intc_type
-		ldr \tmp, [\tmp]
-		cmp \tmp, #DAVINCI_INTC_TYPE_CP_INTC
-		beq 1001f
-#endif
-#if defined(CONFIG_AINTC)
-		ldr \tmp, [\base, #0x14]
-		movs \tmp, \tmp, lsr #2
-		sub \irqnr, \tmp, #1
-		b 1002f
-#endif
-#if defined(CONFIG_CP_INTC)
-1001:		ldr \irqnr, [\base, #0x80] /* get irq number */
-		mov \tmp, \irqnr, lsr #31
-		and \irqnr, \irqnr, #0xff  /* irq is in bits 0-9 */
-		and \tmp, \tmp, #0x1
-		cmp \tmp, #0x1
-#endif
-1002:
-		.endm
diff --git a/arch/arm/mach-davinci/irq.c b/arch/arm/mach-davinci/irq.c
index 952dc126c390..3bbbef78d9ac 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -28,11 +28,13 @@
 #include <mach/cputype.h>
 #include <mach/common.h>
 #include <asm/mach/irq.h>
+#include <asm/exception.h>
 
 #define FIQ_REG0_OFFSET		0x0000
 #define FIQ_REG1_OFFSET		0x0004
 #define IRQ_REG0_OFFSET		0x0008
 #define IRQ_REG1_OFFSET		0x000C
+#define IRQ_IRQENTRY_OFFSET	0x0014
 #define IRQ_ENT_REG0_OFFSET	0x0018
 #define IRQ_ENT_REG1_OFFSET	0x001C
 #define IRQ_INCTL_REG_OFFSET	0x0020
@@ -45,6 +47,11 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
 	__raw_writel(value, davinci_intc_base + offset);
 }
 
+static inline unsigned long davinci_irq_readl(int offset)
+{
+	return __raw_readl(davinci_intc_base + offset);
+}
+
 static __init void
 davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 {
@@ -69,6 +76,19 @@ davinci_alloc_gc(void __iomem *base, unsigned int irq_start, unsigned int num)
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
+static asmlinkage void __exception_irq_entry
+davinci_handle_irq(struct pt_regs *regs)
+{
+	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	irqnr >>= 2;
+	irqnr -= 1;
+
+	generic_handle_irq(irqnr);
+	set_irq_regs(old_regs);
+}
+
 /* ARM Interrupt Controller Initialization */
 void __init davinci_irq_init(void)
 {
@@ -114,4 +134,5 @@ void __init davinci_irq_init(void)
 		davinci_alloc_gc(davinci_intc_base + j, i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+	set_handle_irq(davinci_handle_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
