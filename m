From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Fri, 12 Aug 2016 13:45:11 -0400
Subject: [PATCH] ARM: dts: imx6q-bx50v3: configure unused pca953x pins
Message-ID: <1471023911-2763-1-git-send-email-akshay.bhat@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ken Lin <ken.lin@advantech.com.tw>

At power on, pca953x GPIO pins are configured as input and may cause
unexpected interrupts. Configure the unused pins as GPO low to
avoid unexpected interrupts.

Signed-off-by: Ken Lin <ken.lin@advantech.com.tw>
Signed-off-by: Akshay Bhat <akshay.bhat@timesys.com>
---
 arch/arm/boot/dts/imx6q-b450v3.dts  | 16 +++++++++
 arch/arm/boot/dts/imx6q-b650v3.dts  |  9 +++++
 arch/arm/boot/dts/imx6q-bx50v3.dtsi | 70 +++++++++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/arch/arm/boot/dts/imx6q-b450v3.dts b/arch/arm/boot/dts/imx6q-b450v3.dts
index f0a2be5..78bfc1a 100644
--- a/arch/arm/boot/dts/imx6q-b450v3.dts
+++ b/arch/arm/boot/dts/imx6q-b450v3.dts
@@ -89,3 +89,19 @@
 		};
 	};
 };
+
+&pca9539 {
+	P04 {
+		gpio-hog;
+		gpios = <4 0>;
+		output-low;
+		line-name = "PCA9539-P04";
+	};
+
+	P05 {
+		gpio-hog;
+		gpios = <5 0>;
+		output-low;
+		line-name = "PCA9539-P05";
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-b650v3.dts b/arch/arm/boot/dts/imx6q-b650v3.dts
index 33cb71a..d853887 100644
--- a/arch/arm/boot/dts/imx6q-b650v3.dts
+++ b/arch/arm/boot/dts/imx6q-b650v3.dts
@@ -89,3 +89,12 @@
 		};
 	};
 };
+
+&pca9539 {
+	P05 {
+		gpio-hog;
+		gpios = <5 0>;
+		output-low;
+		line-name = "PCA9539-P05";
+	};
+};
diff --git a/arch/arm/boot/dts/imx6q-bx50v3.dtsi b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
index cf3fd31..e4a415f 100644
--- a/arch/arm/boot/dts/imx6q-bx50v3.dtsi
+++ b/arch/arm/boot/dts/imx6q-bx50v3.dtsi
@@ -183,6 +183,76 @@
 				interrupt-controller;
 				interrupt-parent = <&gpio2>;
 				interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
+
+				P06 {
+					gpio-hog;
+					gpios = <6 0>;
+					output-low;
+					line-name = "PCA9539-P06";
+				};
+
+				P07 {
+					gpio-hog;
+					gpios = <7 0>;
+					output-low;
+					line-name = "PCA9539-P07";
+				};
+
+				P10 {
+					gpio-hog;
+					gpios = <8 0>;
+					output-low;
+					line-name = "PCA9539-P10";
+				};
+
+				P11 {
+					gpio-hog;
+					gpios = <9 0>;
+					output-low;
+					line-name = "PCA9539-P11";
+				};
+
+				P12 {
+					gpio-hog;
+					gpios = <10 0>;
+					output-low;
+					line-name = "PCA9539-P12";
+				};
+
+				P13 {
+					gpio-hog;
+					gpios = <11 0>;
+					output-low;
+					line-name = "PCA9539-P13";
+				};
+
+				P14 {
+					gpio-hog;
+					gpios = <12 0>;
+					output-low;
+					line-name = "PCA9539-P14";
+				};
+
+				P15 {
+					gpio-hog;
+					gpios = <13 0>;
+					output-low;
+					line-name = "PCA9539-P15";
+				};
+
+				P16 {
+					gpio-hog;
+					gpios = <14 0>;
+					output-low;
+					line-name = "PCA9539-P16";
+				};
+
+				P17 {
+					gpio-hog;
+					gpios = <15 0>;
+					output-low;
+					line-name = "PCA9539-P17";
+				};
 			};
 		};
 
-- 
2.8.1
