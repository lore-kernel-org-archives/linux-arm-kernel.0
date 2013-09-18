From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Wed, 18 Sep 2013 19:53:48 +0200
Subject: [PATCH 15/26] ARM: kirkwood: remove custom .init_time hook
In-Reply-To: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1379526839-14798-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <1379526839-14798-16-git-send-email-sebastian.hesselbarth@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With arch/arm calling of_clk_init(NULL) from time_init(), we can now
remove custom .init_time hooks.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/mach-kirkwood/board-dt.c |    8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index 82d3ad8..a32a3e5 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -15,7 +15,6 @@
 #include <linux/of.h>
 #include <linux/of_platform.h>
 #include <linux/clk-provider.h>
-#include <linux/clocksource.h>
 #include <linux/dma-mapping.h>
 #include <linux/irqchip.h>
 #include <linux/kexec.h>
@@ -66,12 +65,6 @@ static void __init kirkwood_legacy_clk_init(void)
 	clk_prepare_enable(clk);
 }
 
-static void __init kirkwood_dt_time_init(void)
-{
-	of_clk_init(NULL);
-	clocksource_of_init();
-}
-
 static void __init kirkwood_dt_init_early(void)
 {
 	mvebu_mbus_init("marvell,kirkwood-mbus",
@@ -122,7 +115,6 @@ DT_MACHINE_START(KIRKWOOD_DT, "Marvell Kirkwood (Flattened Device Tree)")
 	/* Maintainer: Jason Cooper <jason@lakedaemon.net> */
 	.map_io		= kirkwood_map_io,
 	.init_early	= kirkwood_dt_init_early,
-	.init_time	= kirkwood_dt_time_init,
 	.init_machine	= kirkwood_dt_init,
 	.restart	= kirkwood_restart,
 	.dt_compat	= kirkwood_dt_board_compat,
-- 
1.7.10.4
