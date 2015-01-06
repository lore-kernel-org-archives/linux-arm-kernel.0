From: wens@csie.org (Chen-Yu Tsai)
Date: Tue,  6 Jan 2015 10:35:16 +0800
Subject: [PATCH 06/17] ARM: dts: sun7i: Add cpu clock reference and operating
 points to dtsi
In-Reply-To: <1420511727-8242-1-git-send-email-wens@csie.org>
References: <1420511727-8242-1-git-send-email-wens@csie.org>
Message-ID: <1420511727-8242-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The cpu core is clocked from the "cpu" clock. Add a reference to it
in the first cpu node. Also add "cpu0" label to the node.

The operating points were taken from the A20 FEX files in the
sunxi-boards repository. Not all boards have the same settings. The
settings in this patch are the most generic ones.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 01c7133e699c..887b0521bbfb 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -82,10 +82,26 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu at 0 {
+		cpu0: cpu at 0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&cpu>;
+			clock-latency = <244144>; /* 8 32k periods */
+			operating-points = <
+				/* kHz    uV */
+				1008000 1450000
+				960000  1400000
+				912000  1400000
+				864000  1300000
+				720000  1200000
+				528000  1100000
+				312000  1000000
+				144000  900000
+				>;
+			#cooling-cells = <2>;
+			cooling-min-level = <0>;
+			cooling-max-level = <7>;
 		};
 
 		cpu at 1 {
-- 
2.1.4
