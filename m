From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:46 +0900
Subject: [PATCH v2 07/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos542x
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-7-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in all Exynos542x/5800 boards:

Warning (unit_address_vs_reg): Node /video-phy at 10040728 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /video-phy at 10040714 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /usb at 12000000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /usb at 12000000/dwc3 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /usb at 12400000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /usb at 12400000/dwc3 has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's tag.
2. Use dash instead of underscore for usb3 nodes.
---
 arch/arm/boot/dts/exynos5420.dtsi | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 7b99cb58d82d..385491aa539a 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -551,13 +551,13 @@
 		clock-names = "timers";
 	};
 
-	dp_phy: video-phy at 10040728 {
+	dp_phy: dp-video-phy {
 		compatible = "samsung,exynos5420-dp-video-phy";
 		samsung,pmu-syscon = <&pmu_system_controller>;
 		#phy-cells = <0>;
 	};
 
-	mipi_phy: video-phy at 10040714 {
+	mipi_phy: mipi-video-phy {
 		compatible = "samsung,s5pv210-mipi-video-phy";
 		syscon = <&pmu_system_controller>;
 		#phy-cells = <1>;
@@ -913,7 +913,7 @@
 		clock-names = "secss";
 	};
 
-	usbdrd3_0: usb at 12000000 {
+	usbdrd3_0: usb3-0 {
 		compatible = "samsung,exynos5250-dwusb3";
 		clocks = <&clock CLK_USBD300>;
 		clock-names = "usbdrd30";
@@ -921,7 +921,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		usbdrd_dwc3_0: dwc3 {
+		usbdrd_dwc3_0: dwc3 at 12000000 {
 			compatible = "snps,dwc3";
 			reg = <0x12000000 0x10000>;
 			interrupts = <0 72 0>;
@@ -939,7 +939,7 @@
 		#phy-cells = <1>;
 	};
 
-	usbdrd3_1: usb at 12400000 {
+	usbdrd3_1: usb3-1 {
 		compatible = "samsung,exynos5250-dwusb3";
 		clocks = <&clock CLK_USBD301>;
 		clock-names = "usbdrd30";
@@ -947,7 +947,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		usbdrd_dwc3_1: dwc3 {
+		usbdrd_dwc3_1: dwc3 at 12400000 {
 			compatible = "snps,dwc3";
 			reg = <0x12400000 0x10000>;
 			interrupts = <0 73 0>;
-- 
2.5.0
