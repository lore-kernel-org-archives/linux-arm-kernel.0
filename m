From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 27 May 2013 18:59:31 +0900
Subject: [PATCH 7/9] ARM: shmobile: r8a7778: add SDHI clock support
In-Reply-To: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
References: <1369648773-7941-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1369648773-7941-8-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 5cc271e..b251e4d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -103,12 +103,16 @@ static struct clk *main_clks[] = {
 };
 
 enum {
+	MSTP323, MSTP322, MSTP321,
 	MSTP114,
 	MSTP026, MSTP025, MSTP024, MSTP023, MSTP022, MSTP021,
 	MSTP016, MSTP015,
 	MSTP_NR };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP323] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 23, 0), /* SDHI0 */
+	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
+	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
 	[MSTP114] = SH_CLK_MSTP32(&p_clk, MSTPCR1, 14, 0), /* Ether */
 	[MSTP026] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 26, 0), /* SCIF0 */
 	[MSTP025] = SH_CLK_MSTP32(&p_clk, MSTPCR0, 25, 0), /* SCIF1 */
@@ -122,6 +126,9 @@ static struct clk mstp_clks[MSTP_NR] = {
 
 static struct clk_lookup lookups[] = {
 	/* MSTP32 clocks */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
+	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
 	CLKDEV_DEV_ID("sh-eth",	&mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
-- 
1.7.10.4
