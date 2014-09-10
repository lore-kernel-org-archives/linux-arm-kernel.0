From: u.kleine-koenig@pengutronix.de (=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=)
Date: Wed, 10 Sep 2014 10:26:18 +0200
Subject: [PATCH 2/3] ARM: make of_device_ids const
In-Reply-To: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1410337579-23466-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <1410337579-23466-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_ids (i.e. compatible strings and the respective data) are not
supposed to change at runtime. All functions working with of_device_ids
provided by <linux/of.h> work with const of_device_ids. So mark the
non-const structs in arch/arm as const, too.

Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
---
 arch/arm/kernel/perf_event_cpu.c         | 2 +-
 arch/arm/mach-at91/at91rm9200_time.c     | 2 +-
 arch/arm/mach-at91/at91sam9263_devices.c | 2 +-
 arch/arm/mach-at91/at91sam926x_time.c    | 2 +-
 arch/arm/mach-at91/clock.c               | 4 ++--
 arch/arm/mach-at91/setup.c               | 6 +++---
 arch/arm/mach-davinci/da8xx-dt.c         | 2 +-
 arch/arm/mach-imx/mmdc.c                 | 2 +-
 arch/arm/mach-keystone/pm_domain.c       | 2 +-
 arch/arm/mach-mmp/time.c                 | 2 +-
 arch/arm/mach-mvebu/coherency.c          | 2 +-
 arch/arm/mach-mvebu/pmsu.c               | 2 +-
 arch/arm/mach-prima2/platsmp.c           | 2 +-
 arch/arm/mach-sunxi/sunxi.c              | 2 +-
 14 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/perf_event_cpu.c b/arch/arm/kernel/perf_event_cpu.c
