From: sachin.kamat@linaro.org (Sachin Kamat)
Date: Fri,  8 Nov 2013 15:44:07 +0530
Subject: [PATCH 2/3] clk: exynos5250: fix sysmmu_mfc{l,r} gate clocks
In-Reply-To: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
References: <1383905648-23733-1-git-send-email-sachin.kamat@linaro.org>
Message-ID: <1383905648-23733-2-git-send-email-sachin.kamat@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Bresticker <abrestic@chromium.org>

The gate clocks for the MFC sysmmus appear to be flipped, i.e.
GATE_IP_MFC[2] gates sysmmu_mfcl and GATE_IP_MFC[1] gates sysmmu_mfcr.
Fix this so that the MFC will start up.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
---
 drivers/clk/samsung/clk-exynos5250.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
index 6767635dc895..986464c2339a 100644
--- a/drivers/clk/samsung/clk-exynos5250.c
+++ b/drivers/clk/samsung/clk-exynos5250.c
@@ -562,8 +562,8 @@ static struct samsung_gate_clock exynos5250_gate_clks[] __initdata = {
 	GATE(hdmi, "hdmi", "mout_aclk200_disp1_sub", GATE_IP_DISP1, 6, 0, 0),
 
 	GATE(mfc, "mfc", "mout_aclk333_sub", GATE_IP_MFC, 0, 0, 0),
-	GATE(smmu_mfcl, "smmu_mfcl", "mout_aclk333_sub", GATE_IP_MFC, 1, 0, 0),
-	GATE(smmu_mfcr, "smmu_mfcr", "mout_aclk333_sub", GATE_IP_MFC, 2, 0, 0),
+	GATE(smmu_mfcl, "smmu_mfcl", "mout_aclk333_sub", GATE_IP_MFC, 2, 0, 0),
+	GATE(smmu_mfcr, "smmu_mfcr", "mout_aclk333_sub", GATE_IP_MFC, 1, 0, 0),
 
 	GATE(rotator, "rotator", "div_aclk266", GATE_IP_GEN, 1, 0, 0),
 	GATE(jpeg, "jpeg", "div_aclk166", GATE_IP_GEN, 2, 0, 0),
-- 
1.7.9.5
