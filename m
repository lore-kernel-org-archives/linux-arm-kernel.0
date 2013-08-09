From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 09 Aug 2013 18:48:43 +0900
Subject: [PATCH 05/14] ARM: shmobile: Remove r8a7740_add_early_devices_dt()
In-Reply-To: <20130809094748.6530.16511.sendpatchset@w520>
References: <20130809094748.6530.16511.sendpatchset@w520>
Message-ID: <20130809094843.6530.94661.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Remove the unused r8a7740_add_early_devices_dt() function.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7740.c |   15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

--- 0005/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2013-08-08 15:40:07.000000000 +0900
@@ -995,25 +995,14 @@ void __init r8a7740_add_early_devices(vo
 	shmobile_setup_console();
 }
 
-#ifdef CONFIG_USE_OF
-
-void __init r8a7740_add_early_devices_dt(void)
-{
-	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
-
-	early_platform_add_devices(r8a7740_early_devices,
-				   ARRAY_SIZE(r8a7740_early_devices));
-
-	/* setup early console here as well */
-	shmobile_setup_console();
-}
-
 void __init r8a7740_add_dt_devices(void)
 {
 	platform_add_devices(r8a7740_devices_dt,
 			    ARRAY_SIZE(r8a7740_devices_dt));
 }
 
+#ifdef CONFIG_USE_OF
+
 void __init r8a7740_init_delay(void)
 {
 	shmobile_setup_delay(800, 1, 3); /* Cortex-A9 @ 800MHz */
