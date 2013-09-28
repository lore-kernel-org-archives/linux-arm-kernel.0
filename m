From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 28 Sep 2013 04:44:09 +0400
Subject: [PATCH 1/2] ARM: shmobile: r8a7778: add CAN clock support
In-Reply-To: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
References: <201309280441.52414.sergei.shtylyov@cogentembedded.com>
Message-ID: <201309280444.09539.sergei.shtylyov@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for R8A7778 CAN0/1 clocks.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

---
 arch/arm/mach-shmobile/clock-r8a7778.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: renesas/arch/arm/mach-shmobile/clock-r8a7778.c
===================================================================
--- renesas.orig/arch/arm/mach-shmobile/clock-r8a7778.c
+++ renesas/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -117,6 +117,7 @@ static struct clk *main_clks[] = {
 enum {
 	MSTP331,
 	MSTP323, MSTP322, MSTP321,
+	MSTP316, MSTP315,
 	MSTP311, MSTP310,
 	MSTP309, MSTP308, MSTP307,
 	MSTP114,
@@ -133,6 +134,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP323] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 23, 0), /* SDHI0 */
 	[MSTP322] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 22, 0), /* SDHI1 */
 	[MSTP321] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 21, 0), /* SDHI2 */
+	[MSTP316] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 16, 0), /* CAN0 */
+	[MSTP315] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 15, 0), /* CAN1 */
 	[MSTP311] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 11, 0), /* SSI4 */
 	[MSTP310] = SH_CLK_MSTP32(&p_clk, MSTPCR3, 10, 0), /* SSI5 */
 	[MSTP309] = SH_CLK_MSTP32(&p_clk, MSTPCR3,  9, 0), /* SSI6 */
@@ -176,6 +179,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.2", &mstp_clks[MSTP321]), /* SDHI2 */
+	CLKDEV_DEV_ID("rcar_can.0", &mstp_clks[MSTP316]), /* CAN0 */
+	CLKDEV_DEV_ID("rcar_can.1", &mstp_clks[MSTP315]), /* CAN1 */
 	CLKDEV_DEV_ID("r8a777x-ether", &mstp_clks[MSTP114]), /* Ether */
 	CLKDEV_DEV_ID("r8a7778-vin.0", &mstp_clks[MSTP110]), /* VIN0 */
 	CLKDEV_DEV_ID("r8a7778-vin.1", &mstp_clks[MSTP109]), /* VIN1 */
