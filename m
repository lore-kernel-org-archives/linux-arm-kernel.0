From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 13 Nov 2014 11:00:16 +0000
Subject: [PATCH v2 13/14] ARM: STi: DT: STiH410: Add usb2 picophy dt nodes
In-Reply-To: <1415876417-28728-1-git-send-email-peter.griffin@linaro.org>
References: <1415876417-28728-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1415876417-28728-14-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dt nodes for the extra usb2 picophys found on the stih410.
These two picophys are used in conjunction with the extra ehci/ohci usb
controllers also found on the stih410.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih410.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
index c05627e..5ade3ed 100644
--- a/arch/arm/boot/dts/stih410.dtsi
+++ b/arch/arm/boot/dts/stih410.dtsi
@@ -10,5 +10,29 @@
 #include "stih407-family.dtsi"
 #include "stih410-pinctrl.dtsi"
 / {
+	soc {
+		usb2_picophy0: usbpicophy at 0 {
+			compatible = "st,stih407-usb2-phy";
+			reg = <0xf8 0x04>,	/* syscfg 5062 */
+			      <0xf4 0x04>;	/* syscfg 5061 */
+			reg-names = "param", "ctrl";
+			#phy-cells = <0>;
+			st,syscfg = <&syscfg_core>;
+			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+				 <&picophyreset STIH407_PICOPHY0_RESET>;
+			reset-names = "global", "port";
+		};
 
+		usb2_picophy1: usbpicophy at 1 {
+			compatible = "st,stih407-usb2-phy";
+			#phy-cells = <0>;
+			reg = <0xfc 0x04>,	/* syscfg 5063 */
+			      <0xf4 0x04>;	/* syscfg 5061 */
+			reg-names = "param", "ctrl";
+			st,syscfg = <&syscfg_core>;
+			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+				 <&picophyreset STIH407_PICOPHY1_RESET>;
+			reset-names = "global", "port";
+		};
+	};
 };
-- 
1.9.1
