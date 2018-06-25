From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 25 Jun 2018 23:09:32 +0300
Subject: [PATCH] ARM: dts: imx: Add missing chosen/stdout-path
Message-ID: <75f7fb96d53404152e742d405e2a14c5aa0f4438.1529957171.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to enable earlycon for debugging by just passing
an empty "earlycon" argument on the kernel command-line.

Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi | 4 ++++
 arch/arm/boot/dts/imx6sl-evk.dts         | 4 ++++
 arch/arm/boot/dts/imx6sll-evk.dts        | 4 ++++
 arch/arm/boot/dts/imx7d-sdb.dts          | 4 ++++
 4 files changed, 16 insertions(+)

This patch adds stdout-path to some of the basic imx6 evaluation boards
which were missing this property.

Patch against shawnguo/imx/dt because it also touches the newly-added
imx6sll-evk.

Let me know if you want me to split this instead.

diff --git a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
index a59a0fd1eb02..9f11f1fcc3e6 100644
--- a/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabreauto.dtsi
@@ -4,10 +4,14 @@
 // Copyright 2011 Linaro Ltd.
 
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	chosen {
+		stdout-path = &uart4;
+	};
+
 	memory at 10000000 {
 		reg = <0x10000000 0x80000000>;
 	};
 
 	leds {
diff --git a/arch/arm/boot/dts/imx6sl-evk.dts b/arch/arm/boot/dts/imx6sl-evk.dts
index 92ad01f676e3..50bdc65670a3 100644
--- a/arch/arm/boot/dts/imx6sl-evk.dts
+++ b/arch/arm/boot/dts/imx6sl-evk.dts
@@ -10,10 +10,14 @@
 
 / {
 	model = "Freescale i.MX6 SoloLite EVK Board";
 	compatible = "fsl,imx6sl-evk", "fsl,imx6sl";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory at 80000000 {
 		reg = <0x80000000 0x40000000>;
 	};
 
 	backlight_display: backlight_display {
diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 4684ac4a816b..25438ea03092 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -13,10 +13,14 @@
 
 / {
 	model = "Freescale i.MX6SLL EVK Board";
 	compatible = "fsl,imx6sll-evk", "fsl,imx6sll";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory at 80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
 	backlight {
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index 9f9e6a1e3b72..fe61218eec6f 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -8,10 +8,14 @@
 
 / {
 	model = "Freescale i.MX7 SabreSD Board";
 	compatible = "fsl,imx7d-sdb", "fsl,imx7d";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory at 80000000 {
 		reg = <0x80000000 0x80000000>;
 	};
 
 	gpio-keys {
-- 
2.17.1
