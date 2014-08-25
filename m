From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:09:48 +0900
Subject: [PATCH 3/3] ARM: shmobile: r8a7791: add missing 0x0100 for SDCKCR
In-Reply-To: <cover.1408926048.git.horms+renesas@verge.net.au>
References: <cover.1408926048.git.horms+renesas@verge.net.au>
Message-ID: <58b80ad6472c0fa12926dfa1f9103d3a326bdf18.1408926048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

4bfb358b1d6cdeff8c6a13677f01ed78e9696b98
(ARM: shmobile: Add r8a7791 legacy SDHI clocks)
added r8a7791 SDHI clock support.

But, it is missing
"0x0100: x 1/8" division ratio.
This patch fixes hidden bug.
It is based on R-Car H2 v0.7, R-Car M2 v0.9.

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index e2fdfcc..53161c4 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -152,7 +152,7 @@ enum {
 
 static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SDH] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 8, 0x0dff, CLK_ENABLE_ON_INIT),
-	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1de0, CLK_ENABLE_ON_INIT),
+	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1df0, CLK_ENABLE_ON_INIT),
 };
 
 /* DIV6 clocks */
-- 
2.0.1
