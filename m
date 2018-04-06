From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Fri,  6 Apr 2018 09:50:45 +0200
Subject: [PATCH 2/2] clk: spear: fix WDT clock definition on SPEAr600
In-Reply-To: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
References: <0635969b6ef0fe528a27a8b6493cc3df770e1f60.1523000725.git-series.quentin.schulz@bootlin.com>
Message-ID: <c7240072ab53d5d34a9756389729343243028eb3.1523000725.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no SPEAr600 device named "wdt". Instead, the description of the
WDT (watchdog) was recently added to the Device Tree, and the device
name is "fc880000.wdt", so we should associate the WDT fixed rate clock
to this device name.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
---
 drivers/clk/spear/spear6xx_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index f911d9f..47810be 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -147,7 +147,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 
 	clk = clk_register_fixed_factor(NULL, "wdt_clk", "osc_30m_clk", 0, 1,
 			1);
-	clk_register_clkdev(clk, NULL, "wdt");
+	clk_register_clkdev(clk, NULL, "fc880000.wdt");
 
 	/* clock derived from pll1 clk */
 	clk = clk_register_fixed_factor(NULL, "cpu_clk", "pll1_clk",
-- 
git-series 0.9.1
