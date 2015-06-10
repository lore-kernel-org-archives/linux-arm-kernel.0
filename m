From: peter.griffin@linaro.org (Peter Griffin)
Date: Wed, 10 Jun 2015 15:04:05 +0100
Subject: [PATCH 8/9] ARM: STi: DT: Add STiH407 family tsout1 pinctrl
 configuration
In-Reply-To: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
References: <1433945046-19855-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1433945046-19855-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tsout1 channel can only be configured for serial data tranfer.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 85cd9fc..af7f5f7 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -595,6 +595,18 @@
 					};
 				};
 			};
+
+			tsout1 {
+				pinctrl_tsout1_serial: tsout1_serial {
+					st,pins {
+						DATA7 = <&pio19 4 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+						CLKIN = <&pio19 3 ALT1 OUT NICLK 0 CLK_A>;
+						VALID = <&pio19 1 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+						ERROR = <&pio19 0 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+						PKCLK = <&pio19 2 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
+					};
+				};
+			};
 		};
 
 		pin-controller-front1 {
-- 
1.9.1
