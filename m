From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 19 Nov 2014 08:27:08 +0000
Subject: [PATCH 3/7] ARM: STi: DT: STiH407: Add usb2 picophy dt nodes
In-Reply-To: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
References: <1416385632-5832-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1416385632-5832-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dt nodes for the usb2 picophy found on the stih407
device family. It is used on stih407 by the dwc3 usb3 controller when
controlling usb2/1.1 devices.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 3e31d32..e908477 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -274,5 +274,14 @@
 
 			status = "disabled";
 		};
+
+		usb2_picophy0: phy at 0 {
+			compatible = "st,stih407-usb2-phy";
+			#phy-cells = <0>;
+			st,syscfg = <&syscfg_core 0x100 0xf4>;
+			resets = <&softreset STIH407_PICOPHY_SOFTRESET>,
+				 <&picophyreset STIH407_PICOPHY0_RESET>;
+			reset-names = "global", "port";
+		};
 	};
 };
-- 
1.9.1
