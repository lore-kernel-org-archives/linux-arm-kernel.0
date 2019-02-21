Return-Path: <SRS0=b3e6=Q4=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A51C4360F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:42 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51CC1214AF
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 07:22:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="BcQFZeYy";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="otJq9ScE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51CC1214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nvidia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1vByFCZ88McgJTotVTLfAHyaeob2q40nvAnsivUCwRU=; b=BcQFZeYyKHFO9k
	esfrt6ETskXUG+RuQg9GmPocDL5F/2wvGk2oU8L6L6N3SWbv6rXkpMcIew/sc0fcrKBxervVLk1gP
	p4FC0zj3/C7BY0zyEnHFU12c7tEHzN4i26DfXql9X/FjGEV0ONYBgnwuwZUBqAmRVlF0J5gbFQ29T
	fDe7fdjdIsDK18+NAGpAsdWF70rlejaoHN2Vx6wsBA7ufT1GUNT2BvTKiJeIcBIEUsj8gN4m8O9EO
	7nqRzf92Y1VxmQ5YL8JR3rKJfacCq040zD3yGlKc/rWhmAwekpIN99lu0qmShAWOLzBjj/5JKy0oP
	/IAlJlZG4CGpGA8qVDfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gwigo-0006Pq-FC; Thu, 21 Feb 2019 07:22:38 +0000
Received: from hqemgate16.nvidia.com ([216.228.121.65])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gwigC-0005h0-BZ
 for linux-arm-kernel@lists.infradead.org; Thu, 21 Feb 2019 07:22:06 +0000
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by
 hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
 id <B5c6e519e0000>; Wed, 20 Feb 2019 23:22:06 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
 by hqpgpgate102.nvidia.com (PGP Universal service);
 Wed, 20 Feb 2019 23:22:00 -0800
X-PGP-Universal: processed;
 by hqpgpgate102.nvidia.com on Wed, 20 Feb 2019 23:22:00 -0800
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 21 Feb
 2019 07:21:59 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Thu, 21 Feb 2019 07:21:59 +0000
Received: from josephl-linux.nvidia.com (Not Verified[10.19.108.132]) by
 hqnvemgw01.nvidia.com with Trustwave SEG (v7, 5, 8, 10121)
 id <B5c6e51960000>; Wed, 20 Feb 2019 23:21:59 -0800
From: Joseph Lo <josephl@nvidia.com>
To: Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter
 <jonathanh@nvidia.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas
 Gleixner <tglx@linutronix.de>
Subject: [PATCH V7 2/8] clocksource: tegra: add Tegra210 timer support
Date: Thu, 21 Feb 2019 15:21:44 +0800
Message-ID: <20190221072150.4395-3-josephl@nvidia.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221072150.4395-1-josephl@nvidia.com>
References: <20190221072150.4395-1-josephl@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
 t=1550733726; bh=f454FOdTT2RaY4g8msOQEUfNf6jm2ACuW1jcHGmERsA=;
 h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
 In-Reply-To:References:MIME-Version:X-NVConfidentiality:
 Content-Transfer-Encoding:Content-Type;
 b=otJq9ScE2iRKkpoV13xtWIUZo0PHyYbRszcyTWh2qhFwLvHCH3rVHK3Okuatf57A2
 ZLcfrorVdJPN3zID02aaJvM2Czn+1h9laqBKTNSdVsCG2Ol3X4LDA/PUTu3SW5/z9r
 GVZfp1AHCIxlZvjb8Lc7PjqG/Er+LTKf1GNeCKp878gmptFYuNZocJQfzq4ycmQztU
 40vyg2eSG0Imyt+75/i9EInd08qyHEdNmBqNK4z2lhJxQgoza6Z16mU/99A8z3d8Zh
 RPwTfSJiH1onDJ0k9sBCnIOyrhPtrtUGvkSZJLUtxQUAoBhSnBbqvN2g9yaq1SW0WZ
 ZlDNLu3byZJew==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190220_232200_428242_79F23538 
