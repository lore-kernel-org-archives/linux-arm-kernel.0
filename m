From: marcofrk@gmail.com (Marco Franchi)
Date: Wed, 24 Jan 2018 11:22:12 -0200
Subject: [PATCH v3 1/3] ARM: dts: imx: Pass empty memory size on board dts
Message-ID: <1516800134-5018-1-git-send-email-marcofrk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In preparation for removing 'reg = <0 0>;' from the dtsi SoC files, pass
'reg = <0 0 >;' to the dts/dtsi board files that do not pass the memory
size.

Signed-off-by: Marco Franchi <marco.franchi@nxp.com>
---
Change since v2:
-change 'memory at 0 {' to 'memory {'
 arch/arm/boot/dts/imx51-zii-rdu1.dts         | 5 +++++
 arch/arm/boot/dts/imx53-tx53.dtsi            | 5 +++++
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 5 +++++
 arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts   | 5 +++++
 arch/arm/boot/dts/imx6dl-ts4900.dts          | 5 +++++
 arch/arm/boot/dts/imx6dl-ts7970.dts          | 5 +++++
 arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts    | 5 +++++
 arch/arm/boot/dts/imx6q-h100.dts             | 5 +++++
 arch/arm/boot/dts/imx6q-novena.dts           | 5 +++++
 arch/arm/boot/dts/imx6q-ts4900.dts           | 5 +++++
 arch/arm/boot/dts/imx6q-ts7970.dts           | 5 +++++
 arch/arm/boot/dts/imx6q-zii-rdu2.dts         | 5 +++++
 arch/arm/boot/dts/imx6qdl-apalis.dtsi        | 5 +++++
 arch/arm/boot/dts/imx6qdl-cubox-i.dtsi       | 5 +++++
 arch/arm/boot/dts/imx6qdl-hummingboard.dtsi  | 5 +++++
 arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi | 5 +++++
 arch/arm/boot/dts/imx6qp-zii-rdu2.dts        | 5 +++++
 17 files changed, 85 insertions(+)

