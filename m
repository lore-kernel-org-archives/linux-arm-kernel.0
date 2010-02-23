From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 23 Feb 2010 12:45:13 +0100
Subject: [PATCH] ARM: U300: fix inverted clk round rate
Message-ID: <1266925513-28402-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The clk_round_rate() functions in the U300 clocking will always
select the lowest clocking frequency due to inverted rounding
comparisons. Fix this.

Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
---
 arch/arm/mach-u300/clock.c |   24 ++++++++++++------------
 1 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-u300/clock.c b/arch/arm/mach-u300/clock.c
index c174ed1..5af71d5 100644
--- a/arch/arm/mach-u300/clock.c
+++ b/arch/arm/mach-u300/clock.c
@@ -610,34 +610,34 @@ EXPORT_SYMBOL(clk_get_rate);
 
 static unsigned long clk_round_rate_mclk(struct clk *clk, unsigned long rate)
 {
-	if (rate >= 18900000)
+	if (rate <= 18900000)
 		return 18900000;
-	if (rate >= 20800000)
+	if (rate <= 20800000)
 		return 20800000;
-	if (rate >= 23100000)
+	if (rate <= 23100000)
 		return 23100000;
-	if (rate >= 26000000)
+	if (rate <= 26000000)
 		return 26000000;
-	if (rate >= 29700000)
+	if (rate <= 29700000)
 		return 29700000;
-	if (rate >= 34700000)
+	if (rate <= 34700000)
 		return 34700000;
-	if (rate >= 41600000)
+	if (rate <= 41600000)
 		return 41600000;
-	if (rate >= 52000000)
+	if (rate <= 52000000)
 		return 52000000;
 	return -EINVAL;
 }
 
 static unsigned long clk_round_rate_cpuclk(struct clk *clk, unsigned long rate)
 {
-	if (rate >= 13000000)
+	if (rate <= 13000000)
 		return 13000000;
-	if (rate >= 52000000)
+	if (rate <= 52000000)
 		return 52000000;
-	if (rate >= 104000000)
+	if (rate <= 104000000)
 		return 104000000;
-	if (rate >= 208000000)
+	if (rate <= 208000000)
 		return 208000000;
 	return -EINVAL;
 }
-- 
1.6.3.3
