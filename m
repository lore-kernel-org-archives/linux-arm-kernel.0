Return-Path: <SRS0=fpAU=QP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C566C282CB
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF2B2146E
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l7ikmc6n";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="TUQ+8OTP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF2B2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=r0Tfx6iAEOkMMLcDtgi0QSvzfaO7uWxnw+SYh+Qh6YA=; b=l7ikmc6nwNN2eJ
	kdF7wKWEZT/qP+5SIyOL7zizhrM9Gqo8EOvlr/zSta7oQu0arv1/jbhIAxtPnHbZcj7Fw8aRK1BAB
	5TtaD6xQ+SZbjMn2tnV69Vl4DmvtVm7eVxuQeiWH0nyN/LDOymhmdfUtbTkDbxRYZwjqdVC7Upn87
	aatv+zwMOS4W2nx2FQxKxSbAMADaCFXjqGxbD7jxl++V4Sn4SLJ4D9OFDXlgQBoz5ZRTYz9LxNdKW
	NxYwDsddmER3lrJDgfeGUgieweSrnSR6aoYoFV2HAZrayRsHBbx5ZIZ8bIZbO/YYn6izYxr3tJPVM
	8wAzRBp9tJz6Xgqarf7Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gsA4D-0007sH-RS; Fri, 08 Feb 2019 17:35:57 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gsA3S-0006c7-36
 for linux-arm-kernel@lists.infradead.org; Fri, 08 Feb 2019 17:35:19 +0000
Received: by mail-wm1-x343.google.com with SMTP id g67so4269511wmd.2
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 08 Feb 2019 09:35:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Jf/g4gC9Mu/8OgPrpqeKW285bP2v87UHo4ZLhU3FVpU=;
 b=TUQ+8OTP4zf6M++c5bDohxwQ448/c5DXnp5BoTtY0Ghs7gsc4OpDMqPRhQyZRzLHW5
 WJgGSb1DA6PWrs1pCaoQ+oIJKwVcZJlm8dMp1zWZBfAxuqFmY/gaalFj7rvUWgBRh2VX
 tD/X1bE6VbwySITj78daZtSr4Jul7I5tjv65X9YSMzyr1Wp+/NgjnEghX3dLr8TMjIO3
 HuDf+ZoYbvbmUGNFxNdCnlLLv1JIoE+ldi3D/SLaqhOBLWowE200H88mHnc75+djVUYw
 FRahA6rT1Pfnvm0kOf6RWGSvALmeNnya35YJ/Y7fUEWDuhuQZuaGvYtaStA+YEn3xfFg
 goCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Jf/g4gC9Mu/8OgPrpqeKW285bP2v87UHo4ZLhU3FVpU=;
 b=Ahm4mdYJUYQ7rLksnL/Siuo30nR87o6S56jhuaXXAMbnAhVsDcZnwRqw32K8YKbPd/
 jEx7P3uC2yXuk6VHHFh91a5VBJaYYJbLmuLo16Cedc0aKmAvo22vdqFmFyIrcmc9Chko
 S7E4P68aBVYZrgIHuq1RdCstIQec5o5jFKgvkmzwK5nf5lZ9agph/KQCkNIKr0IeEYaf
 xrfjDFNx0eJYMLEhCUojb/LLDsJOY/BZLRs61s1lLUesqWkTI3UvDESoVodMuITOjC5O
 V4UJ/8pd2ER0hO+wew2a1FWnq9/eHr2tDmXMGU2siS3hZmII5/vz4Xiy1yHG3snmR/g7
 RQZg==
X-Gm-Message-State: AHQUAuZluJXNjNtwA1E4mhoELMng5r0T/lEKUCOwSfOZlxclz1RPAlCI
 sfNgEK6rur7RsH0ST7U0juzIKQ==
X-Google-Smtp-Source: AHgI3IZxp11G+CocV7VyJ1QGduJBvHf1cOEZU2Nhvn7dI/+53MjA8JGoppwsBgjVJ6O5hgMqJxAa3w==
X-Received: by 2002:adf:8b4d:: with SMTP id v13mr16863550wra.282.1549647308744; 
 Fri, 08 Feb 2019 09:35:08 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id p17sm354714wrv.59.2019.02.08.09.35.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 08 Feb 2019 09:35:08 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, David Lechner <david@lechnology.com>
Subject: [PATCH v2 03/33] ARM: davinci: select GENERIC_IRQ_MULTI_HANDLER
Date: Fri,  8 Feb 2019 18:34:28 +0100
Message-Id: <20190208173458.4801-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208173458.4801-1-brgl@bgdev.pl>
References: <20190208173458.4801-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190208_093510_478045_FFE798AD 
X-CRM114-Status: GOOD (  20.14  )
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
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
