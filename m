From: peter.griffin@linaro.org (Peter Griffin)
Date: Mon, 28 Sep 2015 13:37:44 +0100
Subject: [PATCH v2 08/11] ARM: DT: STiH407: Add SD pinctrl config for mmc0
 controller
In-Reply-To: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
References: <1443443867-4099-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1443443867-4099-9-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the missing SD pinctrl config
for mmc/sd controller 0. This is required to enable the
B2144A daughter board that exposes this controller as a sd
slot.

Signed-off-by: Nebil BEN MEFTEH <nebil.ben-mefteh@st.com>
Acked-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Patrice Chotard <patrice.chotard@st.com>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index 7a1bd42..352fe98 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -1083,6 +1083,21 @@
 						emmc_d7 = <&pio41 7 ALT1 BIDIR_PU>;
 					};
 				};
+				pinctrl_sd0: sd0-0 {
+					st,pins {
+						sd_clk = <&pio40 6 ALT1 BIDIR>;
+						sd_cmd = <&pio40 7 ALT1 BIDIR_PU>;
+						sd_dat0 = <&pio41 0 ALT1 BIDIR_PU>;
+						sd_dat1 = <&pio41 1 ALT1 BIDIR_PU>;
+						sd_dat2 = <&pio41 2 ALT1 BIDIR_PU>;
+						sd_dat3 = <&pio41 3 ALT1 BIDIR_PU>;
+						sd_led = <&pio42 0 ALT2 OUT>;
+						sd_pwren = <&pio42 2 ALT2 OUT>;
+						sd_vsel = <&pio42 3 ALT2 OUT>;
+						sd_cd = <&pio42 4 ALT2 IN>;
+						sd_wp = <&pio42 5 ALT2 IN>;
+					};
+				};
 			};
 
 			fsm {
-- 
1.9.1
