From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 19:29:39 +0900
Subject: [PATCH 01/06] ARM: shmobile: Remove unused EMEV2 auxdata table
In-Reply-To: <20130628102930.31451.85334.sendpatchset@w520>
References: <20130628102930.31451.85334.sendpatchset@w520>
Message-ID: <20130628102939.31451.91670.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-emev2.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-emev2.c
+++ work/arch/arm/mach-shmobile/setup-emev2.c	2013-06-28 15:46:19.000000000 +0900
@@ -435,14 +435,10 @@ void __init emev2_init_irq(void)
 }
 
 #ifdef CONFIG_USE_OF
-static const struct of_dev_auxdata emev2_auxdata_lookup[] __initconst = {
-	{ }
-};
 
 static void __init emev2_add_standard_devices_dt(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     emev2_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *emev2_boards_compat_dt[] __initdata = {
