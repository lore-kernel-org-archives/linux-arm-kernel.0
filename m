From: colin.king@canonical.com (Colin King)
Date: Thu,  6 Feb 2014 18:53:10 +0000
Subject: [PATCH] clk: at91: remove redundant assignment
Message-ID: <1391712790-13591-1-git-send-email-colin.king@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Colin Ian King <colin.king@canonical.com>

remove the redundant shift = shift assignment, it is extraneous.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/clk/at91/clk-programmable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/at91/clk-programmable.c b/drivers/clk/at91/clk-programmable.c
index fd792b2..ff86efe 100644
--- a/drivers/clk/at91/clk-programmable.c
+++ b/drivers/clk/at91/clk-programmable.c
@@ -109,7 +109,7 @@ static long clk_programmable_round_rate(struct clk_hw *hw, unsigned long rate,
 	unsigned long best_diff;
 	unsigned long new_diff;
 	unsigned long cur_rate;
-	int shift = shift;
+	int shift;
 
 	if (rate > *parent_rate)
 		return *parent_rate;
-- 
1.9.rc1
