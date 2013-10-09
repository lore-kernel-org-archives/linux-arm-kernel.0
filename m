From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  9 Oct 2013 15:49:45 +0900
Subject: [PATCH 04/14] ARM: shmobile: r8a7790: add I2C clocks and aliases for
 the DT mode
In-Reply-To: <cover.1381293239.git.horms+renesas@verge.net.au>
References: <cover.1381293239.git.horms+renesas@verge.net.au>
Message-ID: <911a644cfa03d834220621f22bb4a4d41dfe27d4.1381293239.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

This patch adds clock definitions for the 4 I2C interfaces on r8a7790 and
clock aliases, suitable for the DT mode.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index d99b87b..7661e89 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -52,6 +52,7 @@
 #define SMSTPCR5 0xe6150144
 #define SMSTPCR7 0xe615014c
 #define SMSTPCR8 0xe6150990
+#define SMSTPCR9 0xe6150994
 
 #define SDCKCR		0xE6150074
 #define SD2CKCR		0xE6150078
@@ -181,6 +182,7 @@ static struct clk div6_clks[DIV6_NR] = {
 
 /* MSTP */
 enum {
+	MSTP931, MSTP930, MSTP929, MSTP928,
 	MSTP813,
 	MSTP726, MSTP725, MSTP724, MSTP723, MSTP722, MSTP721, MSTP720,
 	MSTP717, MSTP716,
@@ -192,6 +194,10 @@ enum {
 };
 
 static struct clk mstp_clks[MSTP_NR] = {
+	[MSTP931] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 31, 0), /* I2C0 */
+	[MSTP930] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 30, 0), /* I2C1 */
+	[MSTP929] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 29, 0), /* I2C2 */
+	[MSTP928] = SH_CLK_MSTP32(&hp_clk, SMSTPCR9, 28, 0), /* I2C3 */
 	[MSTP813] = SH_CLK_MSTP32(&p_clk, SMSTPCR8, 13, 0), /* Ether */
 	[MSTP726] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 26, 0), /* LVDS0 */
 	[MSTP725] = SH_CLK_MSTP32(&zx_clk, SMSTPCR7, 25, 0), /* LVDS1 */
@@ -271,6 +277,10 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.7", &mstp_clks[MSTP720]),
 	CLKDEV_DEV_ID("sh-sci.8", &mstp_clks[MSTP717]),
 	CLKDEV_DEV_ID("sh-sci.9", &mstp_clks[MSTP716]),
+	CLKDEV_DEV_ID("e6508000.i2c", &mstp_clks[MSTP931]),
+	CLKDEV_DEV_ID("e6518000.i2c", &mstp_clks[MSTP930]),
+	CLKDEV_DEV_ID("e6530000.i2c", &mstp_clks[MSTP929]),
+	CLKDEV_DEV_ID("e6540000.i2c", &mstp_clks[MSTP928]),
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("ee200000.mmcif", &mstp_clks[MSTP315]),
-- 
1.8.4
