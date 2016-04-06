From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 06 Apr 2016 11:00:45 +0900
Subject: [PATCH v2 06/11] ARM: dts: exynos: Fix DTC unit name warnings in
 Exynos5250
In-Reply-To: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
References: <1459908050-16430-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1459908050-16430-6-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following DTC warnings in all Exynos5250 boards:

Warning (unit_address_vs_reg): Node /dp-controller at 145B0000/display-timings/timing at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /usb at 12000000 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /usb at 12000000/dwc3 has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /hdmi has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /mixer has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /video-phy at 10040720 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /fixed-regulator at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /fixed-regulator at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /fixed-regulator at 2 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 12C70000/trackpad has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 20/ports/port at 0 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c at 12CD0000/lvds-bridge at 20/ports/port at 1 has a unit name, but no reg property
Warning (unit_address_vs_reg): Node /i2c-arbitrator/i2c at 0/embedded-controller has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /i2c-arbitrator/i2c at 0/power-regulator has a reg or ranges property, but no unit name
Warning (unit_address_vs_reg): Node /i2c at 12CA0000/embedded-controller has a reg or ranges property, but no unit name

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's tag.
---
 arch/arm/boot/dts/exynos5250-arndale.dts      |  2 +-
 arch/arm/boot/dts/exynos5250-smdk5250.dts     |  8 ++++----
 arch/arm/boot/dts/exynos5250-snow-common.dtsi | 12 ++++++------
 arch/arm/boot/dts/exynos5250-spring.dts       |  2 +-
 arch/arm/boot/dts/exynos5250.dtsi             | 10 +++++-----
 5 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
