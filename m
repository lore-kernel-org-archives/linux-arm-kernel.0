From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 19:29:58 +0900
Subject: [PATCH 03/06] ARM: shmobile: Remove unused r8a7778 auxdata table
In-Reply-To: <20130628102930.31451.85334.sendpatchset@w520>
References: <20130628102930.31451.85334.sendpatchset@w520>
Message-ID: <20130628102958.31451.56355.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Pass NULL to of_platform_populate instead of passing
an empty list. This cleans up the code and reduces the
number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7778.c |    7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2013-06-28 15:48:43.000000000 +0900
@@ -457,14 +457,9 @@ void __init r8a7778_init_irq_dt(void)
 	r8a7778_init_irq_common();
 }
 
-static const struct of_dev_auxdata r8a7778_auxdata_lookup[] __initconst = {
-	{},
-};
-
 void __init r8a7778_add_standard_devices_dt(void)
 {
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     r8a7778_auxdata_lookup, NULL);
+	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
 static const char *r8a7778_compat_dt[] __initdata = {
