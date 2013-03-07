From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Mar 2013 23:07:11 +0100
Subject: [PATCHv2] ARM: sunxi: dt: Add support for the PineRiver Mini X-plus
Message-ID: <1362694031-1437-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This board comes with an Allwinner A10, two external USB ports, a SD
Card reader, 1GB of RAM, the usual video connectors and an onboard wifi
chip.

Of course, the support is quite minimal for now...

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts |   32 ++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun4i-a10-mini-xplus.dts

diff --git a/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
new file mode 100644
index 0000000..4a7c35d
--- /dev/null
+++ b/arch/arm/boot/dts/sun4i-a10-mini-xplus.dts
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2012 Maxime Ripard
+ *
+ * Maxime Ripard <maxime.ripard@free-electrons.com>
+ *
+ * The code contained herein is licensed under the GNU General Public
+ * License. You may obtain a copy of the GNU General Public License
+ * Version 2 or later at the following locations:
+ *
+ * http://www.opensource.org/licenses/gpl-license.html
+ * http://www.gnu.org/copyleft/gpl.html
+ */
+
+/dts-v1/;
+/include/ "sun4i-a10.dtsi"
+
+/ {
+	model = "PineRiver Mini X-Plus";
+	compatible = "pineriver,mini-xplus", "allwinner,sun4i-a10";
+
+	chosen {
+		bootargs = "earlyprintk console=ttyS0,115200";
+	};
+
+	soc {
+		uart0: uart at 01c28000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart0_pins_a>;
+			status = "okay";
+		};
+	};
+};
-- 
1.7.10.4
