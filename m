Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD79C00319
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EB1A20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="XMbMSfpf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="klZIZBQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EB1A20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=WowUJrmgf7wJ7b2f4eH8eJY69izIihS+ejlYvUIDVOg=; b=XMbMSfpfArrcoN
	gM68Qd2xGlcNI05NYLlvJrzjsfhL6KXr61wXpbI22plDLMoh9fw4aPePHKZtJKEoJMYHUKivdAr2A
	O6tnvjRKYtwP3AIPtsFaK3oULoWY4yWjx5gzobLzOgPEz8tGqsVP1hij/KGQ7P4tntKQ6fBchipoe
	kgKtlB6pMSuPSCAW6vmORMHQuUhfEtVtEHyK2rfw37kSihsRp29bL/8bUX/rOlE/4eY9I76MNVXzv
	dWcfbqGY2goMB89bxJsfM+Pim5gvNoOvIRzyPZpCN56s1xyE/6mBGB0rbYe32F6Jb/K+BCb8Q3ZDn
	+Sm6NT7KEeEpnOkaRmZw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqYr-0006S9-19; Thu, 21 Feb 2019 15:46:57 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXO-0004yw-4Z
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:30 +0000
Received: by mail-lf1-x144.google.com with SMTP id u21so20750233lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=U1cxO7VVwqmxQbAIOAoy5XNG/YE4OZ3otvMxFXrUJPE=;
 b=klZIZBQ9AtQkWuhuoITtBTqWgBbRG848BhhnzJRiw8KwhcN/003cwmYFxVT5Li6Jcw
 xEhh4T3yl9dUo5G/CiO/ps3KxY8W6zPZeg9LdQ9zKs2k5dVPdEbVG14BG0IInfxW1Rzm
 eUb6M/K8L6x6klc1VD+3iyyq+wF1uV7lsrhhm2E7+qlhS6kaspss5l1/JVAHgwVfYf+1
 /LdnI2SaODzaPrBy6pkHPRwAUOrMAhWf5OurmD1ANpD9ZrVRxeOOEVIE6MNtCPOs/AEP
 aHs75PMij+hosSKOBKnWIkeRUpFvphtkDXn4t9kOiWUZegPYbQXMFrnwtvW0sHOcbuKa
 767Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=U1cxO7VVwqmxQbAIOAoy5XNG/YE4OZ3otvMxFXrUJPE=;
 b=TOrVIKltNYsvPtMdl/R+e36pzv408CtBd3E4x5zVUOg8eB0AuGGvfIJ1UuEMjXMJlJ
 h4w/Z8HsLxSNxd0h04Fxlx9lh0s1lB6gcpvKAD9/fjfiQqkwp9zoVw6vBkXcCFkYnHrl
 tepGJrMkawdSl3sfvkuMQiXlnETpcsrEN32i+jZOje+7N/MSroEJUikGHSWwwFgFKzH3
 ic8NbJM9lGVQQBpLCcIvM6QGk15L7mQptRUbpxrMcSpoe2lt2sjVgEPHIjRLZZAXUB0u
 iXrDwEwJS7kgOTRY/jaJp4TYS5EfDnr9jxjpW0Ttgoo8n1wyNQyvdUC5VbcDR24xwSte
 3I8w==
X-Gm-Message-State: AHQUAuZebziDzFTXMMYkBc5PdVwT+rO6IHAMTzntO3mYksuk7vPl84sX
 8940p6L0Kvin/kuW0Eb+4hQ+S6T5HiI=
