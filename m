From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Wed,  5 Nov 2014 10:09:43 +0100
Subject: [PATCH] ARM: shmobile: r8a7740 legacy: Fix INTCA clock parent
Message-ID: <1415178583-28406-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The parent clock index for the INTCA clock indexed the wrong array,
causing the parent clock to point to arbitrary memory instead of a real
struct clk.

Fixes: 2b02b8020fad6ed5 ("ARM: shmobile: r8a7740 legacy: Add missing INTCA clock for irqpin module")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/mach-shmobile/clock-r8a7740.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-shmobile/clock-r8a7740.c b/arch/arm/mach-shmobile/clock-r8a7740.c
index bd5ecc3c16d756d4..dbb0ab283e2fe91f 100644
--- a/arch/arm/mach-shmobile/clock-r8a7740.c
+++ b/arch/arm/mach-shmobile/clock-r8a7740.c
@@ -475,7 +475,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP100] = SH_CLK_MSTP32(&div4_clks[DIV4_B],	SMSTPCR1,  0, 0), /* LCDC0 */
 
 	[MSTP230] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 30, 0), /* SCIFA6 */
-	[MSTP229] = SH_CLK_MSTP32(&div6_clks[DIV4_HP],	SMSTPCR2, 29, 0), /* INTCA */
+	[MSTP229] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],	SMSTPCR2, 29, 0), /* INTCA */
 	[MSTP222] = SH_CLK_MSTP32(&div6_clks[DIV6_SUB],	SMSTPCR2, 22, 0), /* SCIFA7 */
 	[MSTP218] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 18, 0), /* DMAC1 */
 	[MSTP217] = SH_CLK_MSTP32(&div4_clks[DIV4_HP],  SMSTPCR2, 17, 0), /* DMAC2 */
-- 
1.9.1
