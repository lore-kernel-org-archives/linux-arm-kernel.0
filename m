From: andi.shyti@samsung.com (Andi Shyti)
Date: Thu, 29 Dec 2016 17:42:10 +0900
Subject: [PATCH 3/4] ARM64: dts: TM2: comply to the samsung pinctrl naming
 convention
In-Reply-To: <20161229084211.20442-1-andi.shyti@samsung.com>
References: <20161229084211.20442-1-andi.shyti@samsung.com>
 <CGME20161229084222epcas1p4c0db2fd327fc92bfe123442f44b88ab5@epcas1p4.samsung.com>
Message-ID: <20161229084211.20442-4-andi.shyti@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Change the PIN() macro definition so that it can use the macros
from pinctrl/samsung.h header file.

Signed-off-by: Andi Shyti <andi.shyti@samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi |  12 +-
 arch/arm64/boot/dts/exynos/exynos5433-tm2.dts      | 254 ++++++++++-----------
 2 files changed, 133 insertions(+), 133 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
index 36da7dce409a..9afed9fcf7e1 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-pinctrl.dtsi
@@ -27,12 +27,12 @@
 #define PIN_OUT			1
 #define PIN_FUNC1		2
 
-#define PIN(_func, _pin, _pull, _drv)			\
-	_pin {						\
-		samsung,pins = #_pin;			\
-		samsung,pin-function = <PIN_ ##_func>;	\
-		samsung,pin-pud = <PIN_PULL_ ##_pull>;	\
-		samsung,pin-drv = <PIN_DRV_ ##_drv>;	\
+#define PIN(_func, _pin, _pull, _drv)					\
+	_pin {								\
+		samsung,pins = #_pin;					\
+		samsung,pin-function = <EXYNOS_PIN_FUNC_ ##_func>;	\
+		samsung,pin-pud = <EXYNOS_PIN_PULL_ ##_pull>;		\
+		samsung,pin-drv = <EXYNOS5433_PIN_DRV_ ##_drv>;		\
 	}
 
 &pinctrl_alive {
diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
index f21bdc2ff834..a2bc8e48eca4 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tm2.dts
@@ -742,77 +742,77 @@
 	pinctrl-0 = <&initial_alive>;
 
 	initial_alive: initial-state {
-		PIN(IN, gpa0-0, DOWN, LV1);
-		PIN(IN, gpa0-1, NONE, LV1);
-		PIN(IN, gpa0-2, DOWN, LV1);
-		PIN(IN, gpa0-3, NONE, LV1);
-		PIN(IN, gpa0-4, NONE, LV1);
-		PIN(IN, gpa0-5, DOWN, LV1);
-		PIN(IN, gpa0-6, NONE, LV1);
-		PIN(IN, gpa0-7, NONE, LV1);
-
-		PIN(IN, gpa1-0, UP, LV1);
-		PIN(IN, gpa1-1, NONE, LV1);
-		PIN(IN, gpa1-2, NONE, LV1);
-		PIN(IN, gpa1-3, DOWN, LV1);
-		PIN(IN, gpa1-4, DOWN, LV1);
-		PIN(IN, gpa1-5, NONE, LV1);
-		PIN(IN, gpa1-6, NONE, LV1);
-		PIN(IN, gpa1-7, NONE, LV1);
-
-		PIN(IN, gpa2-0, NONE, LV1);
-		PIN(IN, gpa2-1, NONE, LV1);
-		PIN(IN, gpa2-2, NONE, LV1);
-		PIN(IN, gpa2-3, DOWN, LV1);
-		PIN(IN, gpa2-4, NONE, LV1);
-		PIN(IN, gpa2-5, DOWN, LV1);
-		PIN(IN, gpa2-6, DOWN, LV1);
-		PIN(IN, gpa2-7, NONE, LV1);
-
-		PIN(IN, gpa3-0, DOWN, LV1);
-		PIN(IN, gpa3-1, DOWN, LV1);
-		PIN(IN, gpa3-2, NONE, LV1);
-		PIN(IN, gpa3-3, DOWN, LV1);
-		PIN(IN, gpa3-4, NONE, LV1);
-		PIN(IN, gpa3-5, DOWN, LV1);
-		PIN(IN, gpa3-6, DOWN, LV1);
-		PIN(IN, gpa3-7, DOWN, LV1);
-
-		PIN(IN, gpf1-0, NONE, LV1);
-		PIN(IN, gpf1-1, NONE, LV1);
-		PIN(IN, gpf1-2, DOWN, LV1);
-		PIN(IN, gpf1-4, UP, LV1);
-		PIN(OUT, gpf1-5, NONE, LV1);
-		PIN(IN, gpf1-6, DOWN, LV1);
-		PIN(IN, gpf1-7, DOWN, LV1);
-
-		PIN(IN, gpf2-0, DOWN, LV1);
-		PIN(IN, gpf2-1, DOWN, LV1);
-		PIN(IN, gpf2-2, DOWN, LV1);
-		PIN(IN, gpf2-3, DOWN, LV1);
-
-		PIN(IN, gpf3-0, DOWN, LV1);
-		PIN(IN, gpf3-1, DOWN, LV1);
-		PIN(IN, gpf3-2, NONE, LV1);
-		PIN(IN, gpf3-3, DOWN, LV1);
-
-		PIN(IN, gpf4-0, DOWN, LV1);
-		PIN(IN, gpf4-1, DOWN, LV1);
-		PIN(IN, gpf4-2, DOWN, LV1);
-		PIN(IN, gpf4-3, DOWN, LV1);
-		PIN(IN, gpf4-4, DOWN, LV1);
-		PIN(IN, gpf4-5, DOWN, LV1);
-		PIN(IN, gpf4-6, DOWN, LV1);
-		PIN(IN, gpf4-7, DOWN, LV1);
-
-		PIN(IN, gpf5-0, DOWN, LV1);
-		PIN(IN, gpf5-1, DOWN, LV1);
-		PIN(IN, gpf5-2, DOWN, LV1);
-		PIN(IN, gpf5-3, DOWN, LV1);
-		PIN(OUT, gpf5-4, NONE, LV1);
-		PIN(IN, gpf5-5, DOWN, LV1);
-		PIN(IN, gpf5-6, DOWN, LV1);
-		PIN(IN, gpf5-7, DOWN, LV1);
+		PIN(INPUT, gpa0-0, DOWN, LV1);
+		PIN(INPUT, gpa0-1, NONE, LV1);
+		PIN(INPUT, gpa0-2, DOWN, LV1);
+		PIN(INPUT, gpa0-3, NONE, LV1);
+		PIN(INPUT, gpa0-4, NONE, LV1);
+		PIN(INPUT, gpa0-5, DOWN, LV1);
+		PIN(INPUT, gpa0-6, NONE, LV1);
+		PIN(INPUT, gpa0-7, NONE, LV1);
+
+		PIN(INPUT, gpa1-0, UP, LV1);
+		PIN(INPUT, gpa1-1, NONE, LV1);
+		PIN(INPUT, gpa1-2, NONE, LV1);
+		PIN(INPUT, gpa1-3, DOWN, LV1);
+		PIN(INPUT, gpa1-4, DOWN, LV1);
+		PIN(INPUT, gpa1-5, NONE, LV1);
+		PIN(INPUT, gpa1-6, NONE, LV1);
+		PIN(INPUT, gpa1-7, NONE, LV1);
+
+		PIN(INPUT, gpa2-0, NONE, LV1);
+		PIN(INPUT, gpa2-1, NONE, LV1);
+		PIN(INPUT, gpa2-2, NONE, LV1);
+		PIN(INPUT, gpa2-3, DOWN, LV1);
+		PIN(INPUT, gpa2-4, NONE, LV1);
+		PIN(INPUT, gpa2-5, DOWN, LV1);
+		PIN(INPUT, gpa2-6, DOWN, LV1);
+		PIN(INPUT, gpa2-7, NONE, LV1);
+
+		PIN(INPUT, gpa3-0, DOWN, LV1);
+		PIN(INPUT, gpa3-1, DOWN, LV1);
+		PIN(INPUT, gpa3-2, NONE, LV1);
+		PIN(INPUT, gpa3-3, DOWN, LV1);
+		PIN(INPUT, gpa3-4, NONE, LV1);
+		PIN(INPUT, gpa3-5, DOWN, LV1);
+		PIN(INPUT, gpa3-6, DOWN, LV1);
+		PIN(INPUT, gpa3-7, DOWN, LV1);
+
+		PIN(INPUT, gpf1-0, NONE, LV1);
+		PIN(INPUT, gpf1-1, NONE, LV1);
+		PIN(INPUT, gpf1-2, DOWN, LV1);
+		PIN(INPUT, gpf1-4, UP, LV1);
+		PIN(OUTPUT, gpf1-5, NONE, LV1);
+		PIN(INPUT, gpf1-6, DOWN, LV1);
+		PIN(INPUT, gpf1-7, DOWN, LV1);
+
+		PIN(INPUT, gpf2-0, DOWN, LV1);
+		PIN(INPUT, gpf2-1, DOWN, LV1);
+		PIN(INPUT, gpf2-2, DOWN, LV1);
+		PIN(INPUT, gpf2-3, DOWN, LV1);
+
+		PIN(INPUT, gpf3-0, DOWN, LV1);
+		PIN(INPUT, gpf3-1, DOWN, LV1);
+		PIN(INPUT, gpf3-2, NONE, LV1);
+		PIN(INPUT, gpf3-3, DOWN, LV1);
+
+		PIN(INPUT, gpf4-0, DOWN, LV1);
+		PIN(INPUT, gpf4-1, DOWN, LV1);
+		PIN(INPUT, gpf4-2, DOWN, LV1);
+		PIN(INPUT, gpf4-3, DOWN, LV1);
+		PIN(INPUT, gpf4-4, DOWN, LV1);
+		PIN(INPUT, gpf4-5, DOWN, LV1);
+		PIN(INPUT, gpf4-6, DOWN, LV1);
+		PIN(INPUT, gpf4-7, DOWN, LV1);
+
+		PIN(INPUT, gpf5-0, DOWN, LV1);
+		PIN(INPUT, gpf5-1, DOWN, LV1);
+		PIN(INPUT, gpf5-2, DOWN, LV1);
+		PIN(INPUT, gpf5-3, DOWN, LV1);
+		PIN(OUTPUT, gpf5-4, NONE, LV1);
+		PIN(INPUT, gpf5-5, DOWN, LV1);
+		PIN(INPUT, gpf5-6, DOWN, LV1);
+		PIN(INPUT, gpf5-7, DOWN, LV1);
 	};
 
 	te_irq: te_irq {
@@ -826,8 +826,8 @@
 	pinctrl-0 = <&initial_cpif>;
 
 	initial_cpif: initial-state {
-		PIN(IN, gpv6-0, DOWN, LV1);
-		PIN(IN, gpv6-1, DOWN, LV1);
+		PIN(INPUT, gpv6-0, DOWN, LV1);
+		PIN(INPUT, gpv6-1, DOWN, LV1);
 	};
 };
 
@@ -836,9 +836,9 @@
 	pinctrl-0 = <&initial_ese>;
 
 	initial_ese: initial-state {
-		PIN(IN, gpj2-0, DOWN, LV1);
-		PIN(IN, gpj2-1, DOWN, LV1);
-		PIN(IN, gpj2-2, DOWN, LV1);
+		PIN(INPUT, gpj2-0, DOWN, LV1);
+		PIN(INPUT, gpj2-1, DOWN, LV1);
+		PIN(INPUT, gpj2-2, DOWN, LV1);
 	};
 };
 
@@ -847,11 +847,11 @@
 	pinctrl-0 = <&initial_fsys>;
 
 	initial_fsys: initial-state {
-		PIN(IN, gpr3-0, NONE, LV1);
-		PIN(IN, gpr3-1, DOWN, LV1);
-		PIN(IN, gpr3-2, DOWN, LV1);
-		PIN(IN, gpr3-3, DOWN, LV1);
-		PIN(IN, gpr3-7, NONE, LV1);
+		PIN(INPUT, gpr3-0, NONE, LV1);
+		PIN(INPUT, gpr3-1, DOWN, LV1);
+		PIN(INPUT, gpr3-2, DOWN, LV1);
+		PIN(INPUT, gpr3-3, DOWN, LV1);
+		PIN(INPUT, gpr3-7, NONE, LV1);
 	};
 };
 
