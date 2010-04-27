From: ext-mika.1.westerberg@nokia.com (Mika Westerberg)
Date: Tue, 27 Apr 2010 12:59:03 +0300
Subject: [PATCH] beagle: use PHYS_OFFSET for boot_params
Message-ID: <mailman.321.1272362802.2170.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Mika Westerberg <ext-mika.1.westerberg@nokia.com>
---
 arch/arm/mach-omap2/board-omap3beagle.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-omap2/board-omap3beagle.c b/arch/arm/mach-omap2/board-omap3beagle.c
index 962d377..f4ac649 100644
--- a/arch/arm/mach-omap2/board-omap3beagle.c
+++ b/arch/arm/mach-omap2/board-omap3beagle.c
@@ -468,7 +468,7 @@ MACHINE_START(OMAP3_BEAGLE, "OMAP3 Beagle Board")
 	/* Maintainer: Syed Mohammed Khasim - http://beagleboard.org */
 	.phys_io	= 0x48000000,
 	.io_pg_offst	= ((0xfa000000) >> 18) & 0xfffc,
-	.boot_params	= 0x80000100,
+	.boot_params	= PHYS_OFFSET + 0x100,
 	.map_io		= omap3_beagle_map_io,
 	.init_irq	= omap3_beagle_init_irq,
 	.init_machine	= omap3_beagle_init,
-- 
1.5.6.5
