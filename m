From: icenowy@aosc.xyz (Icenowy Zheng)
Date: Tue, 28 Jun 2016 18:13:25 +0800
Subject: [RFC PATCH 5/5] ARM: sun8i: enable ths node for A23/33
In-Reply-To: <20160628101325.2522-1-icenowy@aosc.xyz>
References: <20160628101325.2522-1-icenowy@aosc.xyz>
Message-ID: <20160628101325.2522-5-icenowy@aosc.xyz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Icenowy Zheng <icenowy@aosc.xyz>
---
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 16 ++++++++++++++++
 arch/arm/boot/dts/sun8i-a23.dtsi     |  4 ++++
 arch/arm/boot/dts/sun8i-a33.dtsi     |  4 ++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index a340cea..04df1ca 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -66,6 +66,14 @@
 		};
 	};
 
+	thermal-zones {
+		cpu_thermal: cpu_thermal {
+			polling-delay-passive = <330>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths 0>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
@@ -473,6 +481,14 @@
 			status = "disabled";
 		};
 
+		ths: ths at 01c25000 {
+			#thermal-sensor-cells = <0>;
+			/* compatible is in per-cpu dtsi file */
+			reg = <0x01c25000 0x44>;
+			clocks = <&pll2 0>;
+			clock-names = "pll2";
+		};
+
 		uart0: serial at 01c28000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x01c28000 0x400>;
diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 92e6616..41f0d9e 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -124,3 +124,7 @@
 		     <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
 		     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
 };
+
+&ths {
+	compatible = "allwinner,sun8i-a23-ths";
+};
diff --git a/arch/arm/boot/dts/sun8i-a33.dtsi b/arch/arm/boot/dts/sun8i-a33.dtsi
index 001d840..2273124 100644
--- a/arch/arm/boot/dts/sun8i-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a33.dtsi
@@ -173,3 +173,7 @@
 	};
 
 };
+
+&ths {
+	compatible = "allwinner,sun8i-a33-ths";
+};
-- 
2.9.0
