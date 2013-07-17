From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:54 +0900
Subject: [PATCH 15/22] ARM: shmobile: Remove unused sh7372 auxdata table
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <975e5af958916f8b76a8926cd4d50c04936d7079.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-sh7372.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-sh7372.c b/arch/arm/mach-shmobile/setup-sh7372.c
index 5502d62..13e6fdb 100644
--- a/arch/arm/mach-shmobile/setup-sh7372.c
+++ b/arch/arm/mach-shmobile/setup-sh7372.c
@@ -1147,10 +1147,6 @@ void __init sh7372_add_early_devices_dt(void)
 	shmobile_setup_console();
 }
 
-static const struct of_dev_auxdata sh7372_auxdata_lookup[] __initconst = {
-	{ }
-};
-
 void __init sh7372_add_standard_devices_dt(void)
 {
 	/* clocks are setup late during boot in the case of DT */
@@ -1159,8 +1155,7 @@ void __init sh7372_add_standard_devices_dt(void)
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     sh7372_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *sh7372_boards_compat_dt[] __initdata = {
-- 
1.7.10.4
