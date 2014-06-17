From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 17 Jun 2014 18:41:47 +0200
Subject: [PATCH 5/6] ARM: at91/dt: sam9x5 crystals under the clocks node
In-Reply-To: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1403023308-20533-1-git-send-email-alexandre.belloni@free-electrons.com>
Message-ID: <1403023308-20533-6-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Having clocks grouped in a subnode is common practice, so move the crystals and
the ADC clock under a clocks node for the at91sam9x5 SoC and at91sam9x5 based
boards.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/at91sam9x5.dtsi   | 30 ++++++++++++++++--------------
 arch/arm/boot/dts/at91sam9x5cm.dtsi | 12 +++++++-----
 2 files changed, 23 insertions(+), 19 deletions(-)

diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
index d6133f497207..ed9251324c90 100644
--- a/arch/arm/boot/dts/at91sam9x5.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5.dtsi
@@ -52,22 +52,24 @@
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
-	};
+		main_xtal: main_xtal {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <0>;
+		};
 
-	adc_op_clk: adc_op_clk{
-		compatible = "fixed-clock";
-		#clock-cells = <0>;
-		clock-frequency = <5000000>;
+		adc_op_clk: adc_op_clk{
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <5000000>;
+		};
 	};
 
 	ahb {
diff --git a/arch/arm/boot/dts/at91sam9x5cm.dtsi b/arch/arm/boot/dts/at91sam9x5cm.dtsi
index 8413e21192eb..229d6c24a9c4 100644
--- a/arch/arm/boot/dts/at91sam9x5cm.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5cm.dtsi
@@ -23,12 +23,14 @@
 		};
 	};
 
-	slow_xtal {
-		clock-frequency = <32768>;
-	};
+	clocks {
+		slow_xtal {
+			clock-frequency = <32768>;
+		};
 
-	main_xtal {
-		clock-frequency = <12000000>;
+		main_xtal {
+			clock-frequency = <12000000>;
+		};
 	};
 
 	ahb {
-- 
1.9.1
