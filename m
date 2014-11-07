From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri,  7 Nov 2014 11:57:44 +0000
Subject: [PATCH 02/13] ARM: STi: DT: STiH416: Add DT node for the stih415/6
 usb2 phy
In-Reply-To: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
References: <1415361475-6218-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1415361475-6218-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This usb picophy is found on stih415/6 SoC.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih416.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 1137bdf..0f3019a 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -316,5 +316,14 @@
 
 			status	        = "disabled";
 		};
+
+		usb2_phy: usb2phy at 0 {
+			compatible = "st,stih416-usb-phy";
+			#phy-cells = <0>;
+			st,syscfg = <&syscfg_rear>;
+			clocks = <&clk_sysin>;
+			clock-names = "osc_phy";
+
+		};
 	};
 };
-- 
1.9.1
