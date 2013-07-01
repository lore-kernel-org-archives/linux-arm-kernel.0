From: magnus.damm@gmail.com (Magnus Damm)
Date: Mon, 01 Jul 2013 14:42:13 +0900
Subject: [PATCH 07/07] ARM: shmobile: Remove redundant r8a7790 callback
In-Reply-To: <20130701054106.19319.46845.sendpatchset@w520>
References: <20130701054106.19319.46845.sendpatchset@w520>
Message-ID: <20130701054213.19319.40704.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the SoC-specific callback init_machine() with 
a NULL to use the default code. This cleans up the code
and reduces the number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/setup-r8a7790.c |    5 -----
 1 file changed, 5 deletions(-)

--- 0001/arch/arm/mach-shmobile/setup-r8a7790.c
+++ work/arch/arm/mach-shmobile/setup-r8a7790.c	2013-07-01 13:24:33.000000000 +0900
@@ -217,10 +217,6 @@ void __init r8a7790_init_delay(void)
 }
 
 #ifdef CONFIG_USE_OF
-void __init r8a7790_add_standard_devices_dt(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
 
 static const char *r8a7790_boards_compat_dt[] __initdata = {
 	"renesas,r8a7790",
@@ -230,7 +226,6 @@ static const char *r8a7790_boards_compat
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
 	.init_early	= r8a7790_init_delay,
 	.init_irq	= irqchip_init,
-	.init_machine	= r8a7790_add_standard_devices_dt,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
