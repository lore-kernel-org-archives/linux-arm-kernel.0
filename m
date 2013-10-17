From: t.figa@samsung.com (Tomasz Figa)
Date: Thu, 17 Oct 2013 18:30:36 +0200
Subject: [PATCH 2/8] clk: max77686: Provide .recalc_rate() operation
In-Reply-To: <1382027442-1992-1-git-send-email-t.figa@samsung.com>
References: <1382027442-1992-1-git-send-email-t.figa@samsung.com>
Message-ID: <1382027442-1992-3-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It is usually nice to know frequency of a clock, so this patch adds a
.recalc_rate() callback returning rates of provided clocks.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/clk-max77686.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-max77686.c b/drivers/clk/clk-max77686.c
index e39d463..e40ecdb 100644
--- a/drivers/clk/clk-max77686.c
+++ b/drivers/clk/clk-max77686.c
@@ -81,10 +81,17 @@ static int max77686_clk_is_prepared(struct clk_hw *hw)
 	return val & max77686->mask;
 }
 
+static unsigned long max77686_recalc_rate(struct clk_hw *hw,
+					  unsigned long parent_rate)
+{
+	return 32768;
+}
+
 static struct clk_ops max77686_clk_ops = {
 	.prepare	= max77686_clk_prepare,
 	.unprepare	= max77686_clk_unprepare,
 	.is_prepared	= max77686_clk_is_prepared,
+	.recalc_rate	= max77686_recalc_rate,
 };
 
 static struct clk_init_data max77686_clks_init[MAX77686_CLKS_NUM] = {
-- 
1.8.3.2
