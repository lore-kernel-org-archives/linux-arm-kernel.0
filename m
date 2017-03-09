From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Thu,  9 Mar 2017 10:47:10 +0100
Subject: [PATCH] clocksource: add missing line break to error messages
Message-ID: <20170309094710.31003-1-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rafa? Mi?ecki <rafal@milecki.pl>

Printing with pr_* functions requires adding line break manually.

Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
---
Hi,

I think this change is so trivial it's not worth splitting per single
driver. Are you OK with that?
---
 drivers/clocksource/arc_timer.c           | 14 +++++++-------
 drivers/clocksource/arm_arch_timer.c      |  2 +-
 drivers/clocksource/asm9260_timer.c       |  2 +-
 drivers/clocksource/bcm2835_timer.c       |  6 +++---
 drivers/clocksource/bcm_kona_timer.c      |  2 +-
 drivers/clocksource/clksrc-probe.c        |  2 +-
 drivers/clocksource/dw_apb_timer.c        |  2 +-
 drivers/clocksource/meson6_timer.c        |  4 ++--
 drivers/clocksource/mips-gic-timer.c      |  2 +-
 drivers/clocksource/nomadik-mtu.c         |  8 ++++----
 drivers/clocksource/pxa_timer.c           |  6 +++---
 drivers/clocksource/samsung_pwm_timer.c   |  6 +++---
 drivers/clocksource/sun4i_timer.c         | 10 +++++-----
 drivers/clocksource/tegra20_timer.c       |  2 +-
 drivers/clocksource/time-armada-370-xp.c  | 16 ++++++++--------
 drivers/clocksource/time-efm32.c          |  2 +-
 drivers/clocksource/time-orion.c          |  4 ++--
 drivers/clocksource/timer-atmel-pit.c     |  2 +-
 drivers/clocksource/timer-digicolor.c     |  6 +++---
 drivers/clocksource/timer-integrator-ap.c |  4 ++--
 drivers/clocksource/timer-nps.c           |  6 +++---
 drivers/clocksource/timer-prima2.c        | 10 +++++-----
 drivers/clocksource/timer-sp804.c         |  4 ++--
 drivers/clocksource/timer-sun5i.c         |  6 +++---
 drivers/clocksource/vf_pit_timer.c        |  2 +-
 25 files changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/clocksource/arc_timer.c b/drivers/clocksource/arc_timer.c
index 7517f959cba7..21649733827d 100644
--- a/drivers/clocksource/arc_timer.c
+++ b/drivers/clocksource/arc_timer.c
@@ -37,7 +37,7 @@ static int noinline arc_get_timer_clk(struct device_node *node)
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_err("timer missing clk");
+		pr_err("timer missing clk\n");
 		return PTR_ERR(clk);
 	}
 
@@ -89,7 +89,7 @@ static int __init arc_cs_setup_gfrc(struct device_node *node)
 
 	READ_BCR(ARC_REG_MCIP_BCR, mp);
 	if (!mp.gfrc) {
-		pr_warn("Global-64-bit-Ctr clocksource not detected");
+		pr_warn("Global-64-bit-Ctr clocksource not detected\n");
 		return -ENXIO;
 	}
 
@@ -140,13 +140,13 @@ static int __init arc_cs_setup_rtc(struct device_node *node)
 
 	READ_BCR(ARC_REG_TIMERS_BCR, timer);
 	if (!timer.rtc) {
-		pr_warn("Local-64-bit-Ctr clocksource not detected");
+		pr_warn("Local-64-bit-Ctr clocksource not detected\n");
 		return -ENXIO;
 	}
 
 	/* Local to CPU hence not usable in SMP */
 	if (IS_ENABLED(CONFIG_SMP)) {
-		pr_warn("Local-64-bit-Ctr not usable in SMP");
+		pr_warn("Local-64-bit-Ctr not usable in SMP\n");
 		return -EINVAL;
 	}
 
