From: icenowy@aosc.io (Icenowy Zheng)
Date: Thu, 14 Sep 2017 22:52:51 +0800
Subject: [PATCH v4 6/6] ARM: sun8i: h3: add partial CPU thermal zone
In-Reply-To: <20170914145251.21784-1-icenowy@aosc.io>
References: <20170914145251.21784-1-icenowy@aosc.io>
Message-ID: <20170914145251.21784-7-icenowy@aosc.io>
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
index 3220da3ad790..687c6457d214 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -89,6 +89,15 @@
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
2.13.5
