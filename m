From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 19:30:07 +0900
Subject: [PATCH 04/06] ARM: shmobile: Remove unused r8a7779 auxdata table
In-Reply-To: <20130628102930.31451.85334.sendpatchset@w520>
References: <20130628102930.31451.85334.sendpatchset@w520>
Message-ID: <20130628103007.31451.96485.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7779.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7779.c
+++ work/arch/arm/mach-shmobile/setup-r8a7779.c	2013-06-28 15:49:50.000000000 +0900
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
@@ -676,8 +672,7 @@ void __init r8a7779_add_standard_devices
 
 	platform_add_devices(r8a7779_devices_dt,
 			     ARRAY_SIZE(r8a7779_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     r8a7779_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *r8a7779_compat_dt[] __initdata = {
