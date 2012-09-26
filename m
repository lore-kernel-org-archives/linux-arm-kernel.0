From: wenyou.yang@atmel.com (Wenyou Yang)
Date: Wed, 26 Sep 2012 14:51:00 +0800
Subject: [PATCH 5/6] ARM: dts: add spi nodes for atmel boards
In-Reply-To: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
References: <1348642261-27554-1-git-send-email-wenyou.yang@atmel.com>
Message-ID: <1348642261-27554-6-git-send-email-wenyou.yang@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
---
 arch/arm/boot/dts/at91sam9263ek.dts         |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g20ek_common.dtsi |   10 ++++++++++
 arch/arm/boot/dts/at91sam9g25ek.dts         |   10 ++++++++++
 arch/arm/boot/dts/at91sam9m10g45ek.dts      |   10 ++++++++++
 arch/arm/boot/dts/at91sam9n12ek.dts         |   10 ++++++++++
 5 files changed, 50 insertions(+)

diff --git a/arch/arm/boot/dts/at91sam9263ek.dts b/arch/arm/boot/dts/at91sam9263ek.dts
index f86ac4b..ba68551 100644
--- a/arch/arm/boot/dts/at91sam9263ek.dts
+++ b/arch/arm/boot/dts/at91sam9263ek.dts
@@ -50,6 +50,16 @@
 				atmel,vbus-gpio = <&pioA 25 0>;
 				status = "okay";
 			};
+
+			spi0: spi at fffa4000 {
+				status = "okay";
+				cs-gpios = <&pioA 5 0>;
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
index b06c0db..1be036f 100644
--- a/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
+++ b/arch/arm/boot/dts/at91sam9g20ek_common.dtsi
@@ -51,6 +51,16 @@
 				atmel,vbus-gpio = <&pioC 5 0>;
 				status = "okay";
 			};
+
+			spi0: spi at fffc8000 {
+				status = "okay";
+				cs-gpios = <&pioA 3 0>;
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9g25ek.dts b/arch/arm/boot/dts/at91sam9g25ek.dts
index 96514c1..93d0b3c 100644
--- a/arch/arm/boot/dts/at91sam9g25ek.dts
+++ b/arch/arm/boot/dts/at91sam9g25ek.dts
@@ -32,6 +32,16 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			spi0: spi at f0000000 {
+				status = "okay";
+				cs-gpios = <&pioA 14 0>;
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		usb0: ohci at 00600000 {
diff --git a/arch/arm/boot/dts/at91sam9m10g45ek.dts b/arch/arm/boot/dts/at91sam9m10g45ek.dts
index a3633bd..919faae 100644
--- a/arch/arm/boot/dts/at91sam9m10g45ek.dts
+++ b/arch/arm/boot/dts/at91sam9m10g45ek.dts
@@ -46,6 +46,16 @@
 				phy-mode = "rmii";
 				status = "okay";
 			};
+
+			spi0: spi at fffa4000 {
+				status = "okay";
+				cs-gpios = <&pioB 3 0>;
+				m25p80 at 0 {
+					compatible = "atmel,at25df321a";
+					spi-max-frequency = <50000000>;
+					reg = <0>;
+				};
+			};
 		};
 
 		nand0: nand at 40000000 {
diff --git a/arch/arm/boot/dts/at91sam9n12ek.dts b/arch/arm/boot/dts/at91sam9n12ek.dts
index f4e43e3..a82e4ac 100644
--- a/arch/arm/boot/dts/at91sam9n12ek.dts
+++ b/arch/arm/boot/dts/at91sam9n12ek.dts
@@ -37,6 +37,16 @@
 			dbgu: serial at fffff200 {
 				status = "okay";
 			};
+
+			spi0: spi at f0000000 {
+				status = "okay";
+				cs-gpios = <&pioA 14 0>;
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
