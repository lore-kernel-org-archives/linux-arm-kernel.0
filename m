From: david@lechnology.com (David Lechner)
Date: Sat, 16 Apr 2016 12:00:17 -0500
Subject: [PATCH v2 1/4] ARM: DTS: da850: add spi0 to device tree
In-Reply-To: <1460826020-1256-1-git-send-email-david@lechnology.com>
References: <1460826020-1256-1-git-send-email-david@lechnology.com>
Message-ID: <1460826020-1256-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add device node and pinmux for SoC spi0.

Signed-off-by: David Lechner <david@lechnology.com>
---

Device tree portion of previous "ARM: davinci: add spi0 to da850 device tree"
patch.

Added pinmux definitions.


 arch/arm/boot/dts/da850.dtsi | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index c9bf27d..8880d57 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -120,7 +120,19 @@
 					0x4 0x00000004 0x0000000f
 				>;
 			};
-			spi1_pins: pinmux_spi_pins {
+			spi0_pins: pinmux_spi0_pins {
+				pinctrl-single,bits = <
+					/* SIMO, SOMI, CLK */
+					0xc 0x00001101 0x0000ff0f
+				>;
+			};
+			spi0_cs0_pin: pinmux_spi0_cs0 {
+				pinctrl-single,bits = <
+					/* CS0 */
+					0x10 0x00000010 0x000000f0
+				>;
+			};
+			spi1_pins: pinmux_spi1_pins {
 				pinctrl-single,bits = <
 					/* SIMO, SOMI, CLK */
 					0x14 0x00110100 0x00ff0f00
@@ -291,6 +303,16 @@
 			reg = <0x308000 0x80>;
 			status = "disabled";
 		};
+		spi0: spi at 41000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "ti,da830-spi";
+			reg = <0x41000 0x1000>;
+			num-cs = <6>;
+			ti,davinci-spi-intr-line = <1>;
+			interrupts = <20>;
+			status = "disabled";
+		};
 		spi1: spi at 30e000 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
1.9.1
