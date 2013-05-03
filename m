From: marek.belisko@gmail.com (Marek Belisko)
Date: Fri,  3 May 2013 07:53:22 +0200
Subject: [PATCH v2 1/2] clk: si5351: Fix clkout rate computation.
Message-ID: <1367560403-21685-1-git-send-email-marek.belisko@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rate was incorrectly computed because we read from wrong divider register.

Signed-off-by: Marek Belisko <marek.belisko@streamunlimited.com>
Acked-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
---
 drivers/clk/clk-si5351.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-si5351.c b/drivers/clk/clk-si5351.c
index 8927284..cf39e53 100644
--- a/drivers/clk/clk-si5351.c
+++ b/drivers/clk/clk-si5351.c
@@ -932,7 +932,7 @@ static unsigned long si5351_clkout_recalc_rate(struct clk_hw *hw,
 	unsigned char reg;
 	unsigned char rdiv;
 
-	if (hwdata->num > 5)
+	if (hwdata->num <= 5)
 		reg = si5351_msynth_params_address(hwdata->num) + 2;
 	else
 		reg = SI5351_CLK6_7_OUTPUT_DIVIDER;
-- 
1.7.9.5
