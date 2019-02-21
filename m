Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 350F1C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:10 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F040E20823
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="myC5O/hM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MrjxQBpt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F040E20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F0FcIC5azFkJU2KBCG/g5/BOEDN7M6OoL+6P/bl8fwo=; b=myC5O/hMjpbtCV
	3NsADn1x8dcswkTYMDTqAv+6863LvKzLrbbKQUpasXCwKNNoY0/zHQ2s237VodDVztOHsojlSHtAd
	IIkTL4Jxd/cNH7M5lHI3R/grdVa02sRw5dKpkJwo6AVrfcaFOdu/zYnlRe42u7uMl1MMxmYyvhA/s
	/mUcicX6aWfaupJhGSNefjSyiWJ1dwcAAfccI40GMTNJlcR1YQRowZ4A/7UbT8t/8rcRaNHMPpFzS
	fFpha5RUAi53PDMG6ySbFJ9OBVutsVD56ixr/7LZfo7Vnev2vCg88Scf9ebe8/Ujf5hMDWZwuU3qF
	vLBX5omawDDj5DMpPzHQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwqZ0-0006gU-C3; Thu, 21 Feb 2019 15:47:06 +0000
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwqXR-00053M-0j
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 15:45:35 +0000
Received: by mail-lf1-x141.google.com with SMTP id u21so20750362lfu.1
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 21 Feb 2019 07:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IkKADZznkEQmQ+KwrhSzI2McdxMD2GahdXj+RHxHxTE=;
 b=MrjxQBptDkscX1ArLet6y+rgFRomp+U11jIBimJ5zCp/3t3dk3zbDpwts78sK2jcY0
 06ePwKmNRaFHcBgwY4KuHfrG54rv6MNbsdrZncHwGmQiodtFXl+z0h9mWmC4Qch01dsO
 kcvPee3pG/SIqK+HBa427aGwlpQqsJLy1aXdlEj5urZ8QpMswgdJ5oCPKv4BXLWemSqf
 wZpRkgtfNCQruM+/DJvLY7VJeCzboivFyjs0rLpprr8gOqjwO+s/FZVsj4BhwAMkjmyg
 QIgz5c+NMHVkHX+NlEwRuTgwaoel8jdUGeUwiLk7w+yBxKoyRF8HecDfCH1aHSly1SXi
 WOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IkKADZznkEQmQ+KwrhSzI2McdxMD2GahdXj+RHxHxTE=;
 b=IxAOSDSndrFiR75a03Dw8mtmv+i7AIp31k+reRQGw3JApGsaVfDkdnU7gdPQ3B+Lw5
 4lN0qX8zBDe9CvpYrZ7OcGB368lFcnFwdCm6/IzbpP9LGuR8gxxCRHhdqPL9hakzXUkA
 pTV7JQ6/cJ4b1cmwhBMoOJxUr2Z3lqXrHj3tecpQQG4a2q0GYCm2ipZlirL/M2zqxQai
 pQagfpFYdj/uirU/U0KwTsOhW7twk4lSyaJAAUmWfrNv31KJTgptUhc/XJA1E4Cq6Yex
 Ja6NsAJXRnLzpXiAjSAUSg5P2iDCjc4qx5nNK+xSKvIUejB4oq/D3fm61kuDNxTb2Idz
 zJpA==
X-Gm-Message-State: AHQUAubS2u0HpIVVUH3Oee0emmb/IvgSro5LkXRSqY+H6eAp/P+WNUMT
 fsFRyQuVHBFzfpSaszLhMb1xYaGx86s=
X-Google-Smtp-Source: AHgI3IaMQ9PWXmVM4AFCpTGyTk21J+vqx2WD5GuXPE1Fo3g+o1xs+iooS/+uMk5fUHPnzWrtUvOxeQ==
X-Received: by 2002:ac2:5183:: with SMTP id u3mr24290492lfi.153.1550763926739; 
 Thu, 21 Feb 2019 07:45:26 -0800 (PST)
Received: from linux-2.local (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se.
 [213.113.123.174])
 by smtp.gmail.com with ESMTPSA id m73sm1316965lfa.65.2019.02.21.07.45.24
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 21 Feb 2019 07:45:25 -0800 (PST)
From: Linus Walleij <linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>,
 Krzysztof Halasa <khalasa@piap.pl>
