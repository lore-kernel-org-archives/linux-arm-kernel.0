From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jun 2014 18:41:45 +0200
Subject: [PATCH 3/6] ARM: at91/dt: sam9n12 crystals under the clocks node
In-Reply-To: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1403023308-20533-4-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having clocks grouped in a subnode is common practice, so move the crystals
under a clocks node for the at91sam9n12 SoC and at91sam9n12 based boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9n12.dtsi  | 20 +++++++++++---------
 arch/arm/boot/dts/at91sam9n12ek.dts | 16 ++++++++--------
 2 files changed, 19 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
index 287795985e32..67efd442fd85 100644
--- a/arch/arm/boot/dts/at91sam9n12.dtsi
+++ b/arch/arm/boot/dts/at91sam9n12.dtsi
@@ -50,16 +50,18 @@
 		reg = <0x20000000 0x10000000>;
 	};
 
-	slow_xtal: slow_xtal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
-	};
+	clocks {
+		slow_xtal: slow_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 
-	main_xtal: main_xtal {
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <0>;
+		main_xtal: main_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 64bbe46e4f90..32f1aad889d2 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -21,14 +21,6 @@
 		reg = <0x20000000 0x8000000>;
 	};
 
-	slow_xtal {
-		clock-frequency = <32768>;
-	};
-
-	main_xtal {
-		clock-frequency = <16000000>;
-	};
-
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -38,6 +30,14 @@
 			compatible = "atmel,osc", "fixed-clock";
 			clock-frequency = <16000000>;
 		};
+
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
+
+		main_xtal {
+			clock-frequency = <16000000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
