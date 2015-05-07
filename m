From: b20788@freescale.com (Anson Huang)
Date: Fri, 8 May 2015 00:16:51 +0800
Subject: [PATCH] ARM: imx: using unsigned variable for do_div
Message-ID: <1431015411-8432-1-git-send-email-b20788@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The definition of do_div uses unsigned long long
variable as its first parameter, better to pass
a u64 variable as first parameter when calling
do_div function.

Signed-off-by: Anson Huang <b20788@freescale.com>
---
 drivers/clk/imx/clk-pllv3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/imx/clk-pllv3.c b/drivers/clk/imx/clk-pllv3.c
index e34a925..8a94fa6 100644
--- a/drivers/clk/imx/clk-pllv3.c
+++ b/drivers/clk/imx/clk-pllv3.c
@@ -220,7 +220,7 @@ static long clk_pllv3_av_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long max_rate = parent_rate * 54;
 	u32 div;
 	u32 mfn, mfd = 1000000;
-	s64 temp64;
+	u64 temp64;
 
 	if (rate > max_rate)
 		rate = max_rate;
@@ -244,7 +244,7 @@ static int clk_pllv3_av_set_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long max_rate = parent_rate * 54;
 	u32 val, div;
 	u32 mfn, mfd = 1000000;
-	s64 temp64;
+	u64 temp64;
 
 	if (rate < min_rate || rate > max_rate)
 		return -EINVAL;
-- 
1.9.1