X-Google-Smtp-Source: AHgI3IayufXMo2FLSaezwErWB1akiqYtz2lCrkr2W+luTmMLDzE8VFG432L0t9q9BOytLoj2DHf0SQ==
X-Received: by 2002:a19:f517:: with SMTP id j23mr23569346lfb.118.1550763923595; 
 Thu, 21 Feb 2019 07:45:23 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.21
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:22 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 06/30 v2] ARM: ixp4xx: Switch to use new IRQ+GPIO drivers
Date: Thu, 21 Feb 2019 16:44:34 +0100
Message-Id: <20190221154458.23763-7-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074527_008145_FB7B2B72 
X-CRM114-Status: GOOD (  24.08  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This deletes the old irq+gpiochip combo from the IXP4xx
machine and switches it over to use the new drivers merged
in respective subsystem.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
IRQ+GPIO folks: here you see how I activate those new
drivers. Intended to be merged through ARM SoC.
---
 arch/arm/Kconfig                              |   3 +-
 arch/arm/mach-ixp4xx/common.c                 | 318 ++----------------
 arch/arm/mach-ixp4xx/dsmg600-setup.c          |   3 -
 .../mach-ixp4xx/include/mach/ixp4xx-regs.h    |  89 -----
 arch/arm/mach-ixp4xx/nas100d-setup.c          |   3 -
 5 files changed, 24 insertions(+), 392 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index de2a5647e85d..f6345594cef0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -432,10 +432,11 @@ config ARCH_IXP4XX
 	select DMABOUNCE if PCI
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_MULTI_HANDLER
+	select GPIO_IXP4XX
 	select GPIOLIB
 	select HAVE_PCI
+	select IXP4XX_IRQ
 	select NEED_MACH_IO_H
-	select SPARSE_IRQ
 	select USB_EHCI_BIG_ENDIAN_DESC
 	select USB_EHCI_BIG_ENDIAN_MMIO
 	help
diff --git a/arch/arm/mach-ixp4xx/common.c b/arch/arm/mach-ixp4xx/common.c
index aa8fd248c125..71683dfc48f9 100644
--- a/arch/arm/mach-ixp4xx/common.c
+++ b/arch/arm/mach-ixp4xx/common.c
@@ -27,11 +27,11 @@
 #include <linux/clockchips.h>
 #include <linux/io.h>
 #include <linux/export.h>
-#include <linux/gpio/driver.h>
 #include <linux/cpu.h>
 #include <linux/pci.h>
 #include <linux/sched_clock.h>
 #include <linux/bitops.h>
+#include <linux/irqchip/irq-ixp4xx.h>
 #include <mach/udc.h>
 #include <mach/hardware.h>
 #include <mach/io.h>
@@ -58,7 +58,6 @@
 				       (IXP4XX_OST_RELOAD_MASK + 1) * HZ) * \
 			(IXP4XX_OST_RELOAD_MASK + 1)
 
-static struct irq_domain *ixp4xx_irqdomain;
 static void __init ixp4xx_clocksource_init(void);
 static void __init ixp4xx_clockevent_init(void);
 static struct clock_event_device clockevent_ixp4xx;
@@ -95,266 +94,18 @@ void __init ixp4xx_map_io(void)
   	iotable_init(ixp4xx_io_desc, ARRAY_SIZE(ixp4xx_io_desc));
 }
 
