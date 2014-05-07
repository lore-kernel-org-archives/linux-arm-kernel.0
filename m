From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed,  7 May 2014 15:19:00 +0200
Subject: [PATCH] ARM: dts: Add stdout-path property to i.MX boards
Message-ID: <1399468740-15349-1-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the stdout-path property to various i.MX boards. Values
of the property have been taken from barebox, so they should be
correct. Also, the older linux,stdout-path property is converted
to stdout-path.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 arch/arm/boot/dts/imx25-karo-tx25.dts            | 4 ++++
 arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts | 4 ++++
 arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts   | 4 ++++
 arch/arm/boot/dts/imx51-babbage.dts              | 4 ++++
 arch/arm/boot/dts/imx53-mba53.dts                | 4 ++++
 arch/arm/boot/dts/imx53-qsb-common.dtsi          | 4 ++++
 arch/arm/boot/dts/imx6dl-hummingboard.dts        | 4 ++++
 arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts          | 4 ++++
 arch/arm/boot/dts/imx6q-gk802.dts                | 2 +-
 arch/arm/boot/dts/imx6q-phytec-pbab01.dts        | 4 ++++
 arch/arm/boot/dts/imx6q-udoo.dts                 | 4 ++++
 arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi     | 2 +-
 arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi        | 4 ++++
 arch/arm/boot/dts/imx6qdl-sabrelite.dtsi         | 4 ++++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi           | 4 ++++
 15 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx25-karo-tx25.dts b/arch/arm/boot/dts/imx25-karo-tx25.dts
index f8db366..c83dce9 100644
--- a/arch/arm/boot/dts/imx25-karo-tx25.dts
+++ b/arch/arm/boot/dts/imx25-karo-tx25.dts
@@ -16,6 +16,10 @@
 	model = "Ka-Ro TX25";
 	compatible = "karo,imx25-tx25", "fsl,imx25";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory {
 		reg = <0x80000000 0x02000000 0x90000000 0x02000000>;
 	};
