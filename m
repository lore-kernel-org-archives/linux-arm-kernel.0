From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Sun, 15 Jan 2017 23:20:29 +0100
Subject: [PATCH 2/2] ARM64: dts: meson-gx: add the missing uart_AO_B
In-Reply-To: <20170115222029.8271-1-martin.blumenstingl@googlemail.com>
References: <20170115222029.8271-1-martin.blumenstingl@googlemail.com>
Message-ID: <20170115222029.8271-3-martin.blumenstingl@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the missing node for the uart_AO_B port to the meson-gx.dtsi
(as this is supported by GXBB, GXL and GXM) along with the required
pinctrl pins. This is required as some boards are using it (the boards
from the Khadas VIM series for example have it exposed on the pin
headers).

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi   | 8 ++++++++
 arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 7 +++++++
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi  | 7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
index cddad8c795ec..5ece505dca71 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx.dtsi
@@ -324,6 +324,14 @@
 				status = "disabled";
 			};
 
+			uart_AO_B: serial at 4e0 {
+				compatible = "amlogic,meson-uart";
+				reg = <0x0 0x004e0 0x0 0x14>;
+				interrupts = <GIC_SPI 197 IRQ_TYPE_EDGE_RISING>;
+				clocks = <&xtal>;
+				status = "disabled";
+			};
+
 			ir: ir at 580 {
 				compatible = "amlogic,meson-gxbb-ir";
 				reg = <0x0 0x00580 0x0 0x40>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
index 5d686334f692..474435e21759 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
@@ -138,6 +138,13 @@
 			};
 		};
 
+		uart_ao_b_pins: uart_ao_b {
+			mux {
+				groups = "uart_tx_ao_b", "uart_rx_ao_b";
+				function = "uart_ao_b";
+			};
+		};
+
 		remote_input_ao_pins: remote_input_ao {
 			mux {
 				groups = "remote_input_ao";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index bb2842f8a08f..53ed7a5f50ab 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -82,6 +82,13 @@
 			};
 		};
 
+		uart_ao_b_pins: uart_ao_b {
+			mux {
+				groups = "uart_tx_ao_b", "uart_rx_ao_b";
+				function = "uart_ao_b";
+			};
+		};
+
 		remote_input_ao_pins: remote_input_ao {
 			mux {
 				groups = "remote_input_ao";
-- 
2.11.0
