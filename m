From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:00:21 +0900
Subject: [PATCH 4/7] ARM: shmobile: r8a7790: Make private clock arrays static
In-Reply-To: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
References: <1369645224-3728-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369645224-3728-5-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Both clock-r8a7740.c and clock-r8a7790.c define a div4_clks array as
non-static. Compiling support for both SoCs thus result in a symbol
redefinition. Fix it by defining the arrays as static.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index a481003..bedd20c 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -154,7 +154,7 @@ enum {
 	DIV4_SDH, DIV4_SD0, DIV4_SD1, DIV4_NR
 };
 
-struct clk div4_clks[DIV4_NR] = {
+static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SDH] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 8, 0x0dff, CLK_ENABLE_ON_INIT),
 	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1de0, CLK_ENABLE_ON_INIT),
 	[DIV4_SD1] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 0, 0x1de0, CLK_ENABLE_ON_INIT),
-- 
1.7.10.4
