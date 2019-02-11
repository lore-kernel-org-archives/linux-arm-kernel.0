Return-Path: <SRS0=sCCJ=QS=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467AAC169C4
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FD92075B
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oxRZlsIx";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="oRU7Rpsp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FD92075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0Tfx6iAEOkMMLcDtgi0QSvzfaO7uWxnw+SYh+Qh6YA=; b=oxRZlsIx1PHBks
	QH/H9byMMSo0bzXJ/6V2zdjj/5eCWpnzviZlawmlfSflCxWDNrkbsrZv9TIpKzF6vwR+jW8rDBj7p
	ICLKsKKtqa00l2MB4hFEtxYkOBKCmPAO6LERLl8GTvI560KMFVzaxHqVuU96GHavOTP9CdWHFValk
	fnUPkxOBuwMPV3On34/odKpNuTiGDn4oPVeWtva8/4DiH1QY25ZxQdhxuRPb4mLYA7mjgzqwRJIa4
	L+RjdT6TSxpG5T+ciUcJBz3nmMDGg/NnNR1ZXkmGou9ykMLY2s+NvsSa7A/EEPZwhi3GmRKtL0XX+
	OawXYUmV3DTI7+3uBjtA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gtAgD-0008Ir-Ug; Mon, 11 Feb 2019 12:27:21 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gtAfD-0007Cp-5S
 for linux-arm-kernel@lists.infradead.org; Mon, 11 Feb 2019 12:26:28 +0000
Received: by mail-wm1-x343.google.com with SMTP id t200so17074985wmt.0
 for <linux-arm-kernel@lists.infradead.org>;
 Mon, 11 Feb 2019 04:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jf/g4gC9Mu/8OgPrpqeKW285bP2v87UHo4ZLhU3FVpU=;
 b=oRU7RpspFFIjbaNUPM5Lk27a0hbXhTZ0sNGpFdt4wg9VUBEqX01sG5/1jxbigHby9N
 qAQjijLJemoKLjpIsKCzKHoOcP+zYxN68IBzAswaRzTle7lGJcOyzSsO71evP0feY1rm
 d8NT0THdozh8Bay3W/FfQQdWDE9jNawG8A4QKfMEIickStYiMpEBuc6f3P2pjiwJXO1+
 vS9X6t3EzXJvcCohct8mkuweXc8UeS8ZVU5B0LCDuVes58sx3xNj2ALAqcZ4e8Ski+gq
 Q1vA5h4PVekVFpmyjlDh6zd5A8ZTWfMsJ8vODJxUCaE+XlX3kaihZZdt5Kn4repZBUbj
 EXQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jf/g4gC9Mu/8OgPrpqeKW285bP2v87UHo4ZLhU3FVpU=;
 b=RxQ6gIvdnpc80IN012+xyLDw8XEVS2xyO3Eo24p4sk8tb9uA5EUj5M1PNVZS/TszhL
 JZcPGTF3a6o8W+0pvpZrpPX5K494+4i9whuhQ/uncZ859AyBuSoSHV8n5NHKyG2NylaT
 kn5fUxiuGmQQBc57zTJT4AFjKpVdTAuyM/y6sMKIiZaHoR/T/tGYnh2c/AfmwIKyg2qF
 Y3BQQ8dQ1QUsMNQTXdzd7asVLXQJqkq8c0IO4F9J8Bkr5/ksNuIJ0GcuMROv08+N7xS6
 Poig52pdjCtWZH8K2Z6Hizx/mseZuz9DZIKs0niCh8GalFiV+Qeva/jUwF/sH+f8eOUa
 C/qQ==
X-Gm-Message-State: AHQUAuZKl5oFP6T2g7UncDLPJEMDgG+AMZCIrf+y9wO0hyjhLKDihSl3
 PT87mr0Qx/sM4gyKKwe7PKygEQ==
X-Google-Smtp-Source: AHgI3IY4Vs9Q5LnWsfRtjOBYAC6x5jGxJAc6fFqWSoUsUpZULNoamsvu/5T2/8w/D/t4baGTocIU8w==
X-Received: by 2002:a1c:ed0b:: with SMTP id l11mr8853811wmh.86.1549887977373; 
 Mon, 11 Feb 2019 04:26:17 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id l20sm19494321wrb.93.2019.02.11.04.26.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 11 Feb 2019 04:26:16 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Jason Cooper <jason@lakedaemon.net>,
 Marc Zyngier <marc.zyngier@arm.com>, David Lechner <david@lechnology.com>
