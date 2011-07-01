From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  1 Jul 2011 08:44:40 +0200
Subject: [PATCH 6/8] at91: move register clocks to soc generic init
In-Reply-To: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1309502682-16897-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c    |    4 +---
 arch/arm/mach-at91/at91rm9200.c  |    4 +---
 arch/arm/mach-at91/at91sam9260.c |    4 +---
 arch/arm/mach-at91/at91sam9261.c |    4 +---
 arch/arm/mach-at91/at91sam9263.c |    4 +---
 arch/arm/mach-at91/at91sam9g45.c |    4 +---
 arch/arm/mach-at91/at91sam9rl.c  |    4 +---
 arch/arm/mach-at91/setup.c       |    3 +++
 arch/arm/mach-at91/soc.h         |    1 +
 9 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index bdf5097..8fabf91 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -346,9 +346,6 @@ static void __init at91cap9_initialize(void)
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
-	/* Register the processor-specific clocks */
-	at91cap9_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91cap9_gpio, 4);
 
@@ -404,5 +401,6 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91cap9_soc = {
 	.map_io = at91cap9_map_io,
 	.default_irq_priority = at91cap9_default_irq_priority,
+	.register_clocks = at91cap9_register_clocks,
 	.init = at91cap9_initialize,
 };
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 9661297..0104078 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -317,9 +317,6 @@ static void __init at91rm9200_initialize(void)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
 			| (1 << AT91RM9200_ID_IRQ6);
 
-	/* Register the processor-specific clocks */
-	at91rm9200_register_clocks();
-
 	/* Initialize GPIO subsystem */
 	at91_gpio_init(at91rm9200_gpio,
 		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
@@ -371,5 +368,6 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91rm9200_soc = {
 	.map_io = at91rm9200_map_io,
 	.default_irq_priority = at91rm9200_default_irq_priority,
+	.register_clocks = at91rm9200_register_clocks,
 	.init = at91rm9200_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 40e123f..1addfef 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -357,9 +357,6 @@ static void __init at91sam9260_initialize(void)
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
 
-	/* Register the processor-specific clocks */
-	at91sam9260_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9260_gpio, 3);
 }
@@ -409,5 +406,6 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9260_soc = {
 	.map_io = at91sam9260_map_io,
 	.default_irq_priority = at91sam9260_default_irq_priority,
+	.register_clocks = at91sam9260_register_clocks,
 	.init = at91sam9260_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 9631973..8f97bd4 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -309,9 +309,6 @@ static void __init at91sam9261_initialize(void)
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
 
-	/* Register the processor-specific clocks */
-	at91sam9261_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9261_gpio, 3);
 }
@@ -361,5 +358,6 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9261_soc = {
 	.map_io = at91sam9261_map_io,
 	.default_irq_priority = at91sam9261_default_irq_priority,
+	.register_clocks = at91sam9261_register_clocks,
 	.init = at91sam9261_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 3860007..da13f02 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -320,9 +320,6 @@ static void __init at91sam9263_initialize(void)
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
-	/* Register the processor-specific clocks */
-	at91sam9263_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9263_gpio, 5);
 }
@@ -372,5 +369,6 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9263_soc = {
 	.map_io = at91sam9263_map_io,
 	.default_irq_priority = at91sam9263_default_irq_priority,
+	.register_clocks = at91sam9263_register_clocks,
 	.init = at91sam9263_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index e48dda1..cbc0645 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -336,9 +336,6 @@ static void __init at91sam9g45_initialize(void)
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
-	/* Register the processor-specific clocks */
-	at91sam9g45_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9g45_gpio, 5);
 }
@@ -388,5 +385,6 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9g45_soc = {
 	.map_io = at91sam9g45_map_io,
 	.default_irq_priority = at91sam9g45_default_irq_priority,
+	.register_clocks = at91sam9g45_register_clocks,
 	.init = at91sam9g45_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 53ac1a7..55ee7d0 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -306,9 +306,6 @@ static void __init at91sam9rl_initialize(void)
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
-	/* Register the processor-specific clocks */
-	at91sam9rl_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9rl_gpio, 4);
 }
@@ -358,5 +355,6 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_init_soc __initdata at91sam9rl_soc = {
 	.map_io = at91sam9rl_map_io,
 	.default_irq_priority = at91sam9rl_default_irq_priority,
+	.register_clocks = at91sam9rl_register_clocks,
 	.init = at91sam9rl_initialize,
 };
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index dfbc3fa..43251ef 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -251,5 +251,8 @@ void __init at91_initialize(unsigned long main_clock)
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
 
+	/* Register the processor-specific clocks */
+	at91_boot_soc.register_clocks();
+
 	at91_boot_soc.init();
 }
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 103030a..21ed881 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -7,6 +7,7 @@
 struct at91_init_soc {
 	unsigned int *default_irq_priority;
 	void (*map_io)(void);
+	void (*register_clocks)(void);
 	void (*init)(void);
 };
 
-- 
1.7.4.1