-/*
- * GPIO-functions
- */
-/*
- * The following converted to the real HW bits the gpio_line_config
- */
-/* GPIO pin types */
-#define IXP4XX_GPIO_OUT 		0x1
-#define IXP4XX_GPIO_IN  		0x2
-
-/* GPIO signal types */
-#define IXP4XX_GPIO_LOW			0
-#define IXP4XX_GPIO_HIGH		1
-
-/* GPIO Clocks */
-#define IXP4XX_GPIO_CLK_0		14
-#define IXP4XX_GPIO_CLK_1		15
-
-static void gpio_line_config(u8 line, u32 direction)
-{
-	if (direction == IXP4XX_GPIO_IN)
-		*IXP4XX_GPIO_GPOER |= (1 << line);
-	else
-		*IXP4XX_GPIO_GPOER &= ~(1 << line);
-}
-
-static void gpio_line_get(u8 line, int *value)
-{
-	*value = (*IXP4XX_GPIO_GPINR >> line) & 0x1;
-}
-
-static void gpio_line_set(u8 line, int value)
-{
-	if (value == IXP4XX_GPIO_HIGH)
-	    *IXP4XX_GPIO_GPOUTR |= (1 << line);
-	else if (value == IXP4XX_GPIO_LOW)
-	    *IXP4XX_GPIO_GPOUTR &= ~(1 << line);
-}
-
-/*************************************************************************
- * IXP4xx chipset IRQ handling
- *
- * TODO: GPIO IRQs should be marked invalid until the user of the IRQ
- *       (be it PCI or something else) configures that GPIO line
- *       as an IRQ.
- **************************************************************************/
-enum ixp4xx_irq_type {
-	IXP4XX_IRQ_LEVEL, IXP4XX_IRQ_EDGE
-};
-
-/* Each bit represents an IRQ: 1: edge-triggered, 0: level triggered */
-static unsigned long long ixp4xx_irq_edge = 0;
-
-/*
- * IRQ -> GPIO mapping table
- */
-static signed char irq2gpio[32] = {
-	-1, -1, -1, -1, -1, -1,  0,  1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1,  2,  3,  4,  5,  6,
-	 7,  8,  9, 10, 11, 12, -1, -1,
-};
-
-static int ixp4xx_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
-{
-	int irq;
-
-	for (irq = 0; irq < 32; irq++) {
-		if (irq2gpio[irq] == gpio)
-			return irq;
-	}
-	return -EINVAL;
-}
-
-static int ixp4xx_set_irq_type(struct irq_data *d, unsigned int type)
-{
-	int line = irq2gpio[d->hwirq];
-	u32 int_style;
-	enum ixp4xx_irq_type irq_type;
-	volatile u32 *int_reg;
-
-	/*
-	 * Only for GPIO IRQs
-	 * all other IRQs are simply active low
-	 */
-	if (line < 0)
-		return 0;
-
-	switch (type){
-	case IRQ_TYPE_EDGE_BOTH:
-		int_style = IXP4XX_GPIO_STYLE_TRANSITIONAL;
-		irq_type = IXP4XX_IRQ_EDGE;
-		break;
-	case IRQ_TYPE_EDGE_RISING:
-		int_style = IXP4XX_GPIO_STYLE_RISING_EDGE;
-		irq_type = IXP4XX_IRQ_EDGE;
-		break;
-	case IRQ_TYPE_EDGE_FALLING:
-		int_style = IXP4XX_GPIO_STYLE_FALLING_EDGE;
-		irq_type = IXP4XX_IRQ_EDGE;
-		break;
-	case IRQ_TYPE_LEVEL_HIGH:
-		int_style = IXP4XX_GPIO_STYLE_ACTIVE_HIGH;
-		irq_type = IXP4XX_IRQ_LEVEL;
-		break;
-	case IRQ_TYPE_LEVEL_LOW:
-		int_style = IXP4XX_GPIO_STYLE_ACTIVE_LOW;
-		irq_type = IXP4XX_IRQ_LEVEL;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (irq_type == IXP4XX_IRQ_EDGE)
-		ixp4xx_irq_edge |= (1 << d->hwirq);
-	else
-		ixp4xx_irq_edge &= ~(1 << d->hwirq);
-
-	if (line >= 8) {	/* pins 8-15 */
-		line -= 8;
-		int_reg = IXP4XX_GPIO_GPIT2R;
-	} else {		/* pins 0-7 */
-		int_reg = IXP4XX_GPIO_GPIT1R;
-	}
-
-	/* Clear the style for the appropriate pin */
-	*int_reg &= ~(IXP4XX_GPIO_STYLE_CLEAR <<
-	    		(line * IXP4XX_GPIO_STYLE_SIZE));
-
-	*IXP4XX_GPIO_GPISR = (1 << line);
-
-	/* Set the new style */
-	*int_reg |= (int_style << (line * IXP4XX_GPIO_STYLE_SIZE));
-
-	/* Configure the line as an input */
-	gpio_line_config(irq2gpio[d->hwirq], IXP4XX_GPIO_IN);
-
-	return 0;
-}
-
-static void ixp4xx_irq_mask(struct irq_data *d)
-{
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->hwirq >= 32)
-		*IXP4XX_ICMR2 &= ~(1 << (d->hwirq - 32));
-	else
-		*IXP4XX_ICMR &= ~(1 << d->hwirq);
-}
-
-static void ixp4xx_irq_ack(struct irq_data *d)
-{
-	int line = (d->hwirq < 32) ? irq2gpio[d->hwirq] : -1;
-
-	if (line >= 0)
-		*IXP4XX_GPIO_GPISR = (1 << line);
-}
-
-/*
- * Level triggered interrupts on GPIO lines can only be cleared when the
- * interrupt condition disappears.
- */
-static void ixp4xx_irq_unmask(struct irq_data *d)
-{
-	if (!(ixp4xx_irq_edge & (1 << d->hwirq)))
-		ixp4xx_irq_ack(d);
-
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x()) && d->hwirq >= 32)
-		*IXP4XX_ICMR2 |= (1 << (d->hwirq - 32));
-	else
-		*IXP4XX_ICMR |= (1 << d->hwirq);
-}
-
-static struct irq_chip ixp4xx_irq_chip = {
-	.name		= "IXP4xx",
-	.irq_ack	= ixp4xx_irq_ack,
-	.irq_mask	= ixp4xx_irq_mask,
-	.irq_unmask	= ixp4xx_irq_unmask,
-	.irq_set_type	= ixp4xx_set_irq_type,
-};
-
-asmlinkage void __exception_irq_entry ixp4xx_handle_irq(struct pt_regs *regs)
-{
-	unsigned long status;
-	int i;
-
-	status = *IXP4XX_ICIP;
-
-	for_each_set_bit(i, &status, 32)
-		handle_domain_irq(ixp4xx_irqdomain, i, regs);
-
-	/*
-	 * IXP465/IXP435 has an upper IRQ status register
-	 */
-	if ((cpu_is_ixp46x() || cpu_is_ixp43x())) {
-		status = *IXP4XX_ICIP2;
-		for_each_set_bit(i, &status, 32)
-			handle_domain_irq(ixp4xx_irqdomain, i + 32, regs);
-	}
-}
-
-static int ixp4xx_irqdomain_map(struct irq_domain *d, unsigned int irq,
-				irq_hw_number_t hwirq)
-{
-	irq_set_chip_data(irq, &ixp4xx_irq_chip);
-	irq_set_chip_and_handler(irq, &ixp4xx_irq_chip, handle_level_irq);
-	irq_set_probe(irq);
-
-	return 0;
-}
-
-static void ixp4xx_irqdomain_unmap(struct irq_domain *d, unsigned int irq)
-{
-	irq_set_chip_and_handler(irq, NULL, NULL);
-	irq_set_chip_data(irq, NULL);
-}
-
-static const struct irq_domain_ops ixp4xx_irqdomain_ops = {
-	.map = ixp4xx_irqdomain_map,
-	.unmap = ixp4xx_irqdomain_unmap,
-};
-
 void __init ixp4xx_init_irq(void)
 {
-	int nr_irqs;
-
 	/*
 	 * ixp4xx does not implement the XScale PWRMODE register
 	 * so it must not call cpu_do_idle().
 	 */
 	cpu_idle_poll_ctrl(true);
 
-	/* Route all sources to IRQ instead of FIQ */
-	*IXP4XX_ICLR = 0x0;
-
-	/* Disable all interrupt */
-	*IXP4XX_ICMR = 0x0; 
-
-	if (cpu_is_ixp46x() || cpu_is_ixp43x()) {
-		/* Route upper 32 sources to IRQ instead of FIQ */
-		*IXP4XX_ICLR2 = 0x00;
-
-		/* Disable upper 32 interrupts */
-		*IXP4XX_ICMR2 = 0x00;
-
-		nr_irqs = 64;
-	} else {
-		nr_irqs = 32;
-	}
-
-	ixp4xx_irqdomain = irq_domain_add_simple(NULL, nr_irqs, IRQ_IXP4XX_BASE,
-						 &ixp4xx_irqdomain_ops,
-						 NULL);
-	if (!ixp4xx_irqdomain) {
-		pr_crit("can not add primary irqdomain\n");
-		return;
-	}
-
-	set_handle_irq(ixp4xx_handle_irq);
+	ixp4xx_irq_init(IXP4XX_INTC_BASE_PHYS,
+			(cpu_is_ixp46x() || cpu_is_ixp43x()));
 }
 
