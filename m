From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:31:39 +0900
Subject: [PATCH 3/8] ARM: shmobile: r8a7790: Fix the I2C clocks parents in
 legacy code
In-Reply-To: <cover.1397694178.git.horms+renesas@verge.net.au>
References: <cover.1397694178.git.horms+renesas@verge.net.au>
Message-ID: <ab077bfdc4eaffa5328a9843d4d7970718ac0b8a.1397694178.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

All I2C clocks derive from the HP clock, not from the P clock. Fix them.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Reviewed-by: Wolfram Sang <wsa@sang-engineering.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index 3f93503..3310139 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -249,10 +249,10 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP1007] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 7, MSTPSR10, 0), /* SSI8 */
 	[MSTP1006] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 6, MSTPSR10, 0), /* SSI9 */
 	[MSTP1005] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR10, 5, MSTPSR10, 0), /* SSI ALL */
-	[MSTP931] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 31, MSTPSR9, 0), /* I2C0 */
-	[MSTP930] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 30, MSTPSR9, 0), /* I2C1 */
-	[MSTP929] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
-	[MSTP928] = SH_CLK_MSTP32_STS(&p_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
+	[MSTP931] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 31, MSTPSR9, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 30, MSTPSR9, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 29, MSTPSR9, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32_STS(&hp_clk, SMSTPCR9, 28, MSTPSR9, 0), /* I2C3 */
 	[MSTP917] = SH_CLK_MSTP32_STS(&qspi_clk, SMSTPCR9, 17, MSTPSR9, 0), /* QSPI */
 	[MSTP815] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 15, MSTPSR8, 0), /* SATA0 */
 	[MSTP814] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR8, 14, MSTPSR8, 0), /* SATA1 */
-- 
1.8.4
