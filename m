From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Tue, 4 Jun 2013 14:25:43 +0300
Subject: [PATCH] clk: tegra114: Fix msenc clock register
Message-ID: <1370345143-4885-1-git-send-email-mperttunen@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The msenc clock's register was set to the usb3 clock's register.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index d78e16e..c4f2e0a 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -1747,7 +1747,7 @@ static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_MUX("vi_sensor", "vi_sensor", "tegra_camera", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI_SENSOR, 20, &periph_l_regs, TEGRA_PERIPH_NO_RESET, vi_sensor),
 	TEGRA_INIT_DATA_INT8("vi", "vi", "tegra_camera", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI, 20, &periph_l_regs, 0, vi),
 	TEGRA_INIT_DATA_INT8("epp", NULL, "epp", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_EPP, 19, &periph_l_regs, 0, epp),
-	TEGRA_INIT_DATA_INT8("msenc", NULL, "msenc", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_MSENC, 91, &periph_h_regs, TEGRA_PERIPH_WAR_1005168, msenc),
+	TEGRA_INIT_DATA_INT8("msenc", NULL, "msenc", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_MSENC, 91, &periph_u_regs, TEGRA_PERIPH_WAR_1005168, msenc),
 	TEGRA_INIT_DATA_INT8("tsec", NULL, "tsec", mux_pllp_pllc2_c_c3_pllm_clkm, CLK_SOURCE_TSEC, 83, &periph_u_regs, 0, tsec),
 	TEGRA_INIT_DATA_INT8("host1x", NULL, "host1x", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_HOST1X, 28, &periph_l_regs, 0, host1x),
 	TEGRA_INIT_DATA_MUX8("hdmi", NULL, "hdmi", mux_pllp_pllm_plld_plla_pllc_plld2_clkm, CLK_SOURCE_HDMI, 51, &periph_h_regs, 0, hdmi),
-- 
1.8.1.5
