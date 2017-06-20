From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Tue, 20 Jun 2017 12:28:54 +0200
Subject: [PATCH] arm64: dts: Delete unused dummy clocks
Message-ID: <20170620102854.9346-1-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding the clock subsystem to the SOC, the dummy
clocks clk26m and clk32k are not longer needed. Delete them.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 3512c8e6dc65..09d46befa86b 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -102,20 +102,6 @@
 		};
 	};
 
-	clk26m: oscillator at 0 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <26000000>;
-		clock-output-names = "clk26m";
-	};
-
-	clk32k: oscillator at 1 {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <32000>;
-		clock-output-names = "clk32k";
-	};
-
 	timer {
 		compatible = "arm,armv8-timer";
 		interrupt-parent = <&gic>;
-- 
2.12.3
