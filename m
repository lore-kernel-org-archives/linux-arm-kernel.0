From: balbi@ti.com (Felipe Balbi)
Date: Mon, 23 Jun 2014 13:20:58 -0500
Subject: [PATCH v3 1/2] arm: dts: am4372: let boards access all nodes through
 phandles
In-Reply-To: <1403547659-24558-1-git-send-email-balbi@ti.com>
References: <1403547659-24558-1-git-send-email-balbi@ti.com>
Message-ID: <1403547659-24558-2-git-send-email-balbi@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

by providing phandles to rtc, wdt, cpu and dispc nodes,
boards can access them to add board-specific data.

Signed-off-by: Felipe Balbi <balbi@ti.com>
---

Changes since v1:
	- added phandles to cpu and dispc

 arch/arm/boot/dts/am4372.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/am4372.dtsi b/arch/arm/boot/dts/am4372.dtsi
index 49fa596..8d3c163 100644
--- a/arch/arm/boot/dts/am4372.dtsi
+++ b/arch/arm/boot/dts/am4372.dtsi
@@ -30,7 +30,7 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu at 0 {
+		cpu: cpu at 0 {
 			compatible = "arm,cortex-a9";
 			device_type = "cpu";
 			reg = <0>;
@@ -270,7 +270,7 @@
 			ti,hwmods = "counter_32k";
 		};
 
-		rtc at 44e3e000 {
+		rtc: rtc at 44e3e000 {
 			compatible = "ti,am4372-rtc","ti,da830-rtc";
 			reg = <0x44e3e000 0x1000>;
 			interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH
@@ -279,7 +279,7 @@
 			status = "disabled";
 		};
 
-		wdt at 44e35000 {
+		wdt: wdt@44e35000 {
 			compatible = "ti,am4372-wdt","ti,omap3-wdt";
 			reg = <0x44e35000 0x1000>;
 			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
@@ -871,7 +871,7 @@
 			#size-cells = <1>;
 			ranges;
 
-			dispc at 4832a400 {
+			dispc: dispc at 4832a400 {
 				compatible = "ti,omap3-dispc";
 				reg = <0x4832a400 0x400>;
 				interrupts = <GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.0.0.390.gcb682f8
