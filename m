From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 22:08:25 +0200
Subject: [PATCH v2 37/42] ARM: at91/dt: move rm9200 boards to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374091705-21985-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency in every at91rm9200 boards.
Remove the old main clock definition.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91rm9200ek.dts |   17 ++++++-----------
 arch/arm/boot/dts/mpa1600.dts      |   16 +++++-----------
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/at91rm9200ek.dts b/arch/arm/boot/dts/at91rm9200ek.dts
index d2d72c3..e2960b4 100644
--- a/arch/arm/boot/dts/at91rm9200ek.dts
+++ b/arch/arm/boot/dts/at91rm9200ek.dts
@@ -16,19 +16,14 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <18432000>;
-		};
-	};
-
 	ahb {
 		apb {
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <18432000>;
+				};
+			};
+
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
diff --git a/arch/arm/boot/dts/mpa1600.dts b/arch/arm/boot/dts/mpa1600.dts
index ccf9ea2..317ee5a 100644
--- a/arch/arm/boot/dts/mpa1600.dts
+++ b/arch/arm/boot/dts/mpa1600.dts
@@ -16,17 +16,6 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <18432000>;
-		};
-	};
-
 	ahb {
 		apb {
 			dbgu: serial at fffff200 {
@@ -45,6 +34,11 @@
 			ssc1: ssc at fffd4000 {
 				status = "okay";
 			};
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <18432000>;
+				};
+			};
 		};
 
 		usb0: ohci at 00300000 {
-- 
1.7.9.5
