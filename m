From: baolin.wang@linaro.org (Baolin Wang)
Date: Mon, 23 Jul 2018 14:10:16 +0800
Subject: [PATCH 1/5] arm64: dts: sprd: Add SC27XX breathing light controller
 device
Message-ID: <2531014d066e61063b3d7906e6df55caa028e17c.1531881619.git.baolin.wang@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SC27xx breathing light controller can support 3 outputs:
red LED, green LED and blue LED.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/arm64/boot/dts/sprd/sc2731.dtsi |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/sprd/sc2731.dtsi b/arch/arm64/boot/dts/sprd/sc2731.dtsi
index 98d3b4f..7d53ca6 100644
--- a/arch/arm64/boot/dts/sprd/sc2731.dtsi
+++ b/arch/arm64/boot/dts/sprd/sc2731.dtsi
@@ -17,6 +17,28 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		led-controller at 200 {
+			compatible = "sprd,sc27xx-bltc", "sprd,sc2731-bltc";
+			reg = <0x200>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			led at 0 {
+				label = "red";
+				reg = <0x0>;
+			};
+
+			led at 1 {
+				label = "green";
+				reg = <0x1>;
+			};
+
+			led at 2 {
+				label = "blue";
+				reg = <0x2>;
+			};
+		};
+
 		rtc at 280 {
 			compatible = "sprd,sc27xx-rtc", "sprd,sc2731-rtc";
 			reg = <0x280>;
-- 
1.7.9.5