-
 /*************************************************************************
  * IXP4xx timer tick
  * We use OS timer1 on the CPU for the timer tick and the timestamp 
@@ -408,6 +159,24 @@ static struct resource ixp4xx_udc_resources[] = {
 	},
 };
 
+static struct resource ixp4xx_gpio_resource[] = {
+	{
+		.start = IXP4XX_GPIO_BASE_PHYS,
+		.end = IXP4XX_GPIO_BASE_PHYS + 0xfff,
+		.flags = IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device ixp4xx_gpio_device = {
+	.name           = "ixp4xx-gpio",
+	.id             = -1,
+	.dev = {
+		.coherent_dma_mask      = DMA_BIT_MASK(32),
+	},
+	.resource = ixp4xx_gpio_resource,
+	.num_resources  = ARRAY_SIZE(ixp4xx_gpio_resource),
+};
+
 /*
  * USB device controller. The IXP4xx uses the same controller as PXA25X,
  * so we just use the same device.
@@ -423,6 +192,7 @@ static struct platform_device ixp4xx_udc_device = {
 };
 
 static struct platform_device *ixp4xx_devices[] __initdata = {
+	&ixp4xx_gpio_device,
 	&ixp4xx_udc_device,
 };
 
@@ -457,56 +227,12 @@ static struct platform_device *ixp46x_devices[] __initdata = {
 unsigned long ixp4xx_exp_bus_size;
 EXPORT_SYMBOL(ixp4xx_exp_bus_size);
 
-static int ixp4xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
-{
-	gpio_line_config(gpio, IXP4XX_GPIO_IN);
-
-	return 0;
-}
-
-static int ixp4xx_gpio_direction_output(struct gpio_chip *chip, unsigned gpio,
-					int level)
-{
-	gpio_line_set(gpio, level);
-	gpio_line_config(gpio, IXP4XX_GPIO_OUT);
-
-	return 0;
-}
-
-static int ixp4xx_gpio_get_value(struct gpio_chip *chip, unsigned gpio)
-{
-	int value;
-
-	gpio_line_get(gpio, &value);
-
-	return value;
-}
-
-static void ixp4xx_gpio_set_value(struct gpio_chip *chip, unsigned gpio,
-				  int value)
-{
-	gpio_line_set(gpio, value);
-}
-
-static struct gpio_chip ixp4xx_gpio_chip = {
-	.label			= "IXP4XX_GPIO_CHIP",
-	.direction_input	= ixp4xx_gpio_direction_input,
-	.direction_output	= ixp4xx_gpio_direction_output,
-	.get			= ixp4xx_gpio_get_value,
-	.set			= ixp4xx_gpio_set_value,
-	.to_irq			= ixp4xx_gpio_to_irq,
-	.base			= 0,
-	.ngpio			= 16,
-};
-
 void __init ixp4xx_sys_init(void)
 {
 	ixp4xx_exp_bus_size = SZ_16M;
 
 	platform_add_devices(ixp4xx_devices, ARRAY_SIZE(ixp4xx_devices));
 
-	gpiochip_add_data(&ixp4xx_gpio_chip, NULL);
-
 	if (cpu_is_ixp46x()) {
 		int region;
 
diff --git a/arch/arm/mach-ixp4xx/dsmg600-setup.c b/arch/arm/mach-ixp4xx/dsmg600-setup.c
index 0daaede8fb6d..4d4c62fced71 100644
--- a/arch/arm/mach-ixp4xx/dsmg600-setup.c
+++ b/arch/arm/mach-ixp4xx/dsmg600-setup.c
@@ -270,9 +270,6 @@ static void __init dsmg600_init(void)
 {
 	ixp4xx_sys_init();
 
-	/* Make sure that GPIO14 and GPIO15 are not used as clocks */
-	*IXP4XX_GPIO_GPCLKR = 0;
-
 	dsmg600_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	dsmg600_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
