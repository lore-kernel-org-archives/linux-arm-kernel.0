From: rnayak@codeaurora.org (Rajendra Nayak)
Date: Tue, 21 Mar 2017 11:45:23 +0530
Subject: [PATCH 5/5] clk: qcom: mmcc-8996: Associate all mmagic clks with
 mmagic gdscs
In-Reply-To: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
References: <1490076923-20194-1-git-send-email-rnayak@codeaurora.org>
Message-ID: <1490076923-20194-6-git-send-email-rnayak@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With support added to control clocks associated with a gdsc from within
the gdsc driver, associate all mmagic clock instances with the respective
mmagic gdscs so devices inside these mmagic domains do not have to control
them individually.

Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
---
 drivers/clk/qcom/mmcc-msm8996.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/clk/qcom/mmcc-msm8996.c b/drivers/clk/qcom/mmcc-msm8996.c
index 9b97246..7c0ffb5 100644
--- a/drivers/clk/qcom/mmcc-msm8996.c
+++ b/drivers/clk/qcom/mmcc-msm8996.c
@@ -2893,6 +2893,10 @@ enum {
 	.pd = {
 		.name = "mmagic_bimc",
 	},
+	.clk_hws = {
+		&mmagic_bimc_noc_cfg_ahb_clk.clkr.hw,
+	},
+	.clk_count = 1,
 	.pwrsts = PWRSTS_OFF_ON,
 };
 
@@ -2902,6 +2906,13 @@ enum {
 	.pd = {
 		.name = "mmagic_video",
 	},
+	.clk_hws = {
+		&mmss_mmagic_ahb_clk.clkr.hw,
+		&mmss_mmagic_cfg_ahb_clk.clkr.hw,
+		&mmagic_video_axi_clk.clkr.hw,
+		&mmagic_video_noc_cfg_ahb_clk.clkr.hw,
+	},
+	.clk_count = 4,
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = VOTABLE,
 };
@@ -2912,6 +2923,13 @@ enum {
 	.pd = {
 		.name = "mmagic_mdss",
 	},
+	.clk_hws = {
+		&mmss_mmagic_ahb_clk.clkr.hw,
+		&mmss_mmagic_cfg_ahb_clk.clkr.hw,
+		&mmagic_mdss_axi_clk.clkr.hw,
+		&mmagic_mdss_noc_cfg_ahb_clk.clkr.hw,
+	},
+	.clk_count = 4,
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = VOTABLE,
 };
@@ -2922,6 +2940,13 @@ enum {
 	.pd = {
 		.name = "mmagic_camss",
 	},
+	.clk_hws = {
+		&mmss_mmagic_ahb_clk.clkr.hw,
+		&mmss_mmagic_cfg_ahb_clk.clkr.hw,
+		&mmagic_camss_axi_clk.clkr.hw,
+		&mmagic_camss_noc_cfg_ahb_clk.clkr.hw,
+	},
+	.clk_count = 4,
 	.pwrsts = PWRSTS_OFF_ON,
 	.flags = VOTABLE,
 };
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
