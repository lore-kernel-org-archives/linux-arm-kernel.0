From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed, 17 Jul 2013 22:06:11 +0200
Subject: [PATCH v2 36/42] ARM: at91/dt: move sam9260/sam9g20 to new at91 clk
 implem
In-Reply-To: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
References: <1374068069-13496-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <1374091571-21935-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Define the main clock frequency in every sam9260/sam9g20 boards.
Remove the old main clock definition.

Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
---
 arch/arm/boot/dts/animeo_ip.dts             |   17 ++++++-----------
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   17 ++++++-----------
 arch/arm/boot/dts/ge863-pro3.dtsi           |   16 ++++++----------
 arch/arm/boot/dts/kizbox.dts                |    5 +++++
 arch/arm/boot/dts/tny_a9260_common.dtsi     |   17 ++++++-----------
 arch/arm/boot/dts/usb_a9260_common.dtsi     |   17 ++++++-----------
 6 files changed, 35 insertions(+), 54 deletions(-)

diff --git a/arch/arm/boot/dts/animeo_ip.dts b/arch/arm/boot/dts/animeo_ip.dts
index 3a1de9e..1843f15 100644
--- a/arch/arm/boot/dts/animeo_ip.dts
+++ b/arch/arm/boot/dts/animeo_ip.dts
@@ -31,17 +31,6 @@
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
 			usart0: serial at fffb0000 {
@@ -82,6 +71,12 @@
 			watchdog at fffffd40 {
 				status = "okay";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <18432000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index 1373546..b8c823d 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -17,17 +17,6 @@
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
 			pinctrl at fffff400 {
@@ -108,6 +97,12 @@
 			watchdog at fffffd40 {
 				status = "okay";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <18432000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/ge863-pro3.dtsi b/arch/arm/boot/dts/ge863-pro3.dtsi
index 230099b..b0b6aae 100644
--- a/arch/arm/boot/dts/ge863-pro3.dtsi
+++ b/arch/arm/boot/dts/ge863-pro3.dtsi
@@ -10,22 +10,18 @@
 #include "at91sam9260.dtsi"
 
 / {
-	clocks {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges;
-
-		main_clock: clock at 0 {
-			compatible = "atmel,osc", "fixed-clock";
-			clock-frequency = <6000000>;
-		};
-	};
 
 	ahb {
 		apb {
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <6000000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/kizbox.dts b/arch/arm/boot/dts/kizbox.dts
index 02df191..091da2e 100644
--- a/arch/arm/boot/dts/kizbox.dts
+++ b/arch/arm/boot/dts/kizbox.dts
@@ -53,6 +53,11 @@
 				status = "okay";
 			};
 
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <18432000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/tny_a9260_common.dtsi b/arch/arm/boot/dts/tny_a9260_common.dtsi
index 0e6d3de..1cecb7a 100644
--- a/arch/arm/boot/dts/tny_a9260_common.dtsi
+++ b/arch/arm/boot/dts/tny_a9260_common.dtsi
@@ -15,22 +15,17 @@
 		reg = <0x20000000 0x4000000>;
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
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <12000000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/usb_a9260_common.dtsi b/arch/arm/boot/dts/usb_a9260_common.dtsi
index 2859776..3ed4db8 100644
--- a/arch/arm/boot/dts/usb_a9260_common.dtsi
+++ b/arch/arm/boot/dts/usb_a9260_common.dtsi
@@ -7,17 +7,6 @@
  */
 
 / {
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
 			dbgu: serial at fffff200 {
@@ -33,6 +22,12 @@
 				atmel,vbus-gpio = <&pioC 5 GPIO_ACTIVE_HIGH>;
 				status = "okay";
 			};
+
+			pmc: pmc at fffffc00 {
+				main: mainck {
+					clock-frequency = <12000000>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
