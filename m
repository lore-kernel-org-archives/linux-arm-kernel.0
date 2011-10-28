From: will.deacon@arm.com (Will Deacon)
Date: Fri, 28 Oct 2011 15:43:30 +0100
Subject: [PATCH 02/51] ARM: mach-at91: use arm_arch_reset instead of arch_reset
In-Reply-To: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
References: <1319813059-8914-1-git-send-email-will.deacon@arm.com>
Message-ID: <1319813059-8914-3-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch updates mach-at91 to use arm_arch_reset instead of
arch_reset.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/mach-at91/at91cap9.c            |    5 +++--
 arch/arm/mach-at91/at91rm9200.c          |    5 +++--
 arch/arm/mach-at91/at91sam9260.c         |    3 ++-
 arch/arm/mach-at91/at91sam9261.c         |    3 ++-
 arch/arm/mach-at91/at91sam9263.c         |    3 ++-
 arch/arm/mach-at91/at91sam9g45.c         |    5 +++--
 arch/arm/mach-at91/at91sam9rl.c          |    3 ++-
 arch/arm/mach-at91/generic.h             |    3 +--
 arch/arm/mach-at91/include/mach/system.h |    5 -----
 9 files changed, 18 insertions(+), 17 deletions(-)

diff --git a/arch/arm/mach-at91/at91cap9.c b/arch/arm/mach-at91/at91cap9.c
index bfc6844..d16da6a 100644
--- a/arch/arm/mach-at91/at91cap9.c
+++ b/arch/arm/mach-at91/at91cap9.c
@@ -16,6 +16,7 @@
 #include <linux/pm.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 
@@ -311,7 +312,7 @@ static struct at91_gpio_bank at91cap9_gpio[] = {
 	}
 };
 
-static void at91cap9_reset(void)
+static void at91cap9_reset(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -333,7 +334,7 @@ static void __init at91cap9_map_io(void)
 
 static void __init at91cap9_initialize(void)
 {
-	at91_arch_reset = at91cap9_reset;
+	arm_arch_reset = at91cap9_reset;
 	pm_power_off = at91cap9_poweroff;
 	at91_extern_irq = (1 << AT91CAP9_ID_IRQ0) | (1 << AT91CAP9_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91rm9200.c b/arch/arm/mach-at91/at91rm9200.c
index f73302d..4497e81 100644
--- a/arch/arm/mach-at91/at91rm9200.c
+++ b/arch/arm/mach-at91/at91rm9200.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/at91rm9200.h>
@@ -286,7 +287,7 @@ static struct at91_gpio_bank at91rm9200_gpio[] = {
 	}
 };
 
-static void at91rm9200_reset(void)
+static void at91rm9200_reset(char mode, const char *cmd)
 {
 	/*
 	 * Perform a hardware reset with the use of the Watchdog timer.
@@ -307,7 +308,7 @@ static void __init at91rm9200_map_io(void)
 
 static void __init at91rm9200_initialize(void)
 {
-	at91_arch_reset = at91rm9200_reset;
+	arm_arch_reset = at91rm9200_reset;
 	at91_extern_irq = (1 << AT91RM9200_ID_IRQ0) | (1 << AT91RM9200_ID_IRQ1)
 			| (1 << AT91RM9200_ID_IRQ2) | (1 << AT91RM9200_ID_IRQ3)
 			| (1 << AT91RM9200_ID_IRQ4) | (1 << AT91RM9200_ID_IRQ5)
diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index cb397be..2f5e4c1 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/cpu.h>
@@ -317,7 +318,7 @@ static void __init at91sam9260_map_io(void)
 
 static void __init at91sam9260_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9260_poweroff;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 6c8e3b5..b7b0625 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/cpu.h>
@@ -286,7 +287,7 @@ static void __init at91sam9261_map_io(void)
 
 static void __init at91sam9261_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9261_poweroff;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 044f3c9..42b7380 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/at91sam9263.h>
@@ -303,7 +304,7 @@ static void __init at91sam9263_map_io(void)
 
 static void __init at91sam9263_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9263_poweroff;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index e04c5fb..d13929c 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -14,6 +14,7 @@
 #include <linux/pm.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/at91sam9g45.h>
@@ -301,7 +302,7 @@ static struct at91_gpio_bank at91sam9g45_gpio[] = {
 	}
 };
 
-static void at91sam9g45_reset(void)
+static void at91sam9g45_reset(char mode, const char *cmd)
 {
 	at91_sys_write(AT91_RSTC_CR, AT91_RSTC_KEY | AT91_RSTC_PROCRST | AT91_RSTC_PERRST);
 }
@@ -323,7 +324,7 @@ static void __init at91sam9g45_map_io(void)
 
 static void __init at91sam9g45_initialize(void)
 {
-	at91_arch_reset = at91sam9g45_reset;
+	arm_arch_reset = at91sam9g45_reset;
 	pm_power_off = at91sam9g45_poweroff;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index a238105..f556331 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -13,6 +13,7 @@
 #include <linux/pm.h>
 
 #include <asm/irq.h>
+#include <asm/system.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/map.h>
 #include <mach/cpu.h>
@@ -292,7 +293,7 @@ static void __init at91sam9rl_map_io(void)
 
 static void __init at91sam9rl_initialize(void)
 {
-	at91_arch_reset = at91sam9_alt_reset;
+	arm_arch_reset = at91sam9_alt_reset;
 	pm_power_off = at91sam9rl_poweroff;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 938b34f..c15c9bb 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -57,7 +57,7 @@ extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
 
 /* reset */
-extern void at91sam9_alt_reset(void);
+extern void at91sam9_alt_reset(char mode, const char *cmd);
 
  /* GPIO */
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
@@ -71,5 +71,4 @@ struct at91_gpio_bank {
 extern void __init at91_gpio_init(struct at91_gpio_bank *, int nr_banks);
 extern void __init at91_gpio_irq_setup(void);
 
-extern void (*at91_arch_reset)(void);
 extern int at91_extern_irq;
diff --git a/arch/arm/mach-at91/include/mach/system.h b/arch/arm/mach-at91/include/mach/system.h
index 36af14b..079eb12 100644
--- a/arch/arm/mach-at91/include/mach/system.h
+++ b/arch/arm/mach-at91/include/mach/system.h
@@ -47,13 +47,8 @@ static inline void arch_idle(void)
 #endif
 }
 
-void (*at91_arch_reset)(void);
-
 static inline void arch_reset(char mode, const char *cmd)
 {
-	/* call the CPU-specific reset function */
-	if (at91_arch_reset)
-		(at91_arch_reset)();
 }
 
 #endif
-- 
1.7.4.1
