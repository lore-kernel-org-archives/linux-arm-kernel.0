From: jiada_wang@mentor.com (Jiada Wang)
Date: Fri, 17 May 2013 17:40:45 +0900
Subject: [PATCH 2/2] ARM: imx: remove MLB PLL from pllv3
In-Reply-To: <1368780045-6481-1-git-send-email-jiada_wang@mentor.com>
References: <1368780045-6481-1-git-send-email-jiada_wang@mentor.com>
Message-ID: <1368780045-6481-3-git-send-email-jiada_wang@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MLB PLL should be handled internally in MLB driver,
so remove it from pllv3.

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Dirk Behme <dirk.behme@de.bosch.com>
---
 arch/arm/mach-imx/clk-pllv3.c | 10 ----------
 arch/arm/mach-imx/clk.h       |  1 -
 2 files changed, 11 deletions(-)

diff --git a/arch/arm/mach-imx/clk-pllv3.c b/arch/arm/mach-imx/clk-pllv3.c
index d09bc3d..a9fad5f 100644
--- a/arch/arm/mach-imx/clk-pllv3.c
+++ b/arch/arm/mach-imx/clk-pllv3.c
@@ -296,13 +296,6 @@ static const struct clk_ops clk_pllv3_enet_ops = {
 	.recalc_rate	= clk_pllv3_enet_recalc_rate,
 };
 
-static const struct clk_ops clk_pllv3_mlb_ops = {
-	.prepare	= clk_pllv3_prepare,
-	.unprepare	= clk_pllv3_unprepare,
-	.enable		= clk_pllv3_enable,
-	.disable	= clk_pllv3_disable,
-};
-
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 			  const char *parent_name, void __iomem *base,
 			  u32 div_mask)
@@ -330,9 +323,6 @@ struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
 	case IMX_PLLV3_ENET:
 		ops = &clk_pllv3_enet_ops;
 		break;
-	case IMX_PLLV3_MLB:
-		ops = &clk_pllv3_mlb_ops;
-		break;
 	default:
 		ops = &clk_pllv3_ops;
 	}
diff --git a/arch/arm/mach-imx/clk.h b/arch/arm/mach-imx/clk.h
index d9d9d9c..bcaafe9 100644
--- a/arch/arm/mach-imx/clk.h
+++ b/arch/arm/mach-imx/clk.h
@@ -18,7 +18,6 @@ enum imx_pllv3_type {
 	IMX_PLLV3_USB,
 	IMX_PLLV3_AV,
 	IMX_PLLV3_ENET,
-	IMX_PLLV3_MLB,
 };
 
 struct clk *imx_clk_pllv3(enum imx_pllv3_type type, const char *name,
-- 
1.8.1.1
