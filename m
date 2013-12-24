From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:15:45 +0900
Subject: [PATCH 01/29] ARM: shmobile: r8a7778: add sound SCU clock support
In-Reply-To: <cover.1387888861.git.horms+renesas@verge.net.au>
References: <cover.1387888861.git.horms+renesas@verge.net.au>
Message-ID: <950c4477f7804174338fb32c8cc6f9d228eef833.1387888861.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

This is needed to use SRC (= Sampling Rate Converter)

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 5406434..dfb0fff 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -115,6 +115,8 @@ static struct clk *main_clks[] = {
 };
 
 enum {
+	MSTP531, MSTP530,
+	MSTP529, MSTP528, MSTP527, MSTP526, MSTP525, MSTP524, MSTP523,
 	MSTP331,
 	MSTP323, MSTP322, MSTP321,
 	MSTP311, MSTP310,
@@ -129,6 +131,15 @@ enum {
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP531] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 31, 0), /* SCU0 */
+	[MSTP530] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 30, 0), /* SCU1 */
+	[MSTP529] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 29, 0), /* SCU2 */
+	[MSTP528] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 28, 0), /* SCU3 */
+	[MSTP527] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 27, 0), /* SCU4 */
+	[MSTP526] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 26, 0), /* SCU5 */
+	[MSTP525] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 25, 0), /* SCU6 */
+	[MSTP524] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 24, 0), /* SCU7 */
+	[MSTP523] = SH_CLK_MSTP32(&p_clk, MSTPCR5, 23, 0), /* SCU8 */
 	[MSTP331] = SH_CLK_MSTP32(&s4_clk, MSTPCR3, 31, 0), /* MMC */
 	[MSTP323] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 23, 0), /* SDHI0 */
 	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
@@ -219,6 +230,15 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("ssi.6", "rcar_sound", &mstp_clks[MSTP309]),
 	CLKDEV_ICK_ID("ssi.7", "rcar_sound", &mstp_clks[MSTP308]),
 	CLKDEV_ICK_ID("ssi.8", "rcar_sound", &mstp_clks[MSTP307]),
+	CLKDEV_ICK_ID("scu.0", "rcar_sound", &mstp_clks[MSTP531]),
+	CLKDEV_ICK_ID("scu.1", "rcar_sound", &mstp_clks[MSTP530]),
+	CLKDEV_ICK_ID("scu.2", "rcar_sound", &mstp_clks[MSTP529]),
+	CLKDEV_ICK_ID("scu.3", "rcar_sound", &mstp_clks[MSTP528]),
+	CLKDEV_ICK_ID("scu.4", "rcar_sound", &mstp_clks[MSTP527]),
+	CLKDEV_ICK_ID("scu.5", "rcar_sound", &mstp_clks[MSTP526]),
+	CLKDEV_ICK_ID("scu.6", "rcar_sound", &mstp_clks[MSTP525]),
+	CLKDEV_ICK_ID("scu.7", "rcar_sound", &mstp_clks[MSTP524]),
+	CLKDEV_ICK_ID("scu.8", "rcar_sound", &mstp_clks[MSTP523]),
 };
 
 void __init r8a7778_clock_init(void)
-- 
1.8.4
