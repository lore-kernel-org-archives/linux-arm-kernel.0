Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE83C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:45:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E09220842
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:45:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ErkhyEOD";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e+K62FD7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E09220842
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=dNtl+TU7zY0dlD7ox5bG93Wo+UykTUwJisUN1KyEvWI=; b=ErkhyEOD5bM3bW
	X5t07XVpf11eQOrfmQLGn3fBhr1pm8y5lberS2R+FptlhOkNA2/l8FFPJTK+QJ9+6tdQJ5Lchzc71
	AWWAOsss1JUvjpws4yIMYpubyrakoRHneUo2bGVng4PF8EgTCcqNsLh99zzq3AhBMhrieyk4t0Prn
	10w6bW+riMn2w6nTCLRMloIOgGmRlLXq0829B8AqLoMRlRR6KtwcQ8uSpS5A4++GlXhXPlvUYi0ku
	X15lwflkkACSpE1AthesgnCUg8zYxB96BxzT5tzF6Icgeh7+/5vsqukdplouQi2X8f/nVIsaH/gr6
	iIIweuieMC6QRqCVDe/Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqXS-00055c-HU; Thu, 21 Feb 2019 15:45:30 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqX9-0004hU-It
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:15 +0000
Received: by mail-lf1-x141.google.com with SMTP id z15so4427068lff.4
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=gSl17N1w/YV1K5V5/s6f0yi8s1SWFmXb9koW3edgf7A=;
 b=e+K62FD7fCiEnOc7Dssd+coQVVkQTLanWqDW2X45z1pMv7PfERsiQGkliaQNhKUfiD
 yvIGAfVItOsU4o0FuMZbFUmUg9rtR/4nJDLiAWhdba9U0F9gcy5CoDcArJnCIgb5Y/ch
 izcPQLyaxP/MZUqXAeI9Y+1IKhq5Do75yIaQqYyP7kks4KFeZhhVWQGOhhyjI+Cgrygq
 0pt0oW0EfkGzyaoWQAVe12Q7W2iEHtf853/PxjXHDuDgi7IUjTznaLrcv9rghZqUFaaT
 3GJMg2QZhS+KINe0iKhfyBh6TnEbR1Tnze7rCgWOifoFUUqleFWd4tgyXhodSO89CIQo
 c9Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=gSl17N1w/YV1K5V5/s6f0yi8s1SWFmXb9koW3edgf7A=;
 b=cL7zhDqOCUQvbPUuG/dnSYNYyuK6RhjypDR5DGLKl93W/2C91x6DHBOqggqBYE76sz
 Q6gOgccCrJsXpjGJ2P9IicO1LO6WHr4sI2SWt0NxbojQ3cTrmOk8HYExZuhqHZdiDXAu
 +R+A0sE/Hj6E1GLc63AyLYVQKh86cQf4Gy2Zb43lvrY81nq+YaVGk5MppacgYrgrnXKp
 oFSV2I2BAanmHysLilneKnFii7JtucsDc3JZ9g86UYpiadJdWewEzZtiNEIW2uEWdwHz
 5DdBy79XWsDKCoYgaOzDMcPq2BFjpwHeAR2rPM+XtjtOzYU6wGCvtJxxQK+CN8d3rJpT
 tseg==
X-Gm-Message-State: AHQUAuYoUwyqrvSDx+Dm9MWAAzBOt/ZIpKUP44iHGBtNtOmg1fJs6Vq6
 6cWEp4xEXrvjasCtGAvQrpFkxrDwNxk=
