From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed,  7 Jan 2015 15:04:08 +0000
Subject: [PATCH v2 3/7] ARM: STi: DT: STiH407: Add usb2 picophy dt nodes
In-Reply-To: <1420643052-4506-1-git-send-email-peter.griffin@linaro.org>
References: <1420643052-4506-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1420643052-4506-4-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the dt nodes for the usb2 picophy found on the stih407
device family. It is used on stih407 by the dwc3 usb3 controller when
controlling usb2/1.1 devices.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/boot/dts/stih407-family.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 3e31d32..d4a8f84 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -274,5 +274,14 @@
 
 			status = "disabled";
 		};
+
+		usb2_picophy0: phy1 {
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
