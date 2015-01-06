From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jan 2015 10:35:20 +0800
Subject: [PATCH 10/17] ARM: dts: sun5i: Add cpu clock reference and operating
 points to dtsi
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Message-ID: <1420511727-8242-11-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu core is clocked from the "cpu" clock. Add a reference to it
in the first cpu node. Also add "cpu0" label to the node.

The operating points were taken from the A13 FEX files in the
sunxi-boards repository. All FEX files have the same settings.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-a13.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a13.dtsi b/arch/arm/boot/dts/sun5i-a13.dtsi
index 4fe0bd192e29..dd93d227865e 100644
--- a/arch/arm/boot/dts/sun5i-a13.dtsi
+++ b/arch/arm/boot/dts/sun5i-a13.dtsi
@@ -24,10 +24,26 @@
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
-		cpu at 0 {
+
+		cpu0: cpu at 0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a8";
 			reg = <0x0>;
+			clocks = <&cpu>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz    uV */
+				1104000	1500000
+				1008000 1400000
+				912000  1350000
+				864000  1300000
+				624000  1200000
+				576000  1200000
+				432000  1200000
+				>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <6>;
 		};
 	};
 
-- 
2.1.4
