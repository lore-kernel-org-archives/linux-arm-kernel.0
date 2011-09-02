From: khilman@ti.com (Kevin Hilman)
Date: Fri, 2 Sep 2011 11:00:12 -0700
Subject: [PATCH] OMAP: convert new boards to atag_offset
Message-ID: <mailman.117.1314986819.20020.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These boards were added after the bulk converson from boot_params to
atag_offset (queued for v3.2.)  Fix them up.

Signed-off-by: Kevin Hilman <khilman@ti.com>
---
 arch/arm/mach-omap2/board-omap3encore.c |    2 +-
 arch/arm/mach-omap2/board-omap4pcm049.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3encore.c b/arch/arm/mach-omap2/board-omap3encore.c
index eb70fe1..07ed8ab 100644
--- a/arch/arm/mach-omap2/board-omap3encore.c
+++ b/arch/arm/mach-omap2/board-omap3encore.c
@@ -338,7 +338,7 @@ static void __init omap_encore_init(void)
 }
 
 MACHINE_START(ENCORE, "encore")
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap_encore_init_early,
diff --git a/arch/arm/mach-omap2/board-omap4pcm049.c b/arch/arm/mach-omap2/board-omap4pcm049.c
index d889110..260f2cb 100644
--- a/arch/arm/mach-omap2/board-omap4pcm049.c
+++ b/arch/arm/mach-omap2/board-omap4pcm049.c
@@ -578,7 +578,7 @@ static void __init pcm049_map_io(void)
 
 MACHINE_START(PCM049, "phyCORE OMAP4")
 	/* Maintainer: Jan Weitzel - Phytec Messtechnik GmbH */
-	.boot_params	= 0x80000100,
+	.atag_offset	= 0x100,
 	.reserve	= omap_reserve,
 	.map_io		= pcm049_map_io,
 	.init_early	= pcm049_init_early,
-- 
1.7.6
