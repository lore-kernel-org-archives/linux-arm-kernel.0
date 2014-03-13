From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 13 Mar 2014 11:17:42 -0600
Subject: [PATCH] pinctrl: tegra: add some missing Tegra114 entries
Message-ID: <1394731062-13097-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Add some missing pin and drive group definitions to the driver. These
are all defined in the TRM, but missing from the driver for some reason.

Fix a couple of mistakes in the drive group definitions.

Much of the diff to tegra114_groups[] is an indentation change due to one
of the new group names being long. git diff/show -w will highlight this.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/pinctrl/pinctrl-tegra114.c | 119 ++++++++++++++++++++++++++++---------
 1 file changed, 90 insertions(+), 29 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra114.c b/drivers/pinctrl/pinctrl-tegra114.c
index 7407d0069375..63fe7619d3ff 100644
--- a/drivers/pinctrl/pinctrl-tegra114.c
+++ b/drivers/pinctrl/pinctrl-tegra114.c
@@ -207,6 +207,9 @@
 #define TEGRA_PIN_PWR_INT_N			_PIN(2)
 #define TEGRA_PIN_RESET_OUT_N			_PIN(3)
 #define TEGRA_PIN_OWR				_PIN(4)
+#define TEGRA_PIN_JTAG_RTCK			_PIN(5)
+#define TEGRA_PIN_CLK_32K_IN			_PIN(6)
+#define TEGRA_PIN_GMI_CLK_LB			_PIN(7)
 
 static const struct pinctrl_pin_desc tegra114_pins[] = {
 	PINCTRL_PIN(TEGRA_PIN_CLK_32K_OUT_PA0, "CLK_32K_OUT PA0"),
@@ -383,6 +386,9 @@ static const struct pinctrl_pin_desc tegra114_pins[] = {
 	PINCTRL_PIN(TEGRA_PIN_PWR_INT_N, "PWR_INT_N"),
 	PINCTRL_PIN(TEGRA_PIN_RESET_OUT_N, "RESET_OUT_N"),
 	PINCTRL_PIN(TEGRA_PIN_OWR, "OWR"),
+	PINCTRL_PIN(TEGRA_PIN_JTAG_RTCK, "JTAG_RTCK"),
+	PINCTRL_PIN(TEGRA_PIN_CLK_32K_IN, "CLK_32K_IN"),
+	PINCTRL_PIN(TEGRA_PIN_GMI_CLK_LB, "GMI_CLK_LB"),
 };
 
 static const unsigned clk_32k_out_pa0_pins[] = {
@@ -1081,6 +1087,18 @@ static const unsigned owr_pins[] = {
 	TEGRA_PIN_OWR,
 };
 
+static const unsigned jtag_rtck_pins[] = {
+	TEGRA_PIN_JTAG_RTCK,
+};
+
+static const unsigned clk_32k_in_pins[] = {
+	TEGRA_PIN_CLK_32K_IN,
+};
+
+static const unsigned gmi_clk_lb_pins[] = {
+	TEGRA_PIN_GMI_CLK_LB,
+};
+
 static const unsigned drive_ao1_pins[] = {
 	TEGRA_PIN_KB_ROW0_PR0,
 	TEGRA_PIN_KB_ROW1_PR1,
@@ -1332,10 +1350,38 @@ static const unsigned drive_uda_pins[] = {
 	TEGRA_PIN_ULPI_STP_PY3,
 };
 
+static const unsigned drive_dev3_pins[] = {
+};
+
+static const unsigned drive_cec_pins[] = {
+};
+
+static const unsigned drive_at6_pins[] = {
+};
+
+static const unsigned drive_dap5_pins[] = {
+};
+
+static const unsigned drive_usb_vbus_en_pins[] = {
+};
+
+static const unsigned drive_ao3_pins[] = {
+};
+
+static const unsigned drive_hv0_pins[] = {
+};
+
+static const unsigned drive_sdio4_pins[] = {
+};
+
+static const unsigned drive_ao0_pins[] = {
+};
+
 enum tegra_mux {
 	TEGRA_MUX_BLINK,
 	TEGRA_MUX_CEC,
 	TEGRA_MUX_CLDVFS,
+	TEGRA_MUX_CLK,
 	TEGRA_MUX_CLK12,
 	TEGRA_MUX_CPU,
 	TEGRA_MUX_DAP,
@@ -1380,6 +1426,7 @@ enum tegra_mux {
 	TEGRA_MUX_RSVD2,
 	TEGRA_MUX_RSVD3,
 	TEGRA_MUX_RSVD4,
+	TEGRA_MUX_RTCK,
 	TEGRA_MUX_SDMMC1,
 	TEGRA_MUX_SDMMC2,
 	TEGRA_MUX_SDMMC3,
@@ -1420,6 +1467,7 @@ static struct tegra_function tegra114_functions[] = {
 	FUNCTION(blink),
 	FUNCTION(cec),
 	FUNCTION(cldvfs),
+	FUNCTION(clk),
 	FUNCTION(clk12),
 	FUNCTION(cpu),
 	FUNCTION(dap),
@@ -1464,6 +1512,7 @@ static struct tegra_function tegra114_functions[] = {
 	FUNCTION(rsvd2),
 	FUNCTION(rsvd3),
 	FUNCTION(rsvd4),
+	FUNCTION(rtck),
 	FUNCTION(sdmmc1),
 	FUNCTION(sdmmc2),
 	FUNCTION(sdmmc3),
@@ -1692,6 +1741,7 @@ static const struct tegra_pingroup tegra114_groups[] = {
 	PINGROUP(pbb6,                   VGP6,       DISPLAYA,   DISPLAYB,     RSVD4,       RSVD4,    0x32a4,  N,  N,  N),
 	PINGROUP(pbb7,                   I2S4,       RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x32a8,  N,  N,  N),
 	PINGROUP(pcc2,                   I2S4,       RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x32ac,  N,  N,  N),
+	PINGROUP(jtag_rtck,              RTCK,       RSVD2,      RSVD3,        RSVD4,       RTCK,     0x32b0,  N,  N,  N),
 	PINGROUP(pwr_i2c_scl_pz6,        I2CPWR,     RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x32b4,  Y,  N,  N),
 	PINGROUP(pwr_i2c_sda_pz7,        I2CPWR,     RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x32b8,  Y,  N,  N),
 	PINGROUP(kb_row0_pr0,            KBC,        RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x32bc,  N,  N,  N),
@@ -1718,6 +1768,7 @@ static const struct tegra_pingroup tegra114_groups[] = {
 	PINGROUP(core_pwr_req,           PWRON,      RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x3324,  N,  N,  N),
 	PINGROUP(cpu_pwr_req,            CPU,        RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x3328,  N,  N,  N),
 	PINGROUP(pwr_int_n,              PMI,        RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x332c,  N,  N,  N),
+	PINGROUP(clk_32k_in,             CLK,        RSVD2,      RSVD3,        RSVD4,       CLK,      0x3330,  N,  N,  N),
 	PINGROUP(owr,                    OWR,        RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x3334,  N,  N,  Y),
 	PINGROUP(dap1_fs_pn0,            I2S0,       HDA,        GMI,          RSVD4,       RSVD4,    0x3338,  N,  N,  N),
 	PINGROUP(dap1_din_pn1,           I2S0,       HDA,        GMI,          RSVD4,       RSVD4,    0x333c,  N,  N,  N),
@@ -1754,38 +1805,48 @@ static const struct tegra_pingroup tegra114_groups[] = {
 	PINGROUP(usb_vbus_en1_pn5,       USB,        RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x33f8,  Y,  N,  N),
 	PINGROUP(sdmmc3_clk_lb_in_pee5,  SDMMC3,     RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x33fc,  N,  N,  N),
 	PINGROUP(sdmmc3_clk_lb_out_pee4, SDMMC3,     RSVD2,      RSVD3,        RSVD4,       RSVD4,    0x3400,  N,  N,  N),
+	PINGROUP(gmi_clk_lb,             SDMMC2,     NAND,       GMI,          RSVD4,       GMI,      0x3404,  N,  N,  N),
 	PINGROUP(reset_out_n,            RSVD1,      RSVD2,      RSVD3,        RESET_OUT_N, RSVD3,    0x3408,  N,  N,  N),
 
 	/* pg_name, r, hsm_b, schmitt_b, lpmd_b, drvdn_b, drvdn_w, drvup_b, drvup_w, slwr_b, slwr_w, slwf_b, slwf_w, drvtype */
-	DRV_PINGROUP(ao1,   0x868,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(ao2,   0x86c,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(at1,   0x870,  2,  3,  4,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
-	DRV_PINGROUP(at2,   0x874,  2,  3,  4,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
-	DRV_PINGROUP(at3,   0x878,  2,  3,  4,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
-	DRV_PINGROUP(at4,   0x87c,  2,  3,  4,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
-	DRV_PINGROUP(at5,   0x880,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(cdev1, 0x884,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(cdev2, 0x888,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(dap1,  0x890,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(dap2,  0x894,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(dap3,  0x898,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(dap4,  0x89c,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(dbg,   0x8a0,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(sdio3, 0x8b0,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(spi,   0x8b4,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(uaa,   0x8b8,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(uab,   0x8bc,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(uart2, 0x8c0,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(uart3, 0x8c4,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(sdio1, 0x8ec,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(ddc,   0x8fc,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(gma,   0x900,  2,  3,  4,  14,  5,  20,  5,  28,  2,  30,  2,  Y),
-	DRV_PINGROUP(gme,   0x910,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(gmf,   0x914,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(gmg,   0x918,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(gmh,   0x91c,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(owr,   0x920,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
-	DRV_PINGROUP(uda,   0x924,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(ao1,         0x868,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(ao2,         0x86c,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(at1,         0x870,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
+	DRV_PINGROUP(at2,         0x874,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
+	DRV_PINGROUP(at3,         0x878,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
+	DRV_PINGROUP(at4,         0x87c,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  Y),
+	DRV_PINGROUP(at5,         0x880,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(cdev1,       0x884,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(cdev2,       0x888,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(dap1,        0x890,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(dap2,        0x894,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(dap3,        0x898,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(dap4,        0x89c,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(dbg,         0x8a0,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(sdio3,       0x8b0,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(spi,         0x8b4,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(uaa,         0x8b8,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(uab,         0x8bc,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(uart2,       0x8c0,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(uart3,       0x8c4,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(sdio1,       0x8ec,  2,  3, -1,  12,  7,  20,  7,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(ddc,         0x8fc,  2,  3, -1,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(gma,         0x900,  2,  3, -1,  14,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(gme,         0x910,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(gmf,         0x914,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(gmg,         0x918,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(gmh,         0x91c,  2,  3,  4,  14,  5,  19,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(owr,         0x920,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(uda,         0x924,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(dev3,        0x92c,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(cec,         0x938,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(at6,         0x994,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  Y),
+	DRV_PINGROUP(dap5,        0x998,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(usb_vbus_en, 0x99c,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(ao3,         0x9a0,  2,  3,  4,  12,  5,  -1, -1,  28,  2,  -1, -1,  N),
+	DRV_PINGROUP(hv0,         0x9a4,  2,  3,  4,  12,  5,  -1, -1,  28,  2,  -1, -1,  N),
+	DRV_PINGROUP(sdio4,       0x9a8,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
+	DRV_PINGROUP(ao0,         0x9ac,  2,  3,  4,  12,  5,  20,  5,  28,  2,  30,  2,  N),
 };
 
 static const struct tegra_pinctrl_soc_data tegra114_pinctrl = {
-- 
1.8.1.5
