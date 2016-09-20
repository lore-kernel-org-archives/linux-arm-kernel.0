From: peter.chen@nxp.com (Peter Chen)
Date: Tue, 20 Sep 2016 11:36:45 +0800
Subject: [PATCH v7 6/8] ARM: dts: imx6qdl: Enable usb node children with <reg>
In-Reply-To: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
References: <1474342607-27512-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1474342607-27512-7-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Joshua Clayton <stillcompiling@gmail.com>

Give usb nodes #address and #size attributes, so that a child node
representing a permanently connected device such as an onboard hub may
be addressed with a <reg> attribute

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index b13b0b2..8fc66e1 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -935,6 +935,8 @@
 
 			usbh1: usb at 02184200 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -949,6 +951,8 @@
 
 			usbh2: usb at 02184400 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -962,6 +966,8 @@
 
 			usbh3: usb at 02184600 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
-- 
2.7.4
