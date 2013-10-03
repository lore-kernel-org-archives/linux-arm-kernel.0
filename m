From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu,  3 Oct 2013 13:30:47 +0200
Subject: [PATCH 06/10] ARM: ux500: move TC35892 at 0x42 to hrefprev60
Message-ID: <1380799847-25928-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TC35892 was mounted as a GPIO expander on the HREF prior
to v60 and not in later versions, which instead use the Nomadik
GPIO directly, so move it over to the hrefprev60 DTS file.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-href.dtsi      | 22 ----------------------
 arch/arm/boot/dts/ste-hrefprev60.dts | 20 ++++++++++++++++++++
 2 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/ste-href.dtsi b/arch/arm/boot/dts/ste-href.dtsi
index a561bc3..aa3f020 100644
--- a/arch/arm/boot/dts/ste-href.dtsi
+++ b/arch/arm/boot/dts/ste-href.dtsi
@@ -41,28 +41,6 @@
 			status = "okay";
 		};
 
-		i2c at 80004000 {
-			tc3589x at 42 {
-				compatible = "tc3589x";
-				reg = <0x42>;
-				interrupt-parent = <&gpio6>;
-				interrupts = <25 IRQ_TYPE_EDGE_RISING>;
-
-				interrupt-controller;
-				#interrupt-cells = <2>;
-
-				tc3589x_gpio: tc3589x_gpio {
-					compatible = "tc3589x-gpio";
-					interrupts = <0 IRQ_TYPE_EDGE_RISING>;
-
-					interrupt-controller;
-					#interrupt-cells = <2>;
-					gpio-controller;
-					#gpio-cells = <2>;
-				};
-			};
-		};
-
 		i2c at 80128000 {
 			lp5521 at 33 {
 				compatible = "national,lp5521";
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dts b/arch/arm/boot/dts/ste-hrefprev60.dts
index 767fa21..5016dc9 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dts
+++ b/arch/arm/boot/dts/ste-hrefprev60.dts
@@ -30,6 +30,26 @@
 				compatible = "tps61052";
 				reg = <0x33>;
 			};
+
+			tc3589x at 42 {
+				compatible = "tc3589x";
+				reg = <0x42>;
+				interrupt-parent = <&gpio6>;
+				interrupts = <25 IRQ_TYPE_EDGE_RISING>;
+
+				interrupt-controller;
+				#interrupt-cells = <2>;
+
+				tc3589x_gpio: tc3589x_gpio {
+					compatible = "tc3589x-gpio";
+					interrupts = <0 IRQ_TYPE_EDGE_RISING>;
+
+					interrupt-controller;
+					#interrupt-cells = <2>;
+					gpio-controller;
+					#gpio-cells = <2>;
+				};
+			};
 		};
 
 		i2c at 80110000 {
-- 
1.8.3.1
