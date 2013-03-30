From: chf.fritz@googlemail.com (Christoph Fritz)
Date: Sat, 30 Mar 2013 09:21:28 +0100
Subject: [RFC][BUG] arm/dts: OMAP3: set #interrupt-cells to two
Message-ID: <1364631689.3767.7.camel@mars>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch sets gpio #interrupt-cells from a falsely acquired '1' to '2'
referring to Documentation/devicetree/bindings/gpio/gpio-omap.txt:

      The first cell is the GPIO number.
      The second cell is used to specify flags:
        bits[3:0] trigger type and level flags:
          1 = low-to-high edge triggered.
          2 = high-to-low edge triggered.
          4 = active high level-sensitive.
          8 = active low level-sensitive.

But using this trigger cell in a board specific devicetree leads to a
non-starting kernel. This is due to not yet enabled gpio-clocks while
kernel/irq/irqdomain.c tries to set this trigger-flag (from the second
interrupt-cell) to gpio-irq-controller.

 Any ideas?
---
 arch/arm/boot/dts/omap3.dtsi |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 1997b41..e8e6b8f 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -99,7 +99,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio2: gpio at 49050000 {
@@ -108,7 +108,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio3: gpio at 49052000 {
@@ -117,7 +117,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio4: gpio at 49054000 {
@@ -126,7 +126,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio5: gpio at 49056000 {
@@ -135,7 +135,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		gpio6: gpio at 49058000 {
@@ -144,7 +144,7 @@
 			gpio-controller;
 			#gpio-cells = <2>;
 			interrupt-controller;
-			#interrupt-cells = <1>;
+			#interrupt-cells = <2>;
 		};
 
 		uart1: serial at 4806a000 {
-- 
1.7.10.4
