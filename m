From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jun 2014 18:41:44 +0200
Subject: [PATCH 2/6] ARM: at91/dt: sam9261 crystals under the clocks node
In-Reply-To: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1403023308-20533-3-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having clocks grouped in a subnode is common practice, so move the crystals
under a clocks node for the at91sam9261 SoC and at91sam9261 based boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9261.dtsi  | 20 +++++++++++---------
 arch/arm/boot/dts/at91sam9261ek.dts | 16 ++++++++--------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9261.dtsi b/arch/arm/boot/dts/at91sam9261.dtsi
index 9de312e9bb3e..c8e8b92df51b 100644
--- a/arch/arm/boot/dts/at91sam9261.dtsi
+++ b/arch/arm/boot/dts/at91sam9261.dtsi
@@ -46,16 +46,18 @@
 		reg = <0x20000000 0x08000000>;
 	};
 
-	main_xtal: main_xtal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
+	clocks {
+		main_xtal: main_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 
-	slow_xtal: slow_xtal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
+		slow_xtal: slow_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index aa35a7aec9a8..f4a765729c7a 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -20,14 +20,6 @@
 		reg = <0x20000000 0x4000000>;
 	};
 
-	slow_xtal {
-		clock-frequency = <32768>;
-	};
-
-	main_xtal {
-		clock-frequency = <18432000>;
-	};
-
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -37,6 +29,14 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <18432000>;
 		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <18432000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
