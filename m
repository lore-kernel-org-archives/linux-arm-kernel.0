From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 15 Jul 2014 18:16:28 +0900
Subject: [PATCH 4/4] ARM: shmobile: sh73a0: add SCI clock support for DT
In-Reply-To: <cover.1405398284.git.horms+renesas@verge.net.au>
References: <cover.1405398284.git.horms+renesas@verge.net.au>
Message-ID: <ff4ce48e1f163d945c037c1c90ce12950961d91d.1405398284.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising SCI devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 0d9cd1f..4990e03 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -638,16 +638,25 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("e6820000.i2c", &mstp_clks[MSTP116]), /* I2C0 */
 	CLKDEV_DEV_ID("sh_mobile_lcdc_fb.0", &mstp_clks[MSTP100]), /* LCDC0 */
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP219]), /* SCIFA7 */
+	CLKDEV_DEV_ID("e6cd0000.serial", &mstp_clks[MSTP219]), /* SCIFA7 */
 	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP218]), /* SY-DMAC */
 	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP217]), /* MP-DMAC */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP207]), /* SCIFA5 */
+	CLKDEV_DEV_ID("e6cb0000.serial", &mstp_clks[MSTP207]), /* SCIFA5 */
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP206]), /* SCIFB */
+	CLKDEV_DEV_ID("0xe6c3000.serial", &mstp_clks[MSTP206]), /* SCIFB */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP204]), /* SCIFA0 */
+	CLKDEV_DEV_ID("e6c40000.serial", &mstp_clks[MSTP204]), /* SCIFA0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP203]), /* SCIFA1 */
+	CLKDEV_DEV_ID("e6c50000.serial", &mstp_clks[MSTP203]), /* SCIFA1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP202]), /* SCIFA2 */
+	CLKDEV_DEV_ID("e6c60000.serial", &mstp_clks[MSTP202]), /* SCIFA2 */
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP201]), /* SCIFA3 */
+	CLKDEV_DEV_ID("e6c70000.serial", &mstp_clks[MSTP201]), /* SCIFA3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP200]), /* SCIFA4 */
+	CLKDEV_DEV_ID("e6c80000.serial", &mstp_clks[MSTP200]), /* SCIFA4 */
 	CLKDEV_DEV_ID("sh-sci.6", &mstp_clks[MSTP331]), /* SCIFA6 */
+	CLKDEV_DEV_ID("e6cc0000.serial", &mstp_clks[MSTP331]), /* SCIFA6 */
 	CLKDEV_DEV_ID("sh_fsi2", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("ec230000.sound", &mstp_clks[MSTP328]), /* FSI */
 	CLKDEV_DEV_ID("sh_irda.0", &mstp_clks[MSTP325]), /* IrDA */
-- 
2.0.0
