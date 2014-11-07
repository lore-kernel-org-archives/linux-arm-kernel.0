From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  7 Nov 2014 11:57:51 +0000
Subject: [PATCH 09/13] ARM: STi: DT: STiH410: Add pinctl config for usb
 controllers.
In-Reply-To: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1415361475-6218-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the required pin configiguration for the extra usb
controllers found on the stih410 device.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 402844c..fdaad5d 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -539,6 +539,24 @@
 				};
 			};
 
+			usb0 {
+				pinctrl_usb0: usb2-0 {
+					st,pins {
+						usb-oc-detect = <&pio35 0 ALT1 IN>;
+						usb-pwr-enable = <&pio35 1 ALT1 OUT>;
+					};
+				};
+			};
+
+			usb1 {
+				pinctrl_usb1: usb2-1 {
+					st,pins {
+						usb-oc-detect = <&pio35 2 ALT1 IN>;
+						usb-pwr-enable = <&pio35 3 ALT1 OUT>;
+					};
+				};
+			};
+
 			usb3 {
 				pinctrl_usb3: usb3-2 {
 					st,pins {
-- 
1.9.1
