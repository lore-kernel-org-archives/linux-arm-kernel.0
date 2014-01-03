From: festevam@gmail.com (Fabio Estevam)
Date: Fri,  3 Jan 2014 09:55:56 -0200
Subject: [PATCH] ARM: imx: Explicitly pass the active level of the PHY reset
Message-ID: <1388750156-23208-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Since commit 7a399e3a2e (fec: Do not assume that PHY reset is active low), we no
longer assume that the PHY reset is active low.

Now we need to retrieve this information from the device tree instead.

Passing '0' as the phy-reset-gpios means 'active high' according to the 
definition from include/dt-bindings/gpio/gpio.h:

#define GPIO_ACTIVE_HIGH 0
#define GPIO_ACTIVE_LOW 1

, so in order to keep things working as before we need to explicitly pass
GPIO_ACTIVE_LOW as the flag.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Olof,

This is needed for 3.13 as 7a399e3a2e (fec: Do not assume that PHY reset is 
active low) has already reached mainline.

This patch was generated against linus' tree.

 arch/arm/boot/dts/imx27-phytec-phycore-som.dts | 2 +-
 arch/arm/boot/dts/imx27.dtsi                   | 1 +
 arch/arm/boot/dts/imx28-apf28.dts              | 2 +-
 arch/arm/boot/dts/imx28-apf28dev.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10037.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10049.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10057.dts           | 2 +-
 arch/arm/boot/dts/imx28-cfa10058.dts           | 2 +-
 arch/arm/boot/dts/imx28-evk.dts                | 2 +-
 arch/arm/boot/dts/imx28-m28cu3.dts             | 2 +-
 arch/arm/boot/dts/imx28.dtsi                   | 1 +
 arch/arm/boot/dts/imx51-apf51.dts              | 2 +-
 arch/arm/boot/dts/imx51.dtsi                   | 1 +
 arch/arm/boot/dts/imx53-evk.dts                | 2 +-
 arch/arm/boot/dts/imx53-mba53.dts              | 2 +-
 arch/arm/boot/dts/imx53-qsb.dts                | 2 +-
 arch/arm/boot/dts/imx53-smd.dts                | 2 +-
 arch/arm/boot/dts/imx53.dtsi                   | 1 +
 arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi     | 2 +-
 arch/arm/boot/dts/imx6q-sabrelite.dts          | 2 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi         | 2 +-
 arch/arm/boot/dts/imx6qdl-wandboard.dtsi       | 2 +-
 arch/arm/boot/dts/imx6qdl.dtsi                 | 1 +
 23 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
index 4ec402c..49b5e67 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-som.dts
@@ -134,7 +134,7 @@
 };
 
 &fec {
-	phy-reset-gpios = <&gpio3 30 0>;
+	phy-reset-gpios = <&gpio3 30 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index 826231e..5708e42 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
diff --git a/arch/arm/boot/dts/imx28-apf28.dts b/arch/arm/boot/dts/imx28-apf28.dts
index 7198fe3..070e59c 100644
--- a/arch/arm/boot/dts/imx28-apf28.dts
+++ b/arch/arm/boot/dts/imx28-apf28.dts
@@ -78,7 +78,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx28-apf28dev.dts b/arch/arm/boot/dts/imx28-apf28dev.dts
index e2efd8d..f47a30a 100644
--- a/arch/arm/boot/dts/imx28-apf28dev.dts
+++ b/arch/arm/boot/dts/imx28-apf28dev.dts
@@ -143,7 +143,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac1_pins_a>;
-			phy-reset-gpios = <&gpio0 23 0>;
+			phy-reset-gpios = <&gpio0 23 GPIO_ACTIVE_LOW>;
 			status = "okay";
 		};
 	};
diff --git a/arch/arm/boot/dts/imx28-cfa10037.dts b/arch/arm/boot/dts/imx28-cfa10037.dts
index f93e9a7..b2bbd21 100644
--- a/arch/arm/boot/dts/imx28-cfa10037.dts
+++ b/arch/arm/boot/dts/imx28-cfa10037.dts
@@ -64,7 +64,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a
 				&mac0_pins_cfa10037>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10049.dts b/arch/arm/boot/dts/imx28-cfa10049.dts
index 7087b4b..f57b245 100644
--- a/arch/arm/boot/dts/imx28-cfa10049.dts
+++ b/arch/arm/boot/dts/imx28-cfa10049.dts
@@ -300,7 +300,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a
 				&mac0_pins_cfa10049>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10057.dts b/arch/arm/boot/dts/imx28-cfa10057.dts
