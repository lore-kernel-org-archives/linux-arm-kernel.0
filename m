From: pure.logic@nexus-software.ie (Bryan O'Donoghue)
Date: Sat, 30 Dec 2017 01:13:01 +0000
Subject: [PATCH 22/33] clk: sirf: remove unnecessary long cast on return
In-Reply-To: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
References: <1514596392-22270-1-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <1514596392-22270-23-git-send-email-pure.logic@nexus-software.ie>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Due to the old function signature of clk_ops->round_rate
pll_clk_round_rate does a cast of an internal unsigned long
to a long. After updating clk_ops->round_rate() to be an unsigned long
though the cast isn't necessary. Remove the cast now.

Signed-off-by: Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Barry Song <baohua@kernel.org>
Cc: linux-clk at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
Cc: Barry Song <Baohua.Song@csr.com>
---
 drivers/clk/sirf/clk-common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sirf/clk-common.c b/drivers/clk/sirf/clk-common.c
index 3ce6741..bfa3f4b 100644
--- a/drivers/clk/sirf/clk-common.c
+++ b/drivers/clk/sirf/clk-common.c
@@ -121,7 +121,7 @@ static unsigned long pll_clk_round_rate(struct clk_hw *hw, unsigned long rate,
 	dividend = (u64)fin * nf;
 	do_div(dividend, nr * od);
 
-	return (long)dividend;
+	return dividend;
 }
 
 static int pll_clk_set_rate(struct clk_hw *hw, unsigned long rate,
-- 
2.7.4