@@ -860,14 +860,14 @@
 	pinctrl-0 = <&initial_imem>;
 
 	initial_imem: initial-state {
-		PIN(IN, gpf0-0, UP, LV1);
-		PIN(IN, gpf0-1, UP, LV1);
-		PIN(IN, gpf0-2, DOWN, LV1);
-		PIN(IN, gpf0-3, UP, LV1);
-		PIN(IN, gpf0-4, DOWN, LV1);
-		PIN(IN, gpf0-5, NONE, LV1);
-		PIN(IN, gpf0-6, DOWN, LV1);
-		PIN(IN, gpf0-7, UP, LV1);
+		PIN(INPUT, gpf0-0, UP, LV1);
+		PIN(INPUT, gpf0-1, UP, LV1);
+		PIN(INPUT, gpf0-2, DOWN, LV1);
+		PIN(INPUT, gpf0-3, UP, LV1);
+		PIN(INPUT, gpf0-4, DOWN, LV1);
+		PIN(INPUT, gpf0-5, NONE, LV1);
+		PIN(INPUT, gpf0-6, DOWN, LV1);
+		PIN(INPUT, gpf0-7, UP, LV1);
 	};
 };
 
@@ -876,7 +876,7 @@
 	pinctrl-0 = <&initial_nfc>;
 
 	initial_nfc: initial-state {
-		PIN(IN, gpj0-2, DOWN, LV1);
+		PIN(INPUT, gpj0-2, DOWN, LV1);
 	};
 };
 
