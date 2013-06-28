From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 19:29:49 +0900
Subject: [PATCH 02/06] ARM: shmobile: Remove unused r8a7740 auxdata table
In-Reply-To: <20130628102930.31451.85334.sendpatchset@w520>
References: <20130628102930.31451.85334.sendpatchset@w520>
Message-ID: <20130628102949.31451.55728.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7740.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7740.c
+++ work/arch/arm/mach-shmobile/setup-r8a7740.c	2013-06-28 15:43:04.000000000 +0900
@@ -986,16 +986,11 @@ void __init r8a7740_add_early_devices(vo
 
 #ifdef CONFIG_USE_OF
 
-static const struct of_dev_auxdata r8a7740_auxdata_lookup[] __initconst = {
-	{ }
-};
-
 void __init r8a7740_add_standard_devices_dt(void)
 {
 	platform_add_devices(r8a7740_devices_dt,
 			    ARRAY_SIZE(r8a7740_devices_dt));
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     r8a7740_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 void __init r8a7740_init_delay(void)
