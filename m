From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 16 May 2014 16:07:08 -0700
Subject: [PATCH 1/7] clk: qcom: Fix clk_rcg2_is_enabled() check
In-Reply-To: <1400281634-9313-1-git-send-email-sboyd@codeaurora.org>
References: <1400281634-9313-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1400281634-9313-2-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If the bit is set the clock is off so we should be checking for
a clear bit, not a set bit. Invert the logic.

Fixes: bcd61c0f535a (clk: qcom: Add support for root clock generators (RCGs))
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 00f878a04d3f..0996a3a39855 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -55,7 +55,7 @@ static int clk_rcg2_is_enabled(struct clk_hw *hw)
 	if (ret)
 		return ret;
 
-	return (cmd & CMD_ROOT_OFF) != 0;
+	return (cmd & CMD_ROOT_OFF) == 0;
 }
 
 static u8 clk_rcg2_get_parent(struct clk_hw *hw)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
