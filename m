From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 25 Jun 2014 14:44:19 -0700
Subject: [PATCH] clk: qcom: HDMI source sel is 3 not 2
Message-ID: <1403732659-14033-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The HDMI PLL input to the tv mux is supposed to be 3, not 2. Fix
the code so that we can properly select the HDMI PLL.

Fixes: 6d00b56fe "clk: qcom: Add support for MSM8960's multimedia clock controller (MMCC)"
Reported-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 drivers/clk/qcom/mmcc-msm8960.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/mmcc-msm8960.c b/drivers/clk/qcom/mmcc-msm8960.c
index 12f3c0b64fcd..4c449b3170f6 100644
--- a/drivers/clk/qcom/mmcc-msm8960.c
+++ b/drivers/clk/qcom/mmcc-msm8960.c
@@ -1209,7 +1209,7 @@ static struct clk_branch rot_clk = {
 
 static u8 mmcc_pxo_hdmi_map[] = {
 	[P_PXO]		= 0,
-	[P_HDMI_PLL]	= 2,
+	[P_HDMI_PLL]	= 3,
 };
 
 static const char *mmcc_pxo_hdmi[] = {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
