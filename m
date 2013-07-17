From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 22:32:51 +0200
Subject: [PATCH v2 42/42] ARM: at91/dt: move sama5d3 boards to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374093171-22330-1-git-send-email-b.brezillon@overkiz.com>
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
index 027bac7..4628533 100644
--- a/arch/arm/boot/dts/sama5d31ek.dts
+++ b/arch/arm/boot/dts/sama5d31ek.dts
@@ -9,6 +9,10 @@
 /dts-v1/;
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
+#include "sama5d3_lcd.dtsi"
+#include "sama5d3_emac.dtsi"
+#include "sama5d3_mci2.dtsi"
+#include "sama5d3_uart.dtsi"
 
 / {
 	model = "Atmel SAMA5D31-EK";
diff --git a/arch/arm/boot/dts/sama5d33ek.dts b/arch/arm/boot/dts/sama5d33ek.dts
index 99bd0c8..5aa32f5 100644
--- a/arch/arm/boot/dts/sama5d33ek.dts
+++ b/arch/arm/boot/dts/sama5d33ek.dts
@@ -9,6 +9,8 @@
 /dts-v1/;
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
+#include "sama5d3_lcd.dtsi"
+#include "sama5d3_gmac.dtsi"
 
 / {
 	model = "Atmel SAMA5D33-EK";
diff --git a/arch/arm/boot/dts/sama5d34ek.dts b/arch/arm/boot/dts/sama5d34ek.dts
index fb8ee11..272a611 100644
--- a/arch/arm/boot/dts/sama5d34ek.dts
+++ b/arch/arm/boot/dts/sama5d34ek.dts
@@ -9,6 +9,10 @@
 /dts-v1/;
 #include "sama5d3xmb.dtsi"
 #include "sama5d3xdm.dtsi"
+#include "sama5d3_lcd.dtsi"
+#include "sama5d3_gmac.dtsi"
+#include "sama5d3_can.dtsi"
+#include "sama5d3_mci2.dtsi"
 
 / {
 	model = "Atmel SAMA5D34-EK";
diff --git a/arch/arm/boot/dts/sama5d35ek.dts b/arch/arm/boot/dts/sama5d35ek.dts
index 509a53d..155bb9d 100644
--- a/arch/arm/boot/dts/sama5d35ek.dts
+++ b/arch/arm/boot/dts/sama5d35ek.dts
@@ -8,6 +8,12 @@
  */
 /dts-v1/;
 #include "sama5d3xmb.dtsi"
+#include "sama5d3_gmac.dtsi"
+#include "sama5d3_emac.dtsi"
+#include "sama5d3_can.dtsi"
+#include "sama5d3_mci2.dtsi"
+#include "sama5d3_uart.dtsi"
+#include "sama5d3_tcb1.dtsi"
 
 / {
 	model = "Atmel SAMA5D35-EK";
diff --git a/arch/arm/boot/dts/sama5d3xcm.dtsi b/arch/arm/boot/dts/sama5d3xcm.dtsi
index 1f80508..f58aa43 100644
--- a/arch/arm/boot/dts/sama5d3xcm.dtsi
+++ b/arch/arm/boot/dts/sama5d3xcm.dtsi
@@ -19,17 +19,6 @@
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
 			spi0: spi at f0004000 {
@@ -39,6 +28,12 @@
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