X-Google-Smtp-Source: AHgI3IbylXXJLajxNb4FjmKWx0qEHMePAFJvMXEowuiCZnBWWgIbm1uiQ9m5aHF22C51kroQWKG0xg==
X-Received: by 2002:ac2:518e:: with SMTP id u14mr23206232lfi.76.1550763909412; 
 Thu, 21 Feb 2019 07:45:09 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.07
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:08 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 01/30 v2] ARM: ixp4xx: Convert to MULTI_IRQ_HANDLER
Date: Thu, 21 Feb 2019 16:44:29 +0100
Message-Id: <20190221154458.23763-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074511_795522_C189C933 
X-CRM114-Status: GOOD (  23.84  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This rewrites the IXP4xx to use MULTI_IRQ_HANDLER and
create an irqdomain for the irqchip in the platform. We
convert the timer to request the interrupt like any other
driver in the process.

We bump all IRQs to 16+offset to avoid using IRQ 0 and
set NR_IRQS to 512 (the default for most systems).
This conveniently fits with the first 16 IRQs being
pre-allocated when using SPARSE_IRQ.

This is a prerequisite for SPARSE_IRQ and DT boot.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/Kconfig                              |   1 +
 arch/arm/mach-ixp4xx/common.c                 | 109 +++++++++++++-----
 .../mach-ixp4xx/include/mach/entry-macro.S    |  41 -------
 arch/arm/mach-ixp4xx/include/mach/irqs.h      |  95 ++++++++-------
 4 files changed, 126 insertions(+), 120 deletions(-)
 delete mode 100644 arch/arm/mach-ixp4xx/include/mach/entry-macro.S

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 664e918e2624..0bdcacd40591 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -431,6 +431,7 @@ config ARCH_IXP4XX
 	select CPU_XSCALE
 	select DMABOUNCE if PCI
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_IRQ_MULTI_HANDLER
 	select GPIOLIB
 	select HAVE_PCI
 	select NEED_MACH_IO_H
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index 846e033c56fa..58a1b851425e 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -31,12 +31,14 @@
 #include <linux/cpu.h>
 #include <linux/pci.h>
 #include <linux/sched_clock.h>
+#include <linux/bitops.h>
 #include <mach/udc.h>
 #include <mach/hardware.h>
 #include <mach/io.h>
 #include <linux/uaccess.h>
 #include <asm/pgtable.h>
 #include <asm/page.h>
+#include <asm/exception.h>
 #include <asm/irq.h>
 #include <asm/system_misc.h>
 #include <asm/mach/map.h>
@@ -54,6 +56,7 @@
 				       (IXP4XX_OST_RELOAD_MASK + 1) * HZ) * \
 			(IXP4XX_OST_RELOAD_MASK + 1)
 
+static struct irq_domain *ixp4xx_irqdomain;
 static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
@@ -166,16 +169,17 @@ static int ixp4xx_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
 
 static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 {
-	int line = irq2gpio[d->irq];
+	int line = irq2gpio[d->hwirq];
 	u32 int_style;
 	enum ixp4xx_irq_type irq_type;
 	volatile u32 *int_reg;
 
 	/*
 	 * Only for GPIO IRQs
+	 * all other IRQs are simply active low
 	 */
 	if (line < 0)
-		return -EINVAL;
+		return 0;
 
 	switch (type){
 	case IRQ_TYPE_EDGE_BOTH:
@@ -203,9 +207,9 @@ static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 	}
 
 	if (irq_type == IXP4XX_IRQ_EDGE)
-		ixp4xx_irq_edge |= (1 << d->irq);
+		ixp4xx_irq_edge |= (1 << d->hwirq);
 	else
-		ixp4xx_irq_edge &= ~(1 << d->irq);
+		ixp4xx_irq_edge &= ~(1 << d->hwirq);
 
 	if (line >= 8) {	/* pins 8-15 */
 		line -= 8;
@@ -224,22 +228,22 @@ static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
 	*int_reg |= (int_style << (line * IXP4XX_GPIO_STYLE_SIZE));
 
 	/* Configure the line as an input */
-	gpio_line_config(irq2gpio[d->irq], IXP4XX_GPIO_IN);
+	gpio_line_config(irq2gpio[d->hwirq], IXP4XX_GPIO_IN);
 
 	return 0;
 }
 
 static void ixp4xx_irq_mask(struct irq_data *d)
 {
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->irq >= 32)
-		*IXP4XX_ICMR2 &= ~(1 << (d->irq - 32));
+	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->hwirq >= 32)
+		*IXP4XX_ICMR2 &= ~(1 << (d->hwirq - 32));
 	else
