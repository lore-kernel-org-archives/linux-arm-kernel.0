From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 19 May 2017 15:06:11 +0800
Subject: [PATCH v4 5/6] ARM: sun8i: a83t: Set clock accuracy for 24MHz
 oscillator
In-Reply-To: <20170519070612.32159-1-wens@csie.org>
References: <20170519070612.32159-1-wens@csie.org>
Message-ID: <20170519070612.32159-6-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The datasheets for Allwinner SoCs set strict requirements on the
stability of the external crystal oscillators. Add the accuracy
for the main 24MHz oscillator to the device tree.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index c9a5d07b2ada..e12dd7170b8f 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -126,6 +126,7 @@
 			#clock-cells = <0>;
 			compatible = "fixed-clock";
 			clock-frequency = <24000000>;
+			clock-accuracy = <50000>;
 			clock-output-names = "osc24M";
 		};
 
-- 
2.11.0
