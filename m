From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Wed, 15 Jul 2015 23:22:20 +0200
Subject: [PATCH] ARM: dts: rockchip: add rk3288 arm-pmu irq affinity
Message-ID: <3814250.tDdID2FGKL@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The rk3288 uses spi irqs for the arm-pmu on individual cpu cores, so needs
the affinity to them defined.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/arm/boot/dts/rk3288.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 22e9221..2db91c9 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -78,6 +78,7 @@
 			     <GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
 	};
 
 	cpus {
@@ -110,19 +111,19 @@
 			clock-latency = <40000>;
 			clocks = <&cru ARMCLK>;
 		};
-		cpu at 501 {
+		cpu1: cpu at 501 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x501>;
 			resets = <&cru SRST_CORE1>;
 		};
-		cpu at 502 {
+		cpu2: cpu at 502 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x502>;
 			resets = <&cru SRST_CORE2>;
 		};
-		cpu at 503 {
+		cpu3: cpu at 503 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a12";
 			reg = <0x503>;
-- 
2.1.4