Subject: [RESEND PATCH v2 03/33] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
Date: Mon, 11 Feb 2019 13:25:36 +0100
Message-Id: <20190211122606.8662-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211122606.8662-1-brgl@bgdev.pl>
References: <20190211122606.8662-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190211_042619_430143_6D4D1F18 
X-CRM114-Status: GOOD (  19.53  )
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
 arch/arm/mach-davinci/cp_intc.c               | 28 +++++++++++++
 .../mach-davinci/include/mach/entry-macro.S   | 39 -------------------
 arch/arm/mach-davinci/irq.c                   | 23 +++++++++++
 4 files changed, 52 insertions(+), 39 deletions(-)
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
index 67805ca74ff8..4a372add8cf9 100644
--- a/arch/arm/mach-davinci/cp_intc.c
+++ b/arch/arm/mach-davinci/cp_intc.c
@@ -19,9 +19,13 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#include <asm/exception.h>
 #include <mach/common.h>
 #include "cp_intc.h"
 
+#define DAVINCI_CP_INTC_PRI_INDX_MASK		GENMASK(9, 0)
+#define DAVINCI_CP_INTC_GPIR_NONE		BIT(31)
+
 static inline unsigned int cp_intc_read(unsigned offset)
 {
 	return __raw_readl(davinci_intc_base + offset);
@@ -97,6 +101,28 @@ static struct irq_chip cp_intc_irq_chip = {
 
 static struct irq_domain *cp_intc_domain;
 
+static asmlinkage void __exception_irq_entry
+cp_intc_handle_irq(struct pt_regs *regs)
+{
+	int gpir, irqnr, none;
+
+	/*
+	 * The interrupt number is in first ten bits. The NONE field set to 1
+	 * indicates a spurious irq.
+	 */
+
+	gpir = cp_intc_read(CP_INTC_PRIO_IDX);
+	irqnr = gpir & DAVINCI_CP_INTC_PRI_INDX_MASK;
+	none = gpir & DAVINCI_CP_INTC_GPIR_NONE;
+
+	if (unlikely(none)) {
+		pr_err_once("%s: spurious irq!\n", __func__);
+		return;
+	}
+
+	handle_domain_irq(cp_intc_domain, irqnr, regs);
+}
+
 static int cp_intc_host_map(struct irq_domain *h, unsigned int virq,
 			  irq_hw_number_t hw)
 {
@@ -196,6 +222,8 @@ int __init cp_intc_of_init(struct device_node *node, struct device_node *parent)
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
index 07d8ef8037e4..3ce821a06e52 100644
--- a/arch/arm/mach-davinci/irq.c
+++ b/arch/arm/mach-davinci/irq.c
@@ -29,11 +29,13 @@
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
@@ -48,6 +50,11 @@ static inline void davinci_irq_writel(unsigned long value, int offset)
 	__raw_writel(value, davinci_intc_base + offset);
 }
 
+static inline unsigned long davinci_irq_readl(int offset)
+{
+	return __raw_readl(davinci_intc_base + offset);
+}
+
 static __init void
 davinci_irq_setup_gc(void __iomem *base,
 		     unsigned int irq_start, unsigned int num)
@@ -70,6 +77,21 @@ davinci_irq_setup_gc(void __iomem *base,
 			       IRQ_NOREQUEST | IRQ_NOPROBE, 0);
 }
 
+static asmlinkage void __exception_irq_entry
+davinci_handle_irq(struct pt_regs *regs)
+{
+	int irqnr = davinci_irq_readl(IRQ_IRQENTRY_OFFSET);
+
+	/*
+	 * Use the formula for entry vector index generation from section
+	 * 8.3.3 of the manual.
+	 */
+	irqnr >>= 2;
+	irqnr -= 1;
+
+	handle_domain_irq(davinci_irq_domain, irqnr, regs);
+}
+
 /* ARM Interrupt Controller Initialization */
 void __init davinci_irq_init(void)
 {
@@ -133,4 +155,5 @@ void __init davinci_irq_init(void)
 		davinci_irq_setup_gc(davinci_intc_base + j, irq_base + i, 32);
 
 	irq_set_handler(IRQ_TINT1_TINT34, handle_level_irq);
+	set_handle_irq(davinci_handle_irq);
 }
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
