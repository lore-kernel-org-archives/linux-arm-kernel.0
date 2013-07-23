From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 24 Jul 2013 00:25:10 +0200
Subject: [PATCH 08/10] ARM: sunxi: dt: Add PIO controller to A31 DTSI
In-Reply-To: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1374618312-19001-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1374618312-19001-9-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 has a different set of pins than the one found on the A10 and
A13, so we will need a different compatible string, even though the IP
is the same.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index c6c19a9..0443628 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -67,6 +67,18 @@
 		reg = <0x01c20000 0x300000>;
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
1.8.3.2
