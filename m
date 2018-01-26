From: embed3d@gmail.com (Philipp Rossak)
Date: Fri, 26 Jan 2018 16:19:38 +0100
Subject: [PATCH 13/16] arm: dts: sun8i: h3: add thermal zone to H3
In-Reply-To: <20180126151941.12183-1-embed3d@gmail.com>
References: <20180126151941.12183-1-embed3d@gmail.com>
Message-ID: <20180126151941.12183-14-embed3d@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the thermal zones to the H3. We have only one sensor and
that is placed in the cpu.

Signed-off-by: Philipp Rossak <embed3d@gmail.com>
---
 arch/arm/boot/dts/sun8i-h3.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index fbb007e5798e..3f83f6a27c74 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -72,6 +72,15 @@
 		};
 	};
 
+	thermal-zones {
+		cpu-thermal {
+			/* milliseconds */
+			polling-delay-passive = <250>;
+			polling-delay = <1000>;
+			thermal-sensors = <&ths 0>;
+		};
+	};
+
 	timer {
 		compatible = "arm,armv7-timer";
 		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
-- 
2.11.0
