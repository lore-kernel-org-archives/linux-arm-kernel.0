From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Nov 2012 16:23:24 +0100
Subject: [PATCH 2/7] ARM i.MX6: fix ldb_di_sel mux
In-Reply-To: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
References: <1352733809-27230-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1352733809-27230-3-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Steffen Trumtrar <s.trumtrar@pengutronix.de>

This adds the mmdc_ch1 as a possible parent for the ldb_di clk.
According to the datasheet, this clock can be selected at this mux.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 3ec242f..6b511ba 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -104,7 +104,7 @@ static const char *gpu2d_core_sels[]	= { "axi", "pll3_usb_otg", "pll2_pfd0_352m"
 static const char *gpu3d_core_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd2_396m", };
 static const char *gpu3d_shader_sels[] = { "mmdc_ch0_axi", "pll3_usb_otg", "pll2_pfd1_594m", "pll2_pfd9_720m", };
 static const char *ipu_sels[]		= { "mmdc_ch0_axi", "pll2_pfd2_396m", "pll3_120m", "pll3_pfd1_540m", };
-static const char *ldb_di_sels[]	= { "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
+static const char *ldb_di_sels[]	= { "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "mmdc_ch1_axi", "pll3_pfd1_540m", };
 static const char *ipu_di_pre_sels[]	= { "mmdc_ch0_axi", "pll3_usb_otg", "pll5_video", "pll2_pfd0_352m", "pll2_pfd2_396m", "pll3_pfd1_540m", };
 static const char *ipu1_di0_sels[]	= { "ipu1_di0_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
 static const char *ipu1_di1_sels[]	= { "ipu1_di1_pre", "dummy", "dummy", "ldb_di0", "ldb_di1", };
-- 
1.7.10.4
