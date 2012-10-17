From: horms@verge.net.au (Simon Horman)
Date: Wed, 17 Oct 2012 13:39:18 +0900
Subject: [PATCH 07/10] ARM: shmobile: r8a7779: add HSPI clock support
In-Reply-To: <1350448761-27346-1-git-send-email-horms@verge.net.au>
References: <1350448761-27346-1-git-send-email-horms@verge.net.au>
Message-ID: <1350448761-27346-8-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 3cafb6a..90d717b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -89,6 +89,7 @@ static struct clk div4_clks[DIV4_NR] = {
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
 	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015, MSTP014,
+	MSTP007,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
@@ -105,6 +106,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP016] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 16, 0), /* TMU0 */
 	[MSTP015] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 15, 0), /* TMU1 */
 	[MSTP014] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 14, 0), /* TMU2 */
+	[MSTP007] = SH_CLK_MSTP32(&div4_clks[DIV4_S], MSTPCR0,  7, 0), /* HSPI */
 };
 
 static unsigned long mul4_recalc(struct clk *clk)
@@ -154,6 +156,9 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
+	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
+	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
+	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
-- 
1.7.10.4
