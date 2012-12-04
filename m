From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Tue,  4 Dec 2012 15:54:00 +0800
Subject: [v2 PATCH 14/14] ARM: dts: add spi nodes for atmel boards
In-Reply-To: <1354607640-13229-1-git-send-email-wenyou.yang@atmel.com>
References: <1354607640-13229-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1354607640-13229-15-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
[wenyou.yang at atmel.com: added spi nodes for other atmel boards]
[wenyou.yang at atmel.com: remove the cs-gpios property for sam9x5ek boards]
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux at arm.linux.org.uk
---
 arch/arm/boot/dts/at91sam9263ek.dts         |    9 +++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |    9 +++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts         |    9 +++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |    9 +++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |    9 +++++++++
 5 files changed, 45 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..11e274d 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -50,6 +50,15 @@
 				atmel,vbus-gpio = <&pioA 25 0>;
 				status = "okay";
 			};
+
+			spi0: spi at fffa4000 {
+				status = "okay";
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index e6391a4..3c3b63d 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,15 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <50000000>;
+					reg = <1>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 877c08f..3b84bc9 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -44,6 +44,15 @@
 			i2c2: i2c at f8018000 {
 				status = "okay";
 			};
+
+			spi0: spi at f0000000 {
+				status = "okay";
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		usb0: ohci at 00600000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 15e1dd4..a23ac6e 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -54,6 +54,15 @@
 			i2c1: i2c at fff88000 {
 				status = "okay";
 			};
+
+			spi0: spi at fffa4000{
+				status = "okay";
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <13000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 912b2c2..706bd00 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -45,6 +45,15 @@
 			i2c1: i2c at f8014000 {
 				status = "okay";
 			};
+
+			spi0: spi at f0000000 {
+				status = "okay";
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
-- 
1.7.9.5