X-CRM114-Status: GOOD (  20.54  )
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
Cc: linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Joseph Lo <josephl@nvidia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Add support for the Tegra210 timer that runs at oscillator clock
(TMR10-TMR13). We need these timers to work as clock event device and to
replace the ARMv8 architected timer due to it can't survive across the
power cycle of the CPU core or CPUPORESET signal. So it can't be a wake-up
source when CPU suspends in power down state.

Also convert the original driver to use timer-of API.

Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Joseph Lo <josephl@nvidia.com>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Jon Hunter <jonathanh@nvidia.com>
---
v7:
 * kconfig fix for 'depends on ARM || ARM64'
 * move suspend/resume to clkevt
 * refine the usage for the macro of TIMER_OF_DECLARE
v6:
 * refine the timer defines
 * add ack tag from Jon.
v5:
 * add ack tag from Thierry
v4:
 * merge timer-tegra210.c in previous version into timer-tegra20.c
v3:
 * use timer-of API
v2:
 * add error clean-up code
---
 drivers/clocksource/Kconfig         |   3 +-
 drivers/clocksource/timer-tegra20.c | 370 +++++++++++++++++++---------
 include/linux/cpuhotplug.h          |   1 +
 3 files changed, 262 insertions(+), 112 deletions(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 8dfd3bc448d0..5d93e580e5dc 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -131,7 +131,8 @@ config SUN5I_HSTIMER
 config TEGRA_TIMER
 	bool "Tegra timer driver" if COMPILE_TEST
 	select CLKSRC_MMIO
-	depends on ARM
+	select TIMER_OF
+	depends on ARM || ARM64
 	help
 	  Enables support for the Tegra driver.
 
diff --git a/drivers/clocksource/timer-tegra20.c b/drivers/clocksource/timer-tegra20.c
index 4293943f4e2b..fdb3d795a409 100644
--- a/drivers/clocksource/timer-tegra20.c
+++ b/drivers/clocksource/timer-tegra20.c
@@ -15,21 +15,24 @@
  *
  */
 
-#include <linux/init.h>
+#include <linux/clk.h>
+#include <linux/clockchips.h>
+#include <linux/cpu.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
 #include <linux/err.h>
-#include <linux/time.h>
 #include <linux/interrupt.h>
-#include <linux/irq.h>
-#include <linux/clockchips.h>
-#include <linux/clocksource.h>
-#include <linux/clk.h>
-#include <linux/io.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/percpu.h>
 #include <linux/sched_clock.h>
-#include <linux/delay.h>
+#include <linux/time.h>
+
+#include "timer-of.h"
 
+#ifdef CONFIG_ARM
 #include <asm/mach/time.h>
+#endif
 
 #define RTC_SECONDS            0x08
 #define RTC_SHADOW_SECONDS     0x0c
@@ -39,74 +42,161 @@
 #define TIMERUS_USEC_CFG 0x14
 #define TIMERUS_CNTR_FREEZE 0x4c
 
-#define TIMER1_BASE 0x0
-#define TIMER2_BASE 0x8
-#define TIMER3_BASE 0x50
-#define TIMER4_BASE 0x58
-
-#define TIMER_PTV 0x0
-#define TIMER_PCR 0x4
-
+#define TIMER_PTV		0x0
+#define TIMER_PTV_EN		BIT(31)
+#define TIMER_PTV_PER		BIT(30)
+#define TIMER_PCR		0x4
+#define TIMER_PCR_INTR_CLR	BIT(30)
+
+#ifdef CONFIG_ARM
+#define TIMER_CPU0		0x50 /* TIMER3 */
+#else
+#define TIMER_CPU0		0x90 /* TIMER10 */
+#define TIMER10_IRQ_IDX		10
+#define IRQ_IDX_FOR_CPU(cpu)	(TIMER10_IRQ_IDX + cpu)
+#endif
+#define TIMER_BASE_FOR_CPU(cpu) (TIMER_CPU0 + (cpu) * 8)
+
+static u32 usec_config;
 static void __iomem *timer_reg_base;
+#ifdef CONFIG_ARM
 static void __iomem *rtc_base;
-
 static struct timespec64 persistent_ts;
 static u64 persistent_ms, last_persistent_ms;
-
 static struct delay_timer tegra_delay_timer;
-
-#define timer_writel(value, reg) \
-	writel_relaxed(value, timer_reg_base + (reg))
-#define timer_readl(reg) \
-	readl_relaxed(timer_reg_base + (reg))
+#endif
 
 static int tegra_timer_set_next_event(unsigned long cycles,
 					 struct clock_event_device *evt)
 {
-	u32 reg;
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
 
-	reg = 0x80000000 | ((cycles > 1) ? (cycles-1) : 0);
-	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
+	writel(TIMER_PTV_EN |
+	       ((cycles > 1) ? (cycles - 1) : 0), /* n+1 scheme */
+	       reg_base + TIMER_PTV);
 
 	return 0;
 }
 
-static inline void timer_shutdown(struct clock_event_device *evt)
+static int tegra_timer_shutdown(struct clock_event_device *evt)
 {
-	timer_writel(0, TIMER3_BASE + TIMER_PTV);
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(0, reg_base + TIMER_PTV);
+
+	return 0;
 }
 
-static int tegra_timer_shutdown(struct clock_event_device *evt)
+static int tegra_timer_set_periodic(struct clock_event_device *evt)
 {
-	timer_shutdown(evt);
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PTV_EN | TIMER_PTV_PER |
+	       ((timer_of_rate(to_timer_of(evt)) / HZ) - 1),
+	       reg_base + TIMER_PTV);
+
 	return 0;
 }
 