@@ -885,54 +885,54 @@
 	pinctrl-0 = <&initial_peric>;
 
 	initial_peric: initial-state {
-		PIN(IN, gpv7-0, DOWN, LV1);
-		PIN(IN, gpv7-1, DOWN, LV1);
-		PIN(IN, gpv7-2, NONE, LV1);
-		PIN(IN, gpv7-3, DOWN, LV1);
-		PIN(IN, gpv7-4, DOWN, LV1);
-		PIN(IN, gpv7-5, DOWN, LV1);
+		PIN(INPUT, gpv7-0, DOWN, LV1);
+		PIN(INPUT, gpv7-1, DOWN, LV1);
+		PIN(INPUT, gpv7-2, NONE, LV1);
+		PIN(INPUT, gpv7-3, DOWN, LV1);
+		PIN(INPUT, gpv7-4, DOWN, LV1);
+		PIN(INPUT, gpv7-5, DOWN, LV1);
 
-		PIN(IN, gpb0-4, DOWN, LV1);
+		PIN(INPUT, gpb0-4, DOWN, LV1);
 
-		PIN(IN, gpc0-2, DOWN, LV1);
-		PIN(IN, gpc0-5, DOWN, LV1);
-		PIN(IN, gpc0-7, DOWN, LV1);
+		PIN(INPUT, gpc0-2, DOWN, LV1);
+		PIN(INPUT, gpc0-5, DOWN, LV1);
+		PIN(INPUT, gpc0-7, DOWN, LV1);
 
-		PIN(IN, gpc1-1, DOWN, LV1);
+		PIN(INPUT, gpc1-1, DOWN, LV1);
 
-		PIN(IN, gpc3-4, NONE, LV1);
-		PIN(IN, gpc3-5, NONE, LV1);
-		PIN(IN, gpc3-6, NONE, LV1);
-		PIN(IN, gpc3-7, NONE, LV1);
+		PIN(INPUT, gpc3-4, NONE, LV1);
+		PIN(INPUT, gpc3-5, NONE, LV1);
+		PIN(INPUT, gpc3-6, NONE, LV1);
+		PIN(INPUT, gpc3-7, NONE, LV1);
 
-		PIN(OUT, gpg0-0, NONE, LV1);
-		PIN(FUNC1, gpg0-1, DOWN, LV1);
+		PIN(OUTPUT, gpg0-0, NONE, LV1);
+		PIN(2, gpg0-1, DOWN, LV1);
 
-		PIN(IN, gpd2-5, DOWN, LV1);
+		PIN(INPUT, gpd2-5, DOWN, LV1);
 
-		PIN(IN, gpd4-0, NONE, LV1);
-		PIN(IN, gpd4-1, DOWN, LV1);
-		PIN(IN, gpd4-2, DOWN, LV1);
-		PIN(IN, gpd4-3, DOWN, LV1);
-		PIN(IN, gpd4-4, DOWN, LV1);
+		PIN(INPUT, gpd4-0, NONE, LV1);
+		PIN(INPUT, gpd4-1, DOWN, LV1);
+		PIN(INPUT, gpd4-2, DOWN, LV1);
+		PIN(INPUT, gpd4-3, DOWN, LV1);
+		PIN(INPUT, gpd4-4, DOWN, LV1);
 
-		PIN(IN, gpd6-3, DOWN, LV1);
+		PIN(INPUT, gpd6-3, DOWN, LV1);
 
-		PIN(IN, gpd8-1, UP, LV1);
+		PIN(INPUT, gpd8-1, UP, LV1);
 
-		PIN(IN, gpg1-0, DOWN, LV1);
-		PIN(IN, gpg1-1, DOWN, LV1);
-		PIN(IN, gpg1-2, DOWN, LV1);
-		PIN(IN, gpg1-3, DOWN, LV1);
-		PIN(IN, gpg1-4, DOWN, LV1);
+		PIN(INPUT, gpg1-0, DOWN, LV1);
+		PIN(INPUT, gpg1-1, DOWN, LV1);
+		PIN(INPUT, gpg1-2, DOWN, LV1);
+		PIN(INPUT, gpg1-3, DOWN, LV1);
+		PIN(INPUT, gpg1-4, DOWN, LV1);
 
-		PIN(IN, gpg2-0, DOWN, LV1);
-		PIN(IN, gpg2-1, DOWN, LV1);
+		PIN(INPUT, gpg2-0, DOWN, LV1);
+		PIN(INPUT, gpg2-1, DOWN, LV1);
 
-		PIN(IN, gpg3-0, DOWN, LV1);
-		PIN(IN, gpg3-1, DOWN, LV1);
-		PIN(IN, gpg3-5, DOWN, LV1);
-		PIN(IN, gpg3-7, DOWN, LV1);
+		PIN(INPUT, gpg3-0, DOWN, LV1);
+		PIN(INPUT, gpg3-1, DOWN, LV1);
+		PIN(INPUT, gpg3-5, DOWN, LV1);
+		PIN(INPUT, gpg3-7, DOWN, LV1);
 	};
 };
 
@@ -941,7 +941,7 @@
 	pinctrl-0 = <&initial_touch>;
 
 	initial_touch: initial-state {
-		PIN(IN, gpj1-2, DOWN, LV1);
+		PIN(INPUT, gpj1-2, DOWN, LV1);
 	};
 };
 
-- 
2.11.0
