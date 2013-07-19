From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Fri, 19 Jul 2013 10:16:45 -0700
Subject: [PATCH 2/2] clk/zynq/pll: Use #defines for fbdiv min/max values
In-Reply-To: <1374254205-9912-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1374254205-9912-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1374254205-9912-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use more descriptive #defines for the minimum and maximum PLL
feedback divider.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 drivers/clk/zynq/pll.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/zynq/pll.c b/drivers/clk/zynq/pll.c
index 67f1b5e..26a8d8b 100644
--- a/drivers/clk/zynq/pll.c
+++ b/drivers/clk/zynq/pll.c
@@ -50,6 +50,9 @@ struct zynq_pll {
 #define PLLCTRL_RESET_MASK	1
 #define PLLCTRL_RESET_SHIFT	0
 
+#define PLL_FBDIV_MIN	13
+#define PLL_FBDIV_MAX	66
+
 /**
  * zynq_pll_round_rate() - Round a clock frequency
  * @hw:		Handle between common and hardware-specific interfaces
@@ -63,10 +66,10 @@ static long zynq_pll_round_rate(struct clk_hw *hw, unsigned long rate,
 	u32 fbdiv;
 
 	fbdiv = DIV_ROUND_CLOSEST(rate, *prate);
-	if (fbdiv < 13)
-		fbdiv = 13;
-	else if (fbdiv > 66)
-		fbdiv = 66;
+	if (fbdiv < PLL_FBDIV_MIN)
+		fbdiv = PLL_FBDIV_MIN;
+	else if (fbdiv > PLL_FBDIV_MAX)
+		fbdiv = PLL_FBDIV_MAX;
 
 	return *prate * fbdiv;
 }
-- 
1.8.3.3
