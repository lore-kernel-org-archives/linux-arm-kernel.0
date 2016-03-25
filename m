From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 25 Mar 2016 15:36:25 +0000
Subject: [PATCH 1/4] ARM: DT: STiH407: Add UART RTS/CTS pin configuration
In-Reply-To: <1458920188-29612-1-git-send-email-peter.griffin@linaro.org>
References: <1458920188-29612-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1458920188-29612-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl definitions of UART RTS/CTS pins.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 73 ++++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index a538ae5..87e75bf 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -149,7 +149,20 @@
 						rx = <&pio3 5 ALT1 IN>;
 					};
 				};
+
+				pinctrl_sbc_serial0_rts: sbc_serial0_rts {
+					st,pins {
+						rts = <&pio3 7 ALT1 OUT>;
+					};
+				};
+
+				pinctrl_sbc_serial0_cts: sbc_serial0_cts {
+					st,pins {
+						cts = <&pio3 6 ALT1 IN>;
+					};
+				};
 			};
+
 			/* SBC_ASC1 - UART11 */
 			sbc_serial1 {
 				pinctrl_sbc_serial1: sbc_serial1-0 {
@@ -158,6 +171,18 @@
 						rx = <&pio2 7 ALT3 IN>;
 					};
 				};
+
+				pinctrl_sbc_serial1_rts: sbc_serial1_rts {
+					st,pins {
+						rts = <&pio3 1 ALT3 OUT>;
+					};
+				};
+
+				pinctrl_sbc_serial1_cts: sbc_serial1_cts {
+					st,pins {
+						cts = <&pio3 0 ALT3 IN>;
+					};
+				};
 			};
 
 			i2c10 {
@@ -478,6 +503,18 @@
 						rx = <&pio15 1 ALT1 IN>;
 					};
 				};
+
+				pinctrl_serial0_rts: serial0_rts {
+					st,pins {
+						rts = <&pio17 3 ALT1 OUT>;
+					};
+				};
+
+				pinctrl_serial0_cts: serial0_cts {
+					st,pins {
+						cts = <&pio17 2 ALT1 IN>;
+					};
+				};
 			};
 
 			mmc1 {
@@ -495,6 +532,18 @@
 						sd_wp = <&pio19 1 ALT6 IN>;
 					};
 				};
+
+				pinctrl_serial1_rts: serial1_rts {
+					st,pins {
+						rts = <&pio16 3 ALT1 OUT>;
+					};
+				};
+
+				pinctrl_serial1_cts: serial1_cts {
+					st,pins {
+						cts = <&pio16 2 ALT1 IN>;
+					};
+				};
 			};
 
 
@@ -505,6 +554,18 @@
 						scl = <&pio10 5 ALT2 BIDIR>;
 					};
 				};
+
+				pinctrl_serial2_rts: serial2_rts {
+					st,pins {
+						rts = <&pio15 3 ALT1 OUT>;
+					};
+				};
+
+				pinctrl_serial2_cts: serial2_cts {
+					st,pins {
+						cts = <&pio15 2 ALT1 IN>;
+					};
+				};
 			};
 
 			i2c1 {
@@ -1074,6 +1135,18 @@
 						rx = <&pio31 4 ALT1 IN>;
 					};
 				};
+
+				pinctrl_serial3_rts: serial3_rts {
+					st,pins {
+						rts = <&pio31 6 ALT1 OUT>;
+					};
+				};
+
+				pinctrl_serial3_cts: serial3_cts {
+					st,pins {
+						cts = <&pio31 5 ALT1 IN>;
+					};
+				};
 			};
 		};
 
-- 
1.9.1
