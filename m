From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Tue, 09 Jan 2018 16:58:58 +0900
Subject: [PATCH 1/9] clk: samsung: exynos5433: Add clock flag to support
 suspend-to-ram
In-Reply-To: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
References: <1515484746-10656-1-git-send-email-cw00.choi@samsung.com>
 <CGME20180109075905epcas1p1486543d8fec46f47d9d5ac350d841337@epcas1p1.samsung.com>
Message-ID: <1515484746-10656-2-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the CLK_IS_CRITICAL and CLK_IGNORE_UNUSED flag
to some clocks in order to avoid the hang-out in the suspend mode.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-clk at vger.kernel.org
---
 drivers/clk/samsung/clk-exynos5433.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos5433.c b/drivers/clk/samsung/clk-exynos5433.c
index db270908037a..3dc53cd0c730 100644
--- a/drivers/clk/samsung/clk-exynos5433.c
+++ b/drivers/clk/samsung/clk-exynos5433.c
@@ -583,25 +583,25 @@
 			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_ACLK_CAM1_333, "aclk_cam1_333", "div_aclk_cam1_333",
 			ENABLE_ACLK_TOP, 13,
-			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
+			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_CAM1_400, "aclk_cam1_400", "div_aclk_cam1_400",
 			ENABLE_ACLK_TOP, 12,
 			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_CAM1_552, "aclk_cam1_552", "div_aclk_cam1_552",
 			ENABLE_ACLK_TOP, 11,
-			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
+			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_CAM0_333, "aclk_cam0_333", "div_aclk_cam0_333",
 			ENABLE_ACLK_TOP, 10,
-			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
+			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_CAM0_400, "aclk_cam0_400", "div_aclk_cam0_400",
 			ENABLE_ACLK_TOP, 9,
 			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_CAM0_552, "aclk_cam0_552", "div_aclk_cam0_552",
 			ENABLE_ACLK_TOP, 8,
-			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
+			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_ISP_DIS_400, "aclk_isp_dis_400", "div_aclk_isp_dis_400",
 			ENABLE_ACLK_TOP, 7,
-			CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED, 0),
+			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_ACLK_ISP_400, "aclk_isp_400", "div_aclk_isp_400",
 			ENABLE_ACLK_TOP, 6,
 			CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
@@ -624,11 +624,11 @@

 	/* ENABLE_SCLK_TOP_CAM1 */
 	GATE(CLK_SCLK_ISP_SENSOR2, "sclk_isp_sensor2", "div_sclk_isp_sensor2_b",
-			ENABLE_SCLK_TOP_CAM1, 7, 0, 0),
+			ENABLE_SCLK_TOP_CAM1, 7, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_ISP_SENSOR1, "sclk_isp_sensor1", "div_sclk_isp_sensor1_b",
 			ENABLE_SCLK_TOP_CAM1, 6, 0, 0),
 	GATE(CLK_SCLK_ISP_SENSOR0, "sclk_isp_sensor0", "div_sclk_isp_sensor0_b",
-			ENABLE_SCLK_TOP_CAM1, 5, 0, 0),
+			ENABLE_SCLK_TOP_CAM1, 5, CLK_IGNORE_UNUSED, 0),
 	GATE(CLK_SCLK_ISP_MCTADC_CAM1, "sclk_isp_mctadc_cam1", "oscclk",
 			ENABLE_SCLK_TOP_CAM1, 4, 0, 0),
 	GATE(CLK_SCLK_ISP_UART_CAM1, "sclk_isp_uart_cam1", "div_sclk_isp_uart",
@@ -636,7 +636,7 @@
 	GATE(CLK_SCLK_ISP_SPI1_CAM1, "sclk_isp_spi1_cam1", "div_sclk_isp_spi1_b",
 			ENABLE_SCLK_TOP_CAM1, 1, 0, 0),
 	GATE(CLK_SCLK_ISP_SPI0_CAM1, "sclk_isp_spi0_cam1", "div_sclk_isp_spi0_b",
-			ENABLE_SCLK_TOP_CAM1, 0, 0, 0),
+			ENABLE_SCLK_TOP_CAM1, 0, CLK_IGNORE_UNUSED, 0),

 	/* ENABLE_SCLK_TOP_DISP */
 	GATE(CLK_SCLK_HDMI_SPDIF_DISP, "sclk_hdmi_spdif_disp",
@@ -654,7 +654,7 @@
 			ENABLE_SCLK_TOP_FSYS, 4, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_UFSUNIPRO_FSYS, "sclk_ufsunipro_fsys",
 			"div_sclk_ufsunipro", ENABLE_SCLK_TOP_FSYS,
-			3, CLK_SET_RATE_PARENT, 0),
+			3, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL, 0),
 	GATE(CLK_SCLK_USBHOST30_FSYS, "sclk_usbhost30_fsys",
 			"div_sclk_usbhost30", ENABLE_SCLK_TOP_FSYS,
 			1, CLK_SET_RATE_PARENT, 0),
@@ -2982,7 +2982,7 @@ static void __init exynos5433_cmu_peris_init(struct device_node *np)
 	GATE(CLK_PCLK_AUD_SLIMBUS, "pclk_aud_slimbus", "div_aclk_aud",
 			ENABLE_PCLK_AUD, 6, 0, 0),
 	GATE(CLK_PCLK_AUD_UART, "pclk_aud_uart", "div_aclk_aud",
-			ENABLE_PCLK_AUD, 5, 0, 0),
+			ENABLE_PCLK_AUD, 5, CLK_IS_CRITICAL, 0),
 	GATE(CLK_PCLK_AUD_PCM, "pclk_aud_pcm", "div_aclk_aud",
 			ENABLE_PCLK_AUD, 4, 0, 0),
 	GATE(CLK_PCLK_AUD_I2S, "pclk_aud_i2s", "div_aclk_aud",
@@ -3008,7 +3008,7 @@ static void __init exynos5433_cmu_peris_init(struct device_node *np)
 	GATE(CLK_SCLK_AUD_SLIMBUS, "sclk_aud_slimbus", "div_sclk_aud_slimbus",
 			ENABLE_SCLK_AUD1, 4, 0, 0),
 	GATE(CLK_SCLK_AUD_UART, "sclk_aud_uart", "div_sclk_aud_uart",
-			ENABLE_SCLK_AUD1, 3, CLK_IGNORE_UNUSED, 0),
+			ENABLE_SCLK_AUD1, 3, CLK_IS_CRITICAL, 0),
 	GATE(CLK_SCLK_AUD_PCM, "sclk_aud_pcm", "div_sclk_aud_pcm",
 			ENABLE_SCLK_AUD1, 2, 0, 0),
 	GATE(CLK_SCLK_I2S_BCLK, "sclk_i2s_bclk", "ioclk_i2s_bclk",
--
1.9.1
