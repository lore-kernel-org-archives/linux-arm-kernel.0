From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:52 +0900
Subject: [PATCH 13/22] ARM: shmobile: Remove unused r8a7778 auxdata and
 callback
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <40216263d3d0b9b46688a28a96daf66fe75caa28.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the SoC-specific callback init_machine() with
a NULL to use the default code. This cleans up the code
and reduces the number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7778.c |   11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7778.c b/arch/arm/mach-shmobile/setup-r8a7778.c
index b70bfee..2a101eb 100644
--- a/arch/arm/mach-shmobile/setup-r8a7778.c
+++ b/arch/arm/mach-shmobile/setup-r8a7778.c
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
@@ -475,7 +465,6 @@ static const char *r8a7778_compat_dt[] __initdata = {
 DT_MACHINE_START(R8A7778_DT, "Generic R8A7778 (Flattened Device Tree)")
 	.init_early	= r8a7778_init_delay,
 	.init_irq	= r8a7778_init_irq_dt,
-	.init_machine	= r8a7778_add_standard_devices_dt,
 	.init_time	= shmobile_timer_init,
 	.dt_compat	= r8a7778_compat_dt,
 	.init_late      = r8a7778_init_late,
-- 
1.7.10.4
