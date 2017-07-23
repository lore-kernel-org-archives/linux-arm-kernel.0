From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 23 Jul 2017 22:13:53 +0800
Subject: [PATCH v3 4/5] ARM: sun8i: h3: add support for the thermal sensor in
 H3
In-Reply-To: <20170723141354.42646-1-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
Message-ID: <20170723141354.42646-5-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we have gained the support for the thermal sensor in H3, we can now
add its device nodes to the device tree.

Add them to the H3 device tree.

The H5 thermal sensor has some differences, and will be added furtherly.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
Changes in v3:
- Clock name changes.
- Splited out thermal zone addition.

 arch/arm/boot/dts/sun8i-h3.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index a0cee17fe44b..efe3a8e4f2af 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -108,6 +108,23 @@
 		};
 	};
 
+	iio-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&ths>;
+	};
+
+	soc {
+		ths: thermal-sensor at 1c25000 {
+			compatible = "allwinner,sun8i-h3-ths";
+			reg = <0x01c25000 0x100>;
+			clocks = <&ccu CLK_BUS_THS>, <&ccu CLK_THS>;
+			clock-names = "bus", "mod";
+			resets = <&ccu RST_BUS_THS>;
+			#thermal-sensor-cells = <0>;
+			#io-channel-cells = <0>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.13.0
