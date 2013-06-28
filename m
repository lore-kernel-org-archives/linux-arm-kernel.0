From: magnus.damm@gmail.com (Magnus Damm)
Date: Fri, 28 Jun 2013 19:13:27 +0900
Subject: [PATCH] ARM: shmobile: Sort r8a7790 MSTP entries
Message-ID: <20130628101327.26876.89435.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

The r8a7790 MSTP bits should be kept sorted in the same way
as on other mach-shmobile SoCs. Move the HSCIF and thermal
bits to clean up the current state.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 Written on top of renesas-next-20130628

 arch/arm/mach-shmobile/clock-r8a7790.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- 0001/arch/arm/mach-shmobile/clock-r8a7790.c
+++ work/arch/arm/mach-shmobile/clock-r8a7790.c	2013-06-28 15:15:50.000000000 +0900
@@ -192,6 +192,9 @@ enum {
 static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP721] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 21, 0), /* SCIF0 */
 	[MSTP720] = SH_CLK_MSTP32(&p_clk, SMSTPCR7, 20, 0), /* SCIF1 */
+	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
+	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
+	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
 	[MSTP315] = SH_CLK_MSTP32(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, 0), /* MMC0 */
 	[MSTP314] = SH_CLK_MSTP32(&div4_clks[DIV4_SD0], SMSTPCR3, 14, 0), /* SDHI0 */
 	[MSTP313] = SH_CLK_MSTP32(&div4_clks[DIV4_SD1], SMSTPCR3, 13, 0), /* SDHI1 */
@@ -205,9 +208,6 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP204] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 4, 0), /* SCIFA0 */
 	[MSTP203] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 3, 0), /* SCIFA1 */
 	[MSTP202] = SH_CLK_MSTP32(&mp_clk, SMSTPCR2, 2, 0), /* SCIFA2 */
-	[MSTP522] = SH_CLK_MSTP32(&extal_clk, SMSTPCR5, 22, 0), /* Thermal */
-	[MSTP717] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 17, 0), /* HSCIF0 */
-	[MSTP716] = SH_CLK_MSTP32(&zs_clk, SMSTPCR7, 16, 0), /* HSCIF1 */
 };
 
 static struct clk_lookup lookups[] = {
