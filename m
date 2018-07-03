From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue,  3 Jul 2018 10:05:34 +0200
Subject: [PATCH] ARM: dts: ux500: Get rid of DTC warnings
Message-ID: <20180703080534.28397-1-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

By removing the reference to skeleton.dtsi, defining chosen {}
and proper memory nodes we get warning-free device trees for
the Ux500.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi      | 7 ++++++-
 arch/arm/boot/dts/ste-hrefprev60.dtsi  | 5 +++++
 arch/arm/boot/dts/ste-hrefv60plus.dtsi | 5 +++++
 arch/arm/boot/dts/ste-snowball.dts     | 1 +
 4 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 3dc0028e108b..a58ce6f68d7d 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -15,9 +15,14 @@
 #include <dt-bindings/arm/ux500_pm_domains.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/clock/ste-ab8500.h>
-#include "skeleton.dtsi"
 
 / {
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	chosen {
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/ste-hrefprev60.dtsi b/arch/arm/boot/dts/ste-hrefprev60.dtsi
index 3f14b4df69b4..594be14b14fa 100644
--- a/arch/arm/boot/dts/ste-hrefprev60.dtsi
+++ b/arch/arm/boot/dts/ste-hrefprev60.dtsi
@@ -16,6 +16,11 @@
 #include "ste-href.dtsi"
 
 / {
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
 	gpio_keys {
 		button at 1 {
 			gpios = <&tc3589x_gpio 7 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm/boot/dts/ste-hrefv60plus.dtsi b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
index bf259bbd1d0a..e5be8a94a03a 100644
--- a/arch/arm/boot/dts/ste-hrefv60plus.dtsi
+++ b/arch/arm/boot/dts/ste-hrefv60plus.dtsi
@@ -17,6 +17,11 @@
 	model = "ST-Ericsson HREF (v60+) platform with Device Tree";
 	compatible = "st-ericsson,hrefv60+", "st-ericsson,u8500";
 
+	memory {
+		device_type = "memory";
+		reg = <0x00000000 0x20000000>;
+	};
+
 	soc {
 		/* Name the GPIO muxed rails on the HREF boards */
 		gpio at 8012e000 {
diff --git a/arch/arm/boot/dts/ste-snowball.dts b/arch/arm/boot/dts/ste-snowball.dts
index b0b94d053098..8fa025251dc6 100644
--- a/arch/arm/boot/dts/ste-snowball.dts
+++ b/arch/arm/boot/dts/ste-snowball.dts
@@ -26,6 +26,7 @@
 	};
 
 	memory {
+		device_type = "memory";
 		reg = <0x00000000 0x20000000>;
 	};
 
-- 
2.17.0
