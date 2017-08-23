From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 23 Aug 2017 15:28:19 +0200
Subject: [PATCH] ARM: OMAP2+: fix missing variable declaration
Message-ID: <20170823132841.642239-1-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function that was added doesn't actually build:

arch/arm/mach-omap2/display.c: In function 'omapdss_init_fbdev':
arch/arm/mach-omap2/display.c:184:2: error: 'r' undeclared (first use in this function)

This adds a declaration for 'r' to fix it.

Fixes: 5ce783025c82 ("ARM: OMAP2+: Don't register omapdss device for omapdrm")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-omap2/display.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-omap2/display.c b/arch/arm/mach-omap2/display.c
index 798fc718fffe..b3f6eb5d04a2 100644
--- a/arch/arm/mach-omap2/display.c
+++ b/arch/arm/mach-omap2/display.c
@@ -172,6 +172,7 @@ static int __init omapdss_init_fbdev(void)
 		.set_min_bus_tput = omap_dss_set_min_bus_tput,
 	};
 	struct device_node *node;
+	int r;
 
 	board_data.version = omap_display_get_version();
 	if (board_data.version == OMAPDSS_VER_UNKNOWN) {
-- 
2.9.0
