From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:43:04 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7740: Remove restart callback
In-Reply-To: <cover.1425947508.git.horms+renesas@verge.net.au>
References: <cover.1425947508.git.horms+renesas@verge.net.au>
Message-ID: <82fbf29f26733dd38bd2ab17db04e0aa46ef3857.1425947508.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Remove the restart handling hack from the r8a7740 generic multiplatform
case.

Restart on DT-based r8a7740 platforms is now handled through the
R-Mobile reset driver.

This reverts commit 1174c712afa2779f ("ARM: shmobile: r8a7740: Add
restart callback").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index dd64caf..9832e48 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -842,13 +842,6 @@ static void __init r8a7740_generic_init(void)
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
 
-#define RESCNT2 IOMEM(0xe6188020)
-static void r8a7740_restart(enum reboot_mode mode, const char *cmd)
-{
-	/* Do soft power on reset */
-	writel(1 << 31, RESCNT2);
-}
-
 static const char *r8a7740_boards_compat_dt[] __initdata = {
 	"renesas,r8a7740",
 	NULL,
@@ -861,7 +854,6 @@ DT_MACHINE_START(R8A7740_DT, "Generic R8A7740 (Flattened Device Tree)")
 	.init_machine	= r8a7740_generic_init,
 	.init_late	= shmobile_init_late,
 	.dt_compat	= r8a7740_boards_compat_dt,
-	.restart	= r8a7740_restart,
 MACHINE_END
 
 #endif /* CONFIG_USE_OF */
-- 
2.1.4
