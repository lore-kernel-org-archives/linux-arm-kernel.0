From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:42 +0100
Subject: [PATCH v2 06/11] ARM: DT: STiH407: Add NAND flash controller pin
 configuration
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-7-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds NAND flash support controller pin configuration
for STiH407 family silicon.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index b7a405f..d281f9c 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1085,6 +1085,29 @@
 					};
 				};
 			};
+
+			nand {
+				pinctrl_nand: nand {
+					st,pins {
+						nand_cs1 = <&pio40 6 ALT3 OUT>;
+						nand_cs0 = <&pio40 7 ALT3 OUT>;
+						nand_d0 = <&pio41 0 ALT3 BIDIR>;
+						nand_d1 = <&pio41 1 ALT3 BIDIR>;
+						nand_d2 = <&pio41 2 ALT3 BIDIR>;
+						nand_d3 = <&pio41 3 ALT3 BIDIR>;
+						nand_d4 = <&pio41 4 ALT3 BIDIR>;
+						nand_d5 = <&pio41 5 ALT3 BIDIR>;
+						nand_d6 = <&pio41 6 ALT3 BIDIR>;
+						nand_d7 = <&pio41 7 ALT3 BIDIR>;
+						nand_we = <&pio42 0 ALT3 OUT>;
+						nand_dqs = <&pio42 1 ALT3 OUT>;
+						nand_ale = <&pio42 2 ALT3 OUT>;
+						nand_cle = <&pio42 3 ALT3 OUT>;
+						nand_rnb = <&pio42 4 ALT3 IN>;
+						nand_oe = <&pio42 5 ALT3 OUT>;
+					};
+				};
+			};
 		};
 	};
 };
-- 
1.9.1
