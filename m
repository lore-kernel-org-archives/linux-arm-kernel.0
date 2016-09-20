From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Tue, 20 Sep 2016 22:58:33 +0200
Subject: [PATCH v3 5/5] ARM: dts: at91: sama5d2: use correct sckc compatible
In-Reply-To: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
References: <20160920205833.19638-1-alexandre.belloni@free-electrons.com>
Message-ID: <20160920205833.19638-6-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

the sama5d2 sckc is actually sama5d4 compatible

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/sama5d2.dtsi | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
index 353d0e5ec83b..2e49f10f93fa 100644
--- a/arch/arm/boot/dts/sama5d2.dtsi
+++ b/arch/arm/boot/dts/sama5d2.dtsi
@@ -1059,30 +1059,12 @@
 				status = "disabled";
 			};
 
-			sckc at f8048050 {
-				compatible = "atmel,at91sam9x5-sckc";
+			clk32k: sckc at f8048050 {
+				compatible = "atmel,sama5d4-sckc";
 				reg = <0xf8048050 0x4>;
 
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
+				clocks = <&slow_xtal>;
+				#clock-cells = <0>;
 			};
 
 			rtc at f80480b0 {
-- 
2.9.3
