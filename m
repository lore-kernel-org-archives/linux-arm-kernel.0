From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 14 Apr 2017 22:51:12 +0200
Subject: [PATCH 2/2] clk: spear: fix ADC clock definition on SPEAr600
In-Reply-To: <1492203072-27771-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1492203072-27771-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1492203072-27771-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no SPEAr600 device named "adc". Instead, the description of the
ADC was recently added to the Device Tree, and the device name is
"d820b000.adc", so we should associate the ADC gatable clock to this
device name.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 drivers/clk/spear/spear6xx_clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/spear/spear6xx_clock.c b/drivers/clk/spear/spear6xx_clock.c
index 7c9383c..f911d9f 100644
--- a/drivers/clk/spear/spear6xx_clock.c
+++ b/drivers/clk/spear/spear6xx_clock.c
@@ -313,7 +313,7 @@ void __init spear6xx_clk_init(void __iomem *misc_base)
 	/* clock derived from apb clk */
 	clk = clk_register_gate(NULL, "adc_clk", "apb_clk", 0, PERIP1_CLK_ENB,
 			ADC_CLK_ENB, 0, &_lock);
-	clk_register_clkdev(clk, NULL, "adc");
+	clk_register_clkdev(clk, NULL, "d820b000.adc");
 
 	clk = clk_register_fixed_factor(NULL, "gpio0_clk", "apb_clk", 0, 1, 1);
 	clk_register_clkdev(clk, NULL, "f0100000.gpio");
-- 
2.7.4
