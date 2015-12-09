From: b51503@freescale.com (Bai Ping)
Date: Wed, 9 Dec 2015 16:15:55 +0800
Subject: [PATCH] ARM: dts: imx: Fix the assigned-clock mismatch issue on
 imx6q/dl
Message-ID: <1449648955-30835-1-git-send-email-b51503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The 'assigned-clock-parents' and 'assigned-clock-rates' list
should corresponding to the 'assigned-clocks' property clock list.

Signed-off-by: Bai Ping <b51503@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index 5a26173..dd92279 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -113,14 +113,14 @@
 &clks {
 	assigned-clocks = <&clks IMX6QDL_PLL4_BYPASS_SRC>,
 			  <&clks IMX6QDL_PLL4_BYPASS>,
-			  <&clks IMX6QDL_CLK_PLL4_POST_DIV>,
 			  <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
-			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
+			  <&clks IMX6QDL_CLK_PLL4_POST_DIV>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_LVDS2_IN>,
 				 <&clks IMX6QDL_PLL4_BYPASS_SRC>,
 				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
 				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
-	assigned-clock-rates = <0>, <0>, <24576000>;
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <24576000>;
 };
 
 &ecspi1 {
-- 
1.9.1
