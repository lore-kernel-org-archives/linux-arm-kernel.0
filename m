From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sun,  4 Sep 2016 13:04:19 +0200
Subject: [PATCH v3 16/17] ARM: dts: s3c2416: Use macros for pinctrl
 configuration
In-Reply-To: <1472987060-28293-1-git-send-email-krzk@kernel.org>
References: <1472987060-28293-1-git-send-email-krzk@kernel.org>
Message-ID: <1472987060-28293-17-git-send-email-krzk@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Usage of DTS macros instead of hard-coded numbers makes code easier
to read.  One does not have to remember which value means pull-up/down
or specific driver strength.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>
---
 arch/arm/boot/dts/s3c2416-pinctrl.dtsi | 38 ++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
index 527e3193817f..6274359fb323 100644
--- a/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/s3c2416-pinctrl.dtsi
@@ -8,6 +8,8 @@
  * published by the Free Software Foundation.
  */
 
+#include <dt-bindings/pinctrl/samsung.h>
+
 &pinctrl_0 {
 	/*
 	 * Pin banks
@@ -83,91 +85,91 @@
 
 	uart0_data: uart0-data {
 		samsung,pins = "gph-0", "gph-1";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	uart0_fctl: uart0-fctl {
 		samsung,pins = "gph-8", "gph-9";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	uart1_data: uart1-data {
 		samsung,pins = "gph-2", "gph-3";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	uart1_fctl: uart1-fctl {
 		samsung,pins = "gph-10", "gph-11";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	uart2_data: uart2-data {
 		samsung,pins = "gph-4", "gph-5";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	uart2_fctl: uart2-fctl {
 		samsung,pins = "gph-6", "gph-7";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	uart3_data: uart3-data {
 		samsung,pins = "gph-6", "gph-7";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	extuart_clk: extuart-clk {
 		samsung,pins = "gph-12";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	i2c0_bus: i2c0-bus {
 		samsung,pins = "gpe-14", "gpe-15";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	spi0_bus: spi0-bus {
 		samsung,pins = "gpe-11", "gpe-12", "gpe-13";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd0_clk: sd0-clk {
 		samsung,pins = "gpe-5";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd0_cmd: sd0-cmd {
 		samsung,pins = "gpe-6";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd0_bus1: sd0-bus1 {
 		samsung,pins = "gpe-7";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd0_bus4: sd0-bus4 {
 		samsung,pins = "gpe-8", "gpe-9", "gpe-10";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd1_cmd: sd1-cmd {
 		samsung,pins = "gpl-8";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd1_clk: sd1-clk {
 		samsung,pins = "gpl-9";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd1_bus1: sd1-bus1 {
 		samsung,pins = "gpl-0";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 
 	sd1_bus4: sd1-bus4 {
 		samsung,pins = "gpl-1", "gpl-2", "gpl-3";
-		samsung,pin-function = <2>;
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
 	};
 };
-- 
2.7.4
