From: romain.perier@collabora.com (Romain Perier)
Date: Fri, 30 Jun 2017 15:43:37 +0200
Subject: [PATCH] ARM: dts: imx: Correct B850v3 clock assignment
Message-ID: <20170630134337.18245-1-romain.perier@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Martyn Welch <martyn.welch@collabora.co.uk>

The IPU that drives HDMI must have its pre_sel set to pll2_pfd_396m
to avoid stepping on the LVDS output's toes, as the PLL can't be clocked
to the pixel clock and to the LVDS serial clock (3.5*pixel clock) at the
same time.

As we are using ipu1_di0 and ipu2_di0, ensure both are switched to
to pll2_pfd2_396m to avoid issues. The LDB driver will switch the
required IPU to ldb_di1 when it uses it to drive LVDS.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Signed-off-by: Romain Perier <romain.perier@collabora.com>
---
 arch/arm/boot/dts/imx6q-b850v3.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/imx6q-b850v3.dts b/arch/arm/boot/dts/imx6q-b850v3.dts
index 2c1e98e..46bdc67 100644
--- a/arch/arm/boot/dts/imx6q-b850v3.dts
+++ b/arch/arm/boot/dts/imx6q-b850v3.dts
@@ -57,7 +57,7 @@
 	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
 			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>,
 			  <&clks IMX6QDL_CLK_IPU1_DI0_PRE_SEL>,
-			  <&clks IMX6QDL_CLK_IPU1_DI1_PRE_SEL>;
+			  <&clks IMX6QDL_CLK_IPU2_DI0_PRE_SEL>;
 	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
 				 <&clks IMX6QDL_CLK_PLL5_VIDEO_DIV>,
 				 <&clks IMX6QDL_CLK_PLL2_PFD2_396M>,
-- 
1.8.3.1
