From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 29 Dec 2017 11:55:05 +0100
Subject: [PATCH v2 4/5] arm: dts: sun8i: a83t: Add CCI-400 node
In-Reply-To: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
References: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
Message-ID: <20171229105506.24851-5-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add CCI-400 node and control-port on CPUs needed by MCPM (ie SMP).

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 41 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a6c69b75fe6c..aa27ffb7db81 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -62,48 +62,56 @@
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu at 1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu at 2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu at 3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			cci-control-port = <&cci_control0>;
 		};
 
 		cpu at 100 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x100>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu at 101 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x101>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu at 102 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x102>;
+			cci-control-port = <&cci_control1>;
 		};
 
 		cpu at 103 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0x103>;
+			cci-control-port = <&cci_control1>;
 		};
 	};
 
@@ -167,6 +175,39 @@
 			reg = <0x01700000 0x400>;
 		};
 
+		cci at 1790000 {
+			compatible = "arm,cci-400";
+			#address-cells = <1>;
+			#size-cells = <1>;
+			reg = <0x01790000 0x10000>;
+			ranges = <0x0 0x01790000 0x10000>;
+
+			cci_control0: slave-if at 4000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x4000 0x1000>;
+			};
+
+			cci_control1: slave-if at 5000 {
+				compatible = "arm,cci-400-ctrl-if";
+				interface-type = "ace";
+				reg = <0x5000 0x1000>;
+			};
+
+			pmu at 9000 {
+				compatible = "arm,cci-400-pmu,r1";
+				reg = <0x9000 0x5000>;
+				interrupts = <GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 133 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 134 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 135 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>,
+				<GIC_SPI 154 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun8i-a83t-system-controller",
 				"syscon";
-- 
2.11.0
