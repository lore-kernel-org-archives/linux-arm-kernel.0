From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 24 Jul 2014 10:57:42 +0900
Subject: [PATCH 5/5] ARM: shmobile: sh73a0: add CMT1 clock support for DT
In-Reply-To: <cover.1406164563.git.horms+renesas@verge.net.au>
References: <cover.1406164563.git.horms+renesas@verge.net.au>
Message-ID: <a0f7e7496d56ac2da7c684e2035815318c17973a.1406164563.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This will be used when initialising CMT1 device using DT
until common clock framework support is added.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/clock-sh73a0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-shmobile/clock-sh73a0.c b/arch/arm/mach-shmobile/clock-sh73a0.c
index 4990e03..0d77f65 100644
--- a/arch/arm/mach-shmobile/clock-sh73a0.c
+++ b/arch/arm/mach-shmobile/clock-sh73a0.c
@@ -690,6 +690,7 @@ static struct clk_lookup lookups[] = {
 	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.0", &dsi0phy_clk),
 	CLKDEV_ICK_ID("dsiphy_clk", "sh-mipi-dsi.1", &dsi1phy_clk),
 	CLKDEV_ICK_ID("fck", "sh-cmt-48.1", &mstp_clks[MSTP329]), /* CMT1 */
+	CLKDEV_ICK_ID("fck", "e6138000.timer", &mstp_clks[MSTP329]), /* CMT1 */
 	CLKDEV_ICK_ID("fck", "sh-tmu.0", &mstp_clks[MSTP125]), /* TMU0 */
 };
 
-- 
2.0.1
