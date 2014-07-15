From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 15 Jul 2014 15:42:31 -0700
Subject: [PATCH 2/2] clk: qcom: mdp_lut_clk is a child of mdp_src
In-Reply-To: <1405464151-16152-1-git-send-email-sboyd@codeaurora.org>
References: <1405464151-16152-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <1405464151-16152-3-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The mdp_lut_clk isn't a child of the mdp_clk. Instead it's the
child of the mdp_src clock. Fix it.

Fixes: 6d00b56fe "clk: qcom: Add support for MSM8960's multimedia clock controller (MMCC)"
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/mmcc-msm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index b050433af38e..7985982ab4e9 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -1117,7 +1117,7 @@ static struct clk_branch mdp_lut_clk = {
 		.enable_reg = 0x016c,
 		.enable_mask = BIT(0),
 		.hw.init = &(struct clk_init_data){
-			.parent_names = (const char *[]){ "mdp_clk" },
+			.parent_names = (const char *[]){ "mdp_src" },
 			.num_parents = 1,
 			.name = "mdp_lut_clk",
 			.ops = &clk_branch_ops,
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
