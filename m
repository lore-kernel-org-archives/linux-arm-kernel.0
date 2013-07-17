From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 18 Jul 2013 08:31:56 +0900
Subject: [PATCH 17/22] ARM: shmobile: Remove redundant r8a7790 callback
In-Reply-To: <cover.1374103272.git.horms+renesas@verge.net.au>
References: <cover.1374103272.git.horms+renesas@verge.net.au>
Message-ID: <fdbc45dbbe5a69a2c665630ab577726e01eadf23.1374103272.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Replace the SoC-specific callback init_machine() with
a NULL to use the default code. This cleans up the code
and reduces the number of lines.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7790.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7790.c b/arch/arm/mach-shmobile/setup-r8a7790.c
index d405dbd..b7e78b9 100644
--- a/arch/arm/mach-shmobile/setup-r8a7790.c
+++ b/arch/arm/mach-shmobile/setup-r8a7790.c
@@ -176,10 +176,6 @@ void __init r8a7790_timer_init(void)
 }
 
 #ifdef CONFIG_USE_OF
-void __init r8a7790_add_standard_devices_dt(void)
-{
-	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
-}
 
 static const char *r8a7790_boards_compat_dt[] __initdata = {
 	"renesas,r8a7790",
@@ -187,7 +183,6 @@ static const char *r8a7790_boards_compat_dt[] __initdata = {
 };
 
 DT_MACHINE_START(R8A7790_DT, "Generic R8A7790 (Flattened Device Tree)")
-	.init_machine	= r8a7790_add_standard_devices_dt,
 	.init_time	= r8a7790_timer_init,
 	.dt_compat	= r8a7790_boards_compat_dt,
 MACHINE_END
-- 
1.7.10.4
