From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 26 Jun 2018 18:47:01 +0200
Subject: [PATCH] ARM: dts: pxa: fix the rtc controller
Message-ID: <20180626164701.1034-1-robert.jarzmik@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The RTC controller is fed by an external fixed 32kHz clock. Yet the
driver wants to acquire this clock, even though it doesn't make any use
of it, ie. doesn't get the rate to make calculation.

Therefore, add the dummy clock in the PXA clock tree to make the driver
happy and working.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
---
 arch/arm/boot/dts/pxa25x.dtsi | 4 ++++
 arch/arm/boot/dts/pxa27x.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
index 95d59be97213..c6ca07e4626b 100644
--- a/arch/arm/boot/dts/pxa25x.dtsi
+++ b/arch/arm/boot/dts/pxa25x.dtsi
@@ -80,6 +80,10 @@
 			#pwm-cells = <1>;
 			clocks = <&clks CLK_PWM1>;
 		};
+
+		rtc at 40900000 {
+			clocks = <&clks CLK_NONE>;
+		};
 	};
 
 	timer at 40a00000 {
diff --git a/arch/arm/boot/dts/pxa27x.dtsi b/arch/arm/boot/dts/pxa27x.dtsi
index 747f750f675d..e9cf4192e2e0 100644
--- a/arch/arm/boot/dts/pxa27x.dtsi
+++ b/arch/arm/boot/dts/pxa27x.dtsi
@@ -113,6 +113,10 @@
 
 			status = "disabled";
 		};
+
+		rtc at 40900000 {
+			clocks = <&clks CLK_NONE>;
+		};
 	};
 
 	clocks {
-- 
2.11.0
