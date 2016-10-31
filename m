From: narmstrong@baylibre.com (Neil Armstrong)
Date: Mon, 31 Oct 2016 17:44:40 +0100
Subject: [PATCH 2/8] ARM64: dts: meson-gxl: Add pinctrl nodes
In-Reply-To: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
References: <1477932286-27482-1-git-send-email-narmstrong@baylibre.com>
Message-ID: <1477932286-27482-3-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add pinctrl nodes and pin definitions for Amlogic Meson GXL.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxl.dtsi | 168 +++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
index 13b10ee..ce7f550 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl.dtsi
@@ -42,7 +42,175 @@
  */
 
 #include "meson-gx.dtsi"
+#include <dt-bindings/gpio/meson-gxl-gpio.h>
 
 / {
 	compatible = "amlogic,meson-gxl";
 };
+
+&aobus {
+	pinctrl_aobus: pinctrl at 14 {
+		compatible = "amlogic,meson-gxl-aobus-pinctrl";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpio_ao: bank at 14 {
+			reg = <0x0 0x00014 0x0 0x8>,
+			      <0x0 0x0002c 0x0 0x4>,
+			      <0x0 0x00024 0x0 0x8>;
+			reg-names = "mux", "pull", "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		uart_ao_a_pins: uart_ao_a {
+			mux {
+				groups = "uart_tx_ao_a", "uart_rx_ao_a";
+				function = "uart_ao";
+			};
+		};
+
+		remote_input_ao_pins: remote_input_ao {
+			mux {
+				groups = "remote_input_ao";
+				function = "remote_input_ao";
+			};
+		};
+	};
+};
+
+&periphs {
+	pinctrl_periphs: pinctrl at 4b0 {
+		compatible = "amlogic,meson-gxl-periphs-pinctrl";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		gpio: bank at 4b0 {
+			reg = <0x0 0x004b0 0x0 0x28>,
+			      <0x0 0x004e8 0x0 0x14>,
+			      <0x0 0x00120 0x0 0x14>,
+			      <0x0 0x00430 0x0 0x40>;
+			reg-names = "mux", "pull", "pull-enable", "gpio";
+			gpio-controller;
+			#gpio-cells = <2>;
+		};
+
+		emmc_pins: emmc {
+			mux {
+				groups = "emmc_nand_d07",
+				       "emmc_cmd",
+				       "emmc_clk",
+				       "emmc_ds";
+				function = "emmc";
+			};
+		};
+
+		sdcard_pins: sdcard {
+			mux {
+				groups = "sdcard_d0",
+				       "sdcard_d1",
+				       "sdcard_d2",
+				       "sdcard_d3",
+				       "sdcard_cmd",
+				       "sdcard_clk";
+				function = "sdcard";
+			};
+		};
+
+		sdio_pins: sdio {
+			mux {
+				groups = "sdio_d0",
+				       "sdio_d1",
+				       "sdio_d2",
+				       "sdio_d3",
+				       "sdio_cmd",
+				       "sdio_clk";
+				function = "sdio";
+			};
+		};
+
+		sdio_irq_pins: sdio_irq {
+			mux {
+				groups = "sdio_irq";
+				function = "sdio";
+			};
+		};
+
+		uart_a_pins: uart_a {
+			mux {
+				groups = "uart_tx_a",
+				       "uart_rx_a";
+				function = "uart_a";
+			};
+		};
+
+		uart_b_pins: uart_b {
+			mux {
+				groups = "uart_tx_b",
+				       "uart_rx_b";
+				function = "uart_b";
+			};
+		};
+
+		uart_c_pins: uart_c {
+			mux {
+				groups = "uart_tx_c",
+				       "uart_rx_c";
+				function = "uart_c";
+			};
+		};
+
+		i2c_a_pins: i2c_a {
+			mux {
+				groups = "i2c_sck_a",
+				     "i2c_sda_a";
+				function = "i2c_a";
+			};
+		};
+
+		i2c_b_pins: i2c_b {
+			mux {
+				groups = "i2c_sck_b",
+				      "i2c_sda_b";
+				function = "i2c_b";
+			};
+		};
+
+		i2c_c_pins: i2c_c {
+			mux {
+				groups = "i2c_sck_c",
+				      "i2c_sda_c";
+				function = "i2c_c";
+			};
+		};
+
+		eth_pins: eth_c {
+			mux {
+				groups = "eth_mdio",
+				       "eth_mdc",
+				       "eth_clk_rx_clk",
+				       "eth_rx_dv",
+				       "eth_rxd0",
+				       "eth_rxd1",
+				       "eth_rxd2",
+				       "eth_rxd3",
+				       "eth_rgmii_tx_clk",
+				       "eth_tx_en",
+				       "eth_txd0",
+				       "eth_txd1",
+				       "eth_txd2",
+				       "eth_txd3";
+				function = "eth";
+			};
+		};
+
+		pwm_e_pins: pwm_e {
+			mux {
+				groups = "pwm_e";
+				function = "pwm_e";
+			};
+		};
+	};
+};
-- 
1.9.1
