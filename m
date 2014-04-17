From: festevam@gmail.com (Fabio Estevam)
Date: Thu, 17 Apr 2014 09:42:41 -0300
Subject: [PATCH 2/2] ARM: dts: imx27-pdk: Add keypad support
In-Reply-To: <1397738561-3335-1-git-send-email-festevam@gmail.com>
References: <1397738561-3335-1-git-send-email-festevam@gmail.com>
Message-ID: <1397738561-3335-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/boot/dts/imx27-pdk.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/imx27-pdk.dts b/arch/arm/boot/dts/imx27-pdk.dts
index c629a8c..2b7b24f 100644
--- a/arch/arm/boot/dts/imx27-pdk.dts
+++ b/arch/arm/boot/dts/imx27-pdk.dts
@@ -10,6 +10,7 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
 #include "imx27.dtsi"
 
 / {
@@ -84,6 +85,21 @@
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
 	status = "okay";
 	nand-ecc-mode = "hw";
-- 
1.8.3.2
