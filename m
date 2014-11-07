From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  7 Nov 2014 11:57:49 +0000
Subject: [PATCH 07/13] ARM: STi: DT: STiH407: Add usb2 picophy dt nodes
In-Reply-To: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1415361475-6218-8-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dt nodes for the usb2 picophy found on the stih407
family of devices. It is used on stih410 and later devices with the ehci/ohci usb
controller, and is also used as the usb2 phy with the dwc3 usb3 controller.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407.dtsi | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
index 50637f5..967ec39 100644
--- a/arch/arm/boot/dts/stih407.dtsi
+++ b/arch/arm/boot/dts/stih407.dtsi
@@ -275,5 +275,51 @@
 
 			status = "disabled";
 		};
+
+		/* Generic picoPHY */
+		usb2_picophy0: usbpicophy at 0 {
+			compatible = "st,stih407-usb2-phy";
+			reg =	<0xf8 0x04>,	/* syscfg 5062 */
+				<0xf4 0x04>;    /* syscfg 5061 */
+			reg-names =	"param",
+					"ctrl";
+			#phy-cells = <0>;
+
+			st,syscfg = <&syscfg_core>;
+			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+				 <&picophyreset STIH407_PICOPHY0_RESET>;
+			reset-names = "global",
+				      "port";
+		};
+
+		usb2_picophy1: usbpicophy at 1 {
+			compatible = "st,stih407-usb2-phy";
+			#phy-cells = <0>;
+			reg =	<0xfc 0x04>,	/* syscfg 5063 */
+				<0xf4 0x04>;    /* syscfg 5061 */
+			reg-names =	"param",
+					"ctrl";
+
+			st,syscfg = <&syscfg_core>;
+			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+				 <&picophyreset STIH407_PICOPHY1_RESET>;
+			reset-names = "global",
+				      "port";
+		};
+
+		usb2_picophy2: usbpicophy at 2 {
+			compatible = "st,stih407-usb2-phy";
+			#phy-cells = <0>;
+			reg =	<0x100 0x04>,	/* syscfg 5064 */
+				<0xf4 0x04>;    /* syscfg 5061 */
+			reg-names =	"param",
+					"ctrl";
+
+			st,syscfg = <&syscfg_core>;
+			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+				 <&picophyreset STIH407_PICOPHY2_RESET>;
+			reset-names = "global",
+				      "port";
+		};
 	};
 };
-- 
1.9.1
