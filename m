From: prakash.pm@ti.com (Manjunathappa, Prakash)
Date: Wed, 3 Apr 2013 19:39:08 +0530
Subject: [PATCH v5 3/5] ARM: davinci: da850: add SPI1 DT node
In-Reply-To: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
References: <1364998150-5980-1-git-send-email-prakash.pm@ti.com>
Message-ID: <1364998150-5980-4-git-send-email-prakash.pm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch adds SPI1 DT node along with pinmux data.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
---
Since v4:
Separate out chip_select pinmuxing so as to allow boards choose
what to configure. Dropped unused CS1 and ENA pinmuxing.

 arch/arm/boot/dts/da850.dtsi |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 3ec1bda..1d445cd 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -62,6 +62,18 @@
 					0x10 0x00002200 0x0000ff00
 				>;
 			};
+			spi1_pins: pinmux_spi_pins {
+				pinctrl-single,bits = <
+					/* SIMO, SOMI, CLK */
+					0x14 0x00110100 0x00ff0f00
+				>;
+			};
+			spi1_cs0_pin: pinmux_spi1_cs0 {
+				pinctrl-single,bits = <
+					/* CS0 */
+					0x14 0x00000010 0x000000f0
+				>;
+			};
 		};
 		serial0: serial at 1c42000 {
 			compatible = "ns16550a";
@@ -107,6 +119,16 @@
 			reg = <0x21000 0x1000>;
 			status = "disabled";
 		};
+		spi1: spi at 1f0e000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,da830-spi";
+			reg = <0x30e000 0x1000>;
+			num-cs = <4>;
+			ti,davinci-spi-intr-line = <1>;
+			interrupts = <56>;
+			status = "disabled";
+		};
 	};
 	nand_cs3 at 62000000 {
 		compatible = "ti,davinci-nand";
-- 
1.7.4.1
