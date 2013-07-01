From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 14:41:33 +0900
Subject: [PATCH 03/07] ARM: shmobile: Remove unused r8a7778 auxdata and
 callback
In-Reply-To: <20130701054106.19319.46845.sendpatchset@w520>
References: <20130701054106.19319.46845.sendpatchset@w520>
Message-ID: <20130701054133.19319.79856.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the SoC-specific callback init_machine() with 
a NULL to use the default code. This cleans up the code
and reduces the number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7778.c |   11 -----------
 1 file changed, 11 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7778.c
+++ work/arch/arm/mach-shmobile/setup-r8a7778.c	2013-07-01 13:21:05.000000000 +0900
@@ -457,16 +457,6 @@ void __init r8a7778_init_irq_dt(void)
 	r8a7778_init_irq_common();
 }
 
-static const struct of_dev_auxdata r8a7778_auxdata_lookup[] __initconst = {
-	{},
-};
-
-void __init r8a7778_add_standard_devices_dt(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table,
-			     r8a7778_auxdata_lookup, NULL);
-}
-
 static const char *r8a7778_compat_dt[] __initdata = {
 	"renesas,r8a7778",
 	NULL,
@@ -475,7 +465,6 @@ static const char *r8a7778_compat_dt[] _
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
-	.init_machine	= r8a7778_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7778_compat_dt,
 	.init_late      = r8a7778_init_late,