diff --git a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
index b7ddd27419c2..459abe2eb4b5 100644
--- a/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
+++ b/arch/arm/mach-ixp4xx/include/mach/ixp4xx-regs.h
@@ -147,95 +147,6 @@
 #define IXP4XX_I2C_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x11000)
 #define IXP4XX_SSP_BASE_VIRT		(IXP4XX_PERIPHERAL_BASE_VIRT + 0x12000)
 
-/*
- * Constants to make it easy to access  Interrupt Controller registers
- */
-#define IXP4XX_ICPR_OFFSET	0x00 /* Interrupt Status */
-#define IXP4XX_ICMR_OFFSET	0x04 /* Interrupt Enable */
-#define IXP4XX_ICLR_OFFSET	0x08 /* Interrupt IRQ/FIQ Select */
-#define IXP4XX_ICIP_OFFSET      0x0C /* IRQ Status */
-#define IXP4XX_ICFP_OFFSET	0x10 /* FIQ Status */
-#define IXP4XX_ICHR_OFFSET	0x14 /* Interrupt Priority */
-#define IXP4XX_ICIH_OFFSET	0x18 /* IRQ Highest Pri Int */
-#define IXP4XX_ICFH_OFFSET	0x1C /* FIQ Highest Pri Int */
-
-/*
- * IXP465-only
- */
-#define	IXP4XX_ICPR2_OFFSET	0x20 /* Interrupt Status 2 */
-#define	IXP4XX_ICMR2_OFFSET	0x24 /* Interrupt Enable 2 */
-#define	IXP4XX_ICLR2_OFFSET	0x28 /* Interrupt IRQ/FIQ Select 2 */
-#define IXP4XX_ICIP2_OFFSET     0x2C /* IRQ Status */
-#define IXP4XX_ICFP2_OFFSET	0x30 /* FIQ Status */
-#define IXP4XX_ICEEN_OFFSET	0x34 /* Error High Pri Enable */
-
-
-/*
- * Interrupt Controller Register Definitions.
- */
-
-#define IXP4XX_INTC_REG(x) ((volatile u32 *)(IXP4XX_INTC_BASE_VIRT+(x)))
-
-#define IXP4XX_ICPR	IXP4XX_INTC_REG(IXP4XX_ICPR_OFFSET)
-#define IXP4XX_ICMR     IXP4XX_INTC_REG(IXP4XX_ICMR_OFFSET)
-#define IXP4XX_ICLR     IXP4XX_INTC_REG(IXP4XX_ICLR_OFFSET)
-#define IXP4XX_ICIP     IXP4XX_INTC_REG(IXP4XX_ICIP_OFFSET)
-#define IXP4XX_ICFP     IXP4XX_INTC_REG(IXP4XX_ICFP_OFFSET)
-#define IXP4XX_ICHR     IXP4XX_INTC_REG(IXP4XX_ICHR_OFFSET)
-#define IXP4XX_ICIH     IXP4XX_INTC_REG(IXP4XX_ICIH_OFFSET) 
-#define IXP4XX_ICFH     IXP4XX_INTC_REG(IXP4XX_ICFH_OFFSET)
-#define IXP4XX_ICPR2	IXP4XX_INTC_REG(IXP4XX_ICPR2_OFFSET)
-#define IXP4XX_ICMR2    IXP4XX_INTC_REG(IXP4XX_ICMR2_OFFSET)
-#define IXP4XX_ICLR2    IXP4XX_INTC_REG(IXP4XX_ICLR2_OFFSET)
-#define IXP4XX_ICIP2    IXP4XX_INTC_REG(IXP4XX_ICIP2_OFFSET)
-#define IXP4XX_ICFP2    IXP4XX_INTC_REG(IXP4XX_ICFP2_OFFSET)
-#define IXP4XX_ICEEN    IXP4XX_INTC_REG(IXP4XX_ICEEN_OFFSET)
-                                                                                
-/*
- * Constants to make it easy to access GPIO registers
- */
-#define IXP4XX_GPIO_GPOUTR_OFFSET       0x00
-#define IXP4XX_GPIO_GPOER_OFFSET        0x04
-#define IXP4XX_GPIO_GPINR_OFFSET        0x08
-#define IXP4XX_GPIO_GPISR_OFFSET        0x0C
-#define IXP4XX_GPIO_GPIT1R_OFFSET	0x10
-#define IXP4XX_GPIO_GPIT2R_OFFSET	0x14
-#define IXP4XX_GPIO_GPCLKR_OFFSET	0x18
-#define IXP4XX_GPIO_GPDBSELR_OFFSET	0x1C
-
-/* 
- * GPIO Register Definitions.
- * [Only perform 32bit reads/writes]
- */
-#define IXP4XX_GPIO_REG(x) ((volatile u32 *)(IXP4XX_GPIO_BASE_VIRT+(x)))
-
-#define IXP4XX_GPIO_GPOUTR	IXP4XX_GPIO_REG(IXP4XX_GPIO_GPOUTR_OFFSET)
-#define IXP4XX_GPIO_GPOER       IXP4XX_GPIO_REG(IXP4XX_GPIO_GPOER_OFFSET)
-#define IXP4XX_GPIO_GPINR       IXP4XX_GPIO_REG(IXP4XX_GPIO_GPINR_OFFSET)
-#define IXP4XX_GPIO_GPISR       IXP4XX_GPIO_REG(IXP4XX_GPIO_GPISR_OFFSET)
-#define IXP4XX_GPIO_GPIT1R      IXP4XX_GPIO_REG(IXP4XX_GPIO_GPIT1R_OFFSET)
-#define IXP4XX_GPIO_GPIT2R      IXP4XX_GPIO_REG(IXP4XX_GPIO_GPIT2R_OFFSET)
-#define IXP4XX_GPIO_GPCLKR      IXP4XX_GPIO_REG(IXP4XX_GPIO_GPCLKR_OFFSET)
-#define IXP4XX_GPIO_GPDBSELR    IXP4XX_GPIO_REG(IXP4XX_GPIO_GPDBSELR_OFFSET)
-
-/*
- * GPIO register bit definitions
- */
-
-/* Interrupt styles
- */
-#define IXP4XX_GPIO_STYLE_ACTIVE_HIGH	0x0
-#define IXP4XX_GPIO_STYLE_ACTIVE_LOW	0x1
-#define IXP4XX_GPIO_STYLE_RISING_EDGE	0x2
-#define IXP4XX_GPIO_STYLE_FALLING_EDGE	0x3
-#define IXP4XX_GPIO_STYLE_TRANSITIONAL	0x4
-
-/* 
- * Mask used to clear interrupt styles 
- */
-#define IXP4XX_GPIO_STYLE_CLEAR		0x7
-#define IXP4XX_GPIO_STYLE_SIZE		3
-
 /*
  * Constants to make it easy to access Timer Control/Status registers
  */
diff --git a/arch/arm/mach-ixp4xx/nas100d-setup.c b/arch/arm/mach-ixp4xx/nas100d-setup.c
index 9d67f8de0772..c142cfa8c5d6 100644
--- a/arch/arm/mach-ixp4xx/nas100d-setup.c
+++ b/arch/arm/mach-ixp4xx/nas100d-setup.c
@@ -281,9 +281,6 @@ static void __init nas100d_init(void)
 
 	ixp4xx_sys_init();
 
-	/* gpio 14 and 15 are _not_ clocks */
-	*IXP4XX_GPIO_GPCLKR = 0;
-
 	nas100d_flash_resource.start = IXP4XX_EXP_BUS_BASE(0);
 	nas100d_flash_resource.end =
 		IXP4XX_EXP_BUS_BASE(0) + ixp4xx_exp_bus_size - 1;
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
