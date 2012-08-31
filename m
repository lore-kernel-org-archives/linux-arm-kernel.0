From: horms@verge.net.au (Simon Horman)
Date: Fri, 31 Aug 2012 10:28:17 +0900
Subject: [PATCH 06/11] ARM: shmobile: r8a7779: add USB EHCI clock support
In-Reply-To: <1346376502-12114-1-git-send-email-horms@verge.net.au>
References: <1346376502-12114-1-git-send-email-horms@verge.net.au>
Message-ID: <1346376502-12114-7-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

ehci-platform driver require these clocks

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 3cafb6a..1d8842b 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -87,6 +87,7 @@ static struct clk div4_clks[DIV4_NR] = {
 };
 
 enum { MSTP323, MSTP322, MSTP321, MSTP320,
+	MSTP101, MSTP100,
 	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015, MSTP014,
 	MSTP_NR };
@@ -96,6 +97,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP322] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP320] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR3, 20, 0), /* SDHI3 */
+	[MSTP101] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  1, 0), /* USB2 */
+	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR1,  0, 0), /* USB0/1 */
 	[MSTP026] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 25, 0), /* SCIF1 */
 	[MSTP024] = SH_CLK_MSTP32(&div4_clks[DIV4_P], MSTPCR0, 24, 0), /* SCIF2 */
@@ -154,6 +157,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
+	CLKDEV_DEV_ID("ehci-platform.1", &mstp_clks[MSTP101]), /* USB EHCI port2 */
+	CLKDEV_DEV_ID("ehci-platform.0", &mstp_clks[MSTP100]), /* USB EHCI port0/1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
-- 
1.7.10.2.484.gcd07cc5
