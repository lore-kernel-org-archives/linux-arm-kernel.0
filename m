From: stillcompiling@gmail.com (Joshua Clayton)
Date: Thu, 11 Aug 2016 09:40:30 -0700
Subject: [PATCH 1/3] ARM: dts: imx6qdl: Enable usb node children with <reg>
In-Reply-To: <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
References: <20160810030254.GD1879@shlinux2>
 <1470933632-22133-1-git-send-email-stillcompiling@gmail.com>
Message-ID: <1470933632-22133-2-git-send-email-stillcompiling@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Give usb nodes #address and #size attributes, so that a child node
representing a permanently connected device such as an onboard hub may
be addressed with a <reg> attribute

Signed-off-by: Joshua Clayton <stillcompiling@gmail.com>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index ed613eb..9b1ec83 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -934,6 +934,8 @@
 
 			usbh1: usb at 02184200 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184200 0x200>;
 				interrupts = <0 40 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -948,6 +950,8 @@
 
 			usbh2: usb at 02184400 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184400 0x200>;
 				interrupts = <0 41 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
@@ -961,6 +965,8 @@
 
 			usbh3: usb at 02184600 {
 				compatible = "fsl,imx6q-usb", "fsl,imx27-usb";
+				#address-cells = <1>;
+				#size-cells = <0>;
 				reg = <0x02184600 0x200>;
 				interrupts = <0 42 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clks IMX6QDL_CLK_USBOH3>;
-- 
2.7.4
