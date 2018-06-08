From: pp@emlix.com (Philipp Puschmann)
Date: Fri,  8 Jun 2018 12:19:24 +0200
Subject: [PATCH] clk: imx6: fix video_27m parent for IMX6QDL_CLK_CKO1_SEL
Message-ID: <20180608101924.31195-1-pp@emlix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

q/dl datasheets list the 5th selection value for ck01_sel as
video_27M_clk_root.

By replacing the dummy value we then can set IMX6QDL_CLK_VIDEO_27M
as parent for IMX6QDL_CLK_CKO1_SEL.

Signed-off-by: Philipp Puschmann <pp@emlix.com>
---
 drivers/clk/imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
index 8d518ad5dc13..7e6a8f079634 100644
--- a/drivers/clk/imx/clk-imx6q.c
+++ b/drivers/clk/imx/clk-imx6q.c
@@ -65,7 +65,7 @@ static const char *ipg_per_sels[] = { "ipg", "osc", };
 static const char *ecspi_sels[] = { "pll3_60m", "osc", };
 static const char *can_sels[] = { "pll3_60m", "osc", "pll3_80m", };
 static const char *cko1_sels[]	= { "pll3_usb_otg", "pll2_bus", "pll1_sys", "pll5_video_div",
-				    "dummy", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
+				    "video_27m", "axi", "enfc", "ipu1_di0", "ipu1_di1", "ipu2_di0",
 				    "ipu2_di1", "ahb", "ipg", "ipg_per", "ckil", "pll4_audio_div", };
 static const char *cko2_sels[] = {
 	"mmdc_ch0_axi", "mmdc_ch1_axi", "usdhc4", "usdhc1",
-- 
2.17.0
