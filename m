From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Nov 2014 09:55:10 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7779: Spelling/grammar
 s/entity/identity/, s/map/mapping/
In-Reply-To: <cover.1416530979.git.horms+renesas@verge.net.au>
References: <cover.1416530979.git.horms+renesas@verge.net.au>
Message-ID: <3e940958ed3625187704f41129801800f70c2169.1416530979.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7779.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7779.c b/arch/arm/mach-shmobile/setup-r8a7779.c
index 136078a..65635b1 100644
--- a/arch/arm/mach-shmobile/setup-r8a7779.c
+++ b/arch/arm/mach-shmobile/setup-r8a7779.c
@@ -52,14 +52,14 @@
 #include "r8a7779.h"
 
 static struct map_desc r8a7779_io_desc[] __initdata = {
-	/* 2M entity map for 0xf0000000 (MPCORE) */
+	/* 2M identity mapping for 0xf0000000 (MPCORE) */
 	{
 		.virtual	= 0xf0000000,
 		.pfn		= __phys_to_pfn(0xf0000000),
 		.length		= SZ_2M,
 		.type		= MT_DEVICE_NONSHARED
 	},
-	/* 16M entity map for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
+	/* 16M identity mapping for 0xfexxxxxx (DMAC-S/HPBREG/INTC2/LRAM/DBSC) */
 	{
 		.virtual	= 0xfe000000,
 		.pfn		= __phys_to_pfn(0xfe000000),
@@ -683,7 +683,7 @@ void __init r8a7779_add_early_devices(void)
 
 	/* Early serial console setup is not included here due to
 	 * memory map collisions. The SCIF serial ports in r8a7779
-	 * are difficult to entity map 1:1 due to collision with the
+	 * are difficult to identity map 1:1 due to collision with the
 	 * virtual memory range used by the coherent DMA code on ARM.
 	 *
 	 * Anyone wanting to debug early can remove UPF_IOREMAP from
-- 
2.1.1
