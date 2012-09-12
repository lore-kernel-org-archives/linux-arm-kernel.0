From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 12 Sep 2012 11:58:59 +0200
Subject: [PATCH] ARM i.MX53 clk: Fix ldb parent clocks
Message-ID: <1347443939-23677-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ipu_di0 and ipu_di1 muxes referenced to nonexisting clocks. Use
ldb_di0_gate and ldb_di1_gate instead.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/mach-imx/clk-imx51-imx53.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
index f608669..df1b551 100644
--- a/arch/arm/mach-imx/clk-imx51-imx53.c
+++ b/arch/arm/mach-imx/clk-imx51-imx53.c
@@ -39,10 +39,10 @@ static const char *ssi_ext2_com_sels[] = { "ssi_ext2_podf", "ssi2_root_gate", };
 static const char *emi_slow_sel[] = { "main_bus", "ahb", };
 static const char *usb_phy_sel_str[] = { "osc", "usb_phy_podf", };
 static const char *mx51_ipu_di0_sel[] = { "di_pred", "osc", "ckih1", "tve_di", };
-static const char *mx53_ipu_di0_sel[] = { "di_pred", "osc", "ckih1", "di_pll4_podf", "dummy", "ldb_di0", };
+static const char *mx53_ipu_di0_sel[] = { "di_pred", "osc", "ckih1", "di_pll4_podf", "dummy", "ldb_di0_gate", };
 static const char *mx53_ldb_di0_sel[] = { "pll3_sw", "pll4_sw", };
 static const char *mx51_ipu_di1_sel[] = { "di_pred", "osc", "ckih1", "tve_di", "ipp_di1", };
-static const char *mx53_ipu_di1_sel[] = { "di_pred", "osc", "ckih1", "tve_di", "ipp_di1", "ldb_di1", };
+static const char *mx53_ipu_di1_sel[] = { "di_pred", "osc", "ckih1", "tve_di", "ipp_di1", "ldb_di1_gate", };
 static const char *mx53_ldb_di1_sel[] = { "pll3_sw", "pll4_sw", };
 static const char *mx51_tve_ext_sel[] = { "osc", "ckih1", };
 static const char *mx53_tve_ext_sel[] = { "pll4_sw", "ckih1", };
-- 
1.7.10.4
