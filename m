From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Tue, 10 May 2011 18:34:16 +0200
Subject: [PATCH 6/9] at91: move clock subsystem init to soc generic init
In-Reply-To: <20110510162730.GA18929@game.jcrosoft.org>
References: <20110510162730.GA18929@game.jcrosoft.org>
Message-ID: <1305045259-23066-6-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at572d940hf.c |    5 +----
 arch/arm/mach-at91/at91cap9.c    |    6 ++----
 arch/arm/mach-at91/at91rm9200.c  |    5 +----
 arch/arm/mach-at91/at91sam9260.c |    5 +----
 arch/arm/mach-at91/at91sam9261.c |    5 +----
 arch/arm/mach-at91/at91sam9263.c |    5 +----
 arch/arm/mach-at91/at91sam9g45.c |    5 +----
 arch/arm/mach-at91/at91sam9rl.c  |    5 +----
 arch/arm/mach-at91/generic.h     |    4 ++++
 arch/arm/mach-at91/setup.c       |    5 ++++-
 arch/arm/mach-at91/soc.h         |    2 +-
 11 files changed, 18 insertions(+), 34 deletions(-)

diff --git a/arch/arm/mach-at91/at572d940hf.c b/arch/arm/mach-at91/at572d940hf.c
index 39827ebc..8c9ad21 100644
--- a/arch/arm/mach-at91/at572d940hf.c
+++ b/arch/arm/mach-at91/at572d940hf.c
@@ -367,15 +367,12 @@ static void __init at572d940hf_map_io(void)
 	iotable_init(at572d940hf_sram_desc, ARRAY_SIZE(at572d940hf_sram_desc));
 }
 
-static void __init at572d940hf_initialize(unsigned long main_clock)
+static void __init at572d940hf_initialize(void)
 {
 	at91_arch_reset = at572d940hf_reset;
 	at91_extern_irq = (1 << AT572D940HF_ID_IRQ0) | (1 << AT572D940HF_ID_IRQ1)
 			| (1 << AT572D940HF_ID_IRQ2);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at572d940hf_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 238b6a0..f4219a8 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -362,14 +362,12 @@ static void __init at91cap9_map_io(void)
 	iotable_init(at91cap9_sram_desc, ARRAY_SIZE(at91cap9_sram_desc));
 }
 
-static void __init at91cap9_initialize(unsigned long main_clock)
+static void __init at91cap9_initialize(void)
+{
 	at91_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91cap9_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index 9c8c8ce..80e624e 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -322,7 +322,7 @@ static void __init at91rm9200_map_io(void)
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 }
 
-static void __init at91rm9200_initialize(unsigned long main_clock)
+static void __init at91rm9200_initialize(void)
 {
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
@@ -330,9 +330,6 @@ static void __init at91rm9200_initialize(unsigned long main_clock)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
 			| (1 << AT91RM9200_ID_IRQ6);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91rm9200_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cac454e..47ead44 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -362,16 +362,13 @@ static void __init at91sam9260_map_io(void)
 		iotable_init(at91sam9260_sram_desc, ARRAY_SIZE(at91sam9260_sram_desc));
 }
 
-static void __init at91sam9260_initialize(unsigned long main_clock)
+static void __init at91sam9260_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91sam9260_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 69bc26f..50506c2 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -322,16 +322,13 @@ static void __init at91sam9261_map_io(void)
 		iotable_init(at91sam9261_sram_desc, ARRAY_SIZE(at91sam9261_sram_desc));
 }
 
-static void __init at91sam9261_initialize(unsigned long main_clock)
+static void __init at91sam9261_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91sam9261_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 3da9103..038b3d7 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -334,15 +334,12 @@ static void __init at91sam9263_map_io(void)
 	iotable_init(at91sam9263_sram_desc, ARRAY_SIZE(at91sam9263_sram_desc));
 }
 
-static void __init at91sam9263_initialize(unsigned long main_clock)
+static void __init at91sam9263_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91sam9263_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index ecca942..294126f 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -353,15 +353,12 @@ static void __init at91sam9g45_map_io(void)
 	iotable_init(at91sam9g45_sram_desc, ARRAY_SIZE(at91sam9g45_sram_desc));
 }
 
-static void __init at91sam9g45_initialize(unsigned long main_clock)
+static void __init at91sam9g45_initialize(void)
 {
 	at91_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91sam9g45_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index c25c173..5b23536 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -316,15 +316,12 @@ static void __init at91sam9rl_map_io(void)
 	iotable_init(at91sam9rl_sram_desc, ARRAY_SIZE(at91sam9rl_sram_desc));
 }
 
-static void __init at91sam9rl_initialize(unsigned long main_clock)
+static void __init at91sam9rl_initialize(void)
 {
 	at91_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91sam9rl_register_clocks();
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index e807520..9fd0fa3 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -31,7 +31,11 @@ extern struct sys_timer at91sam926x_timer;
 extern struct sys_timer at91x40_timer;
 
  /* Clocks */
+#ifdef CONFIG_AT91_PMC_UNIT
 extern int __init at91_clock_init(unsigned long main_clock);
+#else
+static int inline at91_clock_init(unsigned long main_clock) { return 0; }
+#endif
 extern struct clk* __init at91rm9200_get_uart_clock(int id);
 extern struct clk* __init at91sam9260_get_uart_clock(int id);
 extern struct clk* __init at91sam9261_get_uart_clock(int id);
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index df6ee4f..d65cfe7 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -252,5 +252,8 @@ void __init at91_map_io(void)
 
 void __init at91_initialize(unsigned long main_clock)
 {
-	at91_boot_soc.init(main_clock);
+	/* Init clock subsystem */
+	at91_clock_init(main_clock);
+
+	at91_boot_soc.init();
 }
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 1125671..a62baf8 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -7,7 +7,7 @@
 struct at91_soc {
 	unsigned int *default_irq_priority;
 	void (*map_io)(void);
-	void (*init)(unsigned long main_clock);
+	void (*init)(void);
 };
 
 extern struct at91_soc at91_boot_soc;
-- 
1.7.4.1
