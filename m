From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Thu, 20 Jul 2017 12:22:47 +0200
Subject: [PATCH 4/4] arm64: dts: mediatek: Delete unused dummy clock for MT6797
In-Reply-To: <20170720102247.12342-1-matthias.bgg@gmail.com>
References: <20170720102247.12342-1-matthias.bgg@gmail.com>
Message-ID: <20170720102247.12342-4-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After adding the clock subsystem to the SOC, the dummy
clock clk32k is not longer needed. Delete it.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 arch/arm64/boot/dts/mediatek/mt6797.dtsi | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/arm64/boot/dts/mediatek/mt6797.dtsi b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
index 1cb45219ef05..4beaa71107d7 100644
--- a/arch/arm64/boot/dts/mediatek/mt6797.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt6797.dtsi
@@ -108,13 +108,6 @@
 		clock-output-names = "clk26m";
 	};
 
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
