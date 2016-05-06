From: khilman@baylibre.com (Kevin Hilman)
Date: Fri,  6 May 2016 07:21:25 -0700
Subject: [PATCH 6/7] ARM64: dts: amlogic: gxbb: pinctrl: add/update UART
In-Reply-To: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
References: <1462544486-9516-1-git-send-email-khilman@baylibre.com>
Message-ID: <1462544486-9516-7-git-send-email-khilman@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DT nodes for additional UARTs (UART B & C in EE domain) and add pins
for all EE domain UARTs.

Signed-off-by: Kevin Hilman <khilman@baylibre.com>
---
 .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts |  1 +
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 42 +++++++++++++++++++++-
 2 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 41e1e669bc70..45778896bd3d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -80,3 +80,4 @@
 	pinctrl-0 = <&uart_ao_a_pins>;
 	pinctrl-names = "default";
 };
+
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 7b22b9d3b9d9..86c41b3798db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -132,11 +132,27 @@
 
 			uart_A: serial at 84c0 {
 				compatible = "amlogic,meson-uart";
-				reg = <0x0 0x084c0 0x0 0x14>;
+				reg = <0x0 0x84c0 0x0 0x14>;
 				interrupts = <GIC_SPI 26 IRQ_TYPE_EDGE_RISING>;
 				clocks = <&xtal>;
 				status = "disabled";
 			};
+
+			uart_B: serial at 84dc {
+				compatible = "amlogic,meson-uart";
+				reg = <0x0 0x84dc 0x0 0x14>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>;
+				status = "disabled";
+			};
+
+			uart_C: serial at 8700 {
+				compatible = "amlogic,meson-uart";
+				reg = <0x0 0x8700 0x0 0x14>;
+				interrupts = <GIC_SPI 93 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>;
+				status = "disabled";
+			};
 		};
 
 		gic: interrupt-controller at c4301000 {
@@ -234,6 +250,30 @@
 						function = "sdcard";
 					};
 				};
+
+				uart_a_pins: uart_a {
+					mux {
+						groups = "uart_tx_a",
+						       "uart_rx_a";
+						function = "uart_a";
+					};
+				};
+
+				uart_b_pins: uart_b {
+					mux {
+						groups = "uart_tx_b",
+						       "uart_rx_b";
+						function = "uart_b";
+					};
+				};
+
+				uart_c_pins: uart_c {
+					mux {
+						groups = "uart_tx_c",
+						       "uart_rx_c";
+						function = "uart_c";
+					};
+				};
 			};
 		};
 
-- 
2.7.4
