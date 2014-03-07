From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri,  7 Mar 2014 12:22:17 -0700
Subject: [PATCH 4/4] pinctrl: tegra: consistency cleanup
In-Reply-To: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
References: <1394220137-16351-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <1394220137-16351-4-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

Fix Tegra30/114/124 pinmux drivers consistency issues.
* Sort all lists of the same object type (e.g. #defines for pins, and
  the array that defines their names) in the same order.
* Whitespace fixes.
* Consistency in layout between the 3 drivers.

These driver files were also auto-generated, which should allow us to
make e.g. the U-Boot drivers completely consistent with the kernel in
the future:-)

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
I noticed that some of the arrays in pinctrl-tegra124.c are indented with
spaces rather than TABs. If you can suffer a larger churny diff, I could
regenerate that file and fix that issue too.

 drivers/pinctrl/pinctrl-tegra114.c |  53 ++++++++-----------
 drivers/pinctrl/pinctrl-tegra124.c | 106 +++++++++++++++++++------------------
 drivers/pinctrl/pinctrl-tegra30.c  |  32 +++++------
 3 files changed, 93 insertions(+), 98 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-tegra114.c b/drivers/pinctrl/pinctrl-tegra114.c
index 1c9346f28b84..7407d0069375 100644
--- a/drivers/pinctrl/pinctrl-tegra114.c
+++ b/drivers/pinctrl/pinctrl-tegra114.c
@@ -1,10 +1,8 @@
 /*
- * Pinctrl data and driver for the NVIDIA Tegra114 pinmux
+ * Pinctrl data for the NVIDIA Tegra114 pinmux
  *
  * Copyright (c) 2012-2013, NVIDIA CORPORATION.  All rights reserved.
  *
- * Author:  Pritesh Raithatha <praithatha@nvidia.com>
- *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License,
  * version 2, as published by the Free Software Foundation.
@@ -13,9 +11,6 @@
  * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
  * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
  * more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
 #include <linux/module.h>
@@ -203,8 +198,8 @@
 #define TEGRA_PIN_SDMMC3_CLK_LB_IN_PEE5		_GPIO(245)
 
 /* All non-GPIO pins follow */
-#define NUM_GPIOS	(TEGRA_PIN_SDMMC3_CLK_LB_IN_PEE5 + 1)
-#define _PIN(offset)	(NUM_GPIOS + (offset))
+#define NUM_GPIOS				(TEGRA_PIN_SDMMC3_CLK_LB_IN_PEE5 + 1)
+#define _PIN(offset)				(NUM_GPIOS + (offset))
 
 /* Non-GPIO pins */
 #define TEGRA_PIN_CORE_PWR_REQ			_PIN(0)
@@ -213,7 +208,7 @@
 #define TEGRA_PIN_RESET_OUT_N			_PIN(3)
 #define TEGRA_PIN_OWR				_PIN(4)
 
