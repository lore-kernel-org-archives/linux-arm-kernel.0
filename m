From: yixun.lan@amlogic.com (Yixun Lan)
Date: Fri, 5 Jan 2018 17:56:19 +0800
Subject: [PATCH 4/6] ARM64: dts: meson-axg: uart: Add the pinctrl info
 description
In-Reply-To: <20180105095621.196472-1-yixun.lan@amlogic.com>
References: <20180105095621.196472-1-yixun.lan@amlogic.com>
Message-ID: <20180105095621.196472-5-yixun.lan@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Describe the pinctrl info for the UART controller which found
in the Meson-AXG SoCs.

Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
---
 arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 96 ++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
index f6bf01cfff4b..78bb206e2897 100644
--- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
@@ -303,6 +303,70 @@
 						function = "pwm_d";
 					};
 				};
+
+				uart_a_pins: uart_a {
+					mux {
+						groups = "uart_tx_a",
+							"uart_rx_a";
+						function = "uart_a";
+					};
+				};
+
+				uart_a_cts_rts_pins: uart_a_cts_rts {
+					mux {
+						groups = "uart_ctx_a",
+							"uart_rts_a";
+						function = "uart_a";
+					};
+				};
+
+				uart_b_x_pins: uart_b_x {
+					mux {
+						groups = "uart_tx_b_x",
+							"uart_rx_b_x";
+						function = "uart_b";
+					};
+				};
+
+				uart_b_x_cts_rts_pins: uart_b_x_cts_rts {
+					mux {
+						groups = "uart_cts_b_x",
+							"uart_rts_b_x";
+						function = "uart_b";
+					};
+				};
+
+				uart_b_z_pins: uart_b_z {
+					mux {
+						groups = "uart_tx_b_z",
+							"uart_rx_b_z";
+						function = "uart_b";
+					};
+				};
+
+				uart_b_z_cts_rts_pins: uart_b_z_cts_rts {
+					mux {
+						groups = "uart_cts_b_z",
+							"uart_rts_b_z";
+						function = "uart_b";
+					};
+				};
+
+				uart_ao_b_z_pins: uart_ao_b_z {
+					mux {
+						groups = "uart_ao_tx_b_z",
+							"uart_ao_rx_b_z";
+						function = "uart_ao_b_groupz";
+					};
+				};
+
+				uart_ao_b_z_cts_rts_pins: uart_ao_b_z_cts_rts {
+					mux {
+						groups = "uart_ao_cts_b_z",
+							"uart_ao_rts_b_z";
+						function = "uart_ao_b_groupz";
+					};
+				};
 			};
 		};
 
@@ -346,6 +410,38 @@
 					#gpio-cells = <2>;
 					gpio-ranges = <&pinctrl_aobus 0 0 15>;
 				};
+
+				uart_ao_a_pins: uart_ao_a {
+					mux {
+						groups = "uart_ao_tx_a",
+							"uart_ao_rx_a";
+						function = "uart_ao_a";
+					};
+				};
+
+				uart_ao_a_cts_rts_pins: uart_ao_a_cts_rts {
+					mux {
+						groups = "uart_ao_cts_a",
+							"uart_ao_rts_a";
+						function = "uart_ao_a";
+					};
+				};
+
+				uart_ao_b_pins: uart_ao_b {
+					mux {
+						groups = "uart_ao_tx_b",
+							"uart_ao_rx_b";
+						function = "uart_ao_b";
+					};
+				};
+
+				uart_ao_b_cts_rts_pins: uart_ao_b_cts_rts {
+					mux {
+						groups = "uart_ao_cts_b",
+							"uart_ao_rts_b";
+						function = "uart_ao_b";
+					};
+				};
 			};
 
 			pwm_AO_ab: pwm at 7000 {
-- 
2.15.1
