From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Thu, 4 Jan 2018 17:40:54 +0800
Subject: [PATCH 04/12] arm64: dts: mt7622: add pinctrl related device nodes
In-Reply-To: <cover.1515057696.git.sean.wang@mediatek.com>
References: <cover.1515057696.git.sean.wang@mediatek.com>
Message-ID: <7900763f8b447613ca335c87e827b895cb550490.1515057696.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

add pinctrl device nodes and rfb1 board, additionally include all pin
groups possible being used on rfb1 board.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts | 200 +++++++++++++++++++++++++++
 arch/arm64/boot/dts/mediatek/mt7622.dtsi     |   7 +
 2 files changed, 207 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
index c08309d..c77e77a 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
+++ b/arch/arm64/boot/dts/mediatek/mt7622-rfb1.dts
@@ -7,6 +7,8 @@
  */
 
 /dts-v1/;
+#include <dt-bindings/input/input.h>
+
 #include "mt7622.dtsi"
 
 / {
@@ -17,11 +19,209 @@
 		bootargs = "console=ttyS0,115200n1";
 	};
 
+	gpio_keys {
+		compatible = "gpio-keys-polled";
+		poll-interval = <100>;
+
+		factory {
+			label = "factory";
+			linux,code = <BTN_0>;
+			gpios = <&pio 0 0>;
+		};
+
+		wps {
+			label = "wps";
+			linux,code = <KEY_WPS_BUTTON>;
+			gpios = <&pio 102 0>;
+		};
+	};
+
 	memory {
 		reg = <0 0x40000000 0 0x3F000000>;
 	};
 };
 
+&pio {
+	/* eMMC is shared pin with parallel NAND */
+	emmc_pins_default: emmc-pins-default {
+		mux {
+			function = "emmc", "emmc_rst";
+			groups = "emmc";
+		};
+	};
+
+	emmc_pins_uhs: emmc-pins-uhs {
+		mux {
+			function = "emmc";
+			groups = "emmc";
+		};
+	};
+
+	eth_pins: eth-pins {
+		mux {
+			function = "eth";
+			groups = "mdc_mdio", "rgmii_via_gmac2";
+		};
+	};
+
+	i2c1_pins: i2c1-pins {
+		mux {
+			function = "i2c";
+			groups =  "i2c1_0";
+		};
+	};
+
+	i2c2_pins: i2c2-pins {
+		mux {
+			function = "i2c";
+			groups =  "i2c2_0";
+		};
+	};
+
+	i2s1_pins: i2s1-pins {
+		mux {
+			function = "i2s";
+			groups =  "i2s_out_bclk_ws_mclk",
+				  "i2s1_in_data",
+				  "i2s1_out_data";
+		};
+	};
+
+	irrx_pins: irrx-pins {
+		mux {
+			function = "ir";
+			groups =  "ir_1_rx";
+		};
+	};
+
+	irtx_pins: irtx-pins {
+		mux {
+			function = "ir";
+			groups =  "ir_1_tx";
+		};
+	};
+
+	/* Parallel nand is shared pin with eMMC */
+	parallel_nand_pins: parallel-nand-pins {
+		mux {
+			function = "flash";
+			groups = "par_nand";
+		};
+	};
+
+	pcie0_pins: pcie0-pins {
+		mux {
+			groups = "pcie0_pad_perst",
+				 "pcie0_1_waken",
+				 "pcie0_1_clkreq";
+			function = "pcie";
+		};
+	};
+
+	pcie1_pins: pcie1-pins {
+		mux {
+			groups = "pcie1_pad_perst",
+				 "pcie1_0_waken",
+				 "pcie1_0_clkreq";
+			function = "pcie";
+		};
+	};
+
+	pmic_bus_pins: pmic-bus-pins {
+		mux {
+			groups = "pmic_bus";
+			function = "pmic";
+		};
+	};
+
+	pwm7_pins: pwm1-2-pins {
+		mux {
+			function = "pwm";
+			groups = "pwm_ch7_2";
+		};
+	};
+
+	wled_pins: wled-pins {
+		mux {
+			function = "led";
+			groups = "wled";
+		};
+	};
+
+	sd0_pins_default: sd0-pins-default {
+		mux {
+			function = "sd";
+			groups = "sd_0";
+		};
+	};
+
+	sd0_pins_uhs: sd0-pins-uhs {
+		mux {
+			function = "sd";
+			groups = "sd_0";
+		};
+	};
+
+	/* Serial NAND is shared pin with SPI-NOR */
+	serial_nand_pins: serial-nand-pins {
+		mux {
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+
+	spic0_pins: spic0-pins {
+		mux {
+			function = "spi";
+			groups = "spic0_0";
+		};
+	};
+
+	spic1_pins: spic1-pins {
+		mux {
+			function = "spi";
+			groups = "spic1_0";
+		};
+	};
+
+	/* SPI-NOR is shared pin with serial NAND */
+	spi_nor_pins: spi-nor-pins {
+		mux {
+			function = "flash";
+			groups = "spi_nor";
+		};
+	};
+
+	/* serial NAND is shared pin with SPI-NOR */
+	serial_nand_pins: serial-nand-pins {
+		mux {
+			function = "flash";
+			groups = "snfi";
+		};
+	};
+
+	uart0_pins: uart0-pins {
+		mux {
+			function = "uart";
+			groups = "uart0_0_tx_rx" ;
+		};
+	};
+
+	uart2_pins: uart2-pins {
+		mux {
+			function = "uart";
+			groups = "uart2_1_tx_rx" ;
+		};
+	};
+
+	watchdog_pins: watchdog-pins {
+		mux {
+			function = "watchdog";
+			groups = "watchdog";
+		};
+	};
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt7622.dtsi b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
index 6fdc449..a531278 100644
--- a/arch/arm64/boot/dts/mediatek/mt7622.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt7622.dtsi
@@ -147,6 +147,13 @@
 		#clock-cells = <1>;
 	};
 
+	pio: pinctrl at 10211000 {
+		compatible = "mediatek,mt7622-pinctrl";
+		reg = <0 0x10211000 0 0x1000>;
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	gic: interrupt-controller at 10300000 {
 		compatible = "arm,gic-400";
 		interrupt-controller;
-- 
2.7.4