-static const struct pinctrl_pin_desc  tegra114_pins[] = {
+static const struct pinctrl_pin_desc tegra114_pins[] = {
 	PINCTRL_PIN(TEGRA_PIN_CLK_32K_OUT_PA0, "CLK_32K_OUT PA0"),
 	PINCTRL_PIN(TEGRA_PIN_UART3_CTS_N_PA1, "UART3_CTS_N PA1"),
 	PINCTRL_PIN(TEGRA_PIN_DAP2_FS_PA2, "DAP2_FS PA2"),
@@ -385,9 +380,9 @@ static const struct pinctrl_pin_desc  tegra114_pins[] = {
 	PINCTRL_PIN(TEGRA_PIN_SDMMC3_CLK_LB_IN_PEE5, "SDMMC3_CLK_LB_IN PEE5"),
 	PINCTRL_PIN(TEGRA_PIN_CORE_PWR_REQ, "CORE_PWR_REQ"),
 	PINCTRL_PIN(TEGRA_PIN_CPU_PWR_REQ, "CPU_PWR_REQ"),
-	PINCTRL_PIN(TEGRA_PIN_OWR, "OWR"),
 	PINCTRL_PIN(TEGRA_PIN_PWR_INT_N, "PWR_INT_N"),
 	PINCTRL_PIN(TEGRA_PIN_RESET_OUT_N, "RESET_OUT_N"),
+	PINCTRL_PIN(TEGRA_PIN_OWR, "OWR"),
 };
 
 static const unsigned clk_32k_out_pa0_pins[] = {
@@ -1074,10 +1069,6 @@ static const unsigned cpu_pwr_req_pins[] = {
 	TEGRA_PIN_CPU_PWR_REQ,
 };
 
-static const unsigned owr_pins[] = {
-	TEGRA_PIN_OWR,
-};
-
 static const unsigned pwr_int_n_pins[] = {
 	TEGRA_PIN_PWR_INT_N,
 };
@@ -1086,6 +1077,10 @@ static const unsigned reset_out_n_pins[] = {
 	TEGRA_PIN_RESET_OUT_N,
 };
 
+static const unsigned owr_pins[] = {
+	TEGRA_PIN_OWR,
+};
+
 static const unsigned drive_ao1_pins[] = {
 	TEGRA_PIN_KB_ROW0_PR0,
 	TEGRA_PIN_KB_ROW1_PR1,
@@ -1127,7 +1122,6 @@ static const unsigned drive_at1_pins[] = {
 	TEGRA_PIN_GMI_AD13_PH5,
 	TEGRA_PIN_GMI_AD14_PH6,
 	TEGRA_PIN_GMI_AD15_PH7,
-
 	TEGRA_PIN_GMI_IORDY_PI5,
 	TEGRA_PIN_GMI_CS7_N_PI6,
 };
@@ -1141,15 +1135,12 @@ static const unsigned drive_at2_pins[] = {
 	TEGRA_PIN_GMI_AD5_PG5,
 	TEGRA_PIN_GMI_AD6_PG6,
 	TEGRA_PIN_GMI_AD7_PG7,
-
 	TEGRA_PIN_GMI_WR_N_PI0,
 	TEGRA_PIN_GMI_OE_N_PI1,
 	TEGRA_PIN_GMI_CS6_N_PI3,
 	TEGRA_PIN_GMI_RST_N_PI4,
 	TEGRA_PIN_GMI_WAIT_PI7,
-
 	TEGRA_PIN_GMI_DQS_P_PJ3,
-
 	TEGRA_PIN_GMI_ADV_N_PK0,
 	TEGRA_PIN_GMI_CLK_PK1,
 	TEGRA_PIN_GMI_CS4_N_PK2,
@@ -1425,7 +1416,7 @@ enum tegra_mux {
 		.name = #fname,				\
 	}
 
-static struct tegra_function  tegra114_functions[] = {
+static struct tegra_function tegra114_functions[] = {
 	FUNCTION(blink),
 	FUNCTION(cec),
 	FUNCTION(cldvfs),
@@ -1504,11 +1495,11 @@ static struct tegra_function  tegra114_functions[] = {
 	FUNCTION(vi_alt3),
 };
 
-#define DRV_PINGROUP_REG_START			0x868	/* bank 0 */
-#define PINGROUP_REG_START			0x3000	/* bank 1 */
+#define DRV_PINGROUP_REG_A		0x868	/* bank 0 */
+#define PINGROUP_REG_A			0x3000	/* bank 1 */
 
-#define PINGROUP_REG_Y(r)			((r) - PINGROUP_REG_START)
-#define PINGROUP_REG_N(r)			-1
+#define PINGROUP_REG_Y(r)		((r) - PINGROUP_REG_A)
+#define PINGROUP_REG_N(r)		-1
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, f_safe, r, od, ior, rcv_sel)	\
 	{								\
@@ -1550,13 +1541,14 @@ static struct tegra_function  tegra114_functions[] = {
 		.drvtype_reg = -1,					\
 	}
 
-#define DRV_PINGROUP_DVRTYPE_Y(r) ((r) - DRV_PINGROUP_REG_START)
-#define DRV_PINGROUP_DVRTYPE_N(r) -1
+#define DRV_PINGROUP_REG_Y(r)		((r) - DRV_PINGROUP_REG_A)
+#define DRV_PINGROUP_REG_N(r)		-1
+
 
 #define DRV_PINGROUP(pg_name, r, hsm_b, schmitt_b, lpmd_b,		\
-			drvdn_b, drvdn_w, drvup_b, drvup_w,		\
-			slwr_b, slwr_w, slwf_b, slwf_w,			\
-			drvtype)					\
+		     drvdn_b, drvdn_w, drvup_b, drvup_w,		\
+		     slwr_b, slwr_w, slwf_b, slwf_w,			\
+		     drvtype)						\
 	{								\
 		.name = "drive_" #pg_name,				\
 		.pins = drive_##pg_name##_pins,				\
@@ -1569,7 +1561,7 @@ static struct tegra_function  tegra114_functions[] = {
 		.lock_reg = -1,						\
 		.ioreset_reg = -1,					\
 		.rcv_sel_reg = -1,					\
-		.drv_reg = DRV_PINGROUP_DVRTYPE_Y(r),			\
+		.drv_reg = DRV_PINGROUP_REG_Y(r),			\
 		.drv_bank = 0,						\
 		.hsm_bit = hsm_b,					\
 		.schmitt_bit = schmitt_b,				\
@@ -1582,14 +1574,13 @@ static struct tegra_function  tegra114_functions[] = {
 		.slwr_width = slwr_w,					\
 		.slwf_bit = slwf_b,					\
 		.slwf_width = slwf_w,					\
-		.drvtype_reg = DRV_PINGROUP_DVRTYPE_##drvtype(r),	\
+		.drvtype_reg = DRV_PINGROUP_REG_##drvtype(r),		\
 		.drvtype_bank = 0,					\
 		.drvtype_bit = 6,					\
 	}
 
 static const struct tegra_pingroup tegra114_groups[] = {
 	/*       pg_name,                f0,         f1,         f2,           f3,          safe,     r,      od, ior, rcv_sel */
-	/* FIXME: Fill in correct data in safe column */
 	PINGROUP(ulpi_data0_po1,         SPI3,       HSI,        UARTA,        ULPI,        ULPI,     0x3000,  N,  N,  N),
 	PINGROUP(ulpi_data1_po2,         SPI3,       HSI,        UARTA,        ULPI,        ULPI,     0x3004,  N,  N,  N),
 	PINGROUP(ulpi_data2_po3,         SPI3,       HSI,        UARTA,        ULPI,        ULPI,     0x3008,  N,  N,  N),
diff --git a/drivers/pinctrl/pinctrl-tegra124.c b/drivers/pinctrl/pinctrl-tegra124.c
index 3b03d77d454b..d1ec687ddfff 100644
--- a/drivers/pinctrl/pinctrl-tegra124.c
+++ b/drivers/pinctrl/pinctrl-tegra124.c
@@ -212,8 +212,8 @@
 #define TEGRA_PIN_PFF2				_GPIO(250)
 
 /* All non-GPIO pins follow */
-#define NUM_GPIOS	(TEGRA_PIN_PFF2 + 1)
-#define _PIN(offset)	(NUM_GPIOS + (offset))
+#define NUM_GPIOS				(TEGRA_PIN_PFF2 + 1)
+#define _PIN(offset)				(NUM_GPIOS + (offset))
 
 /* Non-GPIO pins */
 #define TEGRA_PIN_CORE_PWR_REQ			_PIN(0)
@@ -406,16 +406,16 @@ static const struct pinctrl_pin_desc tegra124_pins[] = {
 	PINCTRL_PIN(TEGRA_PIN_HDMI_CEC_PEE3, "HDMI_CEC PEE3"),
 	PINCTRL_PIN(TEGRA_PIN_SDMMC3_CLK_LB_OUT_PEE4, "SDMMC3_CLK_LB_OUT PEE4"),
 	PINCTRL_PIN(TEGRA_PIN_SDMMC3_CLK_LB_IN_PEE5, "SDMMC3_CLK_LB_IN PEE5"),
+	PINCTRL_PIN(TEGRA_PIN_DP_HPD_PFF0, "DP_HPD PFF0"),
+	PINCTRL_PIN(TEGRA_PIN_USB_VBUS_EN2_PFF1, "USB_VBUS_EN2 PFF1"),
+	PINCTRL_PIN(TEGRA_PIN_PFF2, "PFF2"),
 	PINCTRL_PIN(TEGRA_PIN_CORE_PWR_REQ, "CORE_PWR_REQ"),
 	PINCTRL_PIN(TEGRA_PIN_CPU_PWR_REQ, "CPU_PWR_REQ"),
-	PINCTRL_PIN(TEGRA_PIN_OWR, "OWR"),
 	PINCTRL_PIN(TEGRA_PIN_PWR_INT_N, "PWR_INT_N"),
+	PINCTRL_PIN(TEGRA_PIN_GMI_CLK_LB, "GMI_CLK_LB"),
 	PINCTRL_PIN(TEGRA_PIN_RESET_OUT_N, "RESET_OUT_N"),
-	PINCTRL_PIN(TEGRA_PIN_DP_HPD_PFF0, "DP_HPD PFF0"),
-	PINCTRL_PIN(TEGRA_PIN_USB_VBUS_EN2_PFF1, "USB_VBUS_EN2 PFF1"),
-	PINCTRL_PIN(TEGRA_PIN_PFF2, "PFF2"),
+	PINCTRL_PIN(TEGRA_PIN_OWR, "OWR"),
 	PINCTRL_PIN(TEGRA_PIN_CLK_32K_IN, "CLK_32K_IN"),
-	PINCTRL_PIN(TEGRA_PIN_GMI_CLK_LB, "GMI_CLK_LB"),
 	PINCTRL_PIN(TEGRA_PIN_JTAG_RTCK, "JTAG_RTCK"),
 };
 
@@ -1138,6 +1138,7 @@ static const unsigned sdmmc3_clk_lb_out_pee4_pins[] = {
 static const unsigned sdmmc3_clk_lb_in_pee5_pins[] = {
 	TEGRA_PIN_SDMMC3_CLK_LB_IN_PEE5,
 };
+
 static const unsigned dp_hpd_pff0_pins[] = {
 	TEGRA_PIN_DP_HPD_PFF0,
 };
@@ -1158,24 +1159,24 @@ static const unsigned cpu_pwr_req_pins[] = {
 	TEGRA_PIN_CPU_PWR_REQ,
 };
 
-static const unsigned owr_pins[] = {
-	TEGRA_PIN_OWR,
-};
-
 static const unsigned pwr_int_n_pins[] = {
 	TEGRA_PIN_PWR_INT_N,
 };
 
+static const unsigned gmi_clk_lb_pins[] = {
+	TEGRA_PIN_GMI_CLK_LB,
+};
+
 static const unsigned reset_out_n_pins[] = {
 	TEGRA_PIN_RESET_OUT_N,
 };
 
-static const unsigned clk_32k_in_pins[] = {
-	TEGRA_PIN_CLK_32K_IN,
+static const unsigned owr_pins[] = {
+	TEGRA_PIN_OWR,
 };
 
-static const unsigned gmi_clk_lb_pins[] = {
-	TEGRA_PIN_GMI_CLK_LB,
+static const unsigned clk_32k_in_pins[] = {
+	TEGRA_PIN_CLK_32K_IN,
 };
 
 static const unsigned jtag_rtck_pins[] = {
@@ -1441,15 +1442,15 @@ static const unsigned drive_gpv_pins[] = {
 	TEGRA_PIN_PFF2,
 };
 
-static const unsigned drive_cec_pins[] = {
-	TEGRA_PIN_HDMI_CEC_PEE3,
-};
-
 static const unsigned drive_dev3_pins[] = {
 	TEGRA_PIN_CLK3_OUT_PEE0,
 	TEGRA_PIN_CLK3_REQ_PEE1,
 };
 
+static const unsigned drive_cec_pins[] = {
+	TEGRA_PIN_HDMI_CEC_PEE3,
+};
+
 static const unsigned drive_at6_pins[] = {
 	TEGRA_PIN_PK1,
 	TEGRA_PIN_PK3,
@@ -1496,8 +1497,10 @@ static const unsigned drive_ao4_pins[] = {
 
 enum tegra_mux {
 	TEGRA_MUX_BLINK,
+	TEGRA_MUX_CCLA,
 	TEGRA_MUX_CEC,
 	TEGRA_MUX_CLDVFS,
+	TEGRA_MUX_CLK,
 	TEGRA_MUX_CLK12,
 	TEGRA_MUX_CPU,
 	TEGRA_MUX_DAP,
@@ -1507,6 +1510,7 @@ enum tegra_mux {
 	TEGRA_MUX_DISPLAYA,
 	TEGRA_MUX_DISPLAYA_ALT,
 	TEGRA_MUX_DISPLAYB,
+	TEGRA_MUX_DP,
 	TEGRA_MUX_DTV,
 	TEGRA_MUX_EXTPERIPH1,
 	TEGRA_MUX_EXTPERIPH2,
@@ -1528,6 +1532,9 @@ enum tegra_mux {
 	TEGRA_MUX_IRDA,
 	TEGRA_MUX_KBC,
 	TEGRA_MUX_OWR,
+	TEGRA_MUX_PE,
+	TEGRA_MUX_PE0,
+	TEGRA_MUX_PE1,
 	TEGRA_MUX_PMI,
 	TEGRA_MUX_PWM0,
 	TEGRA_MUX_PWM1,
@@ -1539,6 +1546,8 @@ enum tegra_mux {
 	TEGRA_MUX_RSVD2,
 	TEGRA_MUX_RSVD3,
 	TEGRA_MUX_RSVD4,
+	TEGRA_MUX_RTCK,
+	TEGRA_MUX_SATA,
 	TEGRA_MUX_SDMMC1,
 	TEGRA_MUX_SDMMC2,
 	TEGRA_MUX_SDMMC3,
@@ -1551,6 +1560,8 @@ enum tegra_mux {
 	TEGRA_MUX_SPI4,
 	TEGRA_MUX_SPI5,
 	TEGRA_MUX_SPI6,
+	TEGRA_MUX_SYS,
+	TEGRA_MUX_TMDS,
 	TEGRA_MUX_TRACE,
 	TEGRA_MUX_UARTA,
 	TEGRA_MUX_UARTB,
@@ -1569,16 +1580,6 @@ enum tegra_mux {
 	TEGRA_MUX_VI_ALT3,
 	TEGRA_MUX_VIMCLK2,
 	TEGRA_MUX_VIMCLK2_ALT,
-	TEGRA_MUX_SATA,
-	TEGRA_MUX_CCLA,
-	TEGRA_MUX_PE0,
-	TEGRA_MUX_PE,
-	TEGRA_MUX_PE1,
-	TEGRA_MUX_DP,
-	TEGRA_MUX_RTCK,
-	TEGRA_MUX_SYS,
-	TEGRA_MUX_CLK,
-	TEGRA_MUX_TMDS,
 };
 
 #define FUNCTION(fname)					\
@@ -1588,8 +1589,10 @@ enum tegra_mux {
 
 static struct tegra_function tegra124_functions[] = {
 	FUNCTION(blink),
+	FUNCTION(ccla),
 	FUNCTION(cec),
 	FUNCTION(cldvfs),
+	FUNCTION(clk),
 	FUNCTION(clk12),
 	FUNCTION(cpu),
 	FUNCTION(dap),
@@ -1599,6 +1602,7 @@ static struct tegra_function tegra124_functions[] = {
 	FUNCTION(displaya),
 	FUNCTION(displaya_alt),
 	FUNCTION(displayb),
+	FUNCTION(dp),
 	FUNCTION(dtv),
 	FUNCTION(extperiph1),
 	FUNCTION(extperiph2),
@@ -1620,6 +1624,9 @@ static struct tegra_function tegra124_functions[] = {
 	FUNCTION(irda),
 	FUNCTION(kbc),
 	FUNCTION(owr),
+	FUNCTION(pe),
+	FUNCTION(pe0),
+	FUNCTION(pe1),
 	FUNCTION(pmi),
 	FUNCTION(pwm0),
 	FUNCTION(pwm1),
@@ -1631,6 +1638,8 @@ static struct tegra_function tegra124_functions[] = {
 	FUNCTION(rsvd2),
 	FUNCTION(rsvd3),
 	FUNCTION(rsvd4),
+	FUNCTION(rtck),
+	FUNCTION(sata),
 	FUNCTION(sdmmc1),
 	FUNCTION(sdmmc2),
 	FUNCTION(sdmmc3),
@@ -1643,6 +1652,8 @@ static struct tegra_function tegra124_functions[] = {
 	FUNCTION(spi4),
 	FUNCTION(spi5),
 	FUNCTION(spi6),
+	FUNCTION(sys),
+	FUNCTION(tmds),
 	FUNCTION(trace),
 	FUNCTION(uarta),
 	FUNCTION(uartb),
@@ -1661,23 +1672,13 @@ static struct tegra_function tegra124_functions[] = {
 	FUNCTION(vi_alt3),
 	FUNCTION(vimclk2),
 	FUNCTION(vimclk2_alt),
-	FUNCTION(sata),
-	FUNCTION(ccla),
-	FUNCTION(pe0),
-	FUNCTION(pe),
-	FUNCTION(pe1),
-	FUNCTION(dp),
-	FUNCTION(rtck),
-	FUNCTION(sys),
-	FUNCTION(clk),
-	FUNCTION(tmds),
 };
 
-#define DRV_PINGROUP_REG_A	0x868	/* bank 0 */
-#define PINGROUP_REG_A		0x3000	/* bank 1 */
+#define DRV_PINGROUP_REG_A		0x868	/* bank 0 */
+#define PINGROUP_REG_A			0x3000	/* bank 1 */
 
-#define PINGROUP_REG_Y(r)	((r) - PINGROUP_REG_A)
-#define PINGROUP_REG_N(r)	-1
+#define PINGROUP_REG_Y(r)		((r) - PINGROUP_REG_A)
+#define PINGROUP_REG_N(r)		-1
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, f_safe, r, od, ior, rcv_sel)	\
 	{								\
@@ -1685,12 +1686,12 @@ static struct tegra_function tegra124_functions[] = {
 		.pins = pg_name##_pins,					\
 		.npins = ARRAY_SIZE(pg_name##_pins),			\
 		.funcs = {						\
-			TEGRA_MUX_ ## f0,				\
-			TEGRA_MUX_ ## f1,				\
-			TEGRA_MUX_ ## f2,				\
-			TEGRA_MUX_ ## f3,				\
+			TEGRA_MUX_##f0,					\
+			TEGRA_MUX_##f1,					\
+			TEGRA_MUX_##f2,					\
+			TEGRA_MUX_##f3,					\
 		},							\
-		.func_safe = TEGRA_MUX_ ## f_safe,			\
+		.func_safe = TEGRA_MUX_##f_safe,			\
 		.mux_reg = PINGROUP_REG_Y(r),				\
 		.mux_bank = 1,						\
 		.mux_bit = 0,						\
@@ -1719,8 +1720,9 @@ static struct tegra_function tegra124_functions[] = {
 		.drvtype_reg = -1,					\
 	}
 
-#define DRV_PINGROUP_DVRTYPE_Y(r) ((r) - DRV_PINGROUP_REG_A)
-#define DRV_PINGROUP_DVRTYPE_N(r) -1
+#define DRV_PINGROUP_REG_Y(r)		((r) - DRV_PINGROUP_REG_A)
+#define DRV_PINGROUP_REG_N(r)		-1
+
 
 #define DRV_PINGROUP(pg_name, r, hsm_b, schmitt_b, lpmd_b,		\
 		     drvdn_b, drvdn_w, drvup_b, drvup_w,		\
@@ -1738,7 +1740,7 @@ static struct tegra_function tegra124_functions[] = {
 		.lock_reg = -1,						\
 		.ioreset_reg = -1,					\
 		.rcv_sel_reg = -1,					\
-		.drv_reg = DRV_PINGROUP_DVRTYPE_Y(r),			\
+		.drv_reg = DRV_PINGROUP_REG_Y(r),			\
 		.drv_bank = 0,						\
 		.hsm_bit = hsm_b,					\
 		.schmitt_bit = schmitt_b,				\
@@ -1751,7 +1753,7 @@ static struct tegra_function tegra124_functions[] = {
 		.slwr_width = slwr_w,					\
 		.slwf_bit = slwf_b,					\
 		.slwf_width = slwf_w,					\
-		.drvtype_reg = DRV_PINGROUP_DVRTYPE_##drvtype(r),	\
+		.drvtype_reg = DRV_PINGROUP_REG_##drvtype(r),		\
 		.drvtype_bank = 0,					\
 		.drvtype_bit = 6,					\
 	}
diff --git a/drivers/pinctrl/pinctrl-tegra30.c b/drivers/pinctrl/pinctrl-tegra30.c
index 4bc95802ea67..41d24f5c2854 100644
--- a/drivers/pinctrl/pinctrl-tegra30.c
+++ b/drivers/pinctrl/pinctrl-tegra30.c
@@ -25,7 +25,7 @@
  * Most pins affected by the pinmux can also be GPIOs. Define these first.
  * These must match how the GPIO driver names/numbers its pins.
  */
-#define _GPIO(offset)				(offset)
+#define _GPIO(offset)			(offset)
 
 #define TEGRA_PIN_CLK_32K_OUT_PA0	_GPIO(0)
 #define TEGRA_PIN_UART3_CTS_N_PA1	_GPIO(1)
@@ -277,8 +277,8 @@
 #define TEGRA_PIN_PEE7			_GPIO(247)
 
 /* All non-GPIO pins follow */
-#define NUM_GPIOS				(TEGRA_PIN_PEE7 + 1)
-#define _PIN(offset)				(NUM_GPIOS + (offset))
+#define NUM_GPIOS			(TEGRA_PIN_PEE7 + 1)
+#define _PIN(offset)			(NUM_GPIOS + (offset))
 
 /* Non-GPIO pins */
 #define TEGRA_PIN_CLK_32K_IN		_PIN(0)
@@ -2105,11 +2105,11 @@ static struct tegra_function tegra30_functions[] = {
 	FUNCTION(vi_alt3),
 };
 
-#define DRV_PINGROUP_REG_A	0x868	/* bank 0 */
-#define PINGROUP_REG_A		0x3000	/* bank 1 */
+#define DRV_PINGROUP_REG_A		0x868	/* bank 0 */
+#define PINGROUP_REG_A			0x3000	/* bank 1 */
 
-#define PINGROUP_REG_Y(r) ((r) - PINGROUP_REG_A)
-#define PINGROUP_REG_N(r) -1
+#define PINGROUP_REG_Y(r)		((r) - PINGROUP_REG_A)
+#define PINGROUP_REG_N(r)		-1
 
 #define PINGROUP(pg_name, f0, f1, f2, f3, f_safe, r, od, ior)	\
 	{							\
@@ -2117,12 +2117,12 @@ static struct tegra_function tegra30_functions[] = {
 		.pins = pg_name##_pins,				\
 		.npins = ARRAY_SIZE(pg_name##_pins),		\
 		.funcs = {					\
-			TEGRA_MUX_ ## f0,			\
-			TEGRA_MUX_ ## f1,			\
-			TEGRA_MUX_ ## f2,			\
-			TEGRA_MUX_ ## f3,			\
+			TEGRA_MUX_##f0,				\
+			TEGRA_MUX_##f1,				\
+			TEGRA_MUX_##f2,				\
+			TEGRA_MUX_##f3,				\
 		},						\
-		.func_safe = TEGRA_MUX_ ## f_safe,		\
+		.func_safe = TEGRA_MUX_##f_safe,		\
 		.mux_reg = PINGROUP_REG_Y(r),			\
 		.mux_bank = 1,					\
 		.mux_bit = 0,					\
@@ -2149,6 +2149,9 @@ static struct tegra_function tegra30_functions[] = {
 		.drvtype_reg = -1,				\
 	}
 
+#define DRV_PINGROUP_REG_Y(r)		((r) - DRV_PINGROUP_REG_A)
+#define DRV_PINGROUP_REG_N(r)		-1
+
 #define DRV_PINGROUP(pg_name, r, hsm_b, schmitt_b, lpmd_b,	\
 		     drvdn_b, drvdn_w, drvup_b, drvup_w,	\
 		     slwr_b, slwr_w, slwf_b, slwf_w)		\
@@ -2164,7 +2167,7 @@ static struct tegra_function tegra30_functions[] = {
 		.lock_reg = -1,					\
 		.ioreset_reg = -1,				\
 		.rcv_sel_reg = -1,				\
-		.drv_reg = ((r) - DRV_PINGROUP_REG_A),		\
+		.drv_reg = DRV_PINGROUP_REG_Y(r),		\
 		.drv_bank = 0,					\
 		.hsm_bit = hsm_b,				\
 		.schmitt_bit = schmitt_b,			\
@@ -2182,7 +2185,6 @@ static struct tegra_function tegra30_functions[] = {
 
 static const struct tegra_pingroup tegra30_groups[] = {
 	/*       pg_name,              f0,           f1,           f2,           f3,           safe,         r,      od, ior */
-	/* FIXME: Fill in correct data in safe column */
 	PINGROUP(clk_32k_out_pa0,      BLINK,        RSVD2,        RSVD3,        RSVD4,        RSVD4,        0x331c, N, N),
 	PINGROUP(uart3_cts_n_pa1,      UARTC,        RSVD2,        GMI,          RSVD4,        RSVD4,        0x317c, N, N),
 	PINGROUP(dap2_fs_pa2,          I2S1,         HDA,          RSVD3,        GMI,          RSVD3,        0x3358, N, N),
@@ -2495,6 +2497,7 @@ static struct of_device_id tegra30_pinctrl_of_match[] = {
 	{ .compatible = "nvidia,tegra30-pinmux", },
 	{ },
 };
+MODULE_DEVICE_TABLE(of, tegra30_pinctrl_of_match);
 
 static struct platform_driver tegra30_pinctrl_driver = {
 	.driver = {
@@ -2510,4 +2513,3 @@ module_platform_driver(tegra30_pinctrl_driver);
 MODULE_AUTHOR("Stephen Warren <swarren@nvidia.com>");
 MODULE_DESCRIPTION("NVIDIA Tegra30 pinctrl driver");
 MODULE_LICENSE("GPL v2");
-MODULE_DEVICE_TABLE(of, tegra30_pinctrl_of_match);
-- 
1.8.1.5
