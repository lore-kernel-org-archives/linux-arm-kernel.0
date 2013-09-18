From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:56 +0200
Subject: [PATCH 23/26] ARM: sunxi: remove custom .init_time hook
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-24-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-sunxi/sunxi.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-sunxi/sunxi.c b/arch/arm/mach-sunxi/sunxi.c
index e5a6975..90dda62 100644
--- a/arch/arm/mach-sunxi/sunxi.c
+++ b/arch/arm/mach-sunxi/sunxi.c
@@ -10,7 +10,6 @@
  * warranty of any kind, whether express or implied.
  */
 
-#include <linux/clocksource.h>
 #include <linux/delay.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
@@ -114,12 +113,6 @@ static void sunxi_setup_restart(void)
 	arm_pm_restart = of_id->data;
 }
 
-static void __init sunxi_timer_init(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void __init sunxi_dt_init(void)
 {
 	sunxi_setup_restart();
@@ -138,6 +131,5 @@ static const char * const sunxi_board_dt_compat[] = {
 
 DT_MACHINE_START(SUNXI_DT, "Allwinner A1X (Device Tree)")
 	.init_machine	= sunxi_dt_init,
-	.init_time	= sunxi_timer_init,
 	.dt_compat	= sunxi_board_dt_compat,
 MACHINE_END
-- 
1.7.10.4
