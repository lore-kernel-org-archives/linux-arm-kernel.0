From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:40 +0100
Subject: [PATCH v2 04/11] ARM: DT: STiH407: Add serial3 pinctrl configuration
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-5-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing serial 3 pinctrl config. This can be used
on b2206 HVK, where it defaults to PIO31[3] & PIO31[4],
alternate 1.

Signed-off-by: Erwan Le Ray <erwan.leray@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
Acked-by: Carmelo Amoroso <carmelo.amoroso@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 2248e44..5d725fe 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1009,6 +1009,15 @@
 					};
 				};
 			};
+
+			serial3 {
+				pinctrl_serial3: serial3-0 {
+					st,pins {
+						tx = <&pio31 3 ALT1 OUT>;
+						rx = <&pio31 4 ALT1 IN>;
+					};
+				};
+			};
 		};
 
 		pin-controller-flash {
-- 
1.9.1
