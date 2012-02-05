From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sun,  5 Feb 2012 19:31:09 +0100
Subject: [PATCH 1/1] ARM: at91: factorise duplicated at91sam9 idle
Message-ID: <1328466669-29720-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

introduce in commit c9dfafbaca0b66a6665242d019b3b9c5be056fcf

ARM: mach-at91: move special idle code out of line

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/at91sam9260.c |    8 +-------
 arch/arm/mach-at91/at91sam9261.c |    8 +-------
 arch/arm/mach-at91/at91sam9263.c |    8 +-------
 arch/arm/mach-at91/at91sam9g45.c |    8 +-------
 arch/arm/mach-at91/at91sam9rl.c  |    8 +-------
 arch/arm/mach-at91/generic.h     |    3 +++
 arch/arm/mach-at91/setup.c       |    6 ++++++
 7 files changed, 14 insertions(+), 35 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index 9ac8c6f..e965332 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -329,15 +329,9 @@ static void __init at91sam9260_ioremap_registers(void)
 	at91sam9_ioremap_smc(0, AT91SAM9260_BASE_SMC);
 }
 
-static void at91sam9260_idle(void)
-{
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 static void __init at91sam9260_initialize(void)
 {
-	arm_pm_idle = at91sam9260_idle;
+	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9260_ID_IRQ0) | (1 << AT91SAM9260_ID_IRQ1)
 			| (1 << AT91SAM9260_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index ab76868..d7f51d6 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -287,15 +287,9 @@ static void __init at91sam9261_ioremap_registers(void)
 	at91sam9_ioremap_smc(0, AT91SAM9261_BASE_SMC);
 }
 
-static void at91sam9261_idle(void)
-{
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 static void __init at91sam9261_initialize(void)
 {
-	arm_pm_idle = at91sam9261_idle;
+	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9261_ID_IRQ0) | (1 << AT91SAM9261_ID_IRQ1)
 			| (1 << AT91SAM9261_ID_IRQ2);
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 247ab63..8bdba2a 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -308,15 +308,9 @@ static void __init at91sam9263_ioremap_registers(void)
 	at91sam9_ioremap_smc(1, AT91SAM9263_BASE_SMC1);
 }
 
-static void at91sam9263_idle(void)
-{
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 static void __init at91sam9263_initialize(void)
 {
-	arm_pm_idle = at91sam9263_idle;
+	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9263_ID_IRQ0) | (1 << AT91SAM9263_ID_IRQ1);
 
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index 5b12192..5d2ff90 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -317,12 +317,6 @@ static struct at91_gpio_bank at91sam9g45_gpio[] __initdata = {
 	}
 };
 
-static void at91sam9g45_idle(void)
-{
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 /* --------------------------------------------------------------------
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
@@ -343,7 +337,7 @@ static void __init at91sam9g45_ioremap_registers(void)
 
 static void __init at91sam9g45_initialize(void)
 {
-	arm_pm_idle = at91sam9g45_idle;
+	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9g45_restart;
 	at91_extern_irq = (1 << AT91SAM9G45_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index fd60e22..e86c50b 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -292,15 +292,9 @@ static void __init at91sam9rl_ioremap_registers(void)
 	at91sam9_ioremap_smc(0, AT91SAM9RL_BASE_SMC);
 }
 
-static void at91sam9rl_idle(void)
-{
-	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
-	cpu_do_idle();
-}
-
 static void __init at91sam9rl_initialize(void)
 {
-	arm_pm_idle = at91sam9rl_idle;
+	arm_pm_idle = at91sam9_idle;
 	arm_pm_restart = at91sam9_alt_restart;
 	at91_extern_irq = (1 << AT91SAM9RL_ID_IRQ0);
 
diff --git a/arch/arm/mach-at91/generic.h b/arch/arm/mach-at91/generic.h
index 7e8280e..4e322f3 100644
--- a/arch/arm/mach-at91/generic.h
+++ b/arch/arm/mach-at91/generic.h
@@ -56,6 +56,9 @@ struct device;
 extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
 
+/* idle */
+extern void at91sam9_idle(void);
+
 /* reset */
 extern void at91_ioremap_rstc(u32 base_addr);
 extern void at91sam9_alt_restart(char, const char *);
diff --git a/arch/arm/mach-at91/setup.c b/arch/arm/mach-at91/setup.c
index 620c67e..02b3a40 100644
--- a/arch/arm/mach-at91/setup.c
+++ b/arch/arm/mach-at91/setup.c
@@ -252,6 +252,12 @@ void __init at91_map_io(void)
 		at91_boot_soc.map_io();
 }
 
+void at91sam9_idle(void)
+{
+	at91_sys_write(AT91_PMC_SCDR, AT91_PMC_PCK);
+	cpu_do_idle();
+}
+
 void __iomem *at91_shdwc_base = NULL;
 
 static void at91sam9_poweroff(void)
-- 
1.7.7