-		*IXP4XX_ICMR &= ~(1 << d->irq);
+		*IXP4XX_ICMR &= ~(1 << d->hwirq);
 }
 
 static void ixp4xx_irq_ack(struct irq_data *d)
 {
-	int line = (d->irq < 32) ? irq2gpio[d->irq] : -1;
+	int line = (d->hwirq < 32) ? irq2gpio[d->hwirq] : -1;
 
 	if (line >= 0)
 		*IXP4XX_GPIO_GPISR = (1 << line);
@@ -251,13 +255,13 @@ static void ixp4xx_irq_ack(struct irq_data *d)
  */
 static void ixp4xx_irq_unmask(struct irq_data *d)
 {
-	if (!(ixp4xx_irq_edge & (1 << d->irq)))
+	if (!(ixp4xx_irq_edge & (1 << d->hwirq)))
 		ixp4xx_irq_ack(d);
 
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->irq >= 32)
-		*IXP4XX_ICMR2 |= (1 << (d->irq - 32));
+	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->hwirq >= 32)
+		*IXP4XX_ICMR2 |= (1 << (d->hwirq - 32));
 	else
-		*IXP4XX_ICMR |= (1 << d->irq);
+		*IXP4XX_ICMR |= (1 << d->hwirq);
 }
 
 static struct irq_chip ixp4xx_irq_chip = {
@@ -268,9 +272,50 @@ static struct irq_chip ixp4xx_irq_chip = {
 	.irq_set_type	= ixp4xx_set_irq_type,
 };
 
+asmlinkage void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
+{
+	unsigned long status;
+	int i;
+
+	status = *IXP4XX_ICIP;
+
+	for_each_set_bit(i, &status, 32)
+		handle_domain_irq(ixp4xx_irqdomain, i, regs);
+
+	/*
+	 * IXP465/IXP435 has an upper IRQ status register
+	 */
+	if ((cpu_is_ixp46x() || cpu_is_ixp43x())) {
+		status = *IXP4XX_ICIP2;
+		for_each_set_bit(i, &status, 32)
+			handle_domain_irq(ixp4xx_irqdomain, i + 32, regs);
+	}
+}
+
+static int ixp4xx_irqdomain_map(struct irq_domain *d, unsigned int irq,
+				irq_hw_number_t hwirq)
+{
+	irq_set_chip_data(irq, &ixp4xx_irq_chip);
+	irq_set_chip_and_handler(irq, &ixp4xx_irq_chip, handle_level_irq);
+	irq_set_probe(irq);
+
+	return 0;
+}
+
+static void ixp4xx_irqdomain_unmap(struct irq_domain *d, unsigned int irq)
+{
+	irq_set_chip_and_handler(irq, NULL, NULL);
+	irq_set_chip_data(irq, NULL);
+}
+
+static const struct irq_domain_ops ixp4xx_irqdomain_ops = {
+	.map = ixp4xx_irqdomain_map,
+	.unmap = ixp4xx_irqdomain_unmap,
+};
+
 void __init ixp4xx_init_irq(void)
 {
-	int i = 0;
+	int nr_irqs;
 
 	/*
 	 * ixp4xx does not implement the XScale PWRMODE register
@@ -290,14 +335,21 @@ void __init ixp4xx_init_irq(void)
 
 		/* Disable upper 32 interrupts */
 		*IXP4XX_ICMR2 = 0x00;
+
+		nr_irqs = 64;
+	} else {
+		nr_irqs = 32;
 	}
 
-        /* Default to all level triggered */
-	for(i = 0; i < NR_IRQS; i++) {
-		irq_set_chip_and_handler(i, &ixp4xx_irq_chip,
-					 handle_level_irq);
-		irq_clear_status_flags(i, IRQ_NOREQUEST);
+	ixp4xx_irqdomain = irq_domain_add_simple(NULL, nr_irqs, IRQ_IXP4XX_BASE,
+						 &ixp4xx_irqdomain_ops,
+						 NULL);
+	if (!ixp4xx_irqdomain) {
+		pr_crit("can not add primary irqdomain\n");
+		return;
 	}
+
+	set_handle_irq(ixp4xx_handle_irq);
 }
 
 
@@ -319,13 +371,6 @@ static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static struct irqaction ixp4xx_timer_irq = {
-	.name		= "timer1",
-	.flags		= IRQF_TIMER | IRQF_IRQPOLL,
-	.handler	= ixp4xx_timer_interrupt,
-	.dev_id		= &clockevent_ixp4xx,
-};
-
 void __init ixp4xx_timer_init(void)
 {
 	/* Reset/disable counter */
@@ -337,9 +382,6 @@ void __init ixp4xx_timer_init(void)
 	/* Reset time-stamp counter */
 	*IXP4XX_OSTS = 0;
 
-	/* Connect the interrupt handler and enable the interrupt */
-	setup_irq(IRQ_IXP4XX_TIMER1, &ixp4xx_timer_irq);
-
 	ixp4xx_clocksource_init();
 	ixp4xx_clockevent_init();
 }
@@ -574,7 +616,16 @@ static struct clock_event_device clockevent_ixp4xx = {
 
 static void __init ixp4xx_clockevent_init(void)
 {
+	int ret;
+
 	clockevent_ixp4xx.cpumask = cpumask_of(0);
+	clockevent_ixp4xx.irq = IRQ_IXP4XX_TIMER1;
+	ret = request_irq(IRQ_IXP4XX_TIMER1, ixp4xx_timer_interrupt,
+			  IRQF_TIMER, "IXP4XX-TIMER1", &clockevent_ixp4xx);
+	if (ret) {
+		pr_crit("no timer IRQ\n");
+		return;
+	}
 	clockevents_config_and_register(&clockevent_ixp4xx, IXP4XX_TIMER_FREQ,
 					0xf, 0xfffffffe);
 }
diff --git a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S b/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
deleted file mode 100644
index 79adf83e2c3d..000000000000
--- a/arch/arm/mach-ixp4xx/include/mach/entry-macro.S
+++ /dev/null
@@ -1,41 +0,0 @@
-/*
- * arch/arm/mach-ixp4xx/include/mach/entry-macro.S
- *
- * Low-level IRQ helper macros for IXP4xx-based platforms
- *
- * This file is licensed under  the terms of the GNU General Public
- * License version 2. This program is licensed "as is" without any
- * warranty of any kind, whether express or implied.
- */
-#include <mach/hardware.h>
-
-		.macro  get_irqnr_preamble, base, tmp
-		.endm
-
-		.macro	get_irqnr_and_base, irqnr, irqstat, base, tmp
-		ldr	\irqstat, =(IXP4XX_INTC_BASE_VIRT+IXP4XX_ICIP_OFFSET)
-		ldr	\irqstat, [\irqstat]		@ get interrupts
-		cmp	\irqstat, #0
-		beq	1001f				@ upper IRQ?
-		clz     \irqnr, \irqstat
-		mov     \base, #31
-		sub     \irqnr, \base, \irqnr
-		b	1002f				@ lower IRQ being
-							@ handled
-
-1001:
-		/*
-		 * IXP465/IXP435 has an upper IRQ status register
-		 */
-#if defined(CONFIG_CPU_IXP46X) || defined(CONFIG_CPU_IXP43X)
-		ldr	\irqstat, =(IXP4XX_INTC_BASE_VIRT+IXP4XX_ICIP2_OFFSET)
-		ldr	\irqstat, [\irqstat]		@ get upper interrupts
-		mov	\irqnr, #63
-		clz	\irqstat, \irqstat
- 		cmp	\irqstat, #32
-		subne	\irqnr, \irqnr, \irqstat
-#endif
-1002:
-		.endm
-
-
diff --git a/arch/arm/mach-ixp4xx/include/mach/irqs.h b/arch/arm/mach-ixp4xx/include/mach/irqs.h
index 7e6d4cce7c27..dadcd4ddb0a9 100644
--- a/arch/arm/mach-ixp4xx/include/mach/irqs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/irqs.h
@@ -15,60 +15,55 @@
 #ifndef _ARCH_IXP4XX_IRQS_H_
 #define _ARCH_IXP4XX_IRQS_H_
 
-#define IRQ_IXP4XX_NPEA		0
-#define IRQ_IXP4XX_NPEB		1
-#define IRQ_IXP4XX_NPEC		2
-#define IRQ_IXP4XX_QM1		3
-#define IRQ_IXP4XX_QM2		4
-#define IRQ_IXP4XX_TIMER1	5
-#define IRQ_IXP4XX_GPIO0	6
-#define IRQ_IXP4XX_GPIO1	7
-#define IRQ_IXP4XX_PCI_INT	8
-#define IRQ_IXP4XX_PCI_DMA1	9
-#define IRQ_IXP4XX_PCI_DMA2	10
-#define IRQ_IXP4XX_TIMER2	11
-#define IRQ_IXP4XX_USB		12
-#define IRQ_IXP4XX_UART2	13
-#define IRQ_IXP4XX_TIMESTAMP	14
-#define IRQ_IXP4XX_UART1	15
-#define IRQ_IXP4XX_WDOG		16
-#define IRQ_IXP4XX_AHB_PMU	17
-#define IRQ_IXP4XX_XSCALE_PMU	18
-#define IRQ_IXP4XX_GPIO2	19
-#define IRQ_IXP4XX_GPIO3	20
-#define IRQ_IXP4XX_GPIO4	21
-#define IRQ_IXP4XX_GPIO5	22
-#define IRQ_IXP4XX_GPIO6	23
-#define IRQ_IXP4XX_GPIO7	24
-#define IRQ_IXP4XX_GPIO8	25
-#define IRQ_IXP4XX_GPIO9	26
-#define IRQ_IXP4XX_GPIO10	27
-#define IRQ_IXP4XX_GPIO11	28
-#define IRQ_IXP4XX_GPIO12	29
-#define IRQ_IXP4XX_SW_INT1	30
-#define IRQ_IXP4XX_SW_INT2	31
-#define IRQ_IXP4XX_USB_HOST	32
-#define IRQ_IXP4XX_I2C		33
-#define IRQ_IXP4XX_SSP		34
-#define IRQ_IXP4XX_TSYNC	35
-#define IRQ_IXP4XX_EAU_DONE	36
-#define IRQ_IXP4XX_SHA_DONE	37
-#define IRQ_IXP4XX_SWCP_PE	58
-#define IRQ_IXP4XX_QM_PE	60
-#define IRQ_IXP4XX_MCU_ECC	61
-#define IRQ_IXP4XX_EXP_PE	62
+#define IRQ_IXP4XX_BASE		16
+
+#define IRQ_IXP4XX_NPEA		(IRQ_IXP4XX_BASE + 0)
+#define IRQ_IXP4XX_NPEB		(IRQ_IXP4XX_BASE + 1)
+#define IRQ_IXP4XX_NPEC		(IRQ_IXP4XX_BASE + 2)
+#define IRQ_IXP4XX_QM1		(IRQ_IXP4XX_BASE + 3)
+#define IRQ_IXP4XX_QM2		(IRQ_IXP4XX_BASE + 4)
+#define IRQ_IXP4XX_TIMER1	(IRQ_IXP4XX_BASE + 5)
+#define IRQ_IXP4XX_GPIO0	(IRQ_IXP4XX_BASE + 6)
+#define IRQ_IXP4XX_GPIO1	(IRQ_IXP4XX_BASE + 7)
+#define IRQ_IXP4XX_PCI_INT	(IRQ_IXP4XX_BASE + 8)
+#define IRQ_IXP4XX_PCI_DMA1	(IRQ_IXP4XX_BASE + 9)
+#define IRQ_IXP4XX_PCI_DMA2	(IRQ_IXP4XX_BASE + 10)
+#define IRQ_IXP4XX_TIMER2	(IRQ_IXP4XX_BASE + 11)
+#define IRQ_IXP4XX_USB		(IRQ_IXP4XX_BASE + 12)
+#define IRQ_IXP4XX_UART2	(IRQ_IXP4XX_BASE + 13)
+#define IRQ_IXP4XX_TIMESTAMP	(IRQ_IXP4XX_BASE + 14)
+#define IRQ_IXP4XX_UART1	(IRQ_IXP4XX_BASE + 15)
+#define IRQ_IXP4XX_WDOG		(IRQ_IXP4XX_BASE + 16)
+#define IRQ_IXP4XX_AHB_PMU	(IRQ_IXP4XX_BASE + 17)
+#define IRQ_IXP4XX_XSCALE_PMU	(IRQ_IXP4XX_BASE + 18)
+#define IRQ_IXP4XX_GPIO2	(IRQ_IXP4XX_BASE + 19)
+#define IRQ_IXP4XX_GPIO3	(IRQ_IXP4XX_BASE + 20)
+#define IRQ_IXP4XX_GPIO4	(IRQ_IXP4XX_BASE + 21)
+#define IRQ_IXP4XX_GPIO5	(IRQ_IXP4XX_BASE + 22)
+#define IRQ_IXP4XX_GPIO6	(IRQ_IXP4XX_BASE + 23)
+#define IRQ_IXP4XX_GPIO7	(IRQ_IXP4XX_BASE + 24)
+#define IRQ_IXP4XX_GPIO8	(IRQ_IXP4XX_BASE + 25)
+#define IRQ_IXP4XX_GPIO9	(IRQ_IXP4XX_BASE + 26)
+#define IRQ_IXP4XX_GPIO10	(IRQ_IXP4XX_BASE + 27)
+#define IRQ_IXP4XX_GPIO11	(IRQ_IXP4XX_BASE + 28)
+#define IRQ_IXP4XX_GPIO12	(IRQ_IXP4XX_BASE + 29)
+#define IRQ_IXP4XX_SW_INT1	(IRQ_IXP4XX_BASE + 30)
+#define IRQ_IXP4XX_SW_INT2	(IRQ_IXP4XX_BASE + 31)
+#define IRQ_IXP4XX_USB_HOST	(IRQ_IXP4XX_BASE + 32)
+#define IRQ_IXP4XX_I2C		(IRQ_IXP4XX_BASE + 33)
+#define IRQ_IXP4XX_SSP		(IRQ_IXP4XX_BASE + 34)
+#define IRQ_IXP4XX_TSYNC	(IRQ_IXP4XX_BASE + 35)
+#define IRQ_IXP4XX_EAU_DONE	(IRQ_IXP4XX_BASE + 36)
+#define IRQ_IXP4XX_SHA_DONE	(IRQ_IXP4XX_BASE + 37)
+#define IRQ_IXP4XX_SWCP_PE	(IRQ_IXP4XX_BASE + 58)
+#define IRQ_IXP4XX_QM_PE	(IRQ_IXP4XX_BASE + 60)
+#define IRQ_IXP4XX_MCU_ECC	(IRQ_IXP4XX_BASE + 61)
+#define IRQ_IXP4XX_EXP_PE	(IRQ_IXP4XX_BASE + 62)
 
 #define _IXP4XX_GPIO_IRQ(n)	(IRQ_IXP4XX_GPIO ## n)
 #define IXP4XX_GPIO_IRQ(n)	_IXP4XX_GPIO_IRQ(n)
 
-/*
- * Only first 32 sources are valid if running on IXP42x systems
- */
-#if defined(CONFIG_CPU_IXP46X) || defined(CONFIG_CPU_IXP43X)
-#define NR_IRQS			64
-#else
-#define NR_IRQS			32
-#endif
+#define NR_IRQS 512
 
 #define	XSCALE_PMU_IRQ		(IRQ_IXP4XX_XSCALE_PMU)
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
