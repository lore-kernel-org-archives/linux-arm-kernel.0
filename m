From: jiada_wang@mentor.com (jiada_wang at mentor.com)
Date: Wed, 30 Oct 2013 04:25:51 -0700
Subject: [PATCH] ARM: i.MX6q: fix the wrong parent of can_root clock
Message-ID: <1383132351-32112-1-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jiada Wang <jiada_wang@mentor.com>

instead of pll3_usb_otg the parent of can_root clock
should be pll3_60m.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 arch/arm/mach-imx/clk-imx6q.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-imx/clk-imx6q.c b/arch/arm/mach-imx/clk-imx6q.c
index 9181a24..ef85ac4 100644
--- a/arch/arm/mach-imx/clk-imx6q.c
+++ b/arch/arm/mach-imx/clk-imx6q.c
@@ -428,7 +428,7 @@ static void __init imx6q_clocks_init(struct device_node *ccm_node)
 	clk[asrc_podf]        = imx_clk_divider("asrc_podf",        "asrc_pred",         base + 0x30, 9,  3);
 	clk[spdif_pred]       = imx_clk_divider("spdif_pred",       "spdif_sel",         base + 0x30, 25, 3);
 	clk[spdif_podf]       = imx_clk_divider("spdif_podf",       "spdif_pred",        base + 0x30, 22, 3);
-	clk[can_root]         = imx_clk_divider("can_root",         "pll3_usb_otg",      base + 0x20, 2,  6);
+	clk[can_root]         = imx_clk_divider("can_root",         "pll3_60m",          base + 0x20, 2,  6);
 	clk[ecspi_root]       = imx_clk_divider("ecspi_root",       "pll3_60m",          base + 0x38, 19, 6);
 	clk[gpu2d_core_podf]  = imx_clk_divider("gpu2d_core_podf",  "gpu2d_core_sel",    base + 0x18, 23, 3);
 	clk[gpu3d_core_podf]  = imx_clk_divider("gpu3d_core_podf",  "gpu3d_core_sel",    base + 0x18, 26, 3);
-- 
1.7.9.5