@@ -290,13 +290,13 @@ static int __init arc_clockevent_setup(struct device_node *node)
 
 	arc_timer_irq = irq_of_parse_and_map(node, 0);
 	if (arc_timer_irq <= 0) {
-		pr_err("clockevent: missing irq");
+		pr_err("clockevent: missing irq\n");
 		return -EINVAL;
 	}
 
 	ret = arc_get_timer_clk(node);
 	if (ret) {
-		pr_err("clockevent: missing clk");
+		pr_err("clockevent: missing clk\n");
 		return ret;
 	}
 
@@ -313,7 +313,7 @@ static int __init arc_clockevent_setup(struct device_node *node)
 				arc_timer_starting_cpu,
 				arc_timer_dying_cpu);
 	if (ret) {
-		pr_err("Failed to setup hotplug state");
+		pr_err("Failed to setup hotplug state\n");
 		return ret;
 	}
 	return 0;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 7a8a4117f123..56c3e25f4e1a 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -1055,7 +1055,7 @@ static int __init arch_timer_mem_init(struct device_node *np)
 
 	ret = -EINVAL;
 	if (!irq) {
-		pr_err("arch_timer: Frame missing %s irq",
+		pr_err("arch_timer: Frame missing %s irq\n",
 		       arch_timer_mem_use_virtual ? "virt" : "phys");
 		goto out;
 	}
diff --git a/drivers/clocksource/asm9260_timer.c b/drivers/clocksource/asm9260_timer.c
index 1ba871b7fe11..c6780830b8ac 100644
--- a/drivers/clocksource/asm9260_timer.c
+++ b/drivers/clocksource/asm9260_timer.c
@@ -193,7 +193,7 @@ static int __init asm9260_timer_init(struct device_node *np)
 
 	priv.base = of_io_request_and_map(np, 0, np->name);
 	if (IS_ERR(priv.base)) {
-		pr_err("%s: unable to map resource", np->name);
+		pr_err("%s: unable to map resource\n", np->name);
 		return PTR_ERR(priv.base);
 	}
 
diff --git a/drivers/clocksource/bcm2835_timer.c b/drivers/clocksource/bcm2835_timer.c
index f2f29d2be1cf..dce44307469e 100644
--- a/drivers/clocksource/bcm2835_timer.c
+++ b/drivers/clocksource/bcm2835_timer.c
@@ -89,13 +89,13 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	base = of_iomap(node, 0);
 	if (!base) {
-		pr_err("Can't remap registers");
+		pr_err("Can't remap registers\n");
 		return -ENXIO;
 	}
 
 	ret = of_property_read_u32(node, "clock-frequency", &freq);
 	if (ret) {
-		pr_err("Can't read clock-frequency");
+		pr_err("Can't read clock-frequency\n");
 		goto err_iounmap;
 	}
 
@@ -107,7 +107,7 @@ static int __init bcm2835_timer_init(struct device_node *node)
 
 	irq = irq_of_parse_and_map(node, DEFAULT_TIMER);
 	if (irq <= 0) {
-		pr_err("Can't parse IRQ");
+		pr_err("Can't parse IRQ\n");
 		ret = -EINVAL;
 		goto err_iounmap;
 	}
diff --git a/drivers/clocksource/bcm_kona_timer.c b/drivers/clocksource/bcm_kona_timer.c
index 92f6e4deee74..fda5e1476638 100644
--- a/drivers/clocksource/bcm_kona_timer.c
+++ b/drivers/clocksource/bcm_kona_timer.c
@@ -179,7 +179,7 @@ static int __init kona_timer_init(struct device_node *node)
 	} else if (!of_property_read_u32(node, "clock-frequency", &freq)) {
 		arch_timer_rate = freq;
 	} else {
-		pr_err("Kona Timer v1 unable to determine clock-frequency");
+		pr_err("Kona Timer v1 unable to determine clock-frequency\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/clocksource/clksrc-probe.c b/drivers/clocksource/clksrc-probe.c
index bc62be97f0a8..ac701ffb8d59 100644
--- a/drivers/clocksource/clksrc-probe.c
+++ b/drivers/clocksource/clksrc-probe.c
@@ -40,7 +40,7 @@ void __init clocksource_probe(void)
 
 		ret = init_func_ret(np);
 		if (ret) {
-			pr_err("Failed to initialize '%s': %d",
+			pr_err("Failed to initialize '%s': %d\n",
 			       of_node_full_name(np), ret);
 			continue;
 		}
diff --git a/drivers/clocksource/dw_apb_timer.c b/drivers/clocksource/dw_apb_timer.c
index 63e4f5519577..9e937e23b63e 100644
--- a/drivers/clocksource/dw_apb_timer.c
+++ b/drivers/clocksource/dw_apb_timer.c
@@ -101,7 +101,7 @@ static irqreturn_t dw_apb_clockevent_irq(int irq, void *data)
 	struct dw_apb_clock_event_device *dw_ced = ced_to_dw_apb_ced(evt);
 
 	if (!evt->event_handler) {
-		pr_info("Spurious APBT timer interrupt %d", irq);
+		pr_info("Spurious APBT timer interrupt %d\n", irq);
 		return IRQ_NONE;
 	}
 
diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 52af591a9fc7..39d21f693a33 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -133,13 +133,13 @@ static int __init meson6_timer_init(struct device_node *node)
 
 	timer_base = of_io_request_and_map(node, 0, "meson6-timer");
 	if (IS_ERR(timer_base)) {
-		pr_err("Can't map registers");
+		pr_err("Can't map registers\n");
 		return -ENXIO;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
-		pr_err("Can't parse IRQ");
+		pr_err("Can't parse IRQ\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index d9ef7a61e093..b6ad9c0a7c55 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -174,7 +174,7 @@ static int __init gic_clocksource_of_init(struct device_node *node)
 
 	if (!gic_present || !node->parent ||
 	    !of_device_is_compatible(node->parent, "mti,gic")) {
-		pr_warn("No DT definition for the mips gic driver");
+		pr_warn("No DT definition for the mips gic driver\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/clocksource/nomadik-mtu.c b/drivers/clocksource/nomadik-mtu.c
index 3c124d1ca600..7d44de304f37 100644
--- a/drivers/clocksource/nomadik-mtu.c
+++ b/drivers/clocksource/nomadik-mtu.c
@@ -260,25 +260,25 @@ static int __init nmdk_timer_of_init(struct device_node *node)
 
 	base = of_iomap(node, 0);
 	if (!base) {
-		pr_err("Can't remap registers");
+		pr_err("Can't remap registers\n");
 		return -ENXIO;
 	}
 
 	pclk = of_clk_get_by_name(node, "apb_pclk");
 	if (IS_ERR(pclk)) {
-		pr_err("could not get apb_pclk");
+		pr_err("could not get apb_pclk\n");
 		return PTR_ERR(pclk);
 	}
 
 	clk = of_clk_get_by_name(node, "timclk");
 	if (IS_ERR(clk)) {
-		pr_err("could not get timclk");
+		pr_err("could not get timclk\n");
 		return PTR_ERR(clk);
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
-		pr_err("Can't parse IRQ");
+		pr_err("Can't parse IRQ\n");
 		return -EINVAL;
 	}
 
diff --git a/drivers/clocksource/pxa_timer.c b/drivers/clocksource/pxa_timer.c
index 1c24de215c14..a10fa667325f 100644
--- a/drivers/clocksource/pxa_timer.c
+++ b/drivers/clocksource/pxa_timer.c
@@ -166,14 +166,14 @@ static int __init pxa_timer_common_init(int irq, unsigned long clock_tick_rate)
 
 	ret = setup_irq(irq, &pxa_ost0_irq);
 	if (ret) {
-		pr_err("Failed to setup irq");
+		pr_err("Failed to setup irq\n");
 		return ret;
 	}
 
 	ret = clocksource_mmio_init(timer_base + OSCR, "oscr0", clock_tick_rate, 200,
 				    32, clocksource_mmio_readl_up);
 	if (ret) {
-		pr_err("Failed to init clocksource");
+		pr_err("Failed to init clocksource\n");
 		return ret;
 	}
 
@@ -203,7 +203,7 @@ static int __init pxa_timer_dt_init(struct device_node *np)
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_crit("Failed to prepare clock");
+		pr_crit("Failed to prepare clock\n");
 		return ret;
 	}
 
diff --git a/drivers/clocksource/samsung_pwm_timer.c b/drivers/clocksource/samsung_pwm_timer.c
index 0093ece661fe..a68e6538c809 100644
--- a/drivers/clocksource/samsung_pwm_timer.c
+++ b/drivers/clocksource/samsung_pwm_timer.c
@@ -385,7 +385,7 @@ static int __init _samsung_pwm_clocksource_init(void)
 	mask = ~pwm.variant.output_mask & ((1 << SAMSUNG_PWM_NUM) - 1);
 	channel = fls(mask) - 1;
 	if (channel < 0) {
-		pr_crit("failed to find PWM channel for clocksource");
+		pr_crit("failed to find PWM channel for clocksource\n");
 		return -EINVAL;
 	}
 	pwm.source_id = channel;
@@ -393,7 +393,7 @@ static int __init _samsung_pwm_clocksource_init(void)
 	mask &= ~(1 << channel);
 	channel = fls(mask) - 1;
 	if (channel < 0) {
-		pr_crit("failed to find PWM channel for clock event");
+		pr_crit("failed to find PWM channel for clock event\n");
 		return -EINVAL;
 	}
 	pwm.event_id = channel;
@@ -448,7 +448,7 @@ static int __init samsung_pwm_alloc(struct device_node *np,
 
 	pwm.timerclk = of_clk_get_by_name(np, "timers");
 	if (IS_ERR(pwm.timerclk)) {
-		pr_crit("failed to get timers clock for timer");
+		pr_crit("failed to get timers clock for timer\n");
 		return PTR_ERR(pwm.timerclk);
 	}
 
diff --git a/drivers/clocksource/sun4i_timer.c b/drivers/clocksource/sun4i_timer.c
index c83452cacb41..4452d5c8f304 100644
--- a/drivers/clocksource/sun4i_timer.c
+++ b/drivers/clocksource/sun4i_timer.c
@@ -159,25 +159,25 @@ static int __init sun4i_timer_init(struct device_node *node)
 
 	timer_base = of_iomap(node, 0);
 	if (!timer_base) {
-		pr_crit("Can't map registers");
+		pr_crit("Can't map registers\n");
 		return -ENXIO;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
-		pr_crit("Can't parse IRQ");
+		pr_crit("Can't parse IRQ\n");
 		return -EINVAL;
 	}
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_crit("Can't get timer clock");
+		pr_crit("Can't get timer clock\n");
 		return PTR_ERR(clk);
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_err("Failed to prepare clock");
+		pr_err("Failed to prepare clock\n");
 		return ret;
 	}
 
@@ -200,7 +200,7 @@ static int __init sun4i_timer_init(struct device_node *node)
 	ret = clocksource_mmio_init(timer_base + TIMER_CNTVAL_REG(1), node->name,
 				    rate, 350, 32, clocksource_mmio_readl_down);
 	if (ret) {
-		pr_err("Failed to register clocksource");
+		pr_err("Failed to register clocksource\n");
 		return ret;
 	}
 
diff --git a/drivers/clocksource/tegra20_timer.c b/drivers/clocksource/tegra20_timer.c
index f960891aa04e..b9990b9c98c5 100644
--- a/drivers/clocksource/tegra20_timer.c
+++ b/drivers/clocksource/tegra20_timer.c
@@ -245,7 +245,7 @@ static int __init tegra20_init_rtc(struct device_node *np)
 
 	rtc_base = of_iomap(np, 0);
 	if (!rtc_base) {
-		pr_err("Can't map RTC registers");
+		pr_err("Can't map RTC registers\n");
 		return -ENXIO;
 	}
 
diff --git a/drivers/clocksource/time-armada-370-xp.c b/drivers/clocksource/time-armada-370-xp.c
index 4440aefc59cd..aea4380129ea 100644
--- a/drivers/clocksource/time-armada-370-xp.c
+++ b/drivers/clocksource/time-armada-370-xp.c
@@ -247,13 +247,13 @@ static int __init armada_370_xp_timer_common_init(struct device_node *np)
 
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("Failed to iomap");
+		pr_err("Failed to iomap\n");
 		return -ENXIO;
 	}
 
 	local_base = of_iomap(np, 1);
 	if (!local_base) {
-		pr_err("Failed to iomap");
+		pr_err("Failed to iomap\n");
 		return -ENXIO;
 	}
 
@@ -298,7 +298,7 @@ static int __init armada_370_xp_timer_common_init(struct device_node *np)
 				    "armada_370_xp_clocksource",
 				    timer_clk, 300, 32, clocksource_mmio_readl_down);
 	if (res) {
-		pr_err("Failed to initialize clocksource mmio");
+		pr_err("Failed to initialize clocksource mmio\n");
 		return res;
 	}
 
@@ -315,7 +315,7 @@ static int __init armada_370_xp_timer_common_init(struct device_node *np)
 				armada_370_xp_evt);
 	/* Immediately configure the timer on the boot CPU */
 	if (res) {
-		pr_err("Failed to request percpu irq");
+		pr_err("Failed to request percpu irq\n");
 		return res;
 	}
 
@@ -324,7 +324,7 @@ static int __init armada_370_xp_timer_common_init(struct device_node *np)
 				armada_370_xp_timer_starting_cpu,
 				armada_370_xp_timer_dying_cpu);
 	if (res) {
-		pr_err("Failed to setup hotplug state and timer");
+		pr_err("Failed to setup hotplug state and timer\n");
 		return res;
 	}
 
@@ -339,7 +339,7 @@ static int __init armada_xp_timer_init(struct device_node *np)
 	int ret;
 
 	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock");
+		pr_err("Failed to get clock\n");
 		return PTR_ERR(clk);
 	}
 
@@ -375,7 +375,7 @@ static int __init armada_375_timer_init(struct device_node *np)
 
 		/* Must have at least a clock */
 		if (IS_ERR(clk)) {
-			pr_err("Failed to get clock");
+			pr_err("Failed to get clock\n");
 			return PTR_ERR(clk);
 		}
 
@@ -399,7 +399,7 @@ static int __init armada_370_timer_init(struct device_node *np)
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock");
+		pr_err("Failed to get clock\n");
 		return PTR_ERR(clk);
 	}
 
