From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Apr 2014 15:23:31 -0300
Subject: [PATCH v2 2/2] ARM: dts: imx27-pdk: Add keypad support
In-Reply-To: <1397759011-6717-1-git-send-email-festevam@gmail.com>
References: <1397759011-6717-1-git-send-email-festevam@gmail.com>
Message-ID: <1397759011-6717-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- Add the input header into imx27.dtsi

 arch/arm/boot/dts/imx27-pdk.dts | 15 +++++++++++++++
 arch/arm/boot/dts/imx27.dtsi    |  1 +
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index 042d7ff..764cf79 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -84,6 +84,21 @@
 	status = "okay";
 };
 
+&kpp {
+	linux,keymap = <
+		MATRIX_KEY(0, 0, KEY_UP)
+		MATRIX_KEY(0, 1, KEY_DOWN)
+		MATRIX_KEY(1, 0, KEY_RIGHT)
+		MATRIX_KEY(1, 1, KEY_LEFT)
+		MATRIX_KEY(1, 2, KEY_ENTER)
+		MATRIX_KEY(2, 0, KEY_F6)
+		MATRIX_KEY(2, 1, KEY_F8)
+		MATRIX_KEY(2, 2, KEY_F9)
+		MATRIX_KEY(2, 3, KEY_F10)
+	>;
+	status = "okay";
+};
+
 &nfc {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_nand>;
diff --git a/arch/arm/boot/dts/imx27.dtsi b/arch/arm/boot/dts/imx27.dtsi
index b2c103e..a75555c 100644
--- a/arch/arm/boot/dts/imx27.dtsi
+++ b/arch/arm/boot/dts/imx27.dtsi
@@ -11,6 +11,7 @@
 
 #include "skeleton.dtsi"
 #include "imx27-pinfunc.h"
+#include <dt-bindings/input/input.h>
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/gpio/gpio.h>
 
-- 
1.8.3.2
