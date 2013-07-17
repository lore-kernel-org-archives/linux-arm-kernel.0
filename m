From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 22:19:54 +0200
Subject: [PATCH v2 40/42] ARM: at91/dt: move sam9n12 boards to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374092394-22173-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency in every at91sam9n12 boards.
Remove the old main clock definition.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/at91sam9n12ek.dts |   17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index d59b70c..35f484a 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -21,17 +21,6 @@
 		reg = <0x20000000 0x10000000>;
 	};
 
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <16000000>;
-		};
-	};
-
 	ahb {
 		apb {
 			dbgu: serial at fffff200 {
@@ -81,6 +70,12 @@
 			watchdog at fffffe40 {
 				status = "okay";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <16000000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