index e6a6edbec613..8e13236f184c 100644
--- a/arch/arm/kernel/perf_event_cpu.c
+++ b/arch/arm/kernel/perf_event_cpu.c
@@ -224,7 +224,7 @@ static struct notifier_block cpu_pmu_hotplug_notifier = {
 /*
  * PMU platform driver and devicetree bindings.
  */
-static struct of_device_id cpu_pmu_of_device_ids[] = {
+static const struct of_device_id cpu_pmu_of_device_ids[] = {
 	{.compatible = "arm,cortex-a17-pmu",	.data = armv7_a17_pmu_init},
 	{.compatible = "arm,cortex-a15-pmu",	.data = armv7_a15_pmu_init},
 	{.compatible = "arm,cortex-a12-pmu",	.data = armv7_a12_pmu_init},
diff --git a/arch/arm/mach-at91/at91rm9200_time.c b/arch/arm/mach-at91/at91rm9200_time.c
index 7fd13aef9827..ec978cc892bf 100644
--- a/arch/arm/mach-at91/at91rm9200_time.c
+++ b/arch/arm/mach-at91/at91rm9200_time.c
@@ -184,7 +184,7 @@ void __iomem *at91_st_base;
 EXPORT_SYMBOL_GPL(at91_st_base);
 
 #ifdef CONFIG_OF
-static struct of_device_id at91rm9200_st_timer_ids[] = {
+static const struct of_device_id at91rm9200_st_timer_ids[] = {
 	{ .compatible = "atmel,at91rm9200-st" },
 	{ /* sentinel */ }
 };
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index cef0e2f57068..4f717a53aa0e 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -981,7 +981,7 @@ static struct platform_device at91sam9263_tcb_device = {
 };
 
 #if defined(CONFIG_OF)
-static struct of_device_id tcb_ids[] = {
+static const struct of_device_id tcb_ids[] = {
 	{ .compatible = "atmel,at91rm9200-tcb" },
 	{ /*sentinel*/ }
 };
diff --git a/arch/arm/mach-at91/at91sam926x_time.c b/arch/arm/mach-at91/at91sam926x_time.c
index 0a9e2fc8f796..137c2ca634b0 100644
--- a/arch/arm/mach-at91/at91sam926x_time.c
+++ b/arch/arm/mach-at91/at91sam926x_time.c
@@ -179,7 +179,7 @@ static struct irqaction at91sam926x_pit_irq = {
 };
 
 #ifdef CONFIG_OF
-static struct of_device_id pit_timer_ids[] = {
+static const struct of_device_id pit_timer_ids[] = {
 	{ .compatible = "atmel,at91sam9260-pit" },
 	{ /* sentinel */ }
 };
diff --git a/arch/arm/mach-at91/clock.c b/arch/arm/mach-at91/clock.c
index 034529d801b2..b579988dd877 100644
--- a/arch/arm/mach-at91/clock.c
+++ b/arch/arm/mach-at91/clock.c
@@ -876,7 +876,7 @@ static int __init at91_pmc_init(unsigned long main_clock)
 }
 
 #if defined(CONFIG_OF)
-static struct of_device_id pmc_ids[] = {
+static const struct of_device_id pmc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-pmc" },
 	{ .compatible = "atmel,at91sam9260-pmc" },
 	{ .compatible = "atmel,at91sam9g45-pmc" },
@@ -886,7 +886,7 @@ static struct of_device_id pmc_ids[] = {
 	{ /*sentinel*/ }
 };
 
-static struct of_device_id osc_ids[] = {
+static const struct of_device_id osc_ids[] = {
 	{ .compatible = "atmel,osc" },
 	{ /*sentinel*/ }
 };
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index f7a07a58ebb6..d3ca2b96f0e5 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -352,7 +352,7 @@ void __init at91_ioremap_matrix(u32 base_addr)
 }
 
 #if defined(CONFIG_OF) && !defined(CONFIG_ARCH_AT91X40)
-static struct of_device_id rstc_ids[] = {
+static const struct of_device_id rstc_ids[] = {
 	{ .compatible = "atmel,at91sam9260-rstc", .data = at91sam9_alt_restart },
 	{ .compatible = "atmel,at91sam9g45-rstc", .data = at91sam9g45_restart },
 	{ /*sentinel*/ }
@@ -380,7 +380,7 @@ static void at91_dt_rstc(void)
 	of_node_put(np);
 }
 
-static struct of_device_id ramc_ids[] = {
+static const struct of_device_id ramc_ids[] = {
 	{ .compatible = "atmel,at91rm9200-sdramc", .data = at91rm9200_standby },
 	{ .compatible = "atmel,at91sam9260-sdramc", .data = at91sam9_sdram_standby },
 	{ .compatible = "atmel,at91sam9g45-ddramc", .data = at91_ddr_standby },
@@ -411,7 +411,7 @@ static void at91_dt_ramc(void)
 	of_node_put(np);
 }
 
-static struct of_device_id shdwc_ids[] = {
+static const struct of_device_id shdwc_ids[] = {
 	{ .compatible = "atmel,at91sam9260-shdwc", },
 	{ .compatible = "atmel,at91sam9rl-shdwc", },
 	{ .compatible = "atmel,at91sam9x5-shdwc", },
diff --git a/arch/arm/mach-davinci/da8xx-dt.c b/arch/arm/mach-davinci/da8xx-dt.c
index ed1928740b5f..cd4853a070bd 100644
--- a/arch/arm/mach-davinci/da8xx-dt.c
+++ b/arch/arm/mach-davinci/da8xx-dt.c
@@ -20,7 +20,7 @@
 
 #define DA8XX_NUM_UARTS	3
 
-static struct of_device_id da8xx_irq_match[] __initdata = {
+static const struct of_device_id da8xx_irq_match[] __initconst = {
 	{ .compatible = "ti,cp-intc", .data = cp_intc_of_init, },
 	{ }
 };
diff --git a/arch/arm/mach-imx/mmdc.c b/arch/arm/mach-imx/mmdc.c
index 7a9686ad994c..f3996d45f28e 100644
--- a/arch/arm/mach-imx/mmdc.c
+++ b/arch/arm/mach-imx/mmdc.c
@@ -51,7 +51,7 @@ static int imx_mmdc_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id imx_mmdc_dt_ids[] = {
+static const struct of_device_id imx_mmdc_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-mmdc", },
 	{ /* sentinel */ }
 };
diff --git a/arch/arm/mach-keystone/pm_domain.c b/arch/arm/mach-keystone/pm_domain.c
index ca79ddac38bc..61c94457279b 100644
--- a/arch/arm/mach-keystone/pm_domain.c
+++ b/arch/arm/mach-keystone/pm_domain.c
@@ -61,7 +61,7 @@ static struct pm_clk_notifier_block platform_domain_notifier = {
 	.pm_domain = &keystone_pm_domain,
 };
 
-static struct of_device_id of_keystone_table[] = {
+static const struct of_device_id of_keystone_table[] = {
 	{.compatible = "ti,keystone"},
 	{ /* end of list */ },
 };
diff --git a/arch/arm/mach-mmp/time.c b/arch/arm/mach-mmp/time.c
index 2756351dbb35..10bfa03e58d4 100644
--- a/arch/arm/mach-mmp/time.c
+++ b/arch/arm/mach-mmp/time.c
@@ -213,7 +213,7 @@ void __init timer_init(int irq)
 }
 
 #ifdef CONFIG_OF
-static struct of_device_id mmp_timer_dt_ids[] = {
+static const struct of_device_id mmp_timer_dt_ids[] = {
 	{ .compatible = "mrvl,mmp-timer", },
 	{}
 };
diff --git a/arch/arm/mach-mvebu/coherency.c b/arch/arm/mach-mvebu/coherency.c
index 2bdc3233abe2..67f84cecdfb3 100644
--- a/arch/arm/mach-mvebu/coherency.c
+++ b/arch/arm/mach-mvebu/coherency.c
@@ -53,7 +53,7 @@ enum {
 	COHERENCY_FABRIC_TYPE_ARMADA_380,
 };
 
-static struct of_device_id of_coherency_table[] = {
+static const struct of_device_id of_coherency_table[] = {
 	{.compatible = "marvell,coherency-fabric",
 	 .data = (void *) COHERENCY_FABRIC_TYPE_ARMADA_370_XP },
 	{.compatible = "marvell,armada-375-coherency-fabric",
diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8a70a51533fd..d35d01531183 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -104,7 +104,7 @@ static void __iomem *pmsu_mp_base;
 
 static void *mvebu_cpu_resume;
 
-static struct of_device_id of_pmsu_table[] = {
+static const struct of_device_id of_pmsu_table[] = {
 	{ .compatible = "marvell,armada-370-pmsu", },
 	{ .compatible = "marvell,armada-370-xp-pmsu", },
 	{ .compatible = "marvell,armada-380-pmsu", },
diff --git a/arch/arm/mach-prima2/platsmp.c b/arch/arm/mach-prima2/platsmp.c
index 335c12e92262..59a96daee929 100644
--- a/arch/arm/mach-prima2/platsmp.c
+++ b/arch/arm/mach-prima2/platsmp.c
@@ -60,7 +60,7 @@ static void sirfsoc_secondary_init(unsigned int cpu)
 	spin_unlock(&boot_lock);
 }
 
-static struct of_device_id rsc_ids[]  = {
+static const struct of_device_id rsc_ids[]  = {
 	{ .compatible = "sirf,marco-rsc" },
 	{},
 };
diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index 42d4753683ce..efbcbde296b4 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -64,7 +64,7 @@ static void sun4i_restart(enum reboot_mode mode, const char *cmd)
 	}
 }
 
-static struct of_device_id sunxi_restart_ids[] = {
+static const struct of_device_id sunxi_restart_ids[] = {
 	{ .compatible = "allwinner,sun4i-a10-wdt" },
 	{ /*sentinel*/ }
 };
-- 
2.1.0
