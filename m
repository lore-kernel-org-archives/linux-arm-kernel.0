From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:14:00 +0900
Subject: [PATCH 11/12] ARM: shmobile: r7s72100: Add clock for r7s72100-ether
In-Reply-To: <cover.1392277789.git.horms+renesas@verge.net.au>
References: <cover.1392277789.git.horms+renesas@verge.net.au>
Message-ID: <ad2576ecc8cfada53b77c650ace3397921234503.1392278855.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Acked-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r7s72100.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r7s72100.c b/arch/arm/mach-shmobile/clock-r7s72100.c
index 71c99fe..f17a5db 100644
--- a/arch/arm/mach-shmobile/clock-r7s72100.c
+++ b/arch/arm/mach-shmobile/clock-r7s72100.c
@@ -28,6 +28,7 @@
 /* Standby Control Registers */
 #define STBCR3		0xfcfe0420
 #define STBCR4		0xfcfe0424
+#define STBCR7		0xfcfe0430
 #define STBCR9		0xfcfe0438
 #define STBCR10		0xfcfe043c
 
@@ -150,6 +151,7 @@ struct clk div4_clks[DIV4_NR] = {
 enum {
 	MSTP107, MSTP106, MSTP105, MSTP104, MSTP103,
 	MSTP97, MSTP96, MSTP95, MSTP94,
+	MSTP74,
 	MSTP47, MSTP46, MSTP45, MSTP44, MSTP43, MSTP42, MSTP41, MSTP40,
 	MSTP33,	MSTP_NR
 };
@@ -164,6 +166,7 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP96] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 6, 0), /* RIIC1 */
 	[MSTP95] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 5, 0), /* RIIC2 */
 	[MSTP94] = SH_CLK_MSTP8(&peripheral0_clk, STBCR9, 4, 0), /* RIIC3 */
+	[MSTP74] = SH_CLK_MSTP8(&peripheral1_clk, STBCR7, 4, 0), /* Ether */
 	[MSTP47] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 7, 0), /* SCIF0 */
 	[MSTP46] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 6, 0), /* SCIF1 */
 	[MSTP45] = SH_CLK_MSTP8(&peripheral1_clk, STBCR4, 5, 0), /* SCIF2 */
@@ -200,6 +203,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("fcfee400.i2c", &mstp_clks[MSTP96]),
 	CLKDEV_DEV_ID("fcfee800.i2c", &mstp_clks[MSTP95]),
 	CLKDEV_DEV_ID("fcfeec00.i2c", &mstp_clks[MSTP94]),
+	CLKDEV_DEV_ID("r7s72100-ether", &mstp_clks[MSTP74]),
 	CLKDEV_CON_ID("mtu2_fck", &mstp_clks[MSTP33]),
 
 	/* ICK */
-- 
1.8.5.2