index 8b2acc74aa76..1e25152dc0f6 100644
--- a/arch/arm/boot/dts/exynos5250-arndale.dts
+++ b/arch/arm/boot/dts/exynos5250-arndale.dts
@@ -133,7 +133,7 @@
 	display-timings {
 		native-mode = <&timing0>;
 
-		timing0: timing at 0 {
+		timing0: timing {
 			/* 2560x1600 DP panel */
 			clock-frequency = <50000>;
 			hactive = <2560>;
diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
index 0f5dcd418af8..0e2eb3f6b590 100644
--- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
+++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
@@ -29,7 +29,7 @@
 		bootargs = "root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC2,115200 init=/linuxrc";
 	};
 
-	vdd: fixed-regulator at 0 {
+	vdd: fixed-regulator-vdd {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd-supply";
 		regulator-min-microvolt = <1800000>;
@@ -37,7 +37,7 @@
 		regulator-always-on;
 	};
 
-	dbvdd: fixed-regulator at 1 {
+	dbvdd: fixed-regulator-dbvdd {
 		compatible = "regulator-fixed";
 		regulator-name = "dbvdd-supply";
 		regulator-min-microvolt = <3300000>;
@@ -45,7 +45,7 @@
 		regulator-always-on;
 	};
 
-	spkvdd: fixed-regulator at 2 {
+	spkvdd: fixed-regulator-spkvdd {
 		compatible = "regulator-fixed";
 		regulator-name = "spkvdd-supply";
 		regulator-min-microvolt = <5000000>;
@@ -93,7 +93,7 @@
 	display-timings {
 		native-mode = <&timing0>;
 
-		timing0: timing at 0 {
+		timing0: timing {
 			/* 1280x800 */
 			clock-frequency = <50000>;
 			hactive = <1280>;
diff --git a/arch/arm/boot/dts/exynos5250-snow-common.dtsi b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
index 95210ef6a6b5..c9889b1f530a 100644
--- a/arch/arm/boot/dts/exynos5250-snow-common.dtsi
+++ b/arch/arm/boot/dts/exynos5250-snow-common.dtsi
@@ -84,7 +84,7 @@
 				sbs,poll-retry-count = <1>;
 			};
 
-			cros_ec: embedded-controller {
+			cros_ec: embedded-controller at 1e {
 				compatible = "google,cros-ec-i2c";
 				reg = <0x1e>;
 				interrupts = <6 IRQ_TYPE_NONE>;
@@ -94,7 +94,7 @@
 				wakeup-source;
 			};
 
-			power-regulator {
+			power-regulator at 48 {
 				compatible = "ti,tps65090";
 				reg = <0x48>;
 
@@ -244,7 +244,7 @@
 	samsung,hpd-gpio = <&gpx0 7 GPIO_ACTIVE_HIGH>;
 
 	ports {
-		port at 0 {
+		port0 {
 			dp_out: endpoint {
 				remote-endpoint = <&bridge_in>;
 			};
@@ -428,7 +428,7 @@
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <378000>;
 
-	trackpad {
+	trackpad at 67 {
 		reg = <0x67>;
 		compatible = "cypress,cyapa";
 		interrupts = <2 IRQ_TYPE_NONE>;
@@ -487,13 +487,13 @@
 		edid-emulation = <5>;
 
 		ports {
-			port at 0 {
+			port0 {
 				bridge_out: endpoint {
 					remote-endpoint = <&panel_in>;
 				};
 			};
 
-			port at 1 {
+			port1 {
 				bridge_in: endpoint {
 					remote-endpoint = <&dp_out>;
 				};
diff --git a/arch/arm/boot/dts/exynos5250-spring.dts b/arch/arm/boot/dts/exynos5250-spring.dts
index 0f500cb1eb2d..273d66282ebc 100644
--- a/arch/arm/boot/dts/exynos5250-spring.dts
+++ b/arch/arm/boot/dts/exynos5250-spring.dts
@@ -383,7 +383,7 @@
 	samsung,i2c-sda-delay = <100>;
 	samsung,i2c-max-bus-freq = <66000>;
 
-	cros_ec: embedded-controller {
+	cros_ec: embedded-controller at 1e {
 		compatible = "google,cros-ec-i2c";
 		reg = <0x1e>;
 		interrupts = <6 IRQ_TYPE_NONE>;
diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
index e653ae04015a..c7158b2fb213 100644
--- a/arch/arm/boot/dts/exynos5250.dtsi
+++ b/arch/arm/boot/dts/exynos5250.dtsi
@@ -596,7 +596,7 @@
 		pinctrl-0 = <&i2s2_bus>;
 	};
 
-	usb at 12000000 {
+	usb_dwc3 {
 		compatible = "samsung,exynos5250-dwusb3";
 		clocks = <&clock CLK_USB3>;
 		clock-names = "usbdrd30";
@@ -604,7 +604,7 @@
 		#size-cells = <1>;
 		ranges;
 
-		usbdrd_dwc3: dwc3 {
+		usbdrd_dwc3: dwc3 at 12000000 {
 			compatible = "synopsys,dwc3";
 			reg = <0x12000000 0x10000>;
 			interrupts = <0 72 0>;
@@ -763,7 +763,7 @@
 		iommu = <&sysmmu_gsc3>;
 	};
 
-	hdmi: hdmi {
+	hdmi: hdmi at 14530000 {
 		compatible = "samsung,exynos4212-hdmi";
 		reg = <0x14530000 0x70000>;
 		power-domains = <&pd_disp1>;
@@ -776,7 +776,7 @@
 		samsung,syscon-phandle = <&pmu_system_controller>;
 	};
 
-	mixer {
+	mixer at 14450000 {
 		compatible = "samsung,exynos5250-mixer";
 		reg = <0x14450000 0x10000>;
 		power-domains = <&pd_disp1>;
@@ -787,7 +787,7 @@
 		iommus = <&sysmmu_tv>;
 	};
 
-	dp_phy: video-phy at 10040720 {
+	dp_phy: video-phy {
 		compatible = "samsung,exynos5250-dp-video-phy";
 		samsung,pmu-syscon = <&pmu_system_controller>;
 		#phy-cells = <0>;
-- 
2.5.0
