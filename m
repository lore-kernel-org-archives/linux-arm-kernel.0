From: lho@apm.com (Loc Ho)
Date: Mon, 29 Feb 2016 14:15:43 -0700
Subject: [PATCH] clk: xgene: Add missing parenthesis when clearing divider
 value
Message-ID: <1456780543-13770-1-git-send-email-lho@apm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In the initial fix for non-zero divider shift value, the parenthesis
was missing after the negate operation. This patch adds the required
parenthesis. Otherwise, lower bits may be cleared unintentionally.

Signed-off-by: Loc Ho <lho@apm.com>
Acked-by: Toan Le <toanle@apm.com>
---
 drivers/clk/clk-xgene.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-xgene.c b/drivers/clk/clk-xgene.c
index bd7156b..d73450b 100644
--- a/drivers/clk/clk-xgene.c
+++ b/drivers/clk/clk-xgene.c
@@ -376,8 +376,8 @@ static int xgene_clk_set_rate(struct clk_hw *hw, unsigned long rate,
 		/* Set new divider */
 		data = xgene_clk_read(pclk->param.divider_reg +
 				pclk->param.reg_divider_offset);
-		data &= ~((1 << pclk->param.reg_divider_width) - 1)
-				<< pclk->param.reg_divider_shift;
+		data &= ~(((1 << pclk->param.reg_divider_width) - 1)
+				<< pclk->param.reg_divider_shift);
 		data |= divider;
 		xgene_clk_write(data, pclk->param.divider_reg +
 					pclk->param.reg_divider_offset);
-- 
1.7.1
