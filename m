From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:37 +0100
Subject: [PATCH v2 01/11] ARM: STi: DT: STiH407: Add a cec0 pin definition
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-2-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This pin setup provides the correct configuration in order to
interact with the CEC HW.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
Signed-off-by: Nicolas Vanhaelewyn <nicolas.vanhaelewyn@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
Acked-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 1683deb..30db453 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -107,6 +107,14 @@
 				st,retime-pin-mask = <0x3f>;
 			};
 
+			cec0 {
+				pinctrl_cec0_default: cec0-default {
+					st,pins {
+						hdmi_cec = <&pio2 4 ALT1 BIDIR>;
+					};
+				};
+			};
+
 			rc {
 				pinctrl_ir: ir0 {
 					st,pins {
-- 
1.9.1
