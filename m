From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:30:06 +0900
Subject: [PATCH 33/33] ARM: shmobile: r8a7779: add HSPI clock support for DT
In-Reply-To: <cover.1386897180.git.horms+renesas@verge.net.au>
References: <cover.1386897180.git.horms+renesas@verge.net.au>
Message-ID: <fee05eb3d2ce4813b5e9a70ab888d2bc0047f4e1.1386897180.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Based on work for the r8a7778 SoC by Kuninori Morimoto.

Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-r8a7779.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-shmobile/clock-r8a7779.c b/arch/arm/mach-shmobile/clock-r8a7779.c
index 5c83259..b545c8d 100644
--- a/arch/arm/mach-shmobile/clock-r8a7779.c
+++ b/arch/arm/mach-shmobile/clock-r8a7779.c
@@ -198,8 +198,11 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_DEV_ID("sh-sci.4", &mstp_clks[MSTP022]), /* SCIF4 */
 	CLKDEV_DEV_ID("sh-sci.5", &mstp_clks[MSTP021]), /* SCIF6 */
 	CLKDEV_DEV_ID("sh-hspi.0", &mstp_clks[MSTP007]), /* HSPI0 */
+	CLKDEV_DEV_ID("fffc7000.spi", &mstp_clks[MSTP007]), /* HSPI0 */
 	CLKDEV_DEV_ID("sh-hspi.1", &mstp_clks[MSTP007]), /* HSPI1 */
+	CLKDEV_DEV_ID("fffc8000.spi", &mstp_clks[MSTP007]), /* HSPI1 */
 	CLKDEV_DEV_ID("sh-hspi.2", &mstp_clks[MSTP007]), /* HSPI2 */
+	CLKDEV_DEV_ID("fffc6000.spi", &mstp_clks[MSTP007]), /* HSPI2 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.0", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("ffe4c000.sdhi", &mstp_clks[MSTP323]), /* SDHI0 */
 	CLKDEV_DEV_ID("sh_mobile_sdhi.1", &mstp_clks[MSTP322]), /* SDHI1 */
-- 
1.8.4
