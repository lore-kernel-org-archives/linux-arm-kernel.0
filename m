From: k@japko.eu (Krzysztof Adamski)
Date: Tue,  2 Feb 2016 22:21:52 +0100
Subject: [PATCH v2 4/5] ARM: dts: sun8i-h3: Add R_PIO controller node to the
 dtsi
In-Reply-To: <1454448113-18810-1-git-send-email-k@japko.eu>
References: <1454448113-18810-1-git-send-email-k@japko.eu>
Message-ID: <1454448113-18810-5-git-send-email-k@japko.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the corresponding device node for R_PIO on H3 to the dtsi. Support
for the controller was added in earlier commit.

Signed-off-by: Krzysztof Adamski <k@japko.eu>
---
 .../devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt  |  1 +
 arch/arm/boot/dts/sun8i-h3.dtsi                              | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
index 9213b27..3e56b16 100644
--- a/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/allwinner,sunxi-pinctrl.txt
@@ -21,6 +21,7 @@ Required properties:
   "allwinner,sun9i-a80-r-pinctrl"
   "allwinner,sun8i-a83t-pinctrl"
   "allwinner,sun8i-h3-pinctrl"
+  "allwinner,sun8i-h3-r-pinctrl"
 
 - reg: Should contain the register physical address and length for the
   pin controller.
diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
index ce35e93..1593e2d 100644
--- a/arch/arm/boot/dts/sun8i-h3.dtsi
+++ b/arch/arm/boot/dts/sun8i-h3.dtsi
@@ -525,5 +525,17 @@
 			compatible = "allwinner,sun6i-a31-clock-reset";
 			#reset-cells = <1>;
 		};
+
+		r_pio: pinctrl at 01f02c00 {
+			compatible = "allwinner,sun8i-h3-r-pinctrl";
+			reg = <0x01f02c00 0x400>;
+			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&apb0_gates 0>;
+			resets = <&apb0_reset 0>;
+			gpio-controller;
+			#gpio-cells = <3>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
 	};
 };
-- 
2.1.4
