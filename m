From: shc_work@mail.ru (Alexander Shiyan)
Date: Tue, 19 Aug 2014 20:00:09 +0400
Subject: [PATCH] ARM: i.MX: dts: Add simple-card support
Message-ID: <1408464009-20722-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds simple-card support to the i.MX SoCs.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/boot/dts/imx25.dtsi   | 2 ++
 arch/arm/boot/dts/imx35.dtsi   | 1 +
 arch/arm/boot/dts/imx50.dtsi   | 2 ++
 arch/arm/boot/dts/imx51.dtsi   | 3 +++
 arch/arm/boot/dts/imx53.dtsi   | 3 +++
 arch/arm/boot/dts/imx6qdl.dtsi | 3 +++
 arch/arm/boot/dts/imx6sl.dtsi  | 3 +++
 arch/arm/boot/dts/imx6sx.dtsi  | 3 +++
 8 files changed, 20 insertions(+)

diff --git a/arch/arm/boot/dts/imx25.dtsi b/arch/arm/boot/dts/imx25.dtsi
index c174039..61e34f42 100644
--- a/arch/arm/boot/dts/imx25.dtsi
+++ b/arch/arm/boot/dts/imx25.dtsi
@@ -239,6 +239,7 @@
 			};
 
 			ssi2: ssi at 50014000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
 				reg = <0x50014000 0x4000>;
 				interrupts = <11>;
@@ -274,6 +275,7 @@
 			};
 
 			ssi1: ssi at 50034000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx25-ssi", "fsl,imx21-ssi";
 				reg = <0x50034000 0x4000>;
 				interrupts = <12>;
diff --git a/arch/arm/boot/dts/imx35.dtsi b/arch/arm/boot/dts/imx35.dtsi
index 442e216..6932928 100644
--- a/arch/arm/boot/dts/imx35.dtsi
+++ b/arch/arm/boot/dts/imx35.dtsi
@@ -114,6 +114,7 @@
 			};
 
 			ssi1: ssi at 43fa0000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx35-ssi", "fsl,imx21-ssi";
 				reg = <0x43fa0000 0x4000>;
 				interrupts = <11>;
diff --git a/arch/arm/boot/dts/imx50.dtsi b/arch/arm/boot/dts/imx50.dtsi
index c0e0f60..620b0f0 100644
--- a/arch/arm/boot/dts/imx50.dtsi
+++ b/arch/arm/boot/dts/imx50.dtsi
@@ -145,6 +145,7 @@
 				};
 
 				ssi2: ssi at 50014000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx50-ssi",
 							"fsl,imx51-ssi",
 							"fsl,imx21-ssi";
@@ -454,6 +455,7 @@
 			};
 
 			ssi1: ssi at 63fcc000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx50-ssi", "fsl,imx51-ssi",
 							"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
diff --git a/arch/arm/boot/dts/imx51.dtsi b/arch/arm/boot/dts/imx51.dtsi
index 17c05a6..92660e1 100644
--- a/arch/arm/boot/dts/imx51.dtsi
+++ b/arch/arm/boot/dts/imx51.dtsi
@@ -210,6 +210,7 @@
 				};
 
 				ssi2: ssi at 70014000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 					reg = <0x70014000 0x4000>;
 					interrupts = <30>;
@@ -499,6 +500,7 @@
 			};
 
 			ssi1: ssi at 83fcc000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fcc000 0x4000>;
 				interrupts = <29>;
@@ -554,6 +556,7 @@
 			};
 
 			ssi3: ssi at 83fe8000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx51-ssi", "fsl,imx21-ssi";
 				reg = <0x83fe8000 0x4000>;
 				interrupts = <96>;
diff --git a/arch/arm/boot/dts/imx53.dtsi b/arch/arm/boot/dts/imx53.dtsi
index 64fa27b..f9f497e 100644
--- a/arch/arm/boot/dts/imx53.dtsi
+++ b/arch/arm/boot/dts/imx53.dtsi
@@ -221,6 +221,7 @@
 				};
 
 				ssi2: ssi at 50014000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx53-ssi",
 							"fsl,imx51-ssi",
 							"fsl,imx21-ssi";
@@ -661,6 +662,7 @@
 			};
 
 			ssi1: ssi at 63fcc000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
 						"fsl,imx21-ssi";
 				reg = <0x63fcc000 0x4000>;
@@ -688,6 +690,7 @@
 			};
 
 			ssi3: ssi at 63fe8000 {
+				#sound-dai-cells = <0>;
 				compatible = "fsl,imx53-ssi", "fsl,imx51-ssi",
 						"fsl,imx21-ssi";
 				reg = <0x63fe8000 0x4000>;
diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index c701af9..6692115 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -273,6 +273,7 @@
 				};
 
 				ssi1: ssi at 02028000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6q-ssi",
 							"fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
@@ -286,6 +287,7 @@
 				};
 
 				ssi2: ssi at 0202c000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6q-ssi",
 							"fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
@@ -299,6 +301,7 @@
 				};
 
 				ssi3: ssi at 02030000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6q-ssi",
 							"fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 505da9e..4c400fc 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -226,6 +226,7 @@
 				};
 
 				ssi1: ssi at 02028000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6sl-ssi",
 							"fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
@@ -239,6 +240,7 @@
 				};
 
 				ssi2: ssi at 0202c000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6sl-ssi",
 							"fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
@@ -252,6 +254,7 @@
 				};
 
 				ssi3: ssi at 02030000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6sl-ssi",
 							"fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
diff --git a/arch/arm/boot/dts/imx6sx.dtsi b/arch/arm/boot/dts/imx6sx.dtsi
index f4b9da6..63d9d82 100644
--- a/arch/arm/boot/dts/imx6sx.dtsi
+++ b/arch/arm/boot/dts/imx6sx.dtsi
@@ -298,6 +298,7 @@
 				};
 
 				ssi1: ssi at 02028000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6sx-ssi", "fsl,imx51-ssi";
 					reg = <0x02028000 0x4000>;
 					interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
@@ -311,6 +312,7 @@
 				};
 
 				ssi2: ssi at 0202c000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6sx-ssi", "fsl,imx51-ssi";
 					reg = <0x0202c000 0x4000>;
 					interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
@@ -324,6 +326,7 @@
 				};
 
 				ssi3: ssi at 02030000 {
+					#sound-dai-cells = <0>;
 					compatible = "fsl,imx6sx-ssi", "fsl,imx51-ssi";
 					reg = <0x02030000 0x4000>;
 					interrupts = <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>;
-- 
1.8.5.5