diff --git a/drivers/clocksource/time-efm32.c b/drivers/clocksource/time-efm32.c
index 5ac344b383e1..ce0f97b4e5db 100644
--- a/drivers/clocksource/time-efm32.c
+++ b/drivers/clocksource/time-efm32.c
@@ -235,7 +235,7 @@ static int __init efm32_clockevent_init(struct device_node *np)
 
 	ret = setup_irq(irq, &efm32_clock_event_irq);
 	if (ret) {
-		pr_err("Failed setup irq");
+		pr_err("Failed setup irq\n");
 		goto err_setup_irq;
 	}
 
diff --git a/drivers/clocksource/time-orion.c b/drivers/clocksource/time-orion.c
index a28f496e97cf..b23b34239eb4 100644
--- a/drivers/clocksource/time-orion.c
+++ b/drivers/clocksource/time-orion.c
@@ -124,7 +124,7 @@ static int __init orion_timer_init(struct device_node *np)
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_err("Failed to prepare clock");
+		pr_err("Failed to prepare clock\n");
 		return ret;
 	}
 
@@ -146,7 +146,7 @@ static int __init orion_timer_init(struct device_node *np)
 				    clk_get_rate(clk), 300, 32,
 				    clocksource_mmio_readl_down);
 	if (ret) {
-		pr_err("Failed to initialize mmio timer");
+		pr_err("Failed to initialize mmio timer\n");
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-atmel-pit.c b/drivers/clocksource/timer-atmel-pit.c
index c0b5df3167a0..cc112351dc70 100644
--- a/drivers/clocksource/timer-atmel-pit.c
+++ b/drivers/clocksource/timer-atmel-pit.c
@@ -226,7 +226,7 @@ static int __init at91sam926x_pit_dt_init(struct device_node *node)
 	
 	ret = clocksource_register_hz(&data->clksrc, pit_rate);
 	if (ret) {
-		pr_err("Failed to register clocksource");
+		pr_err("Failed to register clocksource\n");
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-digicolor.c b/drivers/clocksource/timer-digicolor.c
index e9f50d289362..94a161eb9cce 100644
--- a/drivers/clocksource/timer-digicolor.c
+++ b/drivers/clocksource/timer-digicolor.c
@@ -161,19 +161,19 @@ static int __init digicolor_timer_init(struct device_node *node)
 	 */
 	dc_timer_dev.base = of_iomap(node, 0);
 	if (!dc_timer_dev.base) {
-		pr_err("Can't map registers");
+		pr_err("Can't map registers\n");
 		return -ENXIO;
 	}
 
 	irq = irq_of_parse_and_map(node, dc_timer_dev.timer_id);
 	if (irq <= 0) {
-		pr_err("Can't parse IRQ");
+		pr_err("Can't parse IRQ\n");
 		return -EINVAL;
 	}
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Can't get timer clock");
+		pr_err("Can't get timer clock\n");
 		return PTR_ERR(clk);
 	}
 	clk_prepare_enable(clk);
diff --git a/drivers/clocksource/timer-integrator-ap.c b/drivers/clocksource/timer-integrator-ap.c
index df6e672afc04..04ad3066e190 100644
--- a/drivers/clocksource/timer-integrator-ap.c
+++ b/drivers/clocksource/timer-integrator-ap.c
@@ -200,7 +200,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 	err = of_property_read_string(of_aliases,
 				"arm,timer-primary", &path);
 	if (err) {
-		pr_warn("Failed to read property");
+		pr_warn("Failed to read property\n");
 		return err;
 	}
 
@@ -209,7 +209,7 @@ static int __init integrator_ap_timer_init_of(struct device_node *node)
 	err = of_property_read_string(of_aliases,
 				"arm,timer-secondary", &path);
 	if (err) {
-		pr_warn("Failed to read property");		
+		pr_warn("Failed to read property\n");
 		return err;
 	}
 
diff --git a/drivers/clocksource/timer-nps.c b/drivers/clocksource/timer-nps.c
index da1f7986e477..e74ea1722ad3 100644
--- a/drivers/clocksource/timer-nps.c
+++ b/drivers/clocksource/timer-nps.c
@@ -55,7 +55,7 @@ static int __init nps_get_timer_clk(struct device_node *node,
 	*clk = of_clk_get(node, 0);
 	ret = PTR_ERR_OR_ZERO(*clk);
 	if (ret) {
-		pr_err("timer missing clk");
+		pr_err("timer missing clk\n");
 		return ret;
 	}
 
@@ -247,7 +247,7 @@ static int __init nps_setup_clockevent(struct device_node *node)
 
 	nps_timer0_irq = irq_of_parse_and_map(node, 0);
 	if (nps_timer0_irq <= 0) {
-		pr_err("clockevent: missing irq");
+		pr_err("clockevent: missing irq\n");
 		return -EINVAL;
 	}
 
@@ -270,7 +270,7 @@ static int __init nps_setup_clockevent(struct device_node *node)
 				nps_timer_starting_cpu,
 				nps_timer_dying_cpu);
 	if (ret) {
-		pr_err("Failed to setup hotplug state");
+		pr_err("Failed to setup hotplug state\n");
 		clk_disable_unprepare(clk);
 		free_percpu_irq(nps_timer0_irq, &nps_clockevent_device);
 		return ret;
diff --git a/drivers/clocksource/timer-prima2.c b/drivers/clocksource/timer-prima2.c
index bfa981ac1eaf..b4122ed1accb 100644
--- a/drivers/clocksource/timer-prima2.c
+++ b/drivers/clocksource/timer-prima2.c
@@ -196,20 +196,20 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock");
+		pr_err("Failed to get clock\n");
 		return PTR_ERR(clk);
 	}
 
 	ret = clk_prepare_enable(clk);
 	if (ret) {
-		pr_err("Failed to enable clock");
+		pr_err("Failed to enable clock\n");
 		return ret;
 	}
 
 	rate = clk_get_rate(clk);
 
 	if (rate < PRIMA2_CLOCK_FREQ || rate % PRIMA2_CLOCK_FREQ) {
-		pr_err("Invalid clock rate");
+		pr_err("Invalid clock rate\n");
 		return -EINVAL;
 	}
 
@@ -229,7 +229,7 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	ret = clocksource_register_hz(&sirfsoc_clocksource, PRIMA2_CLOCK_FREQ);
 	if (ret) {
-		pr_err("Failed to register clocksource");
+		pr_err("Failed to register clocksource\n");
 		return ret;
 	}
 
@@ -237,7 +237,7 @@ static int __init sirfsoc_prima2_timer_init(struct device_node *np)
 
 	ret = setup_irq(sirfsoc_timer_irq.irq, &sirfsoc_timer_irq);
 	if (ret) {
-		pr_err("Failed to setup irq");
+		pr_err("Failed to setup irq\n");
 		return ret;
 	}
 
diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp804.c
index d07863388e05..2d575a8c0939 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -299,13 +299,13 @@ static int __init integrator_cp_of_init(struct device_node *np)
 
 	base = of_iomap(np, 0);
 	if (!base) {
-		pr_err("Failed to iomap");
+		pr_err("Failed to iomap\n");
 		return -ENXIO;
 	}
 
 	clk = of_clk_get(np, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Failed to get clock");
+		pr_err("Failed to get clock\n");
 		return PTR_ERR(clk);
 	}
 
diff --git a/drivers/clocksource/timer-sun5i.c b/drivers/clocksource/timer-sun5i.c
index a3e662b15964..2e9c830ae1cd 100644
--- a/drivers/clocksource/timer-sun5i.c
+++ b/drivers/clocksource/timer-sun5i.c
@@ -332,19 +332,19 @@ static int __init sun5i_timer_init(struct device_node *node)
 
 	timer_base = of_io_request_and_map(node, 0, of_node_full_name(node));
 	if (IS_ERR(timer_base)) {
-		pr_err("Can't map registers");
+		pr_err("Can't map registers\n");
 		return PTR_ERR(timer_base);;
 	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq <= 0) {
-		pr_err("Can't parse IRQ");
+		pr_err("Can't parse IRQ\n");
 		return -EINVAL;
 	}
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		pr_err("Can't get timer clock");
+		pr_err("Can't get timer clock\n");
 		return PTR_ERR(clk);
 	}
 
diff --git a/drivers/clocksource/vf_pit_timer.c b/drivers/clocksource/vf_pit_timer.c
index 55d8d8402d90..e0849e20a307 100644
--- a/drivers/clocksource/vf_pit_timer.c
+++ b/drivers/clocksource/vf_pit_timer.c
@@ -165,7 +165,7 @@ static int __init pit_timer_init(struct device_node *np)
 
 	timer_base = of_iomap(np, 0);
 	if (!timer_base) {
-		pr_err("Failed to iomap");
+		pr_err("Failed to iomap\n");
 		return -ENXIO;
 	}
 
-- 
2.11.0
