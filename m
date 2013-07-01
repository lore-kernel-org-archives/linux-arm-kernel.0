From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 14:41:55 +0900
Subject: [PATCH 05/07] ARM: shmobile: Remove unused sh7372 auxdata table
In-Reply-To: <20130701054106.19319.46845.sendpatchset@w520>
References: <20130701054106.19319.46845.sendpatchset@w520>
Message-ID: <20130701054155.19319.19762.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-sh7372.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-sh7372.c
+++ work/arch/arm/mach-shmobile/setup-sh7372.c	2013-06-28 15:41:15.000000000 +0900
@@ -1147,10 +1147,6 @@ void __init sh7372_add_early_devices_dt(
 	shmobile_setup_console();
 }
 
-static const struct of_dev_auxdata sh7372_auxdata_lookup[] __initconst = {
-	{ }
-};
-
 void __init sh7372_add_standard_devices_dt(void)
 {
 	/* clocks are setup late during boot in the case of DT */
@@ -1159,8 +1155,7 @@ void __init sh7372_add_standard_devices_
 	platform_add_devices(sh7372_early_devices,
 			    ARRAY_SIZE(sh7372_early_devices));
 
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     sh7372_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *sh7372_boards_compat_dt[] __initdata = {
