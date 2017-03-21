From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 21 Mar 2017 11:45:22 +0530
Subject: [PATCH 4/5] clk: qcom: gcc-msm8996: Mark gcc_mmss_noc_cfg_ahb_clk as
 a critical clock
In-Reply-To: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1490076923-20194-5-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

we have gcc_mmss_noc_cfg_ahb_clk marked with a CLK_IGNORE_UNUSED. While
this can prevent it from being disabled while its unused, it does not
prevent it from being disabled when a child derived from the clock calls
an explicit enable/disable.
Mark this with a CLK_IS_CRITICAL and remove the CLK_IGNORE_UNUSED flag
so its never disabled.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8996.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-msm8996.c b/drivers/clk/qcom/gcc-msm8996.c
index 8abc200..8872985 100644
--- a/drivers/clk/qcom/gcc-msm8996.c
+++ b/drivers/clk/qcom/gcc-msm8996.c
@@ -1333,7 +1333,7 @@ enum {
 			.name = "gcc_mmss_noc_cfg_ahb_clk",
 			.parent_names = (const char *[]){ "config_noc_clk_src" },
 			.num_parents = 1,
-			.flags = CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED,
+			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
 			.ops = &clk_branch2_ops,
 		},
 	},
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
