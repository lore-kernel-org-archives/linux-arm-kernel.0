From: chao.xie@marvell.com (Chao Xie)
Date: Thu, 23 Jan 2014 10:47:40 +0800
Subject: [PATCH 1/3] clk: mmp: fix wrong mask when calculate denominator
In-Reply-To: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
References: <1390445262-27486-1-git-send-email-chao.xie@marvell.com>
Message-ID: <1390445262-27486-2-git-send-email-chao.xie@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chao Xie <chao.xie@marvell.com>

The code has typo when calculate denominator. It should use
den_mask instead of num_mask.

Signed-off-by: Chao Xie <chao.xie@marvell.com>
---
 drivers/clk/mmp/clk-frac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mmp/clk-frac.c b/drivers/clk/mmp/clk-frac.c
index 80c1dd1..f6e7691 100644
--- a/drivers/clk/mmp/clk-frac.c
+++ b/drivers/clk/mmp/clk-frac.c
@@ -64,7 +64,7 @@ static unsigned long clk_factor_recalc_rate(struct clk_hw *hw,
 	num = (val >> masks->num_shift) & masks->num_mask;
 
 	/* calculate denominator */
-	den = (val >> masks->den_shift) & masks->num_mask;
+	den = (val >> masks->den_shift) & masks->den_mask;
 
 	if (!den)
 		return 0;
-- 
1.8.3.2
