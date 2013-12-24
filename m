From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:16:09 +0900
Subject: [PATCH 29/29] arm: shmobile: r7s72100: add i2c clocks
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <d85bcfa916ffdf078f188aeab60f738b290f4309.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Tested with RIIC2 on a genmai board. Others untested but hopefully
trivial enough to be added.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 4aba20c..850a8a3 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -27,6 +27,7 @@
 #define FRQCR2		0xfcfe0014
 #define STBCR3		0xfcfe0420
 #define STBCR4		0xfcfe0424
+#define STBCR9		0xfcfe0438
 
 #define PLL_RATE 30
 
@@ -144,10 +145,15 @@ struct clk div4_clks[DIV4_NR] = {
 					| CLK_ENABLE_ON_INIT),
 };
 
-enum { MSTP47, MSTP46, MSTP45, MSTP44, MSTP43, MSTP42, MSTP41, MSTP40,
+enum {	MSTP97, MSTP96, MSTP95, MSTP94,
+	MSTP47, MSTP46, MSTP45, MSTP44, MSTP43, MSTP42, MSTP41, MSTP40,
 	MSTP33,	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP97] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 7, 0), /* RIIC0 */
+	[MSTP96] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 6, 0), /* RIIC1 */
+	[MSTP95] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 5, 0), /* RIIC2 */
+	[MSTP94] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 4, 0), /* RIIC3 */
 	[MSTP47] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 7, 0), /* SCIF0 */
 	[MSTP46] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 6, 0), /* SCIF1 */
 	[MSTP45] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 5, 0), /* SCIF2 */
-- 
1.8.4
