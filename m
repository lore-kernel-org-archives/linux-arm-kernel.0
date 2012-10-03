From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 3 Oct 2012 19:06:34 +0000
Subject: [PATCH] ARM: mv78xx0: correct addr_map_cfg __initdata annotation
Message-ID: <201210031906.35123.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The annotation on the addr_map_cfg variable is in the wrong place.

Without this patch, building mv78xx0_defconfig results in:

/home/arnd/linux-arm/arch/arm/mach-mv78xx0/addr-map.c:59:2: warning: initialization from incompatible pointer type [enabled by default]
/home/arnd/linux-arm/arch/arm/mach-mv78xx0/addr-map.c:59:2: warning: (near initialization for 'addr_map_cfg.win_cfg_base') [enabled by default]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Andrew Lunn <andrew@lunn.ch>
---
Queued in the late/fixes branch

diff --git a/arch/arm/mach-mv78xx0/addr-map.c b/arch/arm/mach-mv78xx0/addr-map.c
index a9bc841..03f7486 100644
--- a/arch/arm/mach-mv78xx0/addr-map.c
+++ b/arch/arm/mach-mv78xx0/addr-map.c
@@ -53,7 +53,7 @@ static void __init __iomem *win_cfg_base(const struct orion_addr_map_cfg *cfg, i
 /*
  * Description of the windows needed by the platform code
  */
-static struct __initdata orion_addr_map_cfg addr_map_cfg = {
+static struct orion_addr_map_cfg addr_map_cfg __initdata = {
 	.num_wins = 14,
 	.remappable_wins = 8,
 	.win_cfg_base = win_cfg_base,
