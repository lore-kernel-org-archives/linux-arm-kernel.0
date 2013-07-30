From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 30 Jul 2013 22:49:37 +0200
Subject: [PATCHv2 08/10] ARM: sunxi: dt: Add PIO controller to A31 DTSI
In-Reply-To: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1375217379-15126-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1375217379-15126-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a different set of pins than the one found on the A10 and
A13. Now that we have support for the A31 pin set in the pinctrl driver,
we can enable it in the DTSI with its own compatible.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 407e7b4..2d10eb4 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -66,6 +66,18 @@
 		#size-cells = <1>;
 		ranges;
 
+		pio: pinctrl at 01c20800 {
+			compatible = "allwinner,sun6i-a31-pinctrl";
+			reg = <0x01c20800 0x400>;
+			interrupts = <0 11 1>, <0 15 1>, <0 16 1>, <0 17 1>;
+			clocks = <&osc>;
+			gpio-controller;
+			interrupt-controller;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#gpio-cells = <3>;
+		};
+
 		timer at 01c20c00 {
 			compatible = "allwinner,sun4i-timer";
 			reg = <0x01c20c00 0xa0>;
-- 
1.8.3.4
