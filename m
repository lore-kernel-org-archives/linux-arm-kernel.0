From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Mon, 12 Nov 2012 12:25:05 +0200
Subject: [PATCH 4/5] OMAP: common.c: remove init call to vram
In-Reply-To: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
References: <1352715906-16946-1-git-send-email-tomi.valkeinen@ti.com>
Message-ID: <1352715906-16946-5-git-send-email-tomi.valkeinen@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OMAP specific vram allocator is no longer used, and we can remove init
call to the vram allocator.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 arch/arm/plat-omap/common.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/plat-omap/common.c b/arch/arm/plat-omap/common.c
index 111315a..d21ed18 100644
--- a/arch/arm/plat-omap/common.c
+++ b/arch/arm/plat-omap/common.c
@@ -17,7 +17,6 @@
 #include <linux/dma-mapping.h>
 
 #include <plat/common.h>
-#include <plat/vram.h>
 #include <linux/platform_data/dsp-omap.h>
 #include <plat/dma.h>
 
@@ -25,7 +24,6 @@
 
 void __init omap_reserve(void)
 {
-	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
-- 
1.7.10.4
