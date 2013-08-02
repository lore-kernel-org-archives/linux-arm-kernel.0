From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri,  2 Aug 2013 12:02:50 +0200
Subject: [PATCHv2 6/9] ARM: sun7i: Add the PIO controller node to the DTSI
In-Reply-To: <1375437773-3211-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375437773-3211-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375437773-3211-7-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The PIO controller is responsible for the GPIO/muxing/external
interrupts handling. Now that we have support for the A20 pin set in the
pinctrl driver, we can start using it in the DTSI.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index 373ad58..a6d8526 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -61,6 +61,18 @@
 		#size-cells = <1>;
 		ranges;
 
+		pio: pinctrl at 01c20800 {
+			compatible = "allwinner,sun7i-a20-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <0 28 1>;
+			clocks = <&osc24M>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
+
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0x90>;
-- 
1.8.3.4