Subject: [PATCH 07/30 v2] clocksource/drivers/ixp4xx: Add driver
Date: Thu, 21 Feb 2019 16:44:35 +0100
Message-Id: <20190221154458.23763-8-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221154458.23763-1-linus.walleij@linaro.org>
References: <20190221154458.23763-1-linus.walleij@linaro.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190221_074529_347375_F3A99543 
X-CRM114-Status: GOOD (  20.66  )
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
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This adds a new slightly rewritten timer driver for the
Intel IXP4xx clocksource, clockevent and delay timer.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Clocksource/timer maintainers: I am requesting an ACK for
this once you're happy with the driver, as I intend to
merge all of this IXP4xx rework through ARM SoC.
---
 MAINTAINERS                                |   2 +
 drivers/clocksource/Kconfig                |   7 +
 drivers/clocksource/Makefile               |   1 +
 drivers/clocksource/timer-ixp4xx.c         | 249 +++++++++++++++++++++
 include/linux/platform_data/timer-ixp4xx.h |  11 +
 5 files changed, 270 insertions(+)
 create mode 100644 drivers/clocksource/timer-ixp4xx.c
 create mode 100644 include/linux/platform_data/timer-ixp4xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 6c161bd82238..a2fb67b75026 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1651,9 +1651,11 @@ M:	Krzysztof Halasa <khalasa@piap.pl>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	arch/arm/mach-ixp4xx/
+F:	drivers/clocksource/timer-ixp4xx.c
 F:	drivers/gpio/gpio-ixp4xx.c
 F:	drivers/irqchip/irq-ixp4xx.c
 F:	include/linux/irqchip/irq-ixp4xx.h
+F:	include/linux/platform_data/timer-ixp4xx.h
 
 ARM/INTEL RESEARCH IMOTE/STARGATE 2 MACHINE SUPPORT
 M:	Jonathan Cameron <jic23@cam.ac.uk>
diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index a9e26f6a81a1..d290d6c6576d 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -69,6 +69,13 @@ config FTTMR010_TIMER
 	  Enables support for the Faraday Technology timer block
 	  FTTMR010.
 
+config IXP4XX_TIMER
+	bool "Intel XScale IXP4xx timer driver" if COMPILE_TEST
+	depends on HAS_IOMEM
+	select CLKSRC_MMIO
+	help
+	  Enables support for the Intel XScale IXP4xx SoC timer.
+
 config ROCKCHIP_TIMER
 	bool "Rockchip timer driver" if COMPILE_TEST
 	depends on ARM || ARM64
diff --git a/drivers/clocksource/Makefile b/drivers/clocksource/Makefile
index cdd210ff89ea..18158257ebb3 100644
--- a/drivers/clocksource/Makefile
+++ b/drivers/clocksource/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_OMAP_DM_TIMER)	+= timer-ti-dm.o
 obj-$(CONFIG_DW_APB_TIMER)	+= dw_apb_timer.o
 obj-$(CONFIG_DW_APB_TIMER_OF)	+= dw_apb_timer_of.o
 obj-$(CONFIG_FTTMR010_TIMER)	+= timer-fttmr010.o
+obj-$(CONFIG_IXP4XX_TIMER)	+= timer-ixp4xx.o
 obj-$(CONFIG_ROCKCHIP_TIMER)      += timer-rockchip.o
 obj-$(CONFIG_CLKSRC_NOMADIK_MTU)	+= nomadik-mtu.o
 obj-$(CONFIG_CLKSRC_DBX500_PRCMU)	+= clksrc-dbx500-prcmu.o
