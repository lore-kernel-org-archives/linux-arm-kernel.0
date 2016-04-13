From: eric@anholt.net (Eric Anholt)
Date: Wed, 13 Apr 2016 13:05:02 -0700
Subject: [PATCH v2 1/2] clk: bcm2835: Fix compiler warnings on 64-bit builds
Message-ID: <1460577903-32192-1-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Eric Anholt <eric@anholt.net>
---

v2: no change
 drivers/clk/bcm/clk-bcm2835.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
index 4c0f1b504e2f..87616ded5bbe 100644
--- a/drivers/clk/bcm/clk-bcm2835.c
+++ b/drivers/clk/bcm/clk-bcm2835.c
@@ -400,17 +400,17 @@ struct bcm2835_pll_ana_bits {
 static const struct bcm2835_pll_ana_bits bcm2835_ana_default = {
 	.mask0 = 0,
 	.set0 = 0,
-	.mask1 = ~(A2W_PLL_KI_MASK | A2W_PLL_KP_MASK),
+	.mask1 = (u32)~(A2W_PLL_KI_MASK | A2W_PLL_KP_MASK),
 	.set1 = (2 << A2W_PLL_KI_SHIFT) | (8 << A2W_PLL_KP_SHIFT),
-	.mask3 = ~A2W_PLL_KA_MASK,
+	.mask3 = (u32)~A2W_PLL_KA_MASK,
 	.set3 = (2 << A2W_PLL_KA_SHIFT),
 	.fb_prediv_mask = BIT(14),
 };
 
 static const struct bcm2835_pll_ana_bits bcm2835_ana_pllh = {
-	.mask0 = ~(A2W_PLLH_KA_MASK | A2W_PLLH_KI_LOW_MASK),
+	.mask0 = (u32)~(A2W_PLLH_KA_MASK | A2W_PLLH_KI_LOW_MASK),
 	.set0 = (2 << A2W_PLLH_KA_SHIFT) | (2 << A2W_PLLH_KI_LOW_SHIFT),
-	.mask1 = ~(A2W_PLLH_KI_HIGH_MASK | A2W_PLLH_KP_MASK),
+	.mask1 = (u32)~(A2W_PLLH_KI_HIGH_MASK | A2W_PLLH_KP_MASK),
 	.set1 = (6 << A2W_PLLH_KP_SHIFT),
 	.mask3 = 0,
 	.set3 = 0,
-- 
2.8.0.rc3
