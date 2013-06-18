From: dinguyen@altera.com (dinguyen at altera.com)
Date: Mon, 17 Jun 2013 19:08:48 -0500
Subject: [PATCH 1/2] ARM: dts: Change dw-apb-timer-osc and dw-apb-timer-sp to
 just dw-apb-timer
In-Reply-To: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
References: <1371514129-22801-1-git-send-email-dinguyen@altera.com>
Message-ID: <1371514129-22801-2-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

"dw-apb-timer-osc" and "dw-apb-timer-sp" are the same implementation of the
DW APB timer, just fed by different clocks.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Rob Herring <rob.herring@calxeda.com>
Cc: Grant Likely <grant.likely@linaro.org>
CC: Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>
CC: Jamie Iles <jamie@jamieiles.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Pavel Machek <pavel@denx.de>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
---
 Documentation/devicetree/bindings/rtc/dw-apb.txt |   21 +++------------------
 arch/arm/boot/dts/socfpga.dtsi                   |   12 ++++++++----
 2 files changed, 11 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/rtc/dw-apb.txt b/Documentation/devicetree/bindings/rtc/dw-apb.txt
index eb2327b..0a1020e 100644
--- a/Documentation/devicetree/bindings/rtc/dw-apb.txt
+++ b/Documentation/devicetree/bindings/rtc/dw-apb.txt
@@ -1,7 +1,7 @@
 * Designware APB timer
 
 Required properties:
-- compatible: "snps,dw-apb-timer-sp" or "snps,dw-apb-timer-osc"
+- compatible: "snps,dw-apb-timer"
 - reg: physical base address of the controller and length of memory mapped
   region.
 - interrupts: IRQ line for the timer.
@@ -20,23 +20,8 @@ systems may use one.
 
 
 Example:
-
-		timer1: timer at ffc09000 {
-				compatible = "snps,dw-apb-timer-sp";
-				interrupts = <0 168 4>;
-				clock-frequency = <200000000>;
-				reg = <0xffc09000 0x1000>;
-			};
-
-		timer2: timer at ffd00000 {
-				compatible = "snps,dw-apb-timer-osc";
-				interrupts = <0 169 4>;
-				clock-frequency = <200000000>;
-				reg = <0xffd00000 0x1000>;
-			};
-
-		timer3: timer at ffe00000 {
-				compatible = "snps,dw-apb-timer-osc";
+		timer1: timer at ffe00000 {
+				compatible = "snps,dw-apb-timer";
 				interrupts = <0 170 4>;
 				reg = <0xffe00000 0x1000>;
 				clocks = <&timer_clk>, <&timer_pclk>;
diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index bee62a2..ede33ae 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -476,27 +476,31 @@
 		};
 
 		timer0: timer0 at ffc08000 {
-			compatible = "snps,dw-apb-timer-sp";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 167 4>;
 			reg = <0xffc08000 0x1000>;
+			clocks = <&osc>;
 		};
 
 		timer1: timer1 at ffc09000 {
-			compatible = "snps,dw-apb-timer-sp";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 168 4>;
 			reg = <0xffc09000 0x1000>;
+			clocks = <&osc>;
 		};
 
 		timer2: timer2 at ffd00000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 169 4>;
 			reg = <0xffd00000 0x1000>;
+			clocks = <&l4_sp_clk>;
 		};
 
 		timer3: timer3 at ffd01000 {
-			compatible = "snps,dw-apb-timer-osc";
+			compatible = "snps,dw-apb-timer";
 			interrupts = <0 170 4>;
 			reg = <0xffd01000 0x1000>;
+			clocks = <&l4_sp_clk>;
 		};
 
 		uart0: serial0 at ffc02000 {
-- 
1.7.9.5
