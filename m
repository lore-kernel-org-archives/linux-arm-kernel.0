From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 20 Sep 2016 22:58:32 +0200
Subject: [PATCH v3 4/5] ARM: dts: at91: sama5d4: use proper sckc compatible
In-Reply-To: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
References: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160920205833.19638-5-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that there is support for the sama5d4 slow clock controller, use its
driver.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d4.dtsi | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 65e725fb5679..fe094263595c 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1314,30 +1314,11 @@
 				status = "disabled";
 			};
 
-			sckc at fc068650 {
-				compatible = "atmel,at91sam9x5-sckc";
+			clk32k: sckc at fc068650 {
+				compatible = "atmel,sama5d4-sckc";
 				reg = <0xfc068650 0x4>;
-
-				slow_rc_osc: slow_rc_osc {
-					compatible = "atmel,at91sam9x5-clk-slow-rc-osc";
-					#clock-cells = <0>;
-					clock-frequency = <32768>;
-					clock-accuracy = <250000000>;
-					atmel,startup-time-usec = <75>;
-				};
-
-				slow_osc: slow_osc {
-					compatible = "atmel,at91sam9x5-clk-slow-osc";
-					#clock-cells = <0>;
-					clocks = <&slow_xtal>;
-					atmel,startup-time-usec = <1200000>;
-				};
-
-				clk32k: slowck {
-					compatible = "atmel,at91sam9x5-clk-slow";
-					#clock-cells = <0>;
-					clocks = <&slow_rc_osc &slow_osc>;
-				};
+				#clock-cells = <0>;
+				clocks = <&slow_xtal>;
 			};
 
 			rtc at fc0686b0 {
-- 
2.9.3
