From: rklein@nvidia.com (Rhyland Klein)
Date: Mon, 11 Feb 2013 17:25:12 -0500
Subject: [PATCH 1/2] pinctrl: tegra: add clfvs function to Tegra114 support
Message-ID: <1360621513-18814-1-git-send-email-rklein@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the definition for the cldvfs function for Tegra114 pinctrl
support. This is based on work by Pritesh Raithatha.

Signed-off-by: Rhyland Klein <rklein@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra114.c |   22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra114.c b/drivers/pinctrl/pinctrl-tegra114.c
index 053a8b1..622c485 100644
--- a/drivers/pinctrl/pinctrl-tegra114.c
+++ b/drivers/pinctrl/pinctrl-tegra114.c
@@ -1349,6 +1349,7 @@ static const unsigned drive_dev3_pins[] = {
 enum tegra_mux {
 	TEGRA_MUX_BLINK,
 	TEGRA_MUX_CEC,
+	TEGRA_MUX_CLDVFS,
 	TEGRA_MUX_CLK12,
 	TEGRA_MUX_CPU,
 	TEGRA_MUX_DAP,
@@ -1432,6 +1433,15 @@ static const char * const cec_groups[] = {
 	"hdmi_cec_pee3",
 };
 
+static const char * const cldvfs_groups[] = {
+	"gmi_ad9_ph1",
+	"gmi_ad10_ph2",
+	"kb_row7_pr7",
+	"kb_row8_ps0",
+	"dvfs_pwm_px0",
+	"dvfs_clk_px2",
+};
+
 static const char * const clk12_groups[] = {
 	"sdmmc1_wp_n_pv3",
 	"sdmmc1_clk_pz0",
@@ -2352,6 +2362,7 @@ static const char * const vi_alt3_groups[] = {
 static const struct tegra_function  tegra114_functions[] = {
 	FUNCTION(blink),
 	FUNCTION(cec),
+	FUNCTION(cldvfs),
 	FUNCTION(clk12),
 	FUNCTION(cpu),
 	FUNCTION(dap),
@@ -2586,8 +2597,8 @@ static const struct tegra_pingroup tegra114_groups[] = {
 	PINGROUP(gmi_ad6_pg6,            RSVD1,      NAND,       GMI,          SPI4,        RSVD1,    0x3208,  N,  N,  N),
 	PINGROUP(gmi_ad7_pg7,            RSVD1,      NAND,       GMI,          SPI4,        RSVD1,    0x320c,  N,  N,  N),
 	PINGROUP(gmi_ad8_ph0,            PWM0,       NAND,       GMI,          DTV,         GMI,      0x3210,  N,  N,  N),
-	PINGROUP(gmi_ad9_ph1,            PWM1,       NAND,       GMI,          RSVD4,       GMI,      0x3214,  N,  N,  N),
-	PINGROUP(gmi_ad10_ph2,           PWM2,       NAND,       GMI,          RSVD4,       GMI,      0x3218,  N,  N,  N),
+	PINGROUP(gmi_ad9_ph1,            PWM1,       NAND,       GMI,          CLDVFS,      GMI,      0x3214,  N,  N,  N),
+	PINGROUP(gmi_ad10_ph2,           PWM2,       NAND,       GMI,          CLDVFS,      GMI,      0x3218,  N,  N,  N),
 	PINGROUP(gmi_ad11_ph3,           PWM3,       NAND,       GMI,          USB,         GMI,      0x321c,  N,  N,  N),
 	PINGROUP(gmi_ad12_ph4,           SDMMC2,     NAND,       GMI,          RSVD4,       RSVD4,    0x3220,  N,  N,  N),
 	PINGROUP(gmi_ad13_ph5,           SDMMC2,     NAND,       GMI,          RSVD4,       RSVD4,    0x3224,  N,  N,  N),
@@ -2633,8 +2644,8 @@ static const struct tegra_pingroup tegra114_groups[] = {
 	PINGROUP(kb_row4_pr4,            KBC,        DISPLAYA,   SPI2,         DISPLAYB,    KBC,      0x32cc,  N,  N,  N),
 	PINGROUP(kb_row5_pr5,            KBC,        DISPLAYA,   SPI2,         DISPLAYB,    KBC,      0x32d0,  N,  N,  N),
 	PINGROUP(kb_row6_pr6,            KBC,        DISPLAYA,   DISPLAYA_ALT, DISPLAYB,    KBC,      0x32d4,  N,  N,  N),
-	PINGROUP(kb_row7_pr7,            KBC,        RSVD2,      RSVD3,        UARTA,       RSVD2,    0x32d8,  N,  N,  N),
-	PINGROUP(kb_row8_ps0,            KBC,        RSVD2,      RSVD3,        UARTA,       RSVD2,    0x32dc,  N,  N,  N),
+	PINGROUP(kb_row7_pr7,            KBC,        RSVD2,      CLDVFS,       UARTA,       RSVD2,    0x32d8,  N,  N,  N),
+	PINGROUP(kb_row8_ps0,            KBC,        RSVD2,      CLDVFS,       UARTA,       RSVD2,    0x32dc,  N,  N,  N),
 	PINGROUP(kb_row9_ps1,            KBC,        RSVD2,      RSVD3,        UARTA,       RSVD3,    0x32e0,  N,  N,  N),
 	PINGROUP(kb_row10_ps2,           KBC,        RSVD2,      RSVD3,        UARTA,       RSVD3,    0x32e4,  N,  N,  N),
 	PINGROUP(kb_col0_pq0,            KBC,        USB,        SPI2,         EMC_DLL,     KBC,      0x32fc,  N,  N,  N),
@@ -2663,9 +2674,10 @@ static const struct tegra_pingroup tegra114_groups[] = {
 	PINGROUP(dap2_din_pa4,           I2S1,       HDA,        RSVD3,        RSVD4,       RSVD4,    0x335c,  N,  N,  N),
 	PINGROUP(dap2_dout_pa5,          I2S1,       HDA,        RSVD3,        RSVD4,       RSVD4,    0x3360,  N,  N,  N),
 	PINGROUP(dap2_sclk_pa3,          I2S1,       HDA,        RSVD3,        RSVD4,       RSVD4,    0x3364,  N,  N,  N),
-	PINGROUP(dvfs_pwm_px0,           SPI6,       RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x3368,  N,  N,  N),
+	PINGROUP(dvfs_pwm_px0,           SPI6,       CLDVFS,     RSVD3,        RSVD4,       RSVD4,    0x3368,  N,  N,  N),
 	PINGROUP(gpio_x1_aud_px1,        SPI6,       RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x336c,  N,  N,  N),
 	PINGROUP(gpio_x3_aud_px3,        SPI6,       SPI1,       RSVD3,        RSVD4,       RSVD4,    0x3370,  N,  N,  N),
+	PINGROUP(dvfs_clk_px2,           SPI6,       CLDVFS,     RSVD3,        RSVD4,       RSVD4,    0x3374,  N,  N,  N),
 	PINGROUP(gpio_x4_aud_px4,        RSVD1,      SPI1,       SPI2,         DAP2,        RSVD1,    0x3378,  N,  N,  N),
 	PINGROUP(gpio_x5_aud_px5,        RSVD1,      SPI1,       SPI2,         RSVD4,       RSVD1,    0x337c,  N,  N,  N),
 	PINGROUP(gpio_x6_aud_px6,        SPI6,       SPI1,       SPI2,         RSVD4,       RSVD4,    0x3380,  N,  N,  N),
-- 
1.7.9.5
