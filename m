From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Fri,  7 Jun 2013 21:45:09 +0200
Subject: [RFC PATCH 50/50] ARM: at91/dt: move sama5d3 boards to new at91 clk
 implem
In-Reply-To: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
References: <1370615115-16979-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1370634310-4185-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency in every sama5d3 boards.
Remove the old main clock definition.
Include the appropriate peripheral options according to peripherals
availability.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/sama5d31ek.dts  |    4 ++++
 arch/arm/boot/dts/sama5d33ek.dts  |    2 ++
 arch/arm/boot/dts/sama5d34ek.dts  |    4 ++++
 arch/arm/boot/dts/sama5d35ek.dts  |    6 ++++++
 arch/arm/boot/dts/sama5d3xcm.dtsi |   17 ++++++-----------
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d31ek.dts b/arch/arm/boot/dts/sama5d31ek.dts
index 027bac7..3a6c391 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -7,6 +7,10 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
+#include "sama5d3_lcd.dtsi"
+#include "sama5d3_emac.dtsi"
+#include "sama5d3_mci2.dtsi"
+#include "sama5d3_uart.dtsi"
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
 
diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
index 99bd0c8..3e35854 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -7,6 +7,8 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
+#include "sama5d3_lcd.dtsi"
+#include "sama5d3_gmac.dtsi"
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
 
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index fb8ee11..d03db9f 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -7,6 +7,10 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
+#include "sama5d3_lcd.dtsi"
+#include "sama5d3_gmac.dtsi"
+#include "sama5d3_can.dtsi"
+#include "sama5d3_mci2.dtsi"
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
 
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
index 509a53d..57e49b1 100644
--- a/arch/arm/boot/dts/sama5d35ek.dts
+++ b/arch/arm/boot/dts/sama5d35ek.dts
@@ -7,6 +7,12 @@
  * Licensed under GPLv2 or later.
  */
 /dts-v1/;
+#include "sama5d3_gmac.dtsi"
+#include "sama5d3_emac.dtsi"
+#include "sama5d3_can.dtsi"
+#include "sama5d3_mci2.dtsi"
+#include "sama5d3_uart.dtsi"
+#include "sama5d3_tcb1.dtsi"
 #include "sama5d3xmb.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 60637e4..a4ae732 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -19,22 +19,17 @@
 		reg = <0x20000000 0x20000000>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <12000000>;
-		};
-	};
-
 	ahb {
 		apb {
 			macb0: ethernet at f0028000 {
 				phy-mode = "rgmii";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <12000000>;
+				};
+			};
 		};
 
 		nand0: nand at 60000000 {
-- 
1.7.9.5