-static int tegra_timer_set_periodic(struct clock_event_device *evt)
+static irqreturn_t tegra_timer_isr(int irq, void *dev_id)
+{
+	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+	evt->event_handler(evt);
+
+	return IRQ_HANDLED;
+}
+
+static void tegra_timer_suspend(struct clock_event_device *evt)
+{
+	void __iomem *reg_base = timer_of_base(to_timer_of(evt));
+
+	writel(TIMER_PCR_INTR_CLR, reg_base + TIMER_PCR);
+}
+
+static void tegra_timer_resume(struct clock_event_device *evt)
+{
+	writel(usec_config, timer_reg_base + TIMERUS_USEC_CFG);
+}
+
+#ifdef CONFIG_ARM64
+static DEFINE_PER_CPU(struct timer_of, tegra_to) = {
+	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE,
+
+	.clkevt = {
+		.name = "tegra_timer",
+		.rating = 460,
+		.features = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_PERIODIC,
+		.set_next_event = tegra_timer_set_next_event,
+		.set_state_shutdown = tegra_timer_shutdown,
+		.set_state_periodic = tegra_timer_set_periodic,
+		.set_state_oneshot = tegra_timer_shutdown,
+		.tick_resume = tegra_timer_shutdown,
+		.suspend = tegra_timer_suspend,
+		.resume = tegra_timer_resume,
+	},
+};
+
+static int tegra_timer_setup(unsigned int cpu)
 {
-	u32 reg = 0xC0000000 | ((1000000 / HZ) - 1);
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	irq_force_affinity(to->clkevt.irq, cpumask_of(cpu));
+	enable_irq(to->clkevt.irq);
+
+	clockevents_config_and_register(&to->clkevt, timer_of_rate(to),
+					1, /* min */
+					0x1fffffff); /* 29 bits */
 
-	timer_shutdown(evt);
-	timer_writel(reg, TIMER3_BASE + TIMER_PTV);
 	return 0;
 }
 
