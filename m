From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:09:47 +0900
Subject: [PATCH 2/3] ARM: shmobile: r8a7790: add missing 0x0100 for SDCKCR
In-Reply-To: <cover.1408926048.git.horms+renesas@verge.net.au>
References: <cover.1408926048.git.horms+renesas@verge.net.au>
Message-ID: <4fb12fe9c34928c1d2bed817e144aec3f44540e9.1408926048.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

9f13ee6f83c52065112d3e396e42e3780911ef53
(ARM: shmobile: r8a7790: add div4 clocks)
added r8a7790 DIV4 clock support.

But, it is missing
"0x0100: x 1/8" division ratio.
This patch fixes hidden bug.
It is based on R-Car H2 v0.7, R-Car M2 v0.9.

Reported-by: Yusuke Goda <yusuke.goda.sx@renesas.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 296a057..c62bfe7 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -181,8 +181,8 @@ enum {
 
 static struct clk div4_clks[DIV4_NR] = {
 	[DIV4_SDH] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 8, 0x0dff, CLK_ENABLE_ON_INIT),
-	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1de0, CLK_ENABLE_ON_INIT),
-	[DIV4_SD1] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 0, 0x1de0, CLK_ENABLE_ON_INIT),
+	[DIV4_SD0] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 4, 0x1df0, CLK_ENABLE_ON_INIT),
+	[DIV4_SD1] = SH_CLK_DIV4(&pll1_clk, SDCKCR, 0, 0x1df0, CLK_ENABLE_ON_INIT),
 };
 
 /* DIV6 clocks */
-- 
2.0.1
