From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:57:55 +0900
Subject: [PATCH 03/13] ARM: shmobile: ape6evm: Disable legacy clock
 initialization
In-Reply-To: <cover.1425517246.git.horms+renesas@verge.net.au>
References: <cover.1425517246.git.horms+renesas@verge.net.au>
Message-ID: <ccc83dce9d4ebdfc5a74045c5a00518f08884313.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Disables r8a73a4_clock_init() if CCF is enabled.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 3b68370..dd5bc63 100644
--- a/arch/arm/mach-shmobile/board-ape6evm-reference.c
+++ b/arch/arm/mach-shmobile/board-ape6evm-reference.c
@@ -29,7 +29,7 @@
 
 static void __init ape6evm_add_standard_devices(void)
 {
-
+#ifndef CONFIG_COMMON_CLK
 	struct clk *parent;
 	struct clk *mp;
 
@@ -43,6 +43,7 @@ static void __init ape6evm_add_standard_devices(void)
 	clk_set_parent(mp, parent);
 	clk_put(parent);
 	clk_put(mp);
+#endif
 
 	of_platform_populate(NULL, of_default_bus_match_table, NULL, NULL);
 }
-- 
2.1.4
