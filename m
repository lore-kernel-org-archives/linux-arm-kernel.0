From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed,  5 Mar 2014 14:53:32 -0700
Subject: [PATCH] pinctrl: tegra: fix some typos and inconsistencies
Message-ID: <1394056412-12879-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

drive_dev3_pins in pinctrl-tegra114.c wasn't used; delete it.

pinctrl-tegra124.c had quite a few typos. Fix those.

pinctrl-tegra124.c had a few mismatches between the *_groups[] ararys
and the function lists in tegra124_groups[]. Fix those.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra114.c |  5 -----
 drivers/pinctrl/pinctrl-tegra124.c | 41 ++++++++++++++++----------------------
 2 files changed, 17 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra114.c b/drivers/pinctrl/pinctrl-tegra114.c
index 93c9e3899d5e..46da27ff2d64 100644
--- a/drivers/pinctrl/pinctrl-tegra114.c
+++ b/drivers/pinctrl/pinctrl-tegra114.c
@@ -1341,11 +1341,6 @@ static const unsigned drive_uda_pins[] = {
 	TEGRA_PIN_ULPI_STP_PY3,
 };
 
-static const unsigned drive_dev3_pins[] = {
-	TEGRA_PIN_CLK3_OUT_PEE0,
-	TEGRA_PIN_CLK3_REQ_PEE1,
-};
-
 enum tegra_mux {
 	TEGRA_MUX_BLINK,
 	TEGRA_MUX_CEC,
diff --git a/drivers/pinctrl/pinctrl-tegra124.c b/drivers/pinctrl/pinctrl-tegra124.c
index c20e0e1dda83..7c6b7b63320f 100644
--- a/drivers/pinctrl/pinctrl-tegra124.c
+++ b/drivers/pinctrl/pinctrl-tegra124.c
@@ -325,13 +325,13 @@ static const struct pinctrl_pin_desc tegra124_pins[] = {
 	PINCTRL_PIN(TEGRA_PIN_KB_ROW8_PS0, "KB_ROW8 PS0"),
 	PINCTRL_PIN(TEGRA_PIN_KB_ROW9_PS1, "KB_ROW9 PS1"),
 	PINCTRL_PIN(TEGRA_PIN_KB_ROW10_PS2, "KB_ROW10 PS2"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW11_PS3, "KB_ROW10 PS3"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW12_PS4, "KB_ROW10 PS4"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW13_PS5, "KB_ROW10 PS5"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW14_PS6, "KB_ROW10 PS6"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW15_PS7, "KB_ROW10 PS7"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW16_PT0, "KB_ROW10 PT0"),
-	PINCTRL_PIN(TEGRA_PIN_KB_ROW17_PT1, "KB_ROW10 PT1"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW11_PS3, "KB_ROW11 PS3"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW12_PS4, "KB_ROW12 PS4"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW13_PS5, "KB_ROW13 PS5"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW14_PS6, "KB_ROW14 PS6"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW15_PS7, "KB_ROW15 PS7"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW16_PT0, "KB_ROW16 PT0"),
+	PINCTRL_PIN(TEGRA_PIN_KB_ROW17_PT1, "KB_ROW17 PT1"),
 	PINCTRL_PIN(TEGRA_PIN_GEN2_I2C_SCL_PT5, "GEN2_I2C_SCL PT5"),
 	PINCTRL_PIN(TEGRA_PIN_GEN2_I2C_SDA_PT6, "GEN2_I2C_SDA PT6"),
 	PINCTRL_PIN(TEGRA_PIN_SDMMC4_CMD_PT7, "SDMMC4_CMD PT7"),
@@ -1608,12 +1608,12 @@ static const char * const cpu_groups[] = {
 };
 
 static const char * const dap_groups[] = {
-	"dap_mclk1_pee2",
+	"dap_mclk1_req_pee2",
 	"clk2_req_pcc5",
 };
 
 static const char * const dap1_groups[] = {
-	"dap_mclk1_pee2",
+	"dap_mclk1_req_pee2",
 };
 
 static const char * const dap2_groups[] = {
@@ -2013,8 +2013,8 @@ static const char * const rsvd2_groups[] = {
 	"gen1_i2c_scl_pc4",
 	"gen1_i2c_sda_pc5",
 
-	"clk2_out_pee0",
-	"clk2_req_pee1",
+	"clk3_out_pee0",
+	"clk3_req_pee1",
 	"pc7",
 	"pi5",
 	"pj0",
@@ -2130,7 +2130,7 @@ static const char * const rsvd3_groups[] = {
 	"clk3_req_pee1",
 
 	"sdmmc4_dat5_paa5",
-	"gpio_pcc1",
+	"pcc1",
 	"cam_i2c_scl_pbb1",
 	"cam_i2c_sda_pbb2",
 	"pbb5",
@@ -2195,11 +2195,6 @@ static const char * const rsvd4_groups[] = {
 	"ddc_scl_pv4",
 	"ddc_sda_pv5",
 
-	"uart2_rts_n_pj6",
-	"uart2_cts_n_pj5",
-	"uart3_txd_pw6",
-	"uart3_rxd_pw7",
-
 	"pu0",
 	"pu1",
 	"pu2",
@@ -2234,6 +2229,7 @@ static const char * const rsvd4_groups[] = {
 	"gen2_i2c_scl_pt5",
 	"gen2_i2c_sda_pt6",
 
+	"sdmmc4_clk_pcc4",
 	"sdmmc4_cmd_pt7",
 	"sdmmc4_dat0_paa0",
 	"sdmmc4_dat1_paa1",
@@ -2271,7 +2267,7 @@ static const char * const rsvd4_groups[] = {
 	"dap1_din_pn1",
 	"dap1_sclk_pn3",
 	"dap_mclk1_req_pee2",
-	"dap_mclk1_pw5",
+	"dap_mclk1_pw4",
 
 	"dap2_fs_pa2",
 	"dap2_din_pa4",
@@ -2312,8 +2308,6 @@ static const char * const sdmmc1_groups[] = {
 	"sdmmc1_dat2_py5",
 	"sdmmc1_dat1_py6",
 	"sdmmc1_dat0_py7",
-	"clk2_out_pw5",
-	"clk2_req_pcc",
 	"uart3_cts_n_pa1",
 	"sdmmc1_wp_n_pv3",
 };
@@ -2412,7 +2406,6 @@ static const char * const spi2_groups[] = {
 
 	"kb_row13_ps5",
 	"kb_row14_ps6",
-	"kb_row15_ps7",
 	"kb_col0_pq0",
 	"kb_col1_pq1",
 	"kb_col2_pq2",
@@ -2558,7 +2551,7 @@ static const char * const uartc_groups[] = {
 	"uart3_cts_n_pa1",
 	"uart3_rts_n_pc0",
 	"kb_row16_pt0",
-	"kn_row17_pt1",
+	"kb_row17_pt1",
 };
 
 static const char * const uartd_groups[] = {
@@ -2964,9 +2957,9 @@ static const struct tegra_pingroup tegra124_groups[] = {
        PINGROUP(sdmmc4_dat4_paa4,       SDMMC4,     SPI3,       GMI,          RSVD4,       SDMMC4,     0x3270,  N,  Y,  N),
        PINGROUP(sdmmc4_dat5_paa5,       SDMMC4,     SPI3,       RSVD3,        RSVD4,       SDMMC4,     0x3274,  N,  Y,  N),
        PINGROUP(sdmmc4_dat6_paa6,       SDMMC4,     SPI3,       GMI,          RSVD4,       SDMMC4,     0x3278,  N,  Y,  N),
-       PINGROUP(sdmmc4_dat7_paa7,       SDMMC4,     RSVD1,      GMI,          RSVD4,       SDMMC4,     0x327c,  N,  Y,  N),
+       PINGROUP(sdmmc4_dat7_paa7,       SDMMC4,     RSVD2,      GMI,          RSVD4,       SDMMC4,     0x327c,  N,  Y,  N),
        PINGROUP(cam_mclk_pcc0,          VI,         VI_ALT1,    VI_ALT3,      SDMMC2,      VI,         0x3284,  N,  N,  N),
-       PINGROUP(pcc1,                   I2S4,       RSVD1,      RSVD3,        SDMMC2,      I2S4,       0x3288,  N,  N,  N),
+       PINGROUP(pcc1,                   I2S4,       RSVD2,      RSVD3,        SDMMC2,      I2S4,       0x3288,  N,  N,  N),
        PINGROUP(pbb0,                   VGP6,       VIMCLK2,    SDMMC2,       VIMCLK2_ALT, VGP6,       0x328c,  N,  N,  N),
        PINGROUP(cam_i2c_scl_pbb1,       VGP1,       I2C3,       RSVD3,        SDMMC2,      VGP1,       0x3290,  Y,  N,  N),
        PINGROUP(cam_i2c_sda_pbb2,       VGP2,       I2C3,       RSVD3,        SDMMC2,      VGP2,       0x3294,  Y,  N,  N),
-- 
1.8.1.5
