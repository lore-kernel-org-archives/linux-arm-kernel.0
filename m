From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:07 +0800
Subject: [PATCH 01/12] ARM: dts: sun8i: Add PIO controller node to the sun8i
 dtsi
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-2-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for the sun8i PIO controller,
add the corresponding device node to the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 54ac0787..41823b1 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -187,6 +187,20 @@
 		#size-cells = <1>;
 		ranges;
 
+		pio: pinctrl at 01c20800 {
+			compatible = "allwinner,sun8i-a23-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <0 11 4>,
+				     <0 15 4>,
+				     <0 17 4>;
+			clocks = <&apb1_gates 5>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
+
 		ahb1_rst: reset at 01c202c0 {
 			#reset-cells = <1>;
 			compatible = "allwinner,sun6i-a31-clock-reset";
-- 
2.1.0
