From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 20 Jan 2015 13:51:40 +0100
Subject: [PATCH 3/9] ARM: shmobile: ape6evm: Disable legacy clock
 initialization
In-Reply-To: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
References: <1421758306-24838-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1421758306-24838-4-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

Disables r8a73a4_clock_init() if CCF is enabled.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/board-ape6evm-reference.c b/arch/arm/mach-shmobile/board-ape6evm-reference.c
index 3b68370b03a09ad1..dd5bc63aba421df2 100644
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
1.9.1
