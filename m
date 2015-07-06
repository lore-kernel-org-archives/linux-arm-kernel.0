From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon,  6 Jul 2015 12:47:30 +0900
Subject: [PATCH 3/3] ARM: dts: UniPhier: add USB EHCI device nodes
In-Reply-To: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
References: <1436154450-21102-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <1436154450-21102-4-git-send-email-yamada.masahiro@socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Get USB 2.0 host controllers available with generic-ehci bindings.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts  |  8 ++++++++
 arch/arm/boot/dts/uniphier-ph1-ld4.dtsi     | 21 +++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts |  8 ++++++++
 arch/arm/boot/dts/uniphier-ph1-pro4.dtsi    | 14 ++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts | 16 ++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld3.dtsi    | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts | 12 ++++++++++++
 arch/arm/boot/dts/uniphier-ph1-sld8.dtsi    | 21 +++++++++++++++++++++
 8 files changed, 128 insertions(+)

diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
index 0cd385a9..7ac053d 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4-ref.dts
@@ -92,3 +92,11 @@
 &serial3 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
index 1261e6d..b042711 100644
--- a/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-ld4.dtsi
@@ -127,6 +127,27 @@
 			reg = <0x59800000 0x2000>;
 		};
 
+		usb0: usb at 5a800100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a800100 0x100>;
+			interrupts = <0 80 4>;
+		};
+
+		usb1: usb at 5a810100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a810100 0x100>;
+			interrupts = <0 81 4>;
+		};
+
+		usb2: usb at 5a820100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a820100 0x100>;
+			interrupts = <0 82 4>;
+		};
+
 		timer at 60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
index 0951cbf..b669d32 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4-ref.dts
@@ -92,3 +92,11 @@
 &serial2 {
 	status = "okay";
 };
+
+&usb2 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
index acd2c06..85db033 100644
--- a/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-pro4.dtsi
@@ -134,6 +134,20 @@
 			reg = <0x59800000 0x2000>;
 		};
 
+		usb2: usb at 5a800100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a800100 0x100>;
+			interrupts = <0 80 4>;
+		};
+
+		usb3: usb at 5a810100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a810100 0x100>;
+			interrupts = <0 81 4>;
+		};
+
 		timer at 60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
index 47a44da..48f7361 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3-ref.dts
@@ -92,3 +92,19 @@
 &serial2 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
index feb253b..d0c2f11 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld3.dtsi
@@ -146,5 +146,33 @@
 				     "syscon";
 			reg = <0x59800000 0x2000>;
 		};
+
+		usb0: usb at 5a800100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a800100 0x100>;
+			interrupts = <0 80 4>;
+		};
+
+		usb1: usb at 5a810100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a810100 0x100>;
+			interrupts = <0 81 4>;
+		};
+
+		usb2: usb at 5a820100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a820100 0x100>;
+			interrupts = <0 82 4>;
+		};
+
+		usb3: usb at 5a830100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a830100 0x100>;
+			interrupts = <0 83 4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
index 07e93a9..9b5992a 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8-ref.dts
@@ -92,3 +92,15 @@
 &serial3 {
 	status = "okay";
 };
+
+&usb0 {
+	status = "okay";
+};
+
+&usb1 {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
diff --git a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
index bf0c8c1..bcb8808 100644
--- a/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-ph1-sld8.dtsi
@@ -127,6 +127,27 @@
 			reg = <0x59800000 0x2000>;
 		};
 
+		usb0: usb at 5a800100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a800100 0x100>;
+			interrupts = <0 80 4>;
+		};
+
+		usb1: usb at 5a810100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a810100 0x100>;
+			interrupts = <0 81 4>;
+		};
+
+		usb2: usb at 5a820100 {
+			compatible = "generic-ehci";
+			status = "disabled";
+			reg = <0x5a820100 0x100>;
+			interrupts = <0 82 4>;
+		};
+
 		timer at 60000200 {
 			compatible = "arm,cortex-a9-global-timer";
 			reg = <0x60000200 0x20>;
-- 
1.9.1
