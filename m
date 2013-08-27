From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Tue, 27 Aug 2013 23:27:56 +0200
Subject: [PATCH RFC v2 02/16] ARM: dove: remove custom .init_time hook
In-Reply-To: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1376964271-22715-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1377638890-371-3-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks. While at it, also remove some obsolete
includes.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-dove/board-dt.c |   17 +----------------
 1 files changed, 1 insertions(+), 16 deletions(-)

diff --git a/arch/arm/mach-dove/board-dt.c b/arch/arm/mach-dove/board-dt.c
index 9a116d7..b527728 100644
--- a/arch/arm/mach-dove/board-dt.c
+++ b/arch/arm/mach-dove/board-dt.c
@@ -9,26 +9,12 @@
  */
 
 #include <linux/init.h>
-#include <linux/clk-provider.h>
-#include <linux/clocksource.h>
-#include <linux/irqchip.h>
-#include <linux/of.h>
+#include <linux/mbus.h>
 #include <linux/of_platform.h>
-#include <linux/platform_data/usb-ehci-orion.h>
 #include <asm/hardware/cache-tauros2.h>
 #include <asm/mach/arch.h>
-#include <mach/dove.h>
-#include <mach/pm.h>
-#include <plat/common.h>
-#include <plat/irq.h>
 #include "common.h"
 
-static void __init dove_dt_time_init(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void __init dove_dt_init(void)
 {
 	pr_info("Dove 88AP510 SoC\n");
@@ -47,7 +33,6 @@ static const char * const dove_dt_board_compat[] = {
 
 DT_MACHINE_START(DOVE_DT, "Marvell Dove (Flattened Device Tree)")
 	.map_io		= dove_map_io,
-	.init_time	= dove_dt_time_init,
 	.init_machine	= dove_dt_init,
 	.restart	= dove_restart,
 	.dt_compat	= dove_dt_board_compat,
-- 
1.7.2.5
