From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 23 Jun 2015 13:03:37 -0300
Subject: [PATCH] ARM: dts: imx6qdl-sabresd: Allow HDMI and LVDS to work
 simultaneously
Message-ID: <1435075417-28708-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently it is not possible to have HDMI and LVDS working simultaneously,
because both ports try to use PLL5.

Move the LVDS to PLL3_USB_OTG, so that HDMI and LVDS can be driven from
independent sources.

With this change the LDB pixel clock goes to 68.57 MHz, which is still
within the valid range for the HSD100PXN1 LVDS panel.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index a626e6d..dd1bedb 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -494,6 +494,10 @@
 };
 
 &ldb {
+	assigned-clocks = <&clks IMX6QDL_CLK_LDB_DI0_SEL>,
+			  <&clks IMX6QDL_CLK_LDB_DI1_SEL>;
+	assigned-clock-parents = <&clks IMX6QDL_CLK_PLL3_USB_OTG>,
+				 <&clks IMX6QDL_CLK_PLL3_USB_OTG>;
 	status = "okay";
 
 	lvds-channel at 1 {
-- 
1.9.1
