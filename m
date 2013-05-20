From: jiada_wang@mentor.com (Jiada Wang)
Date: Mon, 20 May 2013 21:51:51 +0900
Subject: [PATCH] ARM i.MX6q: fix for ldb_di_sels
Message-ID: <1369054311-2519-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As pll5_video_div has been introduced to represent the clock
generated from post-divider for video.
Instead of pll5_video, pll5_video_div should be proper root clock
for ldb_di_sel.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
CC: Shawn Guo <shawn.guo@linaro.org>
---
 arch/arm/mach-imx/clk-imx6q.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 1512590..19ea58d 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -187,7 +187,7 @@ static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m"
 static const char *gpu3d_core_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd2_396m", };
 static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd9_720m", };
 static const char *ipu_sels[]		= { "mmdc_ch0_axi", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
-static const char *ldb_di_sels[]	= { "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_usb_otg", };
+static const char *ldb_di_sels[]	= { "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_usb_otg", };
 static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_video_div", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
 static const char *ipu1_di0_sels[]	= { "ipu1_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
 static const char *ipu1_di1_sels[]	= { "ipu1_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
-- 
1.8.1.1
