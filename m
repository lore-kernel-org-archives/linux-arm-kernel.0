From: lee.jones@linaro.org (Lee Jones)
Date: Mon, 15 Aug 2016 13:17:38 +0100
Subject: [PATCH 5/7] ARM: dts: STiH407-pinctrl: Add pinctrl_rgmii1_mdio_1 node
In-Reply-To: <20160815121740.29515-1-lee.jones@linaro.org>
References: <20160815121740.29515-1-lee.jones@linaro.org>
Message-ID: <20160815121740.29515-6-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Patrice Chotard <patrice.chotard@st.com>

On 96board, we can't reuse rgmii1-mdio as the pin pio1 3
( mdint ) is dedicated for user led green 1. So create
rgmii1_mdio_1 for 96board on which only mdio and mdc pins
are useful.

Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 arch/arm/boot/dts/stih407-pinctrl.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-pinctrl.dtsi b/arch/arm/boot/dts/stih407-pinctrl.dtsi
index e05be3c..3e7a56d 100644
--- a/arch/arm/boot/dts/stih407-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih407-pinctrl.dtsi
@@ -230,6 +230,13 @@
 					};
 				};
 
+				pinctrl_rgmii1_mdio_1: rgmii1-mdio-1 {
+					st,pins {
+						mdio = <&pio1 0 ALT1 OUT BYPASS 0>;
+						mdc = <&pio1 1 ALT1 OUT NICLK 0 CLK_A>;
+					};
+				};
+
 				pinctrl_mii1: mii1 {
 					st,pins {
 						txd0 = <&pio0 0 ALT1 OUT SE_NICLK_IO 0 CLK_A>;
-- 
2.9.0
