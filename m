From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 15 May 2013 16:04:59 +0200
Subject: [PATCH] arm: kirkwood: use the default of match table
Message-ID: <1368626700-29226-1-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

mach-kirkwood/board-dt.c defines its own OF matching table, but in
fact, it is the same to the default of_default_bus_match_table[] which
is already used by mach-mvebu, mach-dove and mach-orion5x.

This patch therefore makes mach-kirkwood use the same default OF
matching table.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-kirkwood/board-dt.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-kirkwood/board-dt.c b/arch/arm/mach-kirkwood/board-dt.c
index e9647b8..a8dae11 100644
--- a/arch/arm/mach-kirkwood/board-dt.c
+++ b/arch/arm/mach-kirkwood/board-dt.c
@@ -25,11 +25,6 @@
 #include <plat/common.h>
 #include "common.h"
 
-static struct of_device_id kirkwood_dt_match_table[] __initdata = {
-	{ .compatible = "simple-bus", },
-	{ }
-};
-
 /*
  * There are still devices that doesn't know about DT yet.  Get clock
  * gates here and add a clock lookup alias, so that old platform
@@ -159,7 +154,7 @@ static void __init kirkwood_dt_init(void)
 	if (of_machine_is_compatible("usi,topkick"))
 		usi_topkick_init();
 
-	of_platform_populate(NULL, kirkwood_dt_match_table, NULL, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char * const kirkwood_dt_board_compat[] = {
-- 
1.7.9.5