index 3c13128..fb6c6e7 100644
--- a/arch/arm/boot/dts/imx28-cfa10057.dts
+++ b/arch/arm/boot/dts/imx28-cfa10057.dts
@@ -159,7 +159,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-cfa10058.dts b/arch/arm/boot/dts/imx28-cfa10058.dts
index 2469d34..ba0a625 100644
--- a/arch/arm/boot/dts/imx28-cfa10058.dts
+++ b/arch/arm/boot/dts/imx28-cfa10058.dts
@@ -126,7 +126,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio2 21 0>;
+			phy-reset-gpios = <&gpio2 21 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-evk.dts b/arch/arm/boot/dts/imx28-evk.dts
index 4267c2b..fef39a4 100644
--- a/arch/arm/boot/dts/imx28-evk.dts
+++ b/arch/arm/boot/dts/imx28-evk.dts
@@ -263,7 +263,7 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
 			phy-supply = <&reg_fec_3v3>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28-m28cu3.dts b/arch/arm/boot/dts/imx28-m28cu3.dts
index d3958da..82cb4f8 100644
--- a/arch/arm/boot/dts/imx28-m28cu3.dts
+++ b/arch/arm/boot/dts/imx28-m28cu3.dts
@@ -189,7 +189,7 @@
 			phy-mode = "rmii";
 			pinctrl-names = "default";
 			pinctrl-0 = <&mac0_pins_a>;
-			phy-reset-gpios = <&gpio4 13 0>;
+			phy-reset-gpios = <&gpio4 13 GPIO_ACTIVE_LOW>;
 			phy-reset-duration = <100>;
 			status = "okay";
 		};
diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index cda19c8..48529cb 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -9,6 +9,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 #include "imx28-pinfunc.h"
 
diff --git a/arch/arm/boot/dts/imx51-apf51.dts b/arch/arm/boot/dts/imx51-apf51.dts
index b360699..3eae080 100644
--- a/arch/arm/boot/dts/imx51-apf51.dts
+++ b/arch/arm/boot/dts/imx51-apf51.dts
@@ -36,7 +36,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec_2>;
 	phy-mode = "mii";
-	phy-reset-gpios = <&gpio3 0 0>;
+	phy-reset-gpios = <&gpio3 0 GPIO_ACTIVE_LOW>;
 	phy-reset-duration = <1>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 4bcdd3a..f1ab0e2 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 #include "imx51-pinfunc.h"
 
diff --git a/arch/arm/boot/dts/imx53-evk.dts b/arch/arm/boot/dts/imx53-evk.dts
index 801fda7..5ee3d7d 100644
--- a/arch/arm/boot/dts/imx53-evk.dts
+++ b/arch/arm/boot/dts/imx53-evk.dts
@@ -121,6 +121,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec_1>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index a630902..d57e43e 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -175,7 +175,7 @@
 };
 
 &fec {
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-qsb.dts b/arch/arm/boot/dts/imx53-qsb.dts
index 91a5935..3e655e9 100644
--- a/arch/arm/boot/dts/imx53-qsb.dts
+++ b/arch/arm/boot/dts/imx53-qsb.dts
@@ -303,7 +303,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec_1>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx53-smd.dts b/arch/arm/boot/dts/imx53-smd.dts
index a9b6e10..91dc916 100644
--- a/arch/arm/boot/dts/imx53-smd.dts
+++ b/arch/arm/boot/dts/imx53-smd.dts
@@ -177,6 +177,6 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_fec_1>;
 	phy-mode = "rmii";
-	phy-reset-gpios = <&gpio7 6 0>;
+	phy-reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 4307e80..abf1101 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 #include "imx53-pinfunc.h"
 
diff --git a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
index 1a3b50d..3e28d13 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6q-phytec-pfla02.dtsi
@@ -152,7 +152,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_3>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 0>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	status = "disabled";
 };
 
diff --git a/arch/arm/boot/dts/imx6q-sabrelite.dts b/arch/arm/boot/dts/imx6q-sabrelite.dts
index f004913..e44a69b 100644
--- a/arch/arm/boot/dts/imx6q-sabrelite.dts
+++ b/arch/arm/boot/dts/imx6q-sabrelite.dts
@@ -89,7 +89,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 23 0>;
+	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index e75e11b..b4a4de5 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -116,7 +116,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio1 25 0>;
+	phy-reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
index 35f5479..773504c 100644
--- a/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-wandboard.dtsi
@@ -98,7 +98,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet_1>;
 	phy-mode = "rgmii";
-	phy-reset-gpios = <&gpio3 29 0>;
+	phy-reset-gpios = <&gpio3 29 GPIO_ACTIVE_LOW>;
 	status = "okay";
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index fb28b2e..681b07e 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -10,6 +10,7 @@
  * http://www.gnu.org/copyleft/gpl.html
  */
 
+#include <dt-bindings/gpio/gpio.h>
 #include "skeleton.dtsi"
 
 / {
-- 
1.8.1.2