-static struct clock_event_device tegra_clockevent = {
-	.name			= "timer0",
-	.rating			= 300,
-	.features		= CLOCK_EVT_FEAT_ONESHOT |
-				  CLOCK_EVT_FEAT_PERIODIC |
-				  CLOCK_EVT_FEAT_DYNIRQ,
-	.set_next_event		= tegra_timer_set_next_event,
-	.set_state_shutdown	= tegra_timer_shutdown,
-	.set_state_periodic	= tegra_timer_set_periodic,
-	.set_state_oneshot	= tegra_timer_shutdown,
-	.tick_resume		= tegra_timer_shutdown,
+static int tegra_timer_stop(unsigned int cpu)
+{
+	struct timer_of *to = per_cpu_ptr(&tegra_to, cpu);
+
+	to->clkevt.set_state_shutdown(&to->clkevt);
+	disable_irq_nosync(to->clkevt.irq);
+
+	return 0;
+}
+#else /* CONFIG_ARM */
+static struct timer_of tegra_to = {
+	.flags = TIMER_OF_CLOCK | TIMER_OF_BASE | TIMER_OF_IRQ,
+
+	.clkevt = {
+		.name = "tegra_timer",
+		.rating	= 300,
+		.features = CLOCK_EVT_FEAT_ONESHOT |
+			    CLOCK_EVT_FEAT_PERIODIC |
+			    CLOCK_EVT_FEAT_DYNIRQ,
+		.set_next_event	= tegra_timer_set_next_event,
+		.set_state_shutdown = tegra_timer_shutdown,
+		.set_state_periodic = tegra_timer_set_periodic,
+		.set_state_oneshot = tegra_timer_shutdown,
+		.tick_resume = tegra_timer_shutdown,
+		.suspend = tegra_timer_suspend,
+		.resume = tegra_timer_resume,
+		.cpumask = cpu_possible_mask,
+	},
+
+	.of_irq = {
+		.index = 2,
+		.flags = IRQF_TIMER | IRQF_TRIGGER_HIGH,
+		.handler = tegra_timer_isr,
+	},
 };
 
 static u64 notrace tegra_read_sched_clock(void)
 {
-	return timer_readl(TIMERUS_CNTR_1US);
+	return readl(timer_reg_base + TIMERUS_CNTR_1US);
+}
+
+static unsigned long tegra_delay_timer_read_counter_long(void)
+{
+	return readl(timer_reg_base + TIMERUS_CNTR_1US);
 }
 
 /*
@@ -143,100 +233,155 @@ static void tegra_read_persistent_clock64(struct timespec64 *ts)
 	timespec64_add_ns(&persistent_ts, delta * NSEC_PER_MSEC);
 	*ts = persistent_ts;
 }
+#endif
 
-static unsigned long tegra_delay_timer_read_counter_long(void)
-{
-	return readl(timer_reg_base + TIMERUS_CNTR_1US);
-}
-
-static irqreturn_t tegra_timer_interrupt(int irq, void *dev_id)
-{
-	struct clock_event_device *evt = (struct clock_event_device *)dev_id;
-	timer_writel(1<<30, TIMER3_BASE + TIMER_PCR);
-	evt->event_handler(evt);
-	return IRQ_HANDLED;
-}
-
-static struct irqaction tegra_timer_irq = {
-	.name		= "timer0",
-	.flags		= IRQF_TIMER | IRQF_TRIGGER_HIGH,
-	.handler	= tegra_timer_interrupt,
-	.dev_id		= &tegra_clockevent,
-};
-
-static int __init tegra20_init_timer(struct device_node *np)
+static int tegra_timer_common_init(struct device_node *np, struct timer_of *to)
 {
-	struct clk *clk;
-	unsigned long rate;
-	int ret;
-
-	timer_reg_base = of_iomap(np, 0);
-	if (!timer_reg_base) {
-		pr_err("Can't map timer registers\n");
-		return -ENXIO;
-	}
+	int ret = 0;
 
-	tegra_timer_irq.irq = irq_of_parse_and_map(np, 2);
-	if (tegra_timer_irq.irq <= 0) {
-		pr_err("Failed to map timer IRQ\n");
-		return -EINVAL;
-	}
+	ret = timer_of_init(np, to);
+	if (ret < 0)
+		goto out;
 
-	clk = of_clk_get(np, 0);
-	if (IS_ERR(clk)) {
-		pr_warn("Unable to get timer clock. Assuming 12Mhz input clock.\n");
-		rate = 12000000;
-	} else {
-		clk_prepare_enable(clk);
-		rate = clk_get_rate(clk);
-	}
+	timer_reg_base = timer_of_base(to);
 
-	switch (rate) {
+	/*
+	 * Configure microsecond timers to have 1MHz clock
+	 * Config register is 0xqqww, where qq is "dividend", ww is "divisor"
+	 * Uses n+1 scheme
+	 */
+	switch (timer_of_rate(to)) {
 	case 12000000:
-		timer_writel(0x000b, TIMERUS_USEC_CFG);
+		usec_config = 0x000b; /* (11+1)/(0+1) */
+		break;
+	case 12800000:
+		usec_config = 0x043f; /* (63+1)/(4+1) */
 		break;
 	case 13000000:
-		timer_writel(0x000c, TIMERUS_USEC_CFG);
+		usec_config = 0x000c; /* (12+1)/(0+1) */
+		break;
+	case 16800000:
+		usec_config = 0x0453; /* (83+1)/(4+1) */
 		break;
 	case 19200000:
-		timer_writel(0x045f, TIMERUS_USEC_CFG);
+		usec_config = 0x045f; /* (95+1)/(4+1) */
 		break;
 	case 26000000:
-		timer_writel(0x0019, TIMERUS_USEC_CFG);
+		usec_config = 0x0019; /* (25+1)/(0+1) */
+		break;
+	case 38400000:
+		usec_config = 0x04bf; /* (191+1)/(4+1) */
+		break;
+	case 48000000:
+		usec_config = 0x002f; /* (47+1)/(0+1) */
 		break;
 	default:
-		WARN(1, "Unknown clock rate");
+		ret = -EINVAL;
+		goto out;
+	}
+
+	writel(usec_config, timer_of_base(to) + TIMERUS_USEC_CFG);
+
+out:
+	return ret;
+}
+
+#ifdef CONFIG_ARM64
+static int __init tegra_init_timer(struct device_node *np)
+{
+	int cpu, ret = 0;
+	struct timer_of *to;
+
+	to = this_cpu_ptr(&tegra_to);
+	ret = tegra_timer_common_init(np, to);
+	if (ret < 0)
+		goto out;
+
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		cpu_to->of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(cpu);
+		cpu_to->of_clk.rate = timer_of_rate(to);
+		cpu_to->clkevt.cpumask = cpumask_of(cpu);
+		cpu_to->clkevt.irq =
+			irq_of_parse_and_map(np, IRQ_IDX_FOR_CPU(cpu));
+		if (!cpu_to->clkevt.irq) {
+			pr_err("%s: can't map IRQ for CPU%d\n",
+			       __func__, cpu);
+			ret = -EINVAL;
+			goto out;
+		}
+
+		irq_set_status_flags(cpu_to->clkevt.irq, IRQ_NOAUTOEN);
+		ret = request_irq(cpu_to->clkevt.irq, tegra_timer_isr,
+				  IRQF_TIMER | IRQF_NOBALANCING,
+				  cpu_to->clkevt.name, &cpu_to->clkevt);
+		if (ret) {
+			pr_err("%s: cannot setup irq %d for CPU%d\n",
+				__func__, cpu_to->clkevt.irq, cpu);
+			ret = -EINVAL;
+			goto out_irq;
+		}
+	}
+
+	cpuhp_setup_state(CPUHP_AP_TEGRA_TIMER_STARTING,
+			  "AP_TEGRA_TIMER_STARTING", tegra_timer_setup,
+			  tegra_timer_stop);
+
+	return ret;
+out_irq:
+	for_each_possible_cpu(cpu) {
+		struct timer_of *cpu_to;
+
+		cpu_to = per_cpu_ptr(&tegra_to, cpu);
+		if (cpu_to->clkevt.irq) {
+			free_irq(cpu_to->clkevt.irq, &cpu_to->clkevt);
+			irq_dispose_mapping(cpu_to->clkevt.irq);
+		}
 	}
