From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 24 Feb 2016 10:21:27 +0900
Subject: [PATCH 2/6] ARM: shmobile: r8a7740: Remove mapping of L2 cache
 controller registers
In-Reply-To: <cover.1456275652.git.horms+renesas@verge.net.au>
References: <cover.1456275652.git.horms+renesas@verge.net.au>
Message-ID: <c4be044abc6292f392c286b599e260f0c1bbb8ba.1456275652.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Now all r8a7740-based platforms have been migrated to the generic l2c OF
initialization, it's no longer needed to map the L2 cache controller
registers from .map_io().

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/setup-r8a7740.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/mach-shmobile/setup-r8a7740.c b/arch/arm/mach-shmobile/setup-r8a7740.c
index bf221e05c8dc..3e71cd4168dd 100644
--- a/arch/arm/mach-shmobile/setup-r8a7740.c
+++ b/arch/arm/mach-shmobile/setup-r8a7740.c
@@ -37,18 +37,6 @@ static struct map_desc r8a7740_io_desc[] __initdata = {
 		.length		= 160 << 20,
 		.type		= MT_DEVICE_NONSHARED
 	},
-#ifdef CONFIG_CACHE_L2X0
-	/*
-	 * for l2x0_init()
-	 * 0xf0100000-0xf0101000 -> 0xf0002000-0xf0003000
-	 */
-	{
-		.virtual	= 0xf0002000,
-		.pfn		= __phys_to_pfn(0xf0100000),
-		.length		= PAGE_SIZE,
-		.type		= MT_DEVICE_NONSHARED
-	},
-#endif
 };
 
 static void __init r8a7740_map_io(void)
-- 
2.1.4
