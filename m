From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 30 Aug 2016 15:59:27 +0200
Subject: [PATCH 1/3] ARM: integrator: delete some auxdata
Message-ID: <1472565569-11414-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is just a few auxdata entries still needed on the Integrators:

- UART RTS/CTS callbacks for Integrator/AP
- MMC/SD special card detect quirk for Integrator/CP

Delete the rest.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_ap.c |  6 ------
 arch/arm/mach-integrator/integrator_cp.c | 12 ------------
 2 files changed, 18 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_ap.c b/arch/arm/mach-integrator/integrator_ap.c
index ae9aa3caeb0b..b17c68ff1b3e 100644
--- a/arch/arm/mach-integrator/integrator_ap.c
+++ b/arch/arm/mach-integrator/integrator_ap.c
@@ -205,16 +205,10 @@ static void __init ap_init_irq_of(void)
 
 /* For the Device Tree, add in the UART callbacks as AUXDATA */
 static struct of_dev_auxdata ap_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
-		"rtc", NULL),
 	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART0_BASE,
 		"uart0", &ap_uart_data),
 	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART1_BASE,
 		"uart1", &ap_uart_data),
-	OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
-		"kmi0", NULL),
-	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
-		"kmi1", NULL),
 	{ /* sentinel */ },
 };
 
diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index a9e3cb511fcb..1742bc76ccef 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -140,20 +140,8 @@ static void __init intcp_init_irq_of(void)
  * and enforce the bus names since these are used for clock lookups.
  */
 static struct of_dev_auxdata intcp_auxdata_lookup[] __initdata = {
-	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
-		"rtc", NULL),
-	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART0_BASE,
-		"uart0", NULL),
-	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_UART1_BASE,
-		"uart1", NULL),
-	OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
-		"kmi0", NULL),
-	OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
-		"kmi1", NULL),
 	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_CP_MMC_BASE,
 		"mmci", &mmc_data),
-	OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_CP_AACI_BASE,
-		"aaci", &mmc_data),
 	{ /* sentinel */ },
 };
 
-- 
2.7.4
