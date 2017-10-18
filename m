From: marco.franchi@nxp.com (Marco Franchi)
Date: Wed, 18 Oct 2017 17:29:48 -0200
Subject: [PATCH v2 3/6] ARM: dts: imx53: Fix 'usbphy@x' node with unit name
 and no reg property
In-Reply-To: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
References: <1508354991-18016-1-git-send-email-marco.franchi@nxp.com>
Message-ID: <1508354991-18016-3-git-send-email-marco.franchi@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following build warnings are seen with W=1:

Warning (unit_address_vs_reg): Node /soc/aips at 50000000/usbphy at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /soc/aips at 50000000/usbphy at 1 has a unit name, but no reg property

Fix these warnings by changing '@' to '-'.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Changes since v1:
-none
 arch/arm/boot/dts/imx53.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 8bf0d89..c937949 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -299,14 +299,14 @@
 				reg = <0x53f00000 0x60>;
 			};
 
-			usbphy0: usbphy at 0 {
+			usbphy0: usbphy-0 {
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX5_CLK_USB_PHY1_GATE>;
 				clock-names = "main_clk";
 				status = "okay";
 			};
 
-			usbphy1: usbphy at 1 {
+			usbphy1: usbphy-1 {
 				compatible = "usb-nop-xceiv";
 				clocks = <&clks IMX5_CLK_USB_PHY2_GATE>;
 				clock-names = "main_clk";
-- 
2.7.4
