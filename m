From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:45 +0100
Subject: [PATCH v2 09/11] ARM: DT: STiH407: Add pinconfig for IRB UHF and IRB
 TX
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-10-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the pinconfig for IRB TX and IRB UHF.

Signed-off-by: M'boumba Cedric Madianga <cedric.madianga@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 352fe98..9daab1f 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -121,6 +121,24 @@
 						ir = <&pio4 0 ALT2 IN>;
 					};
 				};
+
+				pinctrl_uhf: uhf0 {
+					st,pins {
+						ir = <&pio4 1 ALT2 IN>;
+					};
+				};
+
+				pinctrl_tx: tx0 {
+					st,pins {
+						tx = <&pio4 2 ALT2 OUT>;
+					};
+				};
+
+				pinctrl_tx_od: tx_od0 {
+					st,pins {
+						tx_od = <&pio4 3 ALT2 OUT>;
+					};
+				};
 			};
 
 			/* SBC_ASC0 - UART10 */
-- 
1.9.1
