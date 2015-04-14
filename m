From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 14 Apr 2015 18:42:17 +0530
Subject: [PATCH v5 11/11] clk: qcom: gdsc: Add oxili GDSC for msm8916
In-Reply-To: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
References: <1429017137-20218-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1429017137-20218-12-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the support to control root clk along with the gdsc
powerdomain now added, add the gdsc data for oxili on
msm8916.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/gcc-msm8916.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/clk/qcom/gcc-msm8916.c b/drivers/clk/qcom/gcc-msm8916.c
index d799be9..08a8224 100644
--- a/drivers/clk/qcom/gcc-msm8916.c
+++ b/drivers/clk/qcom/gcc-msm8916.c
@@ -2591,6 +2591,14 @@ static struct gdsc vfe_gdsc = {
 	},
 };
 
+static struct gdsc oxili_gdsc = {
+	.gdscr = 0x5901c,
+	.pd = {
+		.name = "oxili",
+	},
+	.root_con_id = "gfx3d_clk_src",
+};
+
 static struct clk_regmap *gcc_msm8916_clocks[] = {
 	[GPLL0] = &gpll0.clkr,
 	[GPLL0_VOTE] = &gpll0_vote,
@@ -2737,6 +2745,7 @@ static struct gdsc *gcc_msm8916_gdscs[] = {
 	[MDSS_GDSC] = &mdss_gdsc,
 	[JPEG_GDSC] = &jpeg_gdsc,
 	[VFE_GDSC] = &vfe_gdsc,
+	[OXILI_GDSC] = &oxili_gdsc,
 };
 
 static const struct qcom_reset_map gcc_msm8916_resets[] = {
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
