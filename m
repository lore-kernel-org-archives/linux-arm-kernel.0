From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 28 Nov 2018 17:30:11 +0800
Subject: [PATCH 13/15] ARM: dts: sun8i: r40: Add clock accuracy for external
 oscillators
In-Reply-To: <20181128093013.24442-1-wens@csie.org>
References: <20181128093013.24442-1-wens@csie.org>
Message-ID: <20181128093013.24442-15-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R40 datasheet specifies a tolerance range for the external
oscillators used. Add them to the device tree as the clock accuracy.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-r40.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 6f4c9ca5a3ee..a8917f8b1c80 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -61,6 +61,7 @@
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
+			clock-accuracy = <50000>;
 			clock-output-names = "osc24M";
 		};
 
@@ -68,6 +69,7 @@
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <32768>;
+			clock-accuracy = <20000>;
 			clock-output-names = "osc32k";
 		};
 	};
-- 
2.20.0.rc1
