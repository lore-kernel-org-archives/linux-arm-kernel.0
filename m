From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:05 +0200
Subject: [PATCH v3 02/17] pinctrl: dt-bindings: samsung: Update documentation
 with new macros
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-3-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Update examples in Samsung pinctrl dt-bindings with new macros coming
from header file.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

Changes since v1:
1. Add Javier's reviewed-by.
2. Include necessary header in example (pointed by Javier).
---
 .../bindings/pinctrl/samsung-pinctrl.txt           | 44 +++++++++++-----------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 6db16b90873a..d49e22d2a8b5 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -229,6 +229,8 @@ Example: A pin-controller node with pin banks:
 
 Example 1: A pin-controller node with pin groups.
 
+	#include <dt-bindings/pinctrl/samsung.h>
+
 	pinctrl_0: pinctrl at 11400000 {
 		compatible = "samsung,exynos4210-pinctrl";
 		reg = <0x11400000 0x1000>;
@@ -238,53 +240,53 @@ Example 1: A pin-controller node with pin groups.
 
 		uart0_data: uart0-data {
 			samsung,pins = "gpa0-0", "gpa0-1";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+			samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+			samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 		};
 
 		uart0_fctl: uart0-fctl {
 			samsung,pins = "gpa0-2", "gpa0-3";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+			samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+			samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 		};
 
 		uart1_data: uart1-data {
 			samsung,pins = "gpa0-4", "gpa0-5";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+			samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+			samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 		};
 
 		uart1_fctl: uart1-fctl {
 			samsung,pins = "gpa0-6", "gpa0-7";
-			samsung,pin-function = <2>;
-			samsung,pin-pud = <0>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+			samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+			samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 		};
 
 		i2c2_bus: i2c2-bus {
 			samsung,pins = "gpa0-6", "gpa0-7";
-			samsung,pin-function = <3>;
-			samsung,pin-pud = <3>;
-			samsung,pin-drv = <0>;
+			samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+			samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+			samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
 		};
 
 		sd4_bus8: sd4-bus-width8 {
 			part-1 {
 				samsung,pins = "gpk0-3", "gpk0-4",
 						"gpk0-5", "gpk0-6";
-				samsung,pin-function = <3>;
-				samsung,pin-pud = <3>;
-				samsung,pin-drv = <3>;
+				samsung,pin-function = <EXYNOS_PIN_FUNC_3>;
+				samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+				samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 			};
 			part-2 {
 				samsung,pins = "gpk1-3", "gpk1-4",
 						"gpk1-5", "gpk1-6";
-				samsung,pin-function = <4>;
-				samsung,pin-pud = <4>;
-				samsung,pin-drv = <3>;
+				samsung,pin-function = <EXYNOS_PIN_FUNC_4>;
+				samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+				samsung,pin-drv = <EXYNOS4_PIN_DRV_LV4>;
 			};
 		};
 	};
-- 
2.7.4
