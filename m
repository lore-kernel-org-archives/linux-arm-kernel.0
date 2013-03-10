From: gang.chen@asianux.com (Chen Gang)
Date: Sun, 10 Mar 2013 11:48:16 +0800
Subject: [PATCH] drivers/clk: fixup commit
 72480014b86c8b51fb51c5c6a0525876055c37c7
Message-ID: <513C0280.7040004@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  prate is not defined, will cause compiling issue.
  need use parent_rate instead of prate.

Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 drivers/clk/clk-vt8500.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
1.7.7.6
