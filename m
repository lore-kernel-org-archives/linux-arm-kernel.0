From: alexg@meprolight.com (Alex)
Date: Wed, 14 Dec 2011 14:50:28 +0200
Subject: [PATCH] Linux OMAP: Add omap_reserve functionality
Message-ID: <1323867028-8496-1-git-send-email-alexg@meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds omap_reserve functionality to board-omap3logic.c

Signed-off-by: Alex Gershgorin <alexg@meprolight.com>
---
 arch/arm/mach-omap2/board-omap3logic.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3logic.c b/arch/arm/mach-omap2/board-omap3logic.c
index b44c485..6230a96 100644
--- a/arch/arm/mach-omap2/board-omap3logic.c
+++ b/arch/arm/mach-omap2/board-omap3logic.c
@@ -301,6 +301,7 @@ static void __init omap3logic_init(void)
 
 MACHINE_START(OMAP3_TORPEDO, "Logic OMAP3 Torpedo board")
 	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
@@ -310,6 +311,7 @@ MACHINE_END
 
 MACHINE_START(OMAP3530_LV_SOM, "OMAP Logic 3530 LV SOM board")
 	.atag_offset	= 0x100,
+	.reserve	= omap_reserve,
 	.map_io		= omap3_map_io,
 	.init_early	= omap35xx_init_early,
 	.init_irq	= omap3_init_irq,
-- 
1.7.0.4