diff --git a/arch/arm/boot/dts/imx51-zii-rdu1.dts b/arch/arm/boot/dts/imx51-zii-rdu1.dts
index 5306b78..aa36204 100644
--- a/arch/arm/boot/dts/imx51-zii-rdu1.dts
+++ b/arch/arm/boot/dts/imx51-zii-rdu1.dts
@@ -51,6 +51,11 @@
 		stdout-path = &uart1;
 	};
 
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	aliases {
 		mdio-gpio0 = &mdio_gpio;
 		rtc0 = &ds1341;
diff --git a/arch/arm/boot/dts/imx53-tx53.dtsi b/arch/arm/boot/dts/imx53-tx53.dtsi
index a22e461..e77dd0a 100644
--- a/arch/arm/boot/dts/imx53-tx53.dtsi
+++ b/arch/arm/boot/dts/imx53-tx53.dtsi
@@ -49,6 +49,11 @@
 	model = "Ka-Ro electronics TX53 module";
 	compatible = "karo,tx53", "fsl,imx53";
 
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	aliases {
 		can0 = &can2; /* Make the can interface indices consistent with TX28/TX48 modules */
 		can1 = &can1;
diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index dcf9206..700e129 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -53,6 +53,11 @@
 	compatible = "toradex,colibri_imx6dl-eval-v3", "toradex,colibri_imx6dl",
 		     "fsl,imx6dl";
 
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	aliases {
 		i2c0 = &i2c2;
 		i2c1 = &i2c3;
diff --git a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
index 994f96a..c195ad6 100644
--- a/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
+++ b/arch/arm/boot/dts/imx6dl-dfi-fs700-m60.dts
@@ -20,4 +20,9 @@
 / {
 	model = "DFI FS700-M60-6DL i.MX6dl Q7 Board";
 	compatible = "dfi,fs700-m60-6dl", "dfi,fs700e-m60", "fsl,imx6dl";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-ts4900.dts b/arch/arm/boot/dts/imx6dl-ts4900.dts
index 6ea0b78..e23f789 100644
--- a/arch/arm/boot/dts/imx6dl-ts4900.dts
+++ b/arch/arm/boot/dts/imx6dl-ts4900.dts
@@ -46,4 +46,9 @@
 / {
 	model = "Technologic Systems i.MX6 Solo/DualLite TS-4900 (Default Device Tree)";
 	compatible = "technologic,imx6dl-ts4900", "fsl,imx6dl";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6dl-ts7970.dts b/arch/arm/boot/dts/imx6dl-ts7970.dts
index d104daf..cae3313 100644
--- a/arch/arm/boot/dts/imx6dl-ts7970.dts
+++ b/arch/arm/boot/dts/imx6dl-ts7970.dts
@@ -47,4 +47,9 @@
 / {
 	model = "Technologic Systems i.MX6 Solo/DualLite TS-7970 (Default Device Tree)";
 	compatible = "technologic,imx6dl-ts7970", "fsl,imx6dl";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
index fd0ad9a..a266fe6 100644
--- a/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
+++ b/arch/arm/boot/dts/imx6q-dfi-fs700-m60.dts
@@ -20,4 +20,9 @@
 / {
 	model = "DFI FS700-M60-6QD i.MX6qd Q7 Board";
 	compatible = "dfi,fs700-m60-6qd", "dfi,fs700e-m60", "fsl,imx6q";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6q-h100.dts b/arch/arm/boot/dts/imx6q-h100.dts
index 8a2ea6c..db0e738 100644
--- a/arch/arm/boot/dts/imx6q-h100.dts
+++ b/arch/arm/boot/dts/imx6q-h100.dts
@@ -49,6 +49,11 @@
 	model = "Auvidea H100";
 	compatible = "auvidea,h100", "fsl,imx6q";
 
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	aliases {
 		rtc0 = &rtc;
 		rtc1 = &snvs_rtc;
diff --git a/arch/arm/boot/dts/imx6q-novena.dts b/arch/arm/boot/dts/imx6q-novena.dts
index 7d7dc59..43a0c32 100644
--- a/arch/arm/boot/dts/imx6q-novena.dts
+++ b/arch/arm/boot/dts/imx6q-novena.dts
@@ -55,6 +55,11 @@
 	model = "Kosagi Novena Dual/Quad";
 	compatible = "kosagi,imx6q-novena", "fsl,imx6q";
 
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	chosen {
 		stdout-path = &uart2;
 	};
diff --git a/arch/arm/boot/dts/imx6q-ts4900.dts b/arch/arm/boot/dts/imx6q-ts4900.dts
index fab76f8..9cf7b37 100644
--- a/arch/arm/boot/dts/imx6q-ts4900.dts
+++ b/arch/arm/boot/dts/imx6q-ts4900.dts
@@ -46,6 +46,11 @@
 / {
 	model = "Technologic Systems i.MX6 Quad TS-4900 (Default Device Tree)";
 	compatible = "technologic,imx6q-ts4900", "fsl,imx6q";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/imx6q-ts7970.dts b/arch/arm/boot/dts/imx6q-ts7970.dts
index f19e189..fd84fc5 100644
--- a/arch/arm/boot/dts/imx6q-ts7970.dts
+++ b/arch/arm/boot/dts/imx6q-ts7970.dts
@@ -47,6 +47,11 @@
 / {
 	model = "Technologic Systems i.MX6 Quad TS-7970 (Default Device Tree)";
 	compatible = "technologic,imx6q-ts7970", "fsl,imx6q";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
 
 &sata {
diff --git a/arch/arm/boot/dts/imx6q-zii-rdu2.dts b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
index 6be8a1e..fe8b12f 100644
--- a/arch/arm/boot/dts/imx6q-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6q-zii-rdu2.dts
@@ -47,4 +47,9 @@
 / {
 	model = "ZII RDU2 Board";
 	compatible = "zii,imx6q-zii-rdu2", "fsl,imx6q";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
index 4e776e0..bd658db 100644
--- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
@@ -47,6 +47,11 @@
 	model = "Toradex Apalis iMX6Q/D Module";
 	compatible = "toradex,apalis_imx6q", "fsl,imx6q";
 
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pinctrl-names = "default";
diff --git a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
index d1cfdc2..4c5f513 100644
--- a/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-cubox-i.dtsi
@@ -42,6 +42,11 @@
 #include <dt-bindings/gpio/gpio.h>
 
 / {
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	ir_recv: ir-receiver {
 		compatible = "gpio-ir-receiver";
 		gpios = <&gpio3 9 1>;
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
index 9258323..52eeeed 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard.dtsi
@@ -40,6 +40,11 @@
  */
 
 / {
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	chosen {
 		stdout-path = &uart1;
 	};
diff --git a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
index dffbc92..e68e7db 100644
--- a/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-hummingboard2.dtsi
@@ -40,6 +40,11 @@
  */
 
 / {
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
+
 	chosen {
 		stdout-path = &uart1;
 	};
diff --git a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
index 547a766..96ab983 100644
--- a/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
+++ b/arch/arm/boot/dts/imx6qp-zii-rdu2.dts
@@ -47,4 +47,9 @@
 / {
 	model = "ZII RDU2+ Board";
 	compatible = "zii,imx6qp-zii-rdu2", "fsl,imx6qp";
+
+	/* Will be filled by the bootloader */
+	memory {
+		reg = <0 0>;
+	};
 };
-- 
2.7.4
