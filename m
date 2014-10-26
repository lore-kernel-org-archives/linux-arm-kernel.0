From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 26 Oct 2014 16:36:05 +0100
Subject: [PATCH 3/4] ARM: sun9i: Enable the A80 pinctrl driver
In-Reply-To: <1414337766-23690-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1414337766-23690-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1414337766-23690-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 pinctrl driver is just as usual our pinctrl/gpio/external interrupt
controller.

Nothing really out of the extraordinary here...

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index 7bcab5685d0e..9616dc71faf3 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -337,6 +337,22 @@
 			clocks = <&osc24M>;
 		};
 
+		pio: pinctrl at 06000800 {
+			compatible = "allwinner,sun9i-a80-pinctrl";
+			reg = <0x06000800 0x400>;
+			interrupts = <0 11 4>,
+				     <0 15 4>,
+				     <0 16 4>,
+				     <0 17 4>,
+                                     <0 120 4>;
+			clocks = <&apb0_gates 5>;
+			gpio-controller;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
+
 		uart0: serial at 07000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x07000000 0x400>;
-- 
2.1.1
