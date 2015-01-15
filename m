From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 15 Jan 2015 22:58:08 +0100
Subject: [PATCH 05/17] ARM: at91: sam9: set arm_pm_idle from
 sam9_dt_device_init
In-Reply-To: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1421359100-8930-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1421359100-8930-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As all sam9 SoCs are setting arm_pm_idle to at91sam9_idle(), do it from
sam9_dt_device_init().

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-at91/at91sam9260.c   | 6 ------
 arch/arm/mach-at91/at91sam9261.c   | 6 ------
 arch/arm/mach-at91/at91sam9263.c   | 6 ------
 arch/arm/mach-at91/at91sam9g45.c   | 5 -----
 arch/arm/mach-at91/at91sam9rl.c    | 6 ------
 arch/arm/mach-at91/board-dt-sam9.c | 4 ++++
 6 files changed, 4 insertions(+), 29 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9260.c b/arch/arm/mach-at91/at91sam9260.c
index ab9841c8b0d5..37b7ce4c6a3b 100644
--- a/arch/arm/mach-at91/at91sam9260.c
+++ b/arch/arm/mach-at91/at91sam9260.c
@@ -22,11 +22,5 @@
  *  AT91SAM9260 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9260_initialize(void)
-{
-	arm_pm_idle = at91sam9_idle;
-}
-
 AT91_SOC_START(at91sam9260)
-	.init = at91sam9260_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9261.c b/arch/arm/mach-at91/at91sam9261.c
index 2029096b93fa..aebbf76b6038 100644
--- a/arch/arm/mach-at91/at91sam9261.c
+++ b/arch/arm/mach-at91/at91sam9261.c
@@ -21,11 +21,5 @@
  *  AT91SAM9261 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9261_initialize(void)
-{
-	arm_pm_idle = at91sam9_idle;
-}
-
 AT91_SOC_START(at91sam9261)
-	.init = at91sam9261_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9263.c b/arch/arm/mach-at91/at91sam9263.c
index 1fe672a05513..dca29457d9cc 100644
--- a/arch/arm/mach-at91/at91sam9263.c
+++ b/arch/arm/mach-at91/at91sam9263.c
@@ -20,11 +20,5 @@
  *  AT91SAM9263 processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9263_initialize(void)
-{
-	arm_pm_idle = at91sam9_idle;
-}
-
 AT91_SOC_START(at91sam9263)
-	.init = at91sam9263_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9g45.c b/arch/arm/mach-at91/at91sam9g45.c
index f3130501fa75..d77d10cf10f6 100644
--- a/arch/arm/mach-at91/at91sam9g45.c
+++ b/arch/arm/mach-at91/at91sam9g45.c
@@ -20,11 +20,6 @@
 /* --------------------------------------------------------------------
  *  AT91SAM9G45 processor initialization
  * -------------------------------------------------------------------- */
-static void __init at91sam9g45_initialize(void)
-{
-	arm_pm_idle = at91sam9_idle;
-}
 
 AT91_SOC_START(at91sam9g45)
-	.init = at91sam9g45_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/at91sam9rl.c b/arch/arm/mach-at91/at91sam9rl.c
index dab3c0d47f96..a585ff3adf96 100644
--- a/arch/arm/mach-at91/at91sam9rl.c
+++ b/arch/arm/mach-at91/at91sam9rl.c
@@ -22,11 +22,5 @@
  *  AT91SAM9RL processor initialization
  * -------------------------------------------------------------------- */
 
-static void __init at91sam9rl_initialize(void)
-{
-	arm_pm_idle = at91sam9_idle;
-}
-
 AT91_SOC_START(at91sam9rl)
-	.init = at91sam9rl_initialize,
 AT91_SOC_END
diff --git a/arch/arm/mach-at91/board-dt-sam9.c b/arch/arm/mach-at91/board-dt-sam9.c
index 0fe1ced608c5..508468d77475 100644
--- a/arch/arm/mach-at91/board-dt-sam9.c
+++ b/arch/arm/mach-at91/board-dt-sam9.c
@@ -26,7 +26,9 @@
 
 static void __init sam9_dt_device_init(void)
 {
+	arm_pm_idle = at91sam9_idle;
 	at91_sam9260_pm_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
@@ -45,7 +47,9 @@ MACHINE_END
 
 static void __init sam9g45_dt_device_init(void)
 {
+	arm_pm_idle = at91sam9_idle;
 	at91_sam9g45_pm_init();
+
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-- 
2.1.0
