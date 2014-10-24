From: cw00.choi@samsung.com (Chanwoo Choi)
Date: Fri, 24 Oct 2014 22:12:41 +0900
Subject: [PATCHv4 2/3] ARM: dts: Add sleep mode pin configuration for
 exynos3250-rinato
In-Reply-To: <1414156362-5752-1-git-send-email-cw00.choi@samsung.com>
References: <1414156362-5752-1-git-send-email-cw00.choi@samsung.com>
Message-ID: <1414156362-5752-3-git-send-email-cw00.choi@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch add sleep mode pin configuration using pinctrl subsystem
to reduce leakage power-consumption of gpio pin in sleep state.

Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos3250-pinctrl.dtsi |  16 ++++
 arch/arm/boot/dts/exynos3250-rinato.dts   | 154 ++++++++++++++++++++++++++++++
 2 files changed, 170 insertions(+)

diff --git a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
index 47b92c1..5ab81c3 100644
--- a/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
+++ b/arch/arm/boot/dts/exynos3250-pinctrl.dtsi
@@ -12,6 +12,22 @@
  * published by the Free Software Foundation.
 */
 
+#define PIN_PULL_NONE		0
+#define PIN_PULL_DOWN		1
+#define PIN_PULL_UP		3
+
+#define PIN_PDN_OUT0		0
+#define PIN_PDN_OUT1		1
+#define PIN_PDN_INPUT		2
+#define PIN_PDN_PREV		3
+
+#define PIN_SLP(_pin, _mode, _pull)				\
+	_pin {							\
+		samsung,pins = #_pin;				\
+		samsung,pin-con-pdn = <PIN_PDN_ ##_mode>;	\
+		samsung,pin-pud-pdn = <PIN_PULL_ ##_pull>;	\
+	}
+
 &pinctrl_0 {
 	gpa0: gpa0 {
 		gpio-controller;
diff --git a/arch/arm/boot/dts/exynos3250-rinato.dts b/arch/arm/boot/dts/exynos3250-rinato.dts
index 8a18e68..8ad9808 100644
--- a/arch/arm/boot/dts/exynos3250-rinato.dts
+++ b/arch/arm/boot/dts/exynos3250-rinato.dts
@@ -422,3 +422,157 @@
 &xusbxti {
 	clock-frequency = <24000000>;
 };
+
+&pinctrl_0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep0>;
+
+	sleep0: sleep-state {
+		PIN_SLP(gpa0-0, INPUT, DOWN);
+		PIN_SLP(gpa0-1, INPUT, DOWN);
+		PIN_SLP(gpa0-2, INPUT, DOWN);
+		PIN_SLP(gpa0-3, INPUT, DOWN);
+		PIN_SLP(gpa0-4, INPUT, DOWN);
+		PIN_SLP(gpa0-5, INPUT, DOWN);
+		PIN_SLP(gpa0-6, INPUT, DOWN);
+		PIN_SLP(gpa0-7, INPUT, DOWN);
+
+		PIN_SLP(gpa1-0, INPUT, DOWN);
+		PIN_SLP(gpa1-1, INPUT, DOWN);
+		PIN_SLP(gpa1-2, INPUT, DOWN);
+		PIN_SLP(gpa1-3, INPUT, DOWN);
+		PIN_SLP(gpa1-4, INPUT, DOWN);
+		PIN_SLP(gpa1-5, INPUT, DOWN);
+
+		PIN_SLP(gpb-0, PREV, NONE);
+		PIN_SLP(gpb-1, PREV, NONE);
+		PIN_SLP(gpb-2, PREV, NONE);
+		PIN_SLP(gpb-3, PREV, NONE);
+		PIN_SLP(gpb-4, INPUT, DOWN);
+		PIN_SLP(gpb-5, INPUT, DOWN);
+		PIN_SLP(gpb-6, INPUT, DOWN);
+		PIN_SLP(gpb-7, INPUT, DOWN);
+
+		PIN_SLP(gpc0-0, INPUT, DOWN);
+		PIN_SLP(gpc0-1, INPUT, DOWN);
+		PIN_SLP(gpc0-2, INPUT, DOWN);
+		PIN_SLP(gpc0-3, INPUT, DOWN);
+		PIN_SLP(gpc0-4, INPUT, DOWN);
+
+		PIN_SLP(gpc1-0, INPUT, DOWN);
+		PIN_SLP(gpc1-1, INPUT, DOWN);
+		PIN_SLP(gpc1-2, INPUT, DOWN);
+		PIN_SLP(gpc1-3, INPUT, DOWN);
+		PIN_SLP(gpc1-4, INPUT, DOWN);
+
+		PIN_SLP(gpd0-0, INPUT, DOWN);
+		PIN_SLP(gpd0-1, INPUT, DOWN);
+		PIN_SLP(gpd0-2, INPUT, NONE);
+		PIN_SLP(gpd0-3, INPUT, NONE);
+
+		PIN_SLP(gpd1-0, INPUT, NONE);
+		PIN_SLP(gpd1-1, INPUT, NONE);
+		PIN_SLP(gpd1-2, INPUT, NONE);
+		PIN_SLP(gpd1-3, INPUT, NONE);
+	};
+};
+
+&pinctrl_1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&sleep1>;
+
+	sleep1: sleep-state {
+		PIN_SLP(gpe0-0, PREV, NONE);
+		PIN_SLP(gpe0-1, PREV, NONE);
+		PIN_SLP(gpe0-2, INPUT, DOWN);
+		PIN_SLP(gpe0-3, INPUT, UP);
+		PIN_SLP(gpe0-4, INPUT, DOWN);
+		PIN_SLP(gpe0-5, INPUT, DOWN);
+		PIN_SLP(gpe0-6, INPUT, DOWN);
+		PIN_SLP(gpe0-7, INPUT, DOWN);
+
+		PIN_SLP(gpe1-0, INPUT, DOWN);
+		PIN_SLP(gpe1-1, PREV, NONE);
+		PIN_SLP(gpe1-2, INPUT, DOWN);
+		PIN_SLP(gpe1-3, INPUT, DOWN);
+		PIN_SLP(gpe1-4, INPUT, DOWN);
+		PIN_SLP(gpe1-5, INPUT, DOWN);
+		PIN_SLP(gpe1-6, INPUT, DOWN);
+		PIN_SLP(gpe1-7, INPUT, NONE);
+
+		PIN_SLP(gpe2-0, INPUT, NONE);
+		PIN_SLP(gpe2-1, INPUT, NONE);
+		PIN_SLP(gpe2-2, INPUT, NONE);
+
+		PIN_SLP(gpk0-0, INPUT, DOWN);
+		PIN_SLP(gpk0-1, INPUT, DOWN);
+		PIN_SLP(gpk0-2, OUT0, NONE);
+		PIN_SLP(gpk0-3, INPUT, DOWN);
+		PIN_SLP(gpk0-4, INPUT, DOWN);
+		PIN_SLP(gpk0-5, INPUT, DOWN);
+		PIN_SLP(gpk0-6, INPUT, DOWN);
+		PIN_SLP(gpk0-7, INPUT, DOWN);
+
+		PIN_SLP(gpk1-0, INPUT, DOWN);
+		PIN_SLP(gpk1-1, INPUT, DOWN);
+		PIN_SLP(gpk1-2, INPUT, DOWN);
+		PIN_SLP(gpk1-3, INPUT, DOWN);
+		PIN_SLP(gpk1-4, INPUT, DOWN);
+		PIN_SLP(gpk1-5, INPUT, DOWN);
+		PIN_SLP(gpk1-6, INPUT, DOWN);
+
+		PIN_SLP(gpk2-0, INPUT, DOWN);
+		PIN_SLP(gpk2-1, INPUT, DOWN);
+		PIN_SLP(gpk2-2, INPUT, DOWN);
+		PIN_SLP(gpk2-3, INPUT, DOWN);
+		PIN_SLP(gpk2-4, INPUT, DOWN);
+		PIN_SLP(gpk2-5, INPUT, DOWN);
+		PIN_SLP(gpk2-6, INPUT, DOWN);
+
+		PIN_SLP(gpl0-0, INPUT, DOWN);
+		PIN_SLP(gpl0-1, INPUT, DOWN);
+		PIN_SLP(gpl0-2, INPUT, DOWN);
+		PIN_SLP(gpl0-3, INPUT, DOWN);
+
+		PIN_SLP(gpm0-0, INPUT, DOWN);
+		PIN_SLP(gpm0-1, INPUT, DOWN);
+		PIN_SLP(gpm0-2, INPUT, DOWN);
+		PIN_SLP(gpm0-3, INPUT, DOWN);
+		PIN_SLP(gpm0-4, INPUT, DOWN);
+		PIN_SLP(gpm0-5, INPUT, DOWN);
+		PIN_SLP(gpm0-6, INPUT, DOWN);
+		PIN_SLP(gpm0-7, INPUT, DOWN);
+
+		PIN_SLP(gpm1-0, INPUT, DOWN);
+		PIN_SLP(gpm1-1, INPUT, DOWN);
+		PIN_SLP(gpm1-2, INPUT, DOWN);
+		PIN_SLP(gpm1-3, INPUT, DOWN);
+		PIN_SLP(gpm1-4, INPUT, DOWN);
+		PIN_SLP(gpm1-5, INPUT, DOWN);
+		PIN_SLP(gpm1-6, INPUT, DOWN);
+
+		PIN_SLP(gpm2-0, INPUT, DOWN);
+		PIN_SLP(gpm2-1, INPUT, DOWN);
+		PIN_SLP(gpm2-2, INPUT, DOWN);
+		PIN_SLP(gpm2-3, INPUT, DOWN);
+		PIN_SLP(gpm2-4, INPUT, DOWN);
+
+		PIN_SLP(gpm3-0, INPUT, DOWN);
+		PIN_SLP(gpm3-1, INPUT, DOWN);
+		PIN_SLP(gpm3-2, INPUT, DOWN);
+		PIN_SLP(gpm3-3, INPUT, DOWN);
+		PIN_SLP(gpm3-4, INPUT, DOWN);
+		PIN_SLP(gpm3-5, INPUT, DOWN);
+		PIN_SLP(gpm3-6, INPUT, DOWN);
+		PIN_SLP(gpm3-7, INPUT, DOWN);
+
+		PIN_SLP(gpm4-0, INPUT, DOWN);
+		PIN_SLP(gpm4-1, INPUT, DOWN);
+		PIN_SLP(gpm4-2, INPUT, DOWN);
+		PIN_SLP(gpm4-3, INPUT, DOWN);
+		PIN_SLP(gpm4-4, INPUT, DOWN);
+		PIN_SLP(gpm4-5, INPUT, DOWN);
+		PIN_SLP(gpm4-6, INPUT, DOWN);
+		PIN_SLP(gpm4-7, INPUT, DOWN);
+	};
+};
-- 
1.8.5.5
