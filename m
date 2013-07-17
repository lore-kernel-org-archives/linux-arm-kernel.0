From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:53 +0900
Subject: [PATCH 14/22] ARM: shmobile: Remove unused r8a7779 auxdata table
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <41b0156ca5a1460f8f6dde7e57baf1b80d6a7030.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 3986877..66d3826 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -665,10 +665,6 @@ void __init r8a7779_init_delay(void)
 	shmobile_setup_delay(1000, 2, 4); /* Cortex-A9 @ 1000MHz */
 }
 
-static const struct of_dev_auxdata r8a7779_auxdata_lookup[] __initconst = {
-	{},
-};
-
 void __init r8a7779_add_standard_devices_dt(void)
 {
 	/* clocks are setup late during boot in the case of DT */
@@ -676,8 +672,7 @@ void __init r8a7779_add_standard_devices_dt(void)
 
 	platform_add_devices(r8a7779_devices_dt,
 			     ARRAY_SIZE(r8a7779_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     r8a7779_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *r8a7779_compat_dt[] __initdata = {
-- 
1.7.10.4
