From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Wed, 11 Jun 2014 10:58:12 +0100
Subject: [PATCH 1/2] ARM: dts: hummingboard: add support for BT/wifi where
 fitted
Message-ID: <E1WufIK-0007yl-2k@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some microsom modules have BT/Wifi fitted for the Hummingboard.  Enable
support for this additional hardware; where it isn't present, the SDIO
BT/Wifi will not be detected, and no harm will come from having these
additional devices enabled.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/boot/dts/imx6dl-hummingboard.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index 5373a5f2782b..cb9691bac161 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -172,6 +172,10 @@
 	status = "okay";
 };
 
+&uart4 {
+	status = "okay";
+};
+
 &usbh1 {
 	vbus-supply = <&reg_usbh1_vbus>;
 	status = "okay";
@@ -182,6 +186,10 @@
 	status = "okay";
 };
 
+&usdhc1 {
+	status = "okay";
+};
+
 &usdhc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <
-- 
1.8.3.1
