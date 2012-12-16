From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun, 16 Dec 2012 03:48:52 +0100
Subject: [PATCH 1/1] ARM: OMAP2+: common: remove use of vram
Message-ID: <1355626132-32117-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 966458f OMAP: remove vram allocator

Removed the OMAP specific vram allocator but OMAP2 common was
still trying to use it and this lead to the following build error:

CC      arch/arm/mach-omap2/common.o
arch/arm/mach-omap2/common.c:19:23: fatal error: plat/vram.h: No such file or directory
compilation terminated.
make[1]: *** [arch/arm/mach-omap2/common.o] Error 1
make: *** [arch/arm/mach-omap2] Error 2

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/mach-omap2/common.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-omap2/common.c b/arch/arm/mach-omap2/common.c
index 5c2fd48..2dabb9e 100644
--- a/arch/arm/mach-omap2/common.c
+++ b/arch/arm/mach-omap2/common.c
@@ -16,8 +16,6 @@
 #include <linux/init.h>
 #include <linux/platform_data/dsp-omap.h>
 
-#include <plat/vram.h>
-
 #include "common.h"
 #include "omap-secure.h"
 
@@ -32,7 +30,6 @@ int __weak omap_secure_ram_reserve_memblock(void)
 
 void __init omap_reserve(void)
 {
-	omap_vram_reserve_sdram_memblock();
 	omap_dsp_reserve_sdram_memblock();
 	omap_secure_ram_reserve_memblock();
 	omap_barrier_reserve_memblock();
-- 
1.7.7.6
