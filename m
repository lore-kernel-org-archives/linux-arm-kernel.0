From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 27 Feb 2013 08:49:10 +0800
Subject: [PATCH Resend v5 15/16] ARM: dts: add spi nodes for the atmel boards
In-Reply-To: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
References: <1361925297-11854-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1361926150-12646-1-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Richard Genoud <richard.genoud@gmail.com>

Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
[wenyou.yang at atmel.com: added spi nodes for the sam9263ek, sam9g20ek, sam9m10g45ek and sam9n12ek boards]
[wenyou.yang at atmel.com: submit the patch]
Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
Cc: linux at arm.linux.org.uk
Cc: linux-kernel at vger.kernel.org
---
 arch/arm/boot/dts/at91sam9263ek.dts         |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   10 ++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |   10 ++++++++++
 arch/arm/boot/dts/at91sam9x5ek.dtsi         |   10 ++++++++++
 5 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index 1eb0872..a14e424 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -79,6 +79,16 @@
 					};
 				};
 			};
+
+			spi0: spi at fffa4000 {
+				status = "okay";
+				cs-gpios = <&pioA 5 0>, <0>, <0>, <0>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index da15e83..23d1f46 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -96,6 +96,16 @@
 				status = "okay";
 				pinctrl-0 = <&pinctrl_ssc0_tx>;
 			};
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				cs-gpios = <0>, <&pioC 11 0>, <0>, <0>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <50000000>;
+					reg = <1>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index 20c3191..92c52a7 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -102,6 +102,16 @@
 					};
 				};
 			};
+
+			spi0: spi at fffa4000{
+				status = "okay";
+				cs-gpios = <&pioB 3 0>, <0>, <0>, <0>;
+				mtd_dataflash at 0 {
+					compatible = "atmel,at45", "atmel,dataflash";
+					spi-max-frequency = <13000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index 0376bf4..82551a8 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -67,6 +67,16 @@
 					};
 				};
 			};
+
+			spi0: spi at f0000000 {
+				status = "okay";
+				cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9x5ek.dtsi b/arch/arm/boot/dts/at91sam9x5ek.dtsi
index 8a7cf1d..09f5e66 100644
--- a/arch/arm/boot/dts/at91sam9x5ek.dtsi
+++ b/arch/arm/boot/dts/at91sam9x5ek.dtsi
@@ -84,6 +84,16 @@
 					};
 				};
 			};
+
+			spi0: spi at f0000000 {
+				status = "okay";
+				cs-gpios = <&pioA 14 0>, <0>, <0>, <0>;
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		usb0: ohci at 00600000 {
-- 
1.7.9.5
