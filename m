From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 17 Nov 2014 16:47:54 +0000
Subject: [PATCH v3 01/11] ARM: STi: DT: STiH416: Add pinctl setup for usb
 controllers.
In-Reply-To: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
References: <1416242884-5261-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1416242884-5261-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required pin config for all usb controllers
on the stih416.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index c2025bc..9cccf2d 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -147,6 +147,15 @@
 				};
 			};
 
+			usb {
+				pinctrl_usb3: usb3 {
+					st,pins {
+						oc-detect = <&pio40 0 ALT1 IN>;
+						pwr-enable = <&pio40 1 ALT1 OUT>;
+					};
+				};
+			};
+
 			sbc_i2c1 {
 				pinctrl_sbc_i2c1_default: sbc_i2c1-default {
 					st,pins {
@@ -318,6 +327,16 @@
 				};
 			};
 
+			usb {
+				pinctrl_usb0: usb0 {
+					st,pins {
+						oc-detect = <&pio9 4 ALT1 IN>;
+						pwr-enable = <&pio9 5 ALT1 OUT>;
+					};
+				};
+			};
+
+
 			i2c1 {
 				pinctrl_i2c1_default: i2c1-default {
 					st,pins {
@@ -506,6 +525,21 @@
 					};
 				};
 			};
+
+			usb {
+				pinctrl_usb1: usb1 {
+					st,pins {
+						oc-detect = <&pio18 0 ALT1 IN>;
+						pwr-enable = <&pio18 1 ALT1 OUT>;
+					};
+				};
+				pinctrl_usb2: usb2 {
+					st,pins {
+						oc-detect = <&pio18 2 ALT1 IN>;
+						pwr-enable = <&pio18 3 ALT1 OUT>;
+					};
+				};
+			};
 		};
 
 		pin-controller-fvdp-fe {
-- 
1.9.1