+out:
+	timer_of_cleanup(to);
+	return ret;
+}
+#else /* CONFIG_ARM */
+static int __init tegra_init_timer(struct device_node *np)
+{
+	int ret = 0;
+
+	ret = tegra_timer_common_init(np, &tegra_to);
+	if (ret < 0)
+		goto out;
 
-	sched_clock_register(tegra_read_sched_clock, 32, 1000000);
+	tegra_to.of_base.base = timer_reg_base + TIMER_BASE_FOR_CPU(0);
+	tegra_to.of_clk.rate = 1000000; /* microsecond timer */
 
+	sched_clock_register(tegra_read_sched_clock, 32,
+			     timer_of_rate(&tegra_to));
 	ret = clocksource_mmio_init(timer_reg_base + TIMERUS_CNTR_1US,
-				    "timer_us", 1000000, 300, 32,
-				    clocksource_mmio_readl_up);
+				    "timer_us", timer_of_rate(&tegra_to),
+				    300, 32, clocksource_mmio_readl_up);
 	if (ret) {
 		pr_err("Failed to register clocksource\n");
-		return ret;
+		goto out;
 	}
 
 	tegra_delay_timer.read_current_timer =
 			tegra_delay_timer_read_counter_long;
-	tegra_delay_timer.freq = 1000000;
+	tegra_delay_timer.freq = timer_of_rate(&tegra_to);
 	register_current_timer_delay(&tegra_delay_timer);
 
