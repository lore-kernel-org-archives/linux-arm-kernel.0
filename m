From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  2 Jul 2014 06:28:37 +0200
Subject: [PATCH/RFC 1/6] ARM: shmobile: r8a7778: add SCI clock support for DT
In-Reply-To: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
References: <1404275322-26514-1-git-send-email-horms+renesas@verge.net.au>
Message-ID: <1404275322-26514-2-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising SCI devices using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7778.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7778.c b/arch/arm/mach-shmobile/clock-r8a7778.c
index 16bbc94..9557907 100644
--- a/arch/arm/mach-shmobile/clock-r8a7778.c
+++ b/arch/arm/mach-shmobile/clock-r8a7778.c
@@ -202,11 +202,17 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP027]), /* I2C3 */
 	CLKDEV_DEV_ID("ffc73000.i2c", &mstp_clks[MSTP027]), /* I2C3 */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
+	CLKDEV_DEV_ID("ffe40000.serial", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
+	CLKDEV_DEV_ID("ffe41000.serial", &mstp_clks[MSTP025]), /* SCIF1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
+	CLKDEV_DEV_ID("ffe42000.serial", &mstp_clks[MSTP024]), /* SCIF2 */
 	CLKDEV_DEV_ID("sh-sci.3", &mstp_clks[MSTP023]), /* SCIF3 */
+	CLKDEV_DEV_ID("ffe43000.serial", &mstp_clks[MSTP023]), /* SCIF3 */
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
+	CLKDEV_DEV_ID("ffe44000.serial", &mstp_clks[MSTP022]), /* SCIF4 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
+	CLKDEV_DEV_ID("ffe45000.serial", &mstp_clks[MSTP021]), /* SCIF5 */
 	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
 	CLKDEV_DEV_ID("fffc7000.spi", &mstp_clks[MSTP007]), /* HSPI0 */
 	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
-- 
2.0.0.rc2
