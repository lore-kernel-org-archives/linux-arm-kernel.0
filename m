From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:17 +0200
Subject: [PATCH 7/9] at91: move register clocks to soc generic init
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-7-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c |    4 +---
 arch/arm/mach-at91/at91cap9.c    |    4 +---
 arch/arm/mach-at91/at91rm9200.c  |    4 +---
 arch/arm/mach-at91/at91sam9260.c |    4 +---
 arch/arm/mach-at91/at91sam9261.c |    4 +---
 arch/arm/mach-at91/at91sam9263.c |    4 +---
 arch/arm/mach-at91/at91sam9g45.c |    4 +---
 arch/arm/mach-at91/at91sam9rl.c  |    4 +---
 arch/arm/mach-at91/setup.c       |    3 +++
 arch/arm/mach-at91/soc.h         |    1 +
 10 files changed, 12 insertions(+), 24 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 8c9ad21..f3e2c65 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -373,9 +373,6 @@ static void __init at572d940hf_initialize(void)
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
 
-	/* Register the processor-specific clocks */
-	at572d940hf_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at572d940hf_gpio, 3);
 }
@@ -425,5 +422,6 @@ static unsigned int at572d940hf_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at572d940hf_soc = {
 	.map_io = at572d940hf_map_io,
 	.default_irq_priority = at572d940hf_default_irq_priority,
+	.register_clocks = at572d940hf_register_clocks,
 	.init = at572d940hf_initialize,
 };
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index f4219a8..23790b9 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -368,9 +368,6 @@ static void __init at91cap9_initialize(void)
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
-	/* Register the processor-specific clocks */
-	at91cap9_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91cap9_gpio, 4);
 
@@ -426,5 +423,6 @@ static unsigned int at91cap9_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91cap9_soc = {
 	.map_io = at91cap9_map_io,
 	.default_irq_priority = at91cap9_default_irq_priority,
+	.register_clocks = at91cap9_register_clocks,
 	.init = at91cap9_initialize,
 };
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 80e624e..0b512a3 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -330,9 +330,6 @@ static void __init at91rm9200_initialize(void)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
 			| (1 << AT91RM9200_ID_IRQ6);
 
-	/* Register the processor-specific clocks */
-	at91rm9200_register_clocks();
-
 	/* Initialize GPIO subsystem */
 	at91_gpio_init(at91rm9200_gpio,
 		cpu_is_at91rm9200_bga() ? AT91RM9200_BGA : AT91RM9200_PQFP);
@@ -384,5 +381,6 @@ static unsigned int at91rm9200_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91rm9200_soc = {
 	.map_io = at91rm9200_map_io,
 	.default_irq_priority = at91rm9200_default_irq_priority,
+	.register_clocks = at91rm9200_register_clocks,
 	.init = at91rm9200_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 47ead44..7da4f2a 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -369,9 +369,6 @@ static void __init at91sam9260_initialize(void)
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
 
-	/* Register the processor-specific clocks */
-	at91sam9260_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9260_gpio, 3);
 }
@@ -421,5 +418,6 @@ static unsigned int at91sam9260_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91sam9260_soc = {
 	.map_io = at91sam9260_map_io,
 	.default_irq_priority = at91sam9260_default_irq_priority,
+	.register_clocks = at91sam9260_register_clocks,
 	.init = at91sam9260_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 50506c2..bbaf72b 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -329,9 +329,6 @@ static void __init at91sam9261_initialize(void)
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
 
-	/* Register the processor-specific clocks */
-	at91sam9261_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9261_gpio, 3);
 }
@@ -381,5 +378,6 @@ static unsigned int at91sam9261_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91sam9261_soc = {
 	.map_io = at91sam9261_map_io,
 	.default_irq_priority = at91sam9261_default_irq_priority,
+	.register_clocks = at91sam9261_register_clocks,
 	.init = at91sam9261_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 038b3d7..88de596 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -340,9 +340,6 @@ static void __init at91sam9263_initialize(void)
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
-	/* Register the processor-specific clocks */
-	at91sam9263_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9263_gpio, 5);
 }
@@ -392,5 +389,6 @@ static unsigned int at91sam9263_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91sam9263_soc = {
 	.map_io = at91sam9263_map_io,
 	.default_irq_priority = at91sam9263_default_irq_priority,
+	.register_clocks = at91sam9263_register_clocks,
 	.init = at91sam9263_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 294126f..0e5dace 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -359,9 +359,6 @@ static void __init at91sam9g45_initialize(void)
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
-	/* Register the processor-specific clocks */
-	at91sam9g45_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9g45_gpio, 5);
 }
@@ -411,5 +408,6 @@ static unsigned int at91sam9g45_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91sam9g45_soc = {
 	.map_io = at91sam9g45_map_io,
 	.default_irq_priority = at91sam9g45_default_irq_priority,
+	.register_clocks = at91sam9g45_register_clocks,
 	.init = at91sam9g45_initialize,
 };
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index 5b23536..adad00d 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -322,9 +322,6 @@ static void __init at91sam9rl_initialize(void)
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
-	/* Register the processor-specific clocks */
-	at91sam9rl_register_clocks();
-
 	/* Register GPIO subsystem */
 	at91_gpio_init(at91sam9rl_gpio, 4);
 }
@@ -374,5 +371,6 @@ static unsigned int at91sam9rl_default_irq_priority[NR_AIC_IRQS] __initdata = {
 struct at91_soc __initdata at91sam9rl_soc = {
 	.map_io = at91sam9rl_map_io,
 	.default_irq_priority = at91sam9rl_default_irq_priority,
+	.register_clocks = at91sam9rl_register_clocks,
 	.init = at91sam9rl_initialize,
 };
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index d65cfe7..9aaca5f 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -255,5 +255,8 @@ void __init at91_initialize(unsigned long main_clock)
 	/* Init clock subsystem */
 	at91_clock_init(main_clock);
 
+	/* Register the processor-specific clocks */
+	at91_boot_soc.register_clocks();
+
 	at91_boot_soc.init();
 }
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index a62baf8..ea6c3e4 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -7,6 +7,7 @@
 struct at91_soc {
 	unsigned int *default_irq_priority;
 	void (*map_io)(void);
+	void (*register_clocks)(void);
 	void (*init)(void);
 };
 
-- 
1.7.4.1