-	ret = setup_irq(tegra_timer_irq.irq, &tegra_timer_irq);
-	if (ret) {
-		pr_err("Failed to register timer IRQ: %d\n", ret);
-		return ret;
-	}
+	clockevents_config_and_register(&tegra_to.clkevt,
+					timer_of_rate(&tegra_to),
+					0x1,
+					0x1fffffff);
 
-	tegra_clockevent.cpumask = cpu_possible_mask;
-	tegra_clockevent.irq = tegra_timer_irq.irq;
-	clockevents_config_and_register(&tegra_clockevent, 1000000,
-					0x1, 0x1fffffff);
+	return ret;
+out:
+	timer_of_cleanup(&tegra_to);
 
-	return 0;
+	return ret;
 }
-TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra20_init_timer);
 
 static int __init tegra20_init_rtc(struct device_node *np)
 {
@@ -261,3 +406,6 @@ static int __init tegra20_init_rtc(struct device_node *np)
 	return register_persistent_clock(tegra_read_persistent_clock64);
 }
 TIMER_OF_DECLARE(tegra20_rtc, "nvidia,tegra20-rtc", tegra20_init_rtc);
+#endif
+TIMER_OF_DECLARE(tegra210_timer, "nvidia,tegra210-timer", tegra_init_timer);
+TIMER_OF_DECLARE(tegra20_timer, "nvidia,tegra20-timer", tegra_init_timer);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index fd586d0301e7..e78281d07b70 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -121,6 +121,7 @@ enum cpuhp_state {
 	CPUHP_AP_EXYNOS4_MCT_TIMER_STARTING,
 	CPUHP_AP_ARM_TWD_STARTING,
 	CPUHP_AP_QCOM_TIMER_STARTING,
+	CPUHP_AP_TEGRA_TIMER_STARTING,
 	CPUHP_AP_ARMADA_TIMER_STARTING,
 	CPUHP_AP_MARCO_TIMER_STARTING,
 	CPUHP_AP_MIPS_GIC_TIMER_STARTING,
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
