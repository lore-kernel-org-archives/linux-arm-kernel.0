From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon,  2 Dec 2013 11:19:04 +0900
Subject: [PATCH 02/28] ARM: shmobile: r8a7779: add I2C clock for DT
In-Reply-To: <cover.1385950394.git.horms+renesas@verge.net.au>
References: <cover.1385950394.git.horms+renesas@verge.net.au>
Message-ID: <d071601e1a05dbb63454dcdf9b7320cd8da3b86d.1385950394.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

10e8d4f6dddb0f9dc408c2f2bde8399b243a42ca
(ARM: mach-shmobile: r8a7779: Minimal setup using DT)
added I2C driver for DT, but it didn't add clock.
This patch adds missing clock for I2C

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 1f7080f..badb8b7 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -184,9 +184,13 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh_tmu.1", &mstp_clks[MSTP016]), /* TMU01 */
 	CLKDEV_DEV_ID("sh_tmu.2", &mstp_clks[MSTP016]), /* TMU02 */
 	CLKDEV_DEV_ID("i2c-rcar.0", &mstp_clks[MSTP030]), /* I2C0 */
+	CLKDEV_DEV_ID("ffc70000.i2c", &mstp_clks[MSTP030]), /* I2C0 */
 	CLKDEV_DEV_ID("i2c-rcar.1", &mstp_clks[MSTP029]), /* I2C1 */
+	CLKDEV_DEV_ID("ffc71000.i2c", &mstp_clks[MSTP029]), /* I2C1 */
 	CLKDEV_DEV_ID("i2c-rcar.2", &mstp_clks[MSTP028]), /* I2C2 */
+	CLKDEV_DEV_ID("ffc72000.i2c", &mstp_clks[MSTP028]), /* I2C2 */
 	CLKDEV_DEV_ID("i2c-rcar.3", &mstp_clks[MSTP027]), /* I2C3 */
+	CLKDEV_DEV_ID("ffc73000.i2c", &mstp_clks[MSTP027]), /* I2C3 */
 	CLKDEV_DEV_ID("sh-sci.0", &mstp_clks[MSTP026]), /* SCIF0 */
 	CLKDEV_DEV_ID("sh-sci.1", &mstp_clks[MSTP025]), /* SCIF1 */
 	CLKDEV_DEV_ID("sh-sci.2", &mstp_clks[MSTP024]), /* SCIF2 */
-- 
1.8.4
