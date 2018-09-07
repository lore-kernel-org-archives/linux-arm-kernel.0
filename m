From: eugen.hristev@microchip.com (Eugen Hristev)
Date: Fri, 7 Sep 2018 16:38:09 +0300
Subject: [PATCH] ARM: dts: at91: sama5d4: add labels to soc dtsi for
 derivative boards
Message-ID: <1536327489-22005-1-git-send-email-eugen.hristev@microchip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds labels to commonly used device-tree nodes so that derivative
boards can avoid ahb/apb hierarchy.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---

Hello,

This was already done for SoC sama5d3 and sam9x5, in commit:
"fc37204432d" ("ARM: dts: at91: add labels to soc dtsi for derivative boards")

This commit will do basically the same thing for sama5d4 SoC.

Based on top of at91-next branch of at91.git

Thanks.

 arch/arm/boot/dts/sama5d4.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/sama5d4.dtsi b/arch/arm/boot/dts/sama5d4.dtsi
index 92a35a1..7371f2a 100644
--- a/arch/arm/boot/dts/sama5d4.dtsi
+++ b/arch/arm/boot/dts/sama5d4.dtsi
@@ -1323,13 +1323,13 @@
 				};
 			};
 
-			rstc at fc068600 {
+			reset_controller: rstc at fc068600 {
 				compatible = "atmel,sama5d3-rstc", "atmel,at91sam9g45-rstc";
 				reg = <0xfc068600 0x10>;
 				clocks = <&clk32k>;
 			};
 
-			shdwc at fc068610 {
+			shutdown_controller: shdwc at fc068610 {
 				compatible = "atmel,at91sam9x5-shdwc";
 				reg = <0xfc068610 0x10>;
 				clocks = <&clk32k>;
@@ -1342,7 +1342,7 @@
 				clocks = <&h32ck>;
 			};
 
-			watchdog at fc068640 {
+			watchdog: watchdog at fc068640 {
 				compatible = "atmel,sama5d4-wdt";
 				reg = <0xfc068640 0x10>;
 				interrupts = <4 IRQ_TYPE_LEVEL_HIGH 7>;
@@ -1376,7 +1376,7 @@
 			};
 
 
-			pinctrl at fc06a000 {
+			pinctrl: pinctrl at fc06a000 {
 				#address-cells = <1>;
 				#size-cells = <1>;
 				compatible = "atmel,sama5d3-pinctrl", "atmel,at91sam9x5-pinctrl", "simple-bus";
-- 
2.7.4