diff --git a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
index 3c3964a..7c869fe 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycard-s-rdk.dts
@@ -15,6 +15,10 @@
 	model = "Phytec pca100 rapid development kit";
 	compatible = "phytec,imx27-pca100-rdk", "phytec,imx27-pca100", "fsl,imx27";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	display: display {
 		model = "Primeview-PD050VL1";
 		native-mode = <&timing0>;
diff --git a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
index df3b2e7..6ad29b0 100644
--- a/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
+++ b/arch/arm/boot/dts/imx27-phytec-phycore-rdk.dts
@@ -12,6 +12,10 @@
 / {
 	model = "Phytec pcm970";
 	compatible = "phytec,imx27-pcm970", "phytec,imx27-pcm038", "fsl,imx27";
+
+	chosen {
+		stdout-path = &uart1;
+	};
 };
 
 &cspi1 {
diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
index 9e9deb2..b5483e5 100644
--- a/arch/arm/boot/dts/imx51-babbage.dts
+++ b/arch/arm/boot/dts/imx51-babbage.dts
@@ -17,6 +17,10 @@
 	model = "Freescale i.MX51 Babbage Board";
 	compatible = "fsl,imx51-babbage", "fsl,imx51";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory {
 		reg = <0x90000000 0x20000000>;
 	};
diff --git a/arch/arm/boot/dts/imx53-mba53.dts b/arch/arm/boot/dts/imx53-mba53.dts
index 7c8c129..3f2400b 100644
--- a/arch/arm/boot/dts/imx53-mba53.dts
+++ b/arch/arm/boot/dts/imx53-mba53.dts
@@ -17,6 +17,10 @@
 	model = "TQ MBa53 starter kit";
 	compatible = "tq,mba53", "tq,tqma53", "fsl,imx53";
 
+	chosen {
+		stdout-path = &uart2;
+	};
+
 	backlight {
 		compatible = "pwm-backlight";
 		pwms = <&pwm2 0 50000>;
diff --git a/arch/arm/boot/dts/imx53-qsb-common.dtsi b/arch/arm/boot/dts/imx53-qsb-common.dtsi
index ede04fa..76c6306 100644
--- a/arch/arm/boot/dts/imx53-qsb-common.dtsi
+++ b/arch/arm/boot/dts/imx53-qsb-common.dtsi
@@ -13,6 +13,10 @@
 #include "imx53.dtsi"
 
 / {
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory {
 		reg = <0x70000000 0x20000000>,
 		      <0xb0000000 0x20000000>;
diff --git a/arch/arm/boot/dts/imx6dl-hummingboard.dts b/arch/arm/boot/dts/imx6dl-hummingboard.dts
index 5bfae54..121991c 100644
--- a/arch/arm/boot/dts/imx6dl-hummingboard.dts
+++ b/arch/arm/boot/dts/imx6dl-hummingboard.dts
@@ -11,6 +11,10 @@
 	model = "SolidRun HummingBoard DL/Solo";
 	compatible = "solidrun,hummingboard", "fsl,imx6dl";
 
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio1 2 1>;
diff --git a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
index e4ae38f..52446ea 100644
--- a/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
+++ b/arch/arm/boot/dts/imx6q-dmo-edmqmx6.dts
@@ -18,6 +18,10 @@
 	model = "Data Modul eDM-QMX6 Board";
 	compatible = "dmo,imx6q-edmqmx6", "fsl,imx6q";
 
+	chosen {
+		stdout-path = &uart2;
+	};
+
 	aliases {
 		gpio7 = &stmpe_gpio1;
 		gpio8 = &stmpe_gpio2;
diff --git a/arch/arm/boot/dts/imx6q-gk802.dts b/arch/arm/boot/dts/imx6q-gk802.dts
index 4a9b4dc..5c0e674 100644
--- a/arch/arm/boot/dts/imx6q-gk802.dts
+++ b/arch/arm/boot/dts/imx6q-gk802.dts
@@ -14,7 +14,7 @@
 	compatible = "zealz,imx6q-gk802", "fsl,imx6q";
 
 	chosen {
-		linux,stdout-path = &uart4;
+		stdout-path = &uart4;
 	};
 
 	memory {
diff --git a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
index 5607c33..c8fa69d 100644
--- a/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
+++ b/arch/arm/boot/dts/imx6q-phytec-pbab01.dts
@@ -15,6 +15,10 @@
 / {
 	model = "Phytec phyFLEX-i.MX6 Quad Carrier-Board";
 	compatible = "phytec,imx6q-pbab01", "phytec,imx6q-pfla02", "fsl,imx6q";
+
+	chosen {
+		stdout-path = &uart4;
+	};
 };
 
 &fec {
diff --git a/arch/arm/boot/dts/imx6q-udoo.dts b/arch/arm/boot/dts/imx6q-udoo.dts
index ed397d1..7cc0267 100644
--- a/arch/arm/boot/dts/imx6q-udoo.dts
+++ b/arch/arm/boot/dts/imx6q-udoo.dts
@@ -16,6 +16,10 @@
 	model = "Udoo i.MX6 Quad Board";
 	compatible = "udoo,imx6q-udoo", "fsl,imx6q";
 
+	chosen {
+		stdout-path = &uart2;
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
index 25cf035..2c253d6 100644
--- a/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi
@@ -22,7 +22,7 @@
 	};
 
 	chosen {
-		linux,stdout-path = &uart1;
+		stdout-path = &uart1;
 	};
 };
 
diff --git a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
index 99be301..4c4b175 100644
--- a/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi
@@ -14,6 +14,10 @@
 #include <dt-bindings/input/input.h>
 
 / {
+	chosen {
+		stdout-path = &uart2;
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
index 3bec128..6df6127 100644
--- a/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabrelite.dtsi
@@ -13,6 +13,10 @@
 #include <dt-bindings/input/input.h>
 
 / {
+	chosen {
+		stdout-path = &uart2;
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 0d816d3..fc00d19 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -14,6 +14,10 @@
 #include <dt-bindings/input/input.h>
 
 / {
+	chosen {
+		stdout-path = &uart1;
+	};
+
 	memory {
 		reg = <0x10000000 0x40000000>;
 	};
-- 
2.0.0.rc0
