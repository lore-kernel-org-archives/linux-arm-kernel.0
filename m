From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 14 Feb 2013 21:54:01 +0200
Subject: [PATCH 2/2] ARM: tegra114: convert device tree files to use CLK
 defines
In-Reply-To: <1360871650-25771-1-git-send-email-hdoyu@nvidia.com>
References: <1360871650-25771-1-git-send-email-hdoyu@nvidia.com>
Message-ID: <1360871650-25771-2-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Replace magic number in tegra_car:

-               clocks = <&tegra_car 28>;
+               clocks = <&tegra_car CLK_HOST1X>;

Signed-off-by: Hiroshi Doyu <hdoyu@nvidia.com>
---
 .../bindings/clock/nvidia,tegra114-car.txt         |    2 +-
 arch/arm/boot/dts/tegra114.dtsip                   |   13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt b/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
index 25e088d..be95f92 100644
--- a/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
+++ b/Documentation/devicetree/bindings/clock/nvidia,tegra114-car.txt
@@ -283,7 +283,7 @@ Example SoC include file:
 	};
 
 	usb at c5004000 {
-		clocks = <&tegra_car 58>; /* usb2 */
+		clocks = <&tegra_car CLK_USB2>; /* usb2 */
 	};
 };
 
diff --git a/arch/arm/boot/dts/tegra114.dtsip b/arch/arm/boot/dts/tegra114.dtsip
index df01b15..2afa559 100644
--- a/arch/arm/boot/dts/tegra114.dtsip
+++ b/arch/arm/boot/dts/tegra114.dtsip
@@ -1,6 +1,7 @@
 #include "skeleton.dtsi"
 #include "tegra-gpio.h"
 #include "arm-gic.h"
+#include "tegra114-car.h"
 
 / {
 	compatible = "nvidia,tegra114";
@@ -27,7 +28,7 @@
 			     <GIC_SPI 42 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 5>;
+		clocks = <&tegra_car CLK_TIMER>;
 	};
 
 	tegra_car: clock {
@@ -70,7 +71,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
-		clocks = <&tegra_car 6>;
+		clocks = <&tegra_car CLK_UARTA>;
 	};
 
 	serial at 70006040 {
@@ -79,7 +80,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
-		clocks = <&tegra_car 192>;
+		clocks = <&tegra_car CLK_UARTB>;
 	};
 
 	serial at 70006200 {
@@ -88,7 +89,7 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
-		clocks = <&tegra_car 55>;
+		clocks = <&tegra_car CLK_UARTC>;
 	};
 
 	serial at 70006300 {
@@ -97,14 +98,14 @@
 		reg-shift = <2>;
 		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
 		status = "disabled";
-		clocks = <&tegra_car 65>;
+		clocks = <&tegra_car CLK_UARTD>;
 	};
 
 	rtc {
 		compatible = "nvidia,tegra114-rtc", "nvidia,tegra20-rtc";
 		reg = <0x7000e000 0x100>;
 		interrupts = <GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&tegra_car 4>;
+		clocks = <&tegra_car CLK_RTC>;
 	};
 
 	pmc {
-- 
1.7.9.5
