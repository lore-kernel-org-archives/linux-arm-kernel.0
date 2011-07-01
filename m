From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Fri,  1 Jul 2011 08:44:39 +0200
Subject: [PATCH 5/8] at91: move clock subsystem init to soc generic init
In-Reply-To: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
References: <1309502682-16897-1-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <1309502682-16897-5-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
---
 arch/arm/mach-at91/at91cap9.c    |    6 ++----
 arch/arm/mach-at91/at91rm9200.c  |    5 +----
 arch/arm/mach-at91/at91sam9260.c |    5 +----
 arch/arm/mach-at91/at91sam9261.c |    5 +----
 arch/arm/mach-at91/at91sam9263.c |    5 +----
 arch/arm/mach-at91/at91sam9g45.c |    5 +----
 arch/arm/mach-at91/at91sam9rl.c  |    5 +----
 arch/arm/mach-at91/generic.h     |    6 +++++-
 arch/arm/mach-at91/setup.c       |    5 ++++-
 arch/arm/mach-at91/soc.h         |    2 +-
 10 files changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index 6287c0d..bdf5097 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -340,14 +340,12 @@ static void __init at91cap9_map_io(void)
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
index 36d37bd..9661297 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -309,7 +309,7 @@ static void __init at91rm9200_map_io(void)
 	iotable_init(at91rm9200_io_desc, ARRAY_SIZE(at91rm9200_io_desc));
 }
 
-static void __init at91rm9200_initialize(unsigned long main_clock)
+static void __init at91rm9200_initialize(void)
 {
 	at91_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
@@ -317,9 +317,6 @@ static void __init at91rm9200_initialize(unsigned long main_clock)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
 			| (1 << AT91RM9200_ID_IRQ6);
 
-	/* Init clock subsystem */
-	at91_clock_init(main_clock);
-
 	/* Register the processor-specific clocks */
 	at91rm9200_register_clocks();
 
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 8a6b9aa..40e123f 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -350,16 +350,13 @@ static void __init at91sam9260_map_io(void)
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
index f6a2b30..9631973 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -302,16 +302,13 @@ static void __init at91sam9261_map_io(void)
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
index 7245a8e..3860007 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -314,15 +314,12 @@ static void __init at91sam9263_map_io(void)
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
index 57a4726..e48dda1 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -330,15 +330,12 @@ static void __init at91sam9g45_map_io(void)
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
index b83098c..53ac1a7 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -300,15 +300,12 @@ static void __init at91sam9rl_map_io(void)
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
index ce11390..a9d6ed4 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -31,7 +31,6 @@ extern struct sys_timer at91sam926x_timer;
 extern struct sys_timer at91x40_timer;
 
  /* Clocks */
-extern int __init at91_clock_init(unsigned long main_clock);
 /*
  * function to specify the clock of the default console. As we do not
  * use the device/driver bus, the dev_name is not intialize. So we need
@@ -44,6 +43,11 @@ extern void __init at91sam9263_set_console_clock(int id);
 extern void __init at91sam9rl_set_console_clock(int id);
 extern void __init at91sam9g45_set_console_clock(int id);
 extern void __init at91cap9_set_console_clock(int id);
+#ifdef CONFIG_AT91_PMC_UNIT
+extern int __init at91_clock_init(unsigned long main_clock);
+#else
+static int inline at91_clock_init(unsigned long main_clock) { return 0; }
+#endif
 struct device;
 
  /* Power Management */
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 9ea4183..dfbc3fa 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -248,5 +248,8 @@ void __init at91_map_io(void)
 
 void __init at91_initialize(unsigned long main_clock)
 {
-	at91_boot_soc.init(main_clock);
+	/* Init clock subsystem */
+	at91_clock_init(main_clock);
+
+	at91_boot_soc.init();
 }
diff --git a/arch/arm/mach-at91/soc.h b/arch/arm/mach-at91/soc.h
index 9de7be4..103030a 100644
--- a/arch/arm/mach-at91/soc.h
+++ b/arch/arm/mach-at91/soc.h
@@ -7,7 +7,7 @@
 struct at91_init_soc {
 	unsigned int *default_irq_priority;
 	void (*map_io)(void);
-	void (*init)(unsigned long main_clock);
+	void (*init)(void);
 };
 
 extern struct at91_init_soc at91_boot_soc;
-- 
1.7.4.1
