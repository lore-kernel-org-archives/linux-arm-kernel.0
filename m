From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:21:00 +0900
Subject: [PATCH 03/13] ARM: shmobile: r8a7791: Add I2C clocks
In-Reply-To: <cover.1391666228.git.horms+renesas@verge.net.au>
References: <cover.1391666228.git.horms+renesas@verge.net.au>
Message-ID: <106c0e8fa3a2f7a40d25583e193e34af3861564d.1391666228.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Valentine Barshak <valentine.barshak@cogentembedded.com>

This adds I2C[0-5] clock support to R8A7791 SoC.

Changes in V2:
* Capitalized ARM in the subject.

Signed-off-by: Valentine Barshak <valentine.barshak@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7791.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7791.c b/arch/arm/mach-shmobile/clock-r8a7791.c
index f546126..fe4a774 100644
--- a/arch/arm/mach-shmobile/clock-r8a7791.c
+++ b/arch/arm/mach-shmobile/clock-r8a7791.c
@@ -122,6 +122,7 @@ static struct clk *main_clks[] = {
 
 /* MSTP */
 enum {
+	MSTP931, MSTP930, MSTP929, MSTP928, MSTP927, MSTP925,
 	MSTP813,
 	MSTP726, MSTP724, MSTP723, MSTP721, MSTP720,
 	MSTP719, MSTP718, MSTP715, MSTP714,
@@ -133,6 +134,12 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP931] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 31, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 30, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 29, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 28, 0), /* I2C3 */
+	[MSTP927] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 27, 0), /* I2C4 */
+	[MSTP925] = SH_CLK_MSTP32(&p_clk, SMSTPCR9, 25, 0), /* I2C5 */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP724] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 24, 0), /* DU0 */
@@ -194,6 +201,12 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_cmt.0", &mstp_clks[MSTP124]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.0", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.1", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.2", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.3", &mstp_clks[MSTP928]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.4", &mstp_clks[MSTP927]),
+	CLKDEV_DEV_ID("i2c-rcar_gen2.5", &mstp_clks[MSTP925]),
 	CLKDEV_DEV_ID("r8a7791-ether", &mstp_clks[MSTP813]), /* Ether */
 };
 
-- 
1.8.5.2