diff --git a/drivers/clocksource/timer-ixp4xx.c b/drivers/clocksource/timer-ixp4xx.c
new file mode 100644
index 000000000000..fa78f80792db
--- /dev/null
+++ b/drivers/clocksource/timer-ixp4xx.c
@@ -0,0 +1,249 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * IXP4 timer driver
+ * Copyright (C) 2019 Linus Walleij <linus.walleij@linaro.org>
+ *
+ * Based on arch/arm/mach-ixp4xx/common.c
+ * Copyright 2002 (C) Intel Corporation
+ * Copyright 2003-2004 (C) MontaVista, Software, Inc.
+ * Copyright (C) Deepak Saxena <dsaxena@plexity.net>
+ */
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/clockchips.h>
+#include <linux/clocksource.h>
+#include <linux/sched_clock.h>
+#include <linux/slab.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+/* Goes away with OF conversion */
+#include <linux/platform_data/timer-ixp4xx.h>
+
+/*
+ * Constants to make it easy to access Timer Control/Status registers
+ */
+#define IXP4XX_OSTS_OFFSET	0x00  /* Continuous Timestamp */
+#define IXP4XX_OST1_OFFSET	0x04  /* Timer 1 Timestamp */
+#define IXP4XX_OSRT1_OFFSET	0x08  /* Timer 1 Reload */
+#define IXP4XX_OST2_OFFSET	0x0C  /* Timer 2 Timestamp */
+#define IXP4XX_OSRT2_OFFSET	0x10  /* Timer 2 Reload */
+#define IXP4XX_OSWT_OFFSET	0x14  /* Watchdog Timer */
+#define IXP4XX_OSWE_OFFSET	0x18  /* Watchdog Enable */
+#define IXP4XX_OSWK_OFFSET	0x1C  /* Watchdog Key */
+#define IXP4XX_OSST_OFFSET	0x20  /* Timer Status */
+
+/*
+ * Timer register values and bit definitions
+ */
+#define IXP4XX_OST_ENABLE		0x00000001
+#define IXP4XX_OST_ONE_SHOT		0x00000002
+/* Low order bits of reload value ignored */
+#define IXP4XX_OST_RELOAD_MASK		0x00000003
+#define IXP4XX_OST_DISABLED		0x00000000
+#define IXP4XX_OSST_TIMER_1_PEND	0x00000001
+#define IXP4XX_OSST_TIMER_2_PEND	0x00000002
+#define IXP4XX_OSST_TIMER_TS_PEND	0x00000004
+#define IXP4XX_OSST_TIMER_WDOG_PEND	0x00000008
+#define IXP4XX_OSST_TIMER_WARM_RESET	0x00000010
+
+#define	IXP4XX_WDT_KEY			0x0000482E
+#define	IXP4XX_WDT_RESET_ENABLE		0x00000001
+#define	IXP4XX_WDT_IRQ_ENABLE		0x00000002
+#define	IXP4XX_WDT_COUNT_ENABLE		0x00000004
+
+struct ixp4xx_timer {
+	void __iomem *base;
+	unsigned int tick_rate;
+	u32 latch;
+	struct clock_event_device clkevt;
+#ifdef CONFIG_ARM
+	struct delay_timer delay_timer;
+#endif
+};
+
+/*
+ * A local singleton used by sched_clock and delay timer reads, which are
+ * fast and stateless
+ */
+static struct ixp4xx_timer *local_ixp4xx_timer;
+
+static inline struct ixp4xx_timer *
+to_ixp4xx_timer(struct clock_event_device *evt)
+{
+	return container_of(evt, struct ixp4xx_timer, clkevt);
+}
+
+static u64 notrace ixp4xx_read_sched_clock(void)
+{
+	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
+}
+
+static u64 ixp4xx_clocksource_read(struct clocksource *c)
+{
+	return __raw_readl(local_ixp4xx_timer->base + IXP4XX_OSTS_OFFSET);
+}
+
+static irqreturn_t ixp4xx_timer_interrupt(int irq, void *dev_id)
+{
+	struct ixp4xx_timer *tmr = dev_id;
+	struct clock_event_device *evt = &tmr->clkevt;
+
+	/* Clear Pending Interrupt */
+	__raw_writel(IXP4XX_OSST_TIMER_1_PEND,
+		     tmr->base + IXP4XX_OSST_OFFSET);
+
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static int ixp4xx_set_next_event(unsigned long cycles,
+				 struct clock_event_device *evt)
+{
+	struct ixp4xx_timer *tmr = to_ixp4xx_timer(evt);
+	u32 val;
+
+	val = __raw_readl(tmr->base + IXP4XX_OSRT1_OFFSET);
+	/* Keep enable/oneshot bits */
+	val &= IXP4XX_OST_RELOAD_MASK;
+	__raw_writel((cycles & ~IXP4XX_OST_RELOAD_MASK) | val,
+		     tmr->base + IXP4XX_OSRT1_OFFSET);
+
+	return 0;
+}
+
+static int ixp4xx_shutdown(struct clock_event_device *evt)
+{
+	struct ixp4xx_timer *tmr = to_ixp4xx_timer(evt);
+	u32 val;
+
+	val = __raw_readl(tmr->base + IXP4XX_OSRT1_OFFSET);
+	val &= ~IXP4XX_OST_ENABLE;
+	__raw_writel(val, tmr->base + IXP4XX_OSRT1_OFFSET);
+
+	return 0;
+}
+
+static int ixp4xx_set_oneshot(struct clock_event_device *evt)
+{
+	struct ixp4xx_timer *tmr = to_ixp4xx_timer(evt);
+
+	__raw_writel(IXP4XX_OST_ENABLE | IXP4XX_OST_ONE_SHOT,
+		     tmr->base + IXP4XX_OSRT1_OFFSET);
+
+	return 0;
+}
+
+static int ixp4xx_set_periodic(struct clock_event_device *evt)
+{
+	struct ixp4xx_timer *tmr = to_ixp4xx_timer(evt);
+	u32 val;
+
+	val = tmr->latch & ~IXP4XX_OST_RELOAD_MASK;
+	val |= IXP4XX_OST_ENABLE;
+	__raw_writel(val, tmr->base + IXP4XX_OSRT1_OFFSET);
+
+	return 0;
+}
+
+static int ixp4xx_resume(struct clock_event_device *evt)
+{
+	struct ixp4xx_timer *tmr = to_ixp4xx_timer(evt);
+	u32 val;
+
+	val = __raw_readl(tmr->base + IXP4XX_OSRT1_OFFSET);
+	val |= IXP4XX_OST_ENABLE;
+	__raw_writel(val, tmr->base + IXP4XX_OSRT1_OFFSET);
+
+	return 0;
+}
+
+/*
+ * IXP4xx timer tick
+ * We use OS timer1 on the CPU for the timer tick and the timestamp
+ * counter as a source of real clock ticks to account for missed jiffies.
+ */
+static __init int ixp4xx_timer_register(void __iomem *base,
+					int timer_irq,
+					unsigned int timer_freq)
+{
+	struct ixp4xx_timer *tmr;
+	int ret;
+
+	tmr = kzalloc(sizeof(*tmr), GFP_KERNEL);
+	if (!tmr)
+		return -ENOMEM;
+	tmr->base = base;
+	tmr->tick_rate = timer_freq;
+
+	/*
+	 * The timer register doesn't allow to specify the two least
+	 * significant bits of the timeout value and assumes them being zero.
+	 * So make sure the latch is the best value with the two least
+	 * significant bits unset.
+	 */
+	tmr->latch = DIV_ROUND_CLOSEST(timer_freq,
+				       (IXP4XX_OST_RELOAD_MASK + 1) * HZ)
+		* (IXP4XX_OST_RELOAD_MASK + 1);
+
+	local_ixp4xx_timer = tmr;
+
+	/* Reset/disable counter */
+	__raw_writel(0, tmr->base + IXP4XX_OSRT1_OFFSET);
+
+	/* Clear any pending interrupt on timer 1 */
+	__raw_writel(IXP4XX_OSST_TIMER_1_PEND,
+		     tmr->base + IXP4XX_OSST_OFFSET);
+
+	/* Reset time-stamp counter */
+	__raw_writel(0, tmr->base + IXP4XX_OSTS_OFFSET);
+
+	clocksource_mmio_init(NULL, "OSTS", timer_freq, 200, 32,
+			      ixp4xx_clocksource_read);
+
+	tmr->clkevt.name = "ixp4xx timer1";
+	tmr->clkevt.features = CLOCK_EVT_FEAT_PERIODIC | CLOCK_EVT_FEAT_ONESHOT;
+	tmr->clkevt.rating = 200;
+	tmr->clkevt.set_state_shutdown = ixp4xx_shutdown;
+	tmr->clkevt.set_state_periodic = ixp4xx_set_periodic;
+	tmr->clkevt.set_state_oneshot = ixp4xx_set_oneshot;
+	tmr->clkevt.tick_resume = ixp4xx_resume;
+	tmr->clkevt.set_next_event = ixp4xx_set_next_event;
+	tmr->clkevt.cpumask = cpumask_of(0);
+	tmr->clkevt.irq = timer_irq;
+	ret = request_irq(timer_irq, ixp4xx_timer_interrupt,
+			  IRQF_TIMER, "IXP4XX-TIMER1", tmr);
+	if (ret) {
+		pr_crit("no timer IRQ\n");
+		return -ENODEV;
+	}
+	clockevents_config_and_register(&tmr->clkevt, timer_freq,
+					0xf, 0xfffffffe);
+
+#ifdef CONFIG_ARM
+	sched_clock_register(ixp4xx_read_sched_clock, 32, timer_freq);
+#endif
+
+	return 0;
+}
+
+/**
+ * ixp4xx_timer_setup() - Timer setup function to be called from boardfiles
+ * @timerbase: physical base of timer block
+ * @timer_irq: Linux IRQ number for the timer
+ * @timer_freq: Fixed frequency of the timer
+ */
+void __init ixp4xx_timer_setup(resource_size_t timerbase,
+			       int timer_irq,
+			       unsigned int timer_freq)
+{
+	void __iomem *base;
+
+	base = ioremap(timerbase, 0x100);
+	if (!base) {
+		pr_crit("IXP4xx: can't remap timer\n");
+		return;
+	}
+	ixp4xx_timer_register(base, timer_irq, timer_freq);
+}
+EXPORT_SYMBOL_GPL(ixp4xx_timer_setup);
diff --git a/include/linux/platform_data/timer-ixp4xx.h b/include/linux/platform_data/timer-ixp4xx.h
new file mode 100644
index 000000000000..ee92ae7edaed
--- /dev/null
+++ b/include/linux/platform_data/timer-ixp4xx.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __TIMER_IXP4XX_H
+#define __TIMER_IXP4XX_H
+
+#include <linux/ioport.h>
+
+void __init ixp4xx_timer_setup(resource_size_t timerbase,
+			       int timer_irq,
+			       unsigned int timer_freq);
+
+#endif
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
