From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri,  9 Jan 2015 20:11:20 +0100
Subject: [PATCH] ARM: nomadik: fix up leftover device tree pins
Message-ID: <1420830680-18611-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We altered the device tree bindings for the Nomadik family of
pin controllers to be standard, this file was merged out-of-order
so we missed fixing this. Fix it up.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ARM SoC guys: please pick this directly for fixes, I have no
other Nomadik fixes for this merge window AFAIK.
---
 arch/arm/boot/dts/ste-nomadik-nhk15.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/ste-nomadik-nhk15.dts b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
index a1b9deecb23a..aba2efead02e 100644
--- a/arch/arm/boot/dts/ste-nomadik-nhk15.dts
+++ b/arch/arm/boot/dts/ste-nomadik-nhk15.dts
@@ -25,11 +25,11 @@
 		stmpe2401_1 {
 			stmpe2401_1_nhk_mode: stmpe2401_1_nhk {
 				nhk_cfg1 {
-					ste,pins = "GPIO76_B20"; // IRQ line
+					pins = "GPIO76_B20"; // IRQ line
 					ste,input = <0>;
 				};
 				nhk_cfg2 {
-					ste,pins = "GPIO77_B8"; // reset line
+					pins = "GPIO77_B8"; // reset line
 					ste,output = <1>;
 				};
 			};
@@ -37,11 +37,11 @@
 		stmpe2401_2 {
 			stmpe2401_2_nhk_mode: stmpe2401_2_nhk {
 				nhk_cfg1 {
-					ste,pins = "GPIO78_A8"; // IRQ line
+					pins = "GPIO78_A8"; // IRQ line
 					ste,input = <0>;
 				};
 				nhk_cfg2 {
-					ste,pins = "GPIO79_C9"; // reset line
+					pins = "GPIO79_C9"; // reset line
 					ste,output = <1>;
 				};
 			};
-- 
1.9.3
