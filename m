From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed,  2 Oct 2013 23:12:40 +0200
Subject: [PATCH 1/2] clk: tegra114: Rename gr_2d/gr_3d to gr2d/gr3d
Message-ID: <1380748361-32459-1-git-send-email-treding@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These clocks were named gr2d and gr3d on Tegra20 and Tegra30, so use the
same names on Tegra114 for consistency.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/clk/tegra/clk-tegra114.c         | 6 +++---
 include/dt-bindings/clock/tegra114-car.h | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra114.c b/drivers/clk/tegra/clk-tegra114.c
index 1c8701d..ef8e892 100644
--- a/drivers/clk/tegra/clk-tegra114.c
+++ b/drivers/clk/tegra/clk-tegra114.c
@@ -867,7 +867,7 @@ static unsigned long tegra114_input_freq[] = {
 enum tegra114_clk {
 	rtc = 4, timer = 5, uarta = 6, sdmmc2 = 9, i2s1 = 11, i2c1 = 12,
 	ndflash = 13, sdmmc1 = 14, sdmmc4 = 15, pwm = 17, i2s2 = 18, epp = 19,
-	gr_2d = 21, usbd = 22, isp = 23, gr_3d = 24, disp2 = 26, disp1 = 27,
+	gr2d = 21, usbd = 22, isp = 23, gr3d = 24, disp2 = 26, disp1 = 27,
 	host1x = 28, vcp = 29, i2s0 = 30, apbdma = 34, kbc = 36, kfuse = 40,
 	sbc1 = 41, nor = 42, sbc2 = 44, sbc3 = 46, i2c5 = 47, dsia = 48,
 	mipi = 50, hdmi = 51, csi = 52, i2c2 = 54, uartc = 55, mipi_cal = 56,
@@ -1884,8 +1884,8 @@ static struct tegra_periph_init_data tegra_periph_clk_list[] = {
 	TEGRA_INIT_DATA_UART("uartb", NULL, "tegra_uart.1", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTB, 7, &periph_l_regs, uartb),
 	TEGRA_INIT_DATA_UART("uartc", NULL, "tegra_uart.2", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTC, 55, &periph_h_regs, uartc),
 	TEGRA_INIT_DATA_UART("uartd", NULL, "tegra_uart.3", mux_pllp_pllc_pllm_clkm, CLK_SOURCE_UARTD, 65, &periph_u_regs, uartd),
-	TEGRA_INIT_DATA_INT("3d", NULL, "3d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_3D, 24, &periph_l_regs, 0, gr_3d),
-	TEGRA_INIT_DATA_INT("2d", NULL, "2d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_2D, 21, &periph_l_regs, 0, gr_2d),
+	TEGRA_INIT_DATA_INT("3d", NULL, "3d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_3D, 24, &periph_l_regs, 0, gr3d),
+	TEGRA_INIT_DATA_INT("2d", NULL, "2d", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_2D, 21, &periph_l_regs, 0, gr2d),
 	TEGRA_INIT_DATA_MUX("vi_sensor", "vi_sensor", "tegra_camera", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI_SENSOR, 20, &periph_l_regs, TEGRA_PERIPH_NO_RESET, vi_sensor),
 	TEGRA_INIT_DATA_INT8("vi", "vi", "tegra_camera", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_VI, 20, &periph_l_regs, 0, vi),
 	TEGRA_INIT_DATA_INT8("epp", NULL, "epp", mux_pllm_pllc2_c_c3_pllp_plla, CLK_SOURCE_EPP, 19, &periph_l_regs, 0, epp),
diff --git a/include/dt-bindings/clock/tegra114-car.h b/include/dt-bindings/clock/tegra114-car.h
index 614aec4..62a39aa 100644
--- a/include/dt-bindings/clock/tegra114-car.h
+++ b/include/dt-bindings/clock/tegra114-car.h
@@ -37,10 +37,10 @@
 #define TEGRA114_CLK_I2S2 18
 #define TEGRA114_CLK_EPP 19
 /* 20 (register bit affects vi and vi_sensor) */
-#define TEGRA114_CLK_GR_2D 21
+#define TEGRA114_CLK_GR2D 21
 #define TEGRA114_CLK_USBD 22
 #define TEGRA114_CLK_ISP 23
-#define TEGRA114_CLK_GR_3D 24
+#define TEGRA114_CLK_GR3D 24
 /* 25 */
 #define TEGRA114_CLK_DISP2 26
 #define TEGRA114_CLK_DISP1 27
-- 
1.8.4
