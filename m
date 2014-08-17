From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 17 Aug 2014 11:52:08 +0800
Subject: [PATCH 02/12] ARM: dts: sun8i: Add R_PIO controller node to the dtsi
In-Reply-To: <1408247538-16950-1-git-send-email-wens@csie.org>
References: <1408247538-16950-1-git-send-email-wens@csie.org>
Message-ID: <1408247538-16950-3-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that we have a driver for the R_PIO controller,
add the corresponding device node to the dtsi.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a23.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a23.dtsi b/arch/arm/boot/dts/sun8i-a23.dtsi
index 41823b1..a40e632 100644
--- a/arch/arm/boot/dts/sun8i-a23.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23.dtsi
@@ -353,5 +353,18 @@
 			resets = <&apb0_rst 4>;
 			status = "disabled";
 		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun8i-a23-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <0 45 4>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_rst 0>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
 	};
 };
-- 
2.1.0
