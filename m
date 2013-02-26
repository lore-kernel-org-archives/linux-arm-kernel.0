From: tim.gardner@canonical.com (Tim Gardner)
Date: Tue, 26 Feb 2013 10:34:12 -0700
Subject: [PATCH 3.9-rc1] clk: vt8500: Fix variable name '*prate' compile error
Message-ID: <1361900052-66917-1-git-send-email-tim.gardner@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit 72480014b86c8b51fb51c5c6a0525876055c37c7 (clk: vt8500: Fix device clock
divisor calculations) introduced a compile error in the naming of a variable in
vt8500_dclk_set_rate(). It looks like a simple cut and paste error.

Cc: Mike Turquette <mturquette@linaro.org>
Cc: linux-arm-kernel at lists.infradead.org
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---
 drivers/clk/clk-vt8500.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-vt8500.c b/drivers/clk/clk-vt8500.c
index b5538bb..09c6331 100644
--- a/drivers/clk/clk-vt8500.c
+++ b/drivers/clk/clk-vt8500.c
@@ -157,7 +157,7 @@ static int vt8500_dclk_set_rate(struct clk_hw *hw, unsigned long rate,
 	divisor =  parent_rate / rate;
 
 	/* If prate / rate would be decimal, incr the divisor */
-	if (rate * divisor < *prate)
+	if (rate * divisor < parent_rate)
 		divisor++;
 
 	if (divisor == cdev->div_mask + 1)
-- 
1.7.9.5
