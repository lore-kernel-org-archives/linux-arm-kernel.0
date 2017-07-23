From: icenowy@aosc.io (Icenowy Zheng)
Date: Sun, 23 Jul 2017 22:13:54 +0800
Subject: [PATCH v3 5/5] ARM: sun8i: h3: add partial CPU thermal zone
In-Reply-To: <20170723141354.42646-1-icenowy@aosc.io>
References: <20170723141354.42646-1-icenowy@aosc.io>
Message-ID: <20170723141354.42646-6-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Because of the restriction of the OF thermal framework, the thermal
sensor will fail to probe if the thermal zone doesn't exist.

Add a partial thermal zone which claims the H3 THS as the thermal sensor.

The cooling device (CPU DVFS) is still not added as it's not ready, and
the trip points are also not added yet.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index efe3a8e4f2af..551efecaab5d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -125,6 +125,15 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.13.0
