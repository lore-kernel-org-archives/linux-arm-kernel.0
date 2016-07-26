From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 26 Jul 2016 10:01:32 +0200
Subject: [PATCH 1/2] ARM: dts: alpine: add valid clock-frequency values
Message-ID: <20160726080133.31686-1-antoine.tenart@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Update the Alpine clock-frequency values with valid default values. The
bootloader can still update these values if needed, but at least we can
boot if it does not.

Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
---
 arch/arm/boot/dts/alpine.dtsi | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/alpine.dtsi b/arch/arm/boot/dts/alpine.dtsi
index db8752fc480e..feb41cdafaea 100644
--- a/arch/arm/boot/dts/alpine.dtsi
+++ b/arch/arm/boot/dts/alpine.dtsi
@@ -41,28 +41,28 @@
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
 			reg = <0>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <1700000000>;
 		};
 
 		cpu at 1 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
 			reg = <1>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <1700000000>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
 			reg = <2>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <1700000000>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a15";
 			device_type = "cpu";
 			reg = <3>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <1700000000>;
 		};
 	};
 
@@ -81,7 +81,7 @@
 				<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
 				<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <50000000>;
 		};
 
 		/* Interrupt Controller */
@@ -123,7 +123,7 @@
 		uart0:uart at fd883000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd883000 0x0 0x1000>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <375000000>;
 			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
@@ -132,7 +132,7 @@
 		uart1:uart at 0xfd884000 {
 			compatible = "ns16550a";
 			reg = <0x0 0xfd884000 0x0 0x1000>;
-			clock-frequency = <0>; /* Filled by loader */
+			clock-frequency = <375000000>;
 			interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
 			reg-shift = <2>;
 			reg-io-width = <4>;
-- 
2.9.2
