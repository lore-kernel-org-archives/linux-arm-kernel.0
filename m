From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  6 Feb 2014 15:21:03 +0900
Subject: [PATCH 06/13] ARM: shmobile: r8a7790: add Audio DMAC clock
In-Reply-To: <cover.1391666228.git.horms+renesas@verge.net.au>
References: <cover.1391666228.git.horms+renesas@verge.net.au>
Message-ID: <f5b2947e4a6589f07d485ca149d606283294979f.1391666228.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Audio DMAC can be controlled via sh-dma-engine

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7790.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7790.c b/arch/arm/mach-shmobile/clock-r8a7790.c
index a028f96..58f3dcf 100644
--- a/arch/arm/mach-shmobile/clock-r8a7790.c
+++ b/arch/arm/mach-shmobile/clock-r8a7790.c
@@ -201,6 +201,7 @@ enum {
 	MSTP717, MSTP716,
 	MSTP704,
 	MSTP522,
+	MSTP502, MSTP501,
 	MSTP315, MSTP314, MSTP313, MSTP312, MSTP311, MSTP305, MSTP304,
 	MSTP216, MSTP207, MSTP206, MSTP204, MSTP203, MSTP202,
 	MSTP124,
@@ -236,6 +237,8 @@ static struct clk mstp_clks[MSTP_NR] = {
 	[MSTP716] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR7, 16, MSTPSR7, 0), /* HSCIF1 */
 	[MSTP704] = SH_CLK_MSTP32_STS(&mp_clk, SMSTPCR7, 4, MSTPSR7, 0), /* HSUSB */
 	[MSTP522] = SH_CLK_MSTP32_STS(&extal_clk, SMSTPCR5, 22, MSTPSR5, 0), /* Thermal */
+	[MSTP502] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR5, 2, MSTPSR5, 0), /* Audio-DMAC low */
+	[MSTP501] = SH_CLK_MSTP32_STS(&zs_clk, SMSTPCR5, 1, MSTPSR5, 0), /* Audio-DMAC hi */
 	[MSTP315] = SH_CLK_MSTP32_STS(&div6_clks[DIV6_MMC0], SMSTPCR3, 15, MSTPSR3, 0), /* MMC0 */
 	[MSTP314] = SH_CLK_MSTP32_STS(&div4_clks[DIV4_SD0], SMSTPCR3, 14, MSTPSR3, 0), /* SDHI0 */
 	[MSTP313] = SH_CLK_MSTP32_STS(&div4_clks[DIV4_SD1], SMSTPCR3, 13, MSTPSR3, 0), /* SDHI1 */
@@ -311,6 +314,8 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("r8a7790-ether", &mstp_clks[MSTP813]),
 	CLKDEV_DEV_ID("e61f0000.thermal", &mstp_clks[MSTP522]),
 	CLKDEV_DEV_ID("rcar_thermal", &mstp_clks[MSTP522]),
+	CLKDEV_DEV_ID("sh-dma-engine.0", &mstp_clks[MSTP502]),
+	CLKDEV_DEV_ID("sh-dma-engine.1", &mstp_clks[MSTP501]),
 	CLKDEV_DEV_ID("ee200000.mmc", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("sh_mmcif.0", &mstp_clks[MSTP315]),
 	CLKDEV_DEV_ID("ee100000.sd", &mstp_clks[MSTP314]),
-- 
1.8.5.2
