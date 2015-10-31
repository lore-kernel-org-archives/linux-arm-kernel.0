From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Sat, 31 Oct 2015 10:24:20 +0800
Subject: [PATCH 3/3] arm64: dts: add Hi6220 pinctrl configuration nodes
In-Reply-To: <1446258260-72902-1-git-send-email-zhongkaihua@huawei.com>
References: <1446258260-72902-1-git-send-email-zhongkaihua@huawei.com>
Message-ID: <1446258260-72902-3-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: add Hi6220 pinctrl configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts   |   1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi        | 243 ++++++++
 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi    | 416 ++++++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi | 684 +++++++++++++++++++++++
 include/dt-bindings/pinctrl/hisi.h               |  59 ++
 5 files changed, 1403 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
 create mode 100644 include/dt-bindings/pinctrl/hisi.h

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index f2b9c98..71a72d7 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -12,6 +12,7 @@
 
 #include "hi6220.dtsi"
 #include "hikey-gpio.dtsi"
+#include "hikey-pinctrl.dtsi"
 
 / {
 	model = "HiKey Development Board";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index c2b8925..8e209c2 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -5,6 +5,7 @@
  */
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/pinctrl/hisi.h>
 
 / {
 	compatible = "hisilicon,hi6220";
@@ -205,5 +206,247 @@
 			clock-names = "apb_pclk";
 			status = "ok";
 		};
+
+		gpio3: gpio at f8014000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8014000 0x0 0x1000>;
+			interrupts = <0 55 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 80 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio4: gpio at f7020000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7020000 0x0 0x1000>;
+			interrupts = <0 56 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 88 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio5: gpio at f7021000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7021000 0x0 0x1000>;
+			interrupts = <0 57 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 96 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio6: gpio at f7022000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7022000 0x0 0x1000>;
+			interrupts = <0 58 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 104 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio7: gpio at f7023000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7023000 0x0 0x1000>;
+			interrupts = <0 59 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 112 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio8: gpio at f7024000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7024000 0x0 0x1000>;
+			interrupts = <0 60 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 120 2 &pmx0 2 2 6>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio9: gpio at f7025000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7025000 0x0 0x1000>;
+			interrupts = <0 61 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 8 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio10: gpio at f7026000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7026000 0x0 0x1000>;
+			interrupts = <0 62 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 0 1 &pmx0 1 16 7>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio11: gpio at f7027000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7027000 0x0 0x1000>;
+			interrupts = <0 63 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 23 3 &pmx0 3 28 5>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio12: gpio at f7028000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7028000 0x0 0x1000>;
+			interrupts = <0 64 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 33 3 &pmx0 3 43 5>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio13: gpio at f7029000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf7029000 0x0 0x1000>;
+			interrupts = <0 65 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 48 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio14: gpio at f702a000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702a000 0x0 0x1000>;
+			interrupts = <0 66 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 56 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio15: gpio at f702b000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702b000 0x0 0x1000>;
+			interrupts = <0 67 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <
+				&pmx0 0 74 6
+				&pmx0 6 122 1
+				&pmx0 7 126 1
+			>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio16: gpio at f702c000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702c000 0x0 0x1000>;
+			interrupts = <0 68 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 127 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio17: gpio at f702d000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702d000 0x0 0x1000>;
+			interrupts = <0 69 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 135 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio18: gpio at f702e000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702e000 0x0 0x1000>;
+			interrupts = <0 70 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 143 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio19: gpio at f702f000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf702f000 0x0 0x1000>;
+			interrupts = <0 71 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			gpio-ranges = <&pmx0 0 151 8>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
index 6eabf40..6f9d94e 100644
--- a/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
@@ -111,18 +111,117 @@
 	gpio_rf_reset1:gpio_rf_reset1 {
 		gpios;
 	};
+	gpio_boot_sel:gpio_boot_sel {
+		gpios = <&gpio10 0 0>;
+	};
 	gpio_pmu_ssi:gpio_pmu_ssi {
 		gpios;
 	};
+	gpio_gps_ref_clk:gpio_gps_ref_clk {
+		gpios = <&gpio8 2 0>;
+	};
+	gpio_sd_clk:gpio_sd_clk {
+		gpios = <&gpio8 3 0>;
+	};
+	gpio_sd_cmd:gpio_sd_cmd {
+		gpios = <&gpio8 4 0>;
+	};
+	gpio_sd_data0:gpio_sd_data0 {
+		gpios = <&gpio8 5 0>;
+	};
+	gpio_sd_data1:gpio_sd_data1 {
+		gpios = <&gpio8 6 0>;
+	};
+	gpio_sd_data2:gpio_sd_data2 {
+		gpios = <&gpio8 7 0>;
+	};
+	gpio_sd_data3:gpio_sd_data3 {
+		gpios = <&gpio9 0 0>;
+	};
 	gpio_unused_002:gpio_unused_002 {
 		gpios;
 	};
+	gpio_mcam_pwdn:gpio_mcam_pwdn {
+		gpios = <&gpio9 1 0>;
+	};
+	gpio_vcm_pwdn:gpio_vcm_pwdn {
+		gpios = <&gpio9 2 0>;
+	};
+	gpio_scam_pwdn:gpio_scam_pwdn {
+		gpios = <&gpio9 3 0>;
+	};
+	gpio_cam_id0:gpio_cam_id0 {
+		gpios = <&gpio9 4 0>;
+	};
+	gpio_cam_id1:gpio_cam_id1 {
+		gpios = <&gpio9 5 0>;
+	};
+	gpio_flash_strobe:gpio_flash_strobe {
+		gpios = <&gpio9 6 0>;
+	};
+	gpio_mcam_mclk:gpio_mcam_mclk {
+		gpios = <&gpio9 7 0>;
+	};
+	gpio_scam_mclk:gpio_scam_mclk {
+		gpios = <&gpio10 1 0>;
+	};
+	gpio_cam_reset0:gpio_cam_reset0 {
+		gpios = <&gpio10 2 0>;
+	};
+	gpio_cam_reset1:gpio_cam_reset1 {
+		gpios = <&gpio10 3 0>;
+	};
+	gpio_tp_rst_n:gpio_tp_rst_n {
+		gpios = <&gpio10 4 0>;
+	};
+	gpio_unused_003:gpio_unused_003 {
+		gpios = <&gpio10 5 0>;
+	};
+	gpio_isp_sda0:gpio_isp_sda0 {
+		gpios = <&gpio10 6 0>;
+	};
+	gpio_isp_scl0:gpio_isp_scl0 {
+		gpios = <&gpio10 7 0>;
+	};
+	gpio_isp_sda1:gpio_isp_sda1 {
+		gpios = <&gpio11 0 0>;
+	};
+	gpio_isp_scl1:gpio_isp_scl1 {
+		gpios = <&gpio11 1 0>;
+	};
+	gpio_mdm_rst:gpio_mdm_rst {
+		gpios = <&gpio11 2 0>;
+	};
 	gpio_hkadc_ssi:gpio_hkadc_ssi {
 		gpios;
 	};
 	gpio_codec_clk:gpio_codec_clk {
 		gpios;
 	};
+	gpio_ap_wakeup_mdm:gpio_ap_wakeup_mdm {
+		gpios = <&gpio11 3 0>;
+	};
+	gpio_codec_sync:gpio_codec_sync {
+		gpios = <&gpio11 4 0>;
+	};
+	gpio_codec_datain:gpio_codec_datain {
+		gpios = <&gpio11 5 0>;
+	};
+	gpio_codec_dataout:gpio_codec_dataout {
+		gpios = <&gpio11 6 0>;
+	};
+	gpio_fm_xclk:gpio_fm_xclk {
+		gpios = <&gpio11 7 0>;
+	};
+	gpio_fm_xfs:gpio_fm_xfs {
+		gpios = <&gpio12 0 0>;
+	};
+	gpio_fm_di:gpio_fm_di {
+		gpios = <&gpio12 1 0>;
+	};
+	gpio_fm_do:gpio_fm_do {
+		gpios = <&gpio12 2 0>;
+	};
 	gpio_bt_xclk:gpio_bt_xclk {
 		gpios;
 	};
@@ -144,6 +243,69 @@
 	gpio_usim0_rst:gpio_usim0_rst {
 		gpios;
 	};
+	gpio_usim1_clk:gpio_usim1_clk {
+		gpios = <&gpio12 3 0>;
+	};
+	gpio_usim1_data:gpio_usim1_data {
+		gpios = <&gpio12 4 0>;
+	};
+	gpio_usim1_rst:gpio_usim1_rst {
+		gpios = <&gpio12 5 0>;
+	};
+	gpio_unused_004:gpio_unused_004 {
+		gpios = <&gpio12 6 0>;
+	};
+	gpio_unused_005:gpio_unused_005 {
+		gpios = <&gpio12 7 0>;
+	};
+	gpio_uart0_rxd:gpio_uart0_rxd {
+		gpios = <&gpio13 0 0>;
+	};
+	gpio_uart0_txd:gpio_uart0_txd {
+		gpios = <&gpio13 1 0>;
+	};
+	gpio_bt_uart_cts_n:gpio_bt_uart_cts_n {
+		gpios = <&gpio13 2 0>;
+	};
+	gpio_bt_uart_rts_n:gpio_bt_uart_rts_n {
+		gpios = <&gpio13 3 0>;
+	};
+	gpio_bt_uart_rxd:gpio_bt_uart_rxd {
+		gpios = <&gpio13 4 0>;
+	};
+	gpio_bt_uart_txd:gpio_bt_uart_txd {
+		gpios = <&gpio13 5 0>;
+	};
+	gpio_gps_uart_cts_n:gpio_gps_uart_cts_n {
+		gpios = <&gpio13 6 0>;
+	};
+	gpio_gps_uart_rts_n:gpio_gps_uart_rts_n {
+		gpios = <&gpio13 7 0>;
+	};
+	gpio_gps_uart_rxd:gpio_gps_uart_rxd {
+		gpios = <&gpio14 0 0>;
+	};
+	gpio_gps_uart_txd:gpio_gps_uart_txd {
+		gpios = <&gpio14 1 0>;
+	};
+	gpio_i2c0_scl:gpio_i2c0_scl {
+		gpios = <&gpio14 2 0>;
+	};
+	gpio_i2c0_sda:gpio_i2c0_sda {
+		gpios = <&gpio14 3 0>;
+	};
+	gpio_i2c1_scl:gpio_i2c1_scl {
+		gpios = <&gpio14 4 0>;
+	};
+	gpio_i2c1_sda:gpio_i2c1_sda {
+		gpios = <&gpio14 5 0>;
+	};
+	gpio_i2c2_scl:gpio_i2c2_scl {
+		gpios = <&gpio14 6 0>;
+	};
+	gpio_i2c2_sda:gpio_i2c2_sda {
+		gpios = <&gpio14 7 0>;
+	};
 	gpio_emmc_clk:gpio_emmc_clk {
 		gpios;
 	};
@@ -180,9 +342,164 @@
 	gpio_unused_006:gpio_unused_006 {
 		gpios;
 	};
+	gpio_sdio_clk:gpio_sdio_clk {
+		gpios = <&gpio15 0 0>;
+	};
+	gpio_sdio_cmd:gpio_sdio_cmd {
+		gpios = <&gpio15 1 0>;
+	};
+	gpio_sdio_data0:gpio_sdio_data0 {
+		gpios = <&gpio15 2 0>;
+	};
+	gpio_sdio_data1:gpio_sdio_data1 {
+		gpios = <&gpio15 3 0>;
+	};
+	gpio_sdio_data2:gpio_sdio_data2 {
+		gpios = <&gpio15 4 0>;
+	};
+	gpio_sdio_data3:gpio_sdio_data3 {
+		gpios = <&gpio15 5 0>;
+	};
 	gpio_unused_007:gpio_unused_007 {
 		gpios;
 	};
+	/* LCB: GPIO3_0, on J15, as general purpose input */
+	gpio_j15_3_0:gpio_j15_3_0 {
+		gpios = <&gpio3 0 0>;
+	};
+	gpio_jtag_sel0:gpio_jtag_sel0 {
+		gpios = <&gpio3 1 0>;
+	};
+	gpio_jtag_sel1:gpio_jtag_sel1 {
+		gpios = <&gpio3 2 0>;
+	};
+	gpio_lcd_rst_n:gpio_lcd_rst_n {
+		gpios = <&gpio3 3 0>;
+	};
+	gpio_aux_ssi0:gpio_aux_ssi0 {
+		gpios = <&gpio3 4 0>;
+	};
+	/* LCB: WLAN_ACTIVE_GPIO3_5, connects to led, as general purpose */
+	gpio_wlan_active_led:gpio_wlan_active_led {
+		gpios = <&gpio3 5 0>;
+	};
+	gpio_unused_008:gpio_unused_008 {
+		gpios = <&gpio3 6 0>;
+	};
+	gpio_ap_wakeup_bt:gpio_ap_wakeup_bt {
+		gpios = <&gpio3 7 0>;
+	};
+	/* LCB: USER_LED1_GPIO4_0 */
+	gpio_user_led_1:gpio_user_led_1 {
+		gpios = <&gpio4 0 0>;
+	};
+	/* LCB: USER_LED1_GPIO4_1 */
+	gpio_user_led_2:gpio_user_led_2 {
+		gpios = <&gpio4 1 0>;
+	};
+	/* LCB: USER_LED1_GPIO4_2 */
+	gpio_user_led_3:gpio_user_led_3 {
+		gpios = <&gpio4 2 0>;
+	};
+	/* LCB: USER_LED1_GPIO4_3 */
+	gpio_user_led_4:gpio_user_led_4 {
+		gpios = <&gpio4 3 0>;
+	};
+	gpio_i2c3_scl:gpio_i2c3_scl {
+		gpios = <&gpio4 4 0>;
+	};
+	gpio_i2c3_sda:gpio_i2c3_sda {
+		gpios = <&gpio4 5 0>;
+	};
+	gpio_wlan_bt_priority:gpio_wlan_bt_priority {
+		gpios = <&gpio4 6 0>;
+	};
+	/* LCB: BT_ACTIVE_GPIO4_7, connects to led, as general purpose */
+	gpio_bt_active_led:gpio_bt_active_led {
+		gpios = <&gpio4 7 0>;
+	};
+	gpio_uart3_cts_n:gpio_uart3_cts_n {
+		gpios = <&gpio5 0 0>;
+	};
+	gpio_uart3_rts_n:gpio_uart3_rts_n {
+		gpios = <&gpio5 1 0>;
+	};
+	gpio_uart3_rxd:gpio_uart3_rxd {
+		gpios = <&gpio5 2 0>;
+	};
+	gpio_uart3_txd:gpio_uart3_txd {
+		gpios = <&gpio5 3 0>;
+	};
+	gpio_aux_ssi1:gpio_aux_ssi1 {
+		gpios = <&gpio5 4 0>;
+	};
+	gpio_unused_009:gpio_unused_009 {
+		gpios = <&gpio5 5 0>;
+	};
+	gpio_modem_pcm_xclk:gpio_modem_pcm_xclk {
+		gpios = <&gpio5 6 0>;
+	};
+	gpio_modem_pcm_xfs:gpio_modem_pcm_xfs {
+		gpios = <&gpio5 7 0>;
+	};
+	gpio_spi0_di:gpio_spi0_di {
+		gpios = <&gpio6 0 0>;
+	};
+	gpio_spi0_do:gpio_spi0_do {
+		gpios = <&gpio6 1 0>;
+	};
+	gpio_spi0_cs_n:gpio_spi0_cs_n {
+		gpios = <&gpio6 2 0>;
+	};
+	gpio_spi0_clk:gpio_spi0_clk {
+		gpios = <&gpio6 3 0>;
+	};
+	gpio_lte_tx_active:gpio_lte_tx_active {
+		gpios = <&gpio6 4 0>;
+	};
+	gpio_lte_rx_active:gpio_lte_rx_active {
+		gpios = <&gpio6 5 0>;
+	};
+	gpio_lcd_id0:gpio_lcd_id0 {
+		gpios = <&gpio6 6 0>;
+	};
+	/* LCB: GPIO6_7_DSI_TE0 */
+	gpio_dsi_te0:gpio_dsi_te0 {
+		gpios = <&gpio6 7 0>;
+	};
+	gpio_lcd_id1:gpio_lcd_id1 {
+		gpios = <&gpio7 0 0>;
+	};
+	gpio_volume1_n:gpio_volume1_n {
+		gpios = <&gpio7 1 0>;
+	};
+	gpio_uart5_rxd:gpio_uart5_rxd {
+		gpios = <&gpio7 2 0>;
+	};
+	gpio_uart5_txd:gpio_uart5_txd {
+		gpios = <&gpio7 3 0>;
+	};
+	gpio_modem_pcm_di:gpio_modem_pcm_di {
+		gpios = <&gpio7 4 0>;
+	};
+	gpio_modem_pcm_do:gpio_modem_pcm_do {
+		gpios = <&gpio7 5 0>;
+	};
+	gpio_uart4_rxd:gpio_uart4_rxd {
+		gpios = <&gpio7 6 0>;
+	};
+	gpio_uart4_txd:gpio_uart4_txd {
+		gpios = <&gpio7 7 0>;
+	};
+	gpio_ap_wakeup_wl:gpio_ap_wakeup_wl {
+		gpios = <&gpio8 0 0>;
+	};
+	gpio_mdm_pwr_en:gpio_mdm_pwr_en {
+		gpios = <&gpio8 1 0>;
+	};
+	gpio_tcxo0_afc:gpio_tcxo0_afc {
+		gpios = <&gpio15 6 0>;
+	};
 	gpio_rf_ssi0:gpio_rf_ssi0 {
 		gpios;
 	};
@@ -192,4 +509,103 @@
 	gpio_rf_mipi_clk0:gpio_rf_mipi_clk0 {
 		gpios;
 	};
+	gpio_rf_mipi_data0:gpio_rf_mipi_data0 {
+		gpios = <&gpio15 7 0>;
+	};
+	gpio_flash_mask:gpio_flash_mask {
+		gpios = <&gpio16 0 0>;
+	};
+	gpio_gps_blanking:gpio_gps_blanking {
+		gpios = <&gpio16 1 0>;
+	};
+	gpio_rf_gpio_2:gpio_rf_gpio_2 {
+		gpios = <&gpio16 2 0>;
+	};
+	gpio_rf_gpio_3:gpio_rf_gpio_3 {
+		gpios = <&gpio16 3 0>;
+	};
+	gpio_rf_gpio_4:gpio_rf_gpio_4 {
+		gpios = <&gpio16 4 0>;
+	};
+	gpio_rf_gpio_5:gpio_rf_gpio_5 {
+		gpios = <&gpio16 5 0>;
+	};
+	gpio_rf_gpio_6:gpio_rf_gpio_6 {
+		gpios = <&gpio16 6 0>;
+	};
+	gpio_rf_gpio_7:gpio_rf_gpio_7 {
+		gpios = <&gpio16 7 0>;
+	};
+	gpio_rf_gpio_8:gpio_rf_gpio_8 {
+		gpios = <&gpio17 0 0>;
+	};
+	gpio_rf_gpio_9:gpio_rf_gpio_9 {
+		gpios = <&gpio17 1 0>;
+	};
+	gpio_rf_gpio_10:gpio_rf_gpio_10 {
+		gpios = <&gpio17 2 0>;
+	};
+	gpio_rf_gpio_11:gpio_rf_gpio_11 {
+		gpios = <&gpio17 3 0>;
+	};
+	gpio_rf_gpio_12:gpio_rf_gpio_12 {
+		gpios = <&gpio17 4 0>;
+	};
+	gpio_rf_gpio_13:gpio_rf_gpio_13 {
+		gpios = <&gpio17 5 0>;
+	};
+	gpio_rf_gpio_14:gpio_rf_gpio_14 {
+		gpios = <&gpio17 6 0>;
+	};
+	gpio_rf_gpio_15:gpio_rf_gpio_15 {
+		gpios = <&gpio17 7 0>;
+	};
+	gpio_rf_gpio_16:gpio_rf_gpio_16 {
+		gpios = <&gpio18 0 0>;
+	};
+	gpio_rf_gpio_17:gpio_rf_gpio_17 {
+		gpios = <&gpio18 1 0>;
+	};
+	gpio_rf_gpio_18:gpio_rf_gpio_18 {
+		gpios = <&gpio18 2 0>;
+	};
+	gpio_rf_gpio_19:gpio_rf_gpio_19 {
+		gpios = <&gpio18 3 0>;
+	};
+	gpio_rf_gpio_20:gpio_rf_gpio_20 {
+		gpios = <&gpio18 4 0>;
+	};
+	gpio_rf_gpio_21:gpio_rf_gpio_21 {
+		gpios = <&gpio18 5 0>;
+	};
+	gpio_rf_gpio_22:gpio_rf_gpio_22 {
+		gpios = <&gpio18 6 0>;
+	};
+	gpio_rf_gpio_23:gpio_rf_gpio_23 {
+		gpios = <&gpio18 7 0>;
+	};
+	gpio_rf_gpio_24:gpio_rf_gpio_24 {
+		gpios = <&gpio19 0 0>;
+	};
+	gpio_rf_gpio_25:gpio_rf_gpio_25 {
+		gpios = <&gpio19 1 0>;
+	};
+	gpio_rf_gpio_26:gpio_rf_gpio_26 {
+		gpios = <&gpio19 2 0>;
+	};
+	gpio_rf_ssi1:gpio_rf_ssi1 {
+		gpios = <&gpio19 3 0>;
+	};
+	gpio_rf_tcvr_on1:gpio_rf_tcvr_on1 {
+		gpios = <&gpio19 4 0>;
+	};
+	gpio_rf_gpio_29:gpio_rf_gpio_29 {
+		gpios = <&gpio19 5 0>;
+	};
+	gpio_rf_gpio_30:gpio_rf_gpio_30 {
+		gpios = <&gpio19 6 0>;
+	};
+	gpio_apt_pdm0:gpio_apt_pdm0 {
+		gpios = <&gpio19 7 0>;
+	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi b/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
new file mode 100644
index 0000000..f0769b4
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey-pinctrl.dtsi
@@ -0,0 +1,684 @@
+/*
+ * pinctrl dts file for	Hisilicon HiKey development board
+ *
+ */
+#include <dt-bindings/pinctrl/hisi.h>
+
+/ {
+	soc {
+		pmx0: pinmux at f7010000 {
+			pinctrl-names =	"default";
+			pinctrl-0 = <
+				&boot_sel_pmx_func
+				&hkadc_ssi_pmx_func
+				&codec_clk_pmx_func
+				&pwm_in_pmx_func
+				&bl_pwm_pmx_func
+				>;
+
+			boot_sel_pmx_func: boot_sel_pmx_func {
+				pinctrl-single,pins = <
+					0x0    MUX_M0	/* BOOT_SEL	(IOMG000) */
+				>;
+			};
+
+			emmc_pmx_func: emmc_pmx_func {
+				pinctrl-single,pins = <
+					0x100  MUX_M0	/* EMMC_CLK	(IOMG064) */
+					0x104  MUX_M0	/* EMMC_CMD	(IOMG065) */
+					0x108  MUX_M0	/* EMMC_DATA0	(IOMG066) */
+					0x10c  MUX_M0	/* EMMC_DATA1	(IOMG067) */
+					0x110  MUX_M0	/* EMMC_DATA2	(IOMG068) */
+					0x114  MUX_M0	/* EMMC_DATA3	(IOMG069) */
+					0x118  MUX_M0	/* EMMC_DATA4	(IOMG070) */
+					0x11c  MUX_M0	/* EMMC_DATA5	(IOMG071) */
+					0x120  MUX_M0	/* EMMC_DATA6	(IOMG072) */
+					0x124  MUX_M0	/* EMMC_DATA7	(IOMG073) */
+				>;
+			};
+
+			sd_pmx_func: sd_pmx_func {
+				pinctrl-single,pins = <
+					0xc    MUX_M0	/* SD_CLK	(IOMG003) */
+					0x10   MUX_M0	/* SD_CMD	(IOMG004) */
+					0x14   MUX_M0	/* SD_DATA0	(IOMG005) */
+					0x18   MUX_M0	/* SD_DATA1	(IOMG006) */
+					0x1c   MUX_M0	/* SD_DATA2	(IOMG007) */
+					0x20   MUX_M0	/* SD_DATA3	(IOMG008) */
+				>;
+			};
+			sd_pmx_idle: sd_pmx_idle {
+				pinctrl-single,pins = <
+					0xc    MUX_M1	/* SD_CLK	(IOMG003) */
+					0x10   MUX_M1	/* SD_CMD	(IOMG004) */
+					0x14   MUX_M1	/* SD_DATA0	(IOMG005) */
+					0x18   MUX_M1	/* SD_DATA1	(IOMG006) */
+					0x1c   MUX_M1	/* SD_DATA2	(IOMG007) */
+					0x20   MUX_M1	/* SD_DATA3	(IOMG008) */
+				>;
+			};
+
+			sdio_pmx_func: sdio_pmx_func {
+				pinctrl-single,pins = <
+					0x128  MUX_M0	/* SDIO_CLK	(IOMG074) */
+					0x12c  MUX_M0	/* SDIO_CMD	(IOMG075) */
+					0x130  MUX_M0	/* SDIO_DATA0	(IOMG076) */
+					0x134  MUX_M0	/* SDIO_DATA1	(IOMG077) */
+					0x138  MUX_M0	/* SDIO_DATA2	(IOMG078) */
+					0x13c  MUX_M0	/* SDIO_DATA3	(IOMG079) */
+				>;
+			};
+			sdio_pmx_idle: sdio_pmx_idle {
+				pinctrl-single,pins = <
+					0x128  MUX_M1	/* SDIO_CLK	(IOMG074) */
+					0x12c  MUX_M1	/* SDIO_CMD	(IOMG075) */
+					0x130  MUX_M1	/* SDIO_DATA0	(IOMG076) */
+					0x134  MUX_M1	/* SDIO_DATA1	(IOMG077) */
+					0x138  MUX_M1	/* SDIO_DATA2	(IOMG078) */
+					0x13c  MUX_M1	/* SDIO_DATA3	(IOMG079) */
+				>;
+			};
+
+			isp_pmx_func: isp_pmx_func {
+				pinctrl-single,pins = <
+					0x24   MUX_M0	/* ISP_PWDN0	(IOMG009) */
+					0x28   MUX_M0	/* ISP_PWDN1	(IOMG010) */
+					0x2c   MUX_M0	/* ISP_PWDN2	(IOMG011) */
+					0x30   MUX_M1	/* ISP_SHUTTER0	(IOMG012) */
+					0x34   MUX_M1	/* ISP_SHUTTER1	(IOMG013) */
+					0x38   MUX_M1	/* ISP_PWM	(IOMG014) */
+					0x3c   MUX_M0	/* ISP_CCLK0	(IOMG015) */
+					0x40   MUX_M0	/* ISP_CCLK1	(IOMG016) */
+					0x44   MUX_M0	/* ISP_RESETB0	(IOMG017) */
+					0x48   MUX_M0	/* ISP_RESETB1	(IOMG018) */
+					0x4c   MUX_M1	/* ISP_STROBE0	(IOMG019) */
+					0x50   MUX_M1	/* ISP_STROBE1	(IOMG020) */
+					0x54   MUX_M0	/* ISP_SDA0	(IOMG021) */
+					0x58   MUX_M0	/* ISP_SCL0	(IOMG022) */
+					0x5c   MUX_M0	/* ISP_SDA1	(IOMG023) */
+					0x60   MUX_M0	/* ISP_SCL1	(IOMG024) */
+				>;
+			};
+
+			hkadc_ssi_pmx_func: hkadc_ssi_pmx_func {
+				pinctrl-single,pins = <
+					0x68   MUX_M0	/* HKADC_SSI	(IOMG026) */
+				>;
+			};
+
+			codec_clk_pmx_func: codec_clk_pmx_func {
+				pinctrl-single,pins = <
+					0x6c   MUX_M0	/* CODEC_CLK	(IOMG027) */
+				>;
+			};
+
+			codec_pmx_func:	codec_pmx_func {
+				pinctrl-single,pins = <
+					0x70   MUX_M1	/* DMIC_CLK	(IOMG028) */
+					0x74   MUX_M0	/* CODEC_SYNC	(IOMG029) */
+					0x78   MUX_M0	/* CODEC_DI	(IOMG030) */
+					0x7c   MUX_M0	/* CODEC_DO	(IOMG031) */
+				>;
+			};
+
+			fm_pmx_func: fm_pmx_func {
+				pinctrl-single,pins = <
+					0x80   MUX_M1	/* FM_XCLK	(IOMG032) */
+					0x84   MUX_M1	/* FM_XFS	(IOMG033) */
+					0x88   MUX_M1	/* FM_DI	(IOMG034) */
+					0x8c   MUX_M1	/* FM_DO	(IOMG035) */
+				>;
+			};
+
+			bt_pmx_func: bt_pmx_func {
+				pinctrl-single,pins = <
+					0x90   MUX_M0	/* BT_XCLK	(IOMG036) */
+					0x94   MUX_M0	/* BT_XFS	(IOMG037) */
+					0x98   MUX_M0	/* BT_DI	(IOMG038) */
+					0x9c   MUX_M0	/* BT_DO	(IOMG039) */
+				>;
+			};
+
+			pwm_in_pmx_func: pwm_in_pmx_func {
+				pinctrl-single,pins = <
+					0xb8   MUX_M1	/* PWM_IN	(IOMG046) */
+				>;
+			};
+
+			bl_pwm_pmx_func: bl_pwm_pmx_func {
+				pinctrl-single,pins = <
+					0xbc   MUX_M1	/* BL_PWM	(IOMG047) */
+				>;
+			};
+
+			uart0_pmx_func:	uart0_pmx_func {
+				pinctrl-single,pins = <
+					0xc0   MUX_M0	/* UART0_RXD	(IOMG048) */
+					0xc4   MUX_M0	/* UART0_TXD	(IOMG049) */
+				>;
+			};
+
+			uart1_pmx_func:	uart1_pmx_func {
+				pinctrl-single,pins = <
+					0xc8   MUX_M0	/* UART1_CTS_N	(IOMG050) */
+					0xcc   MUX_M0	/* UART1_RTS_N	(IOMG051) */
+					0xd0   MUX_M0	/* UART1_RXD	(IOMG052) */
+					0xd4   MUX_M0	/* UART1_TXD	(IOMG053) */
+				>;
+			};
+
+			uart2_pmx_func:	uart2_pmx_func {
+				pinctrl-single,pins = <
+					0xd8   MUX_M0	/* UART2_CTS_N	(IOMG054) */
+					0xdc   MUX_M0	/* UART2_RTS_N	(IOMG055) */
+					0xe0   MUX_M0	/* UART2_RXD	(IOMG056) */
+					0xe4   MUX_M0	/* UART2_TXD	(IOMG057) */
+				>;
+			};
+
+			uart3_pmx_func:	uart3_pmx_func {
+				pinctrl-single,pins = <
+					0x180  MUX_M1	/* UART3_CTS_N	(IOMG096) */
+					0x184  MUX_M1	/* UART3_RTS_N	(IOMG097) */
+					0x188  MUX_M1	/* UART3_RXD	(IOMG098) */
+					0x18c  MUX_M1	/* UART3_TXD	(IOMG099) */
+				>;
+			};
+
+			uart4_pmx_func:	uart4_pmx_func {
+				pinctrl-single,pins = <
+					0x1d0  MUX_M1	/* UART4_CTS_N	(IOMG116) */
+					0x1d4  MUX_M1	/* UART4_RTS_N	(IOMG117) */
+					0x1d8  MUX_M1	/* UART4_RXD	(IOMG118) */
+					0x1dc  MUX_M1	/* UART4_TXD	(IOMG119) */
+				>;
+			};
+
+			uart5_pmx_func:	uart5_pmx_func {
+				pinctrl-single,pins = <
+					0x1c8  MUX_M1	/* UART5_RXD	(IOMG114) */
+					0x1cc  MUX_M1	/* UART5_TXD	(IOMG115) */
+				>;
+			};
+
+			i2c0_pmx_func: i2c0_pmx_func {
+				pinctrl-single,pins = <
+					0xe8   MUX_M0	/* I2C0_SCL	(IOMG058) */
+					0xec   MUX_M0	/* I2C0_SDA	(IOMG059) */
+				>;
+			};
+
+			i2c1_pmx_func: i2c1_pmx_func {
+				pinctrl-single,pins = <
+					0xf0   MUX_M0	/* I2C1_SCL	(IOMG060) */
+					0xf4   MUX_M0	/* I2C1_SDA	(IOMG061) */
+				>;
+			};
+
+			i2c2_pmx_func: i2c2_pmx_func {
+				pinctrl-single,pins = <
+					0xf8   MUX_M0	/* I2C2_SCL	(IOMG062) */
+					0xfc   MUX_M0	/* I2C2_SDA	(IOMG063) */
+				>;
+			};
+		};
+
+		pmx1: pinmux at f7010800 {
+
+			pinctrl-names =	"default";
+			pinctrl-0 = <
+				&boot_sel_cfg_func
+				&hkadc_ssi_cfg_func
+				&codec_clk_cfg_func
+				&pwm_in_cfg_func
+				&bl_pwm_cfg_func
+				>;
+
+			boot_sel_cfg_func: boot_sel_cfg_func {
+				pinctrl-single,pins = <
+					0x0    0x0	/* BOOT_SEL	(IOCFG000) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			hkadc_ssi_cfg_func: hkadc_ssi_cfg_func {
+				pinctrl-single,pins = <
+					0x6c   0x0	/* HKADC_SSI	(IOCFG027) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			emmc_clk_cfg_func: emmc_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x104  0x0	/* EMMC_CLK	(IOCFG065) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_08MA DRIVE_MASK>;
+			};
+
+			emmc_cfg_func: emmc_cfg_func {
+				pinctrl-single,pins = <
+					0x108  0x0	/* EMMC_CMD	(IOCFG066) */
+					0x10c  0x0	/* EMMC_DATA0	(IOCFG067) */
+					0x110  0x0	/* EMMC_DATA1	(IOCFG068) */
+					0x114  0x0	/* EMMC_DATA2	(IOCFG069) */
+					0x118  0x0	/* EMMC_DATA3	(IOCFG070) */
+					0x11c  0x0	/* EMMC_DATA4	(IOCFG071) */
+					0x120  0x0	/* EMMC_DATA5	(IOCFG072) */
+					0x124  0x0	/* EMMC_DATA6	(IOCFG073) */
+					0x128  0x0	/* EMMC_DATA7	(IOCFG074) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_04MA DRIVE_MASK>;
+			};
+
+			emmc_rst_cfg_func: emmc_rst_cfg_func {
+				pinctrl-single,pins = <
+					0x12c  0x0	/* EMMC_RST_N	(IOCFG075) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_04MA DRIVE_MASK>;
+			};
+
+			sd_clk_cfg_func: sd_clk_cfg_func {
+				pinctrl-single,pins = <
+					0xc    0x0	/* SD_CLK	(IOCFG003) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_10MA DRIVE_MASK>;
+			};
+			sd_clk_cfg_idle: sd_clk_cfg_idle {
+				pinctrl-single,pins = <
+					0xc    0x0	/* SD_CLK	(IOCFG003) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sd_cfg_func: sd_cfg_func {
+				pinctrl-single,pins = <
+					0x10   0x0	/* SD_CMD	(IOCFG004) */
+					0x14   0x0	/* SD_DATA0	(IOCFG005) */
+					0x18   0x0	/* SD_DATA1	(IOCFG006) */
+					0x1c   0x0	/* SD_DATA2	(IOCFG007) */
+					0x20   0x0	/* SD_DATA3	(IOCFG008) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_08MA DRIVE_MASK>;
+			};
+			sd_cfg_idle: sd_cfg_idle {
+				pinctrl-single,pins = <
+					0x10   0x0	/* SD_CMD	(IOCFG004) */
+					0x14   0x0	/* SD_DATA0	(IOCFG005) */
+					0x18   0x0	/* SD_DATA1	(IOCFG006) */
+					0x1c   0x0	/* SD_DATA2	(IOCFG007) */
+					0x20   0x0	/* SD_DATA3	(IOCFG008) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sdio_clk_cfg_func: sdio_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x134  0x0	/* SDIO_CLK	(IOCFG077) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_08MA DRIVE_MASK>;
+			};
+			sdio_clk_cfg_idle: sdio_clk_cfg_idle {
+				pinctrl-single,pins = <
+					0x134  0x0	/* SDIO_CLK	(IOCFG077) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sdio_cfg_func: sdio_cfg_func {
+				pinctrl-single,pins = <
+					0x138  0x0	/* SDIO_CMD	(IOCFG078) */
+					0x13c  0x0	/* SDIO_DATA0	(IOCFG079) */
+					0x140  0x0	/* SDIO_DATA1	(IOCFG080) */
+					0x144  0x0	/* SDIO_DATA2	(IOCFG081) */
+					0x148  0x0	/* SDIO_DATA3	(IOCFG082) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_04MA DRIVE_MASK>;
+			};
+			sdio_cfg_idle: sdio_cfg_idle {
+				pinctrl-single,pins = <
+					0x138  0x0	/* SDIO_CMD	(IOCFG078) */
+					0x13c  0x0	/* SDIO_DATA0	(IOCFG079) */
+					0x140  0x0	/* SDIO_DATA1	(IOCFG080) */
+					0x144  0x0	/* SDIO_DATA2	(IOCFG081) */
+					0x148  0x0	/* SDIO_DATA3	(IOCFG082) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			isp_cfg_func1: isp_cfg_func1 {
+				pinctrl-single,pins = <
+					0x28   0x0	/* ISP_PWDN0	(IOCFG010) */
+					0x2c   0x0	/* ISP_PWDN1	(IOCFG011) */
+					0x30   0x0	/* ISP_PWDN2	(IOCFG012) */
+					0x34   0x0	/* ISP_SHUTTER0	(IOCFG013) */
+					0x38   0x0	/* ISP_SHUTTER1	(IOCFG014) */
+					0x3c   0x0	/* ISP_PWM	(IOCFG015) */
+					0x40   0x0	/* ISP_CCLK0	(IOCFG016) */
+					0x44   0x0	/* ISP_CCLK1	(IOCFG017) */
+					0x48   0x0	/* ISP_RESETB0	(IOCFG018) */
+					0x4c   0x0	/* ISP_RESETB1	(IOCFG019) */
+					0x50   0x0	/* ISP_STROBE0	(IOCFG020) */
+					0x58   0x0	/* ISP_SDA0	(IOCFG022) */
+					0x5c   0x0	/* ISP_SCL0	(IOCFG023) */
+					0x60   0x0	/* ISP_SDA1	(IOCFG024) */
+					0x64   0x0	/* ISP_SCL1	(IOCFG025) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+			isp_cfg_idle1: isp_cfg_idle1 {
+				pinctrl-single,pins = <
+					0x34   0x0	/* ISP_SHUTTER0	(IOCFG013) */
+					0x38   0x0	/* ISP_SHUTTER1	(IOCFG014) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			isp_cfg_func2: isp_cfg_func2 {
+				pinctrl-single,pins = <
+					0x54   0x0	/* ISP_STROBE1	(IOCFG021) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			codec_clk_cfg_func: codec_clk_cfg_func {
+				pinctrl-single,pins = <
+					0x70   0x0	/* CODEC_CLK	(IOCFG028) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_04MA DRIVE_MASK>;
+			};
+			codec_clk_cfg_idle: codec_clk_cfg_idle {
+				pinctrl-single,pins = <
+					0x70   0x0	/* CODEC_CLK	(IOCFG028) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			codec_cfg_func1: codec_cfg_func1 {
+				pinctrl-single,pins = <
+					0x74   0x0	/* DMIC_CLK	(IOCFG029) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			codec_cfg_func2: codec_cfg_func2 {
+				pinctrl-single,pins = <
+					0x78   0x0	/* CODEC_SYNC	(IOCFG030) */
+					0x7c   0x0	/* CODEC_DI	(IOCFG031) */
+					0x80   0x0	/* CODEC_DO	(IOCFG032) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_04MA DRIVE_MASK>;
+			};
+			codec_cfg_idle2: codec_cfg_idle2 {
+				pinctrl-single,pins = <
+					0x78   0x0	/* CODEC_SYNC	(IOCFG030) */
+					0x7c   0x0	/* CODEC_DI	(IOCFG031) */
+					0x80   0x0	/* CODEC_DO	(IOCFG032) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			fm_cfg_func: fm_cfg_func {
+				pinctrl-single,pins = <
+					0x84   0x0	/* FM_XCLK	(IOCFG033) */
+					0x88   0x0	/* FM_XFS	(IOCFG034) */
+					0x8c   0x0	/* FM_DI	(IOCFG035) */
+					0x90   0x0	/* FM_DO	(IOCFG036) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			bt_cfg_func: bt_cfg_func {
+				pinctrl-single,pins = <
+					0x94   0x0	/* BT_XCLK	(IOCFG037) */
+					0x98   0x0	/* BT_XFS	(IOCFG038) */
+					0x9c   0x0	/* BT_DI	(IOCFG039) */
+					0xa0   0x0	/* BT_DO	(IOCFG040) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+			bt_cfg_idle: bt_cfg_idle {
+				pinctrl-single,pins = <
+					0x94   0x0	/* BT_XCLK	(IOCFG037) */
+					0x98   0x0	/* BT_XFS	(IOCFG038) */
+					0x9c   0x0	/* BT_DI	(IOCFG039) */
+					0xa0   0x0	/* BT_DO	(IOCFG040) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			pwm_in_cfg_func: pwm_in_cfg_func {
+				pinctrl-single,pins = <
+					0xbc   0x0	/* PWM_IN	(IOCFG047) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			bl_pwm_cfg_func: bl_pwm_cfg_func {
+				pinctrl-single,pins = <
+					0xc0   0x0	/* BL_PWM	(IOCFG048) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart0_cfg_func1: uart0_cfg_func1 {
+				pinctrl-single,pins = <
+					0xc4   0x0	/* UART0_RXD	(IOCFG049) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart0_cfg_func2: uart0_cfg_func2 {
+				pinctrl-single,pins = <
+					0xc8   0x0	/* UART0_TXD	(IOCFG050) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_04MA DRIVE_MASK>;
+			};
+
+			uart1_cfg_func1: uart1_cfg_func1 {
+				pinctrl-single,pins = <
+					0xcc   0x0	/* UART1_CTS_N	(IOCFG051) */
+					0xd4   0x0	/* UART1_RXD	(IOCFG053) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_UP   PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart1_cfg_func2: uart1_cfg_func2 {
+				pinctrl-single,pins = <
+					0xd0   0x0	/* UART1_RTS_N	(IOCFG052) */
+					0xd8   0x0	/* UART1_TXD	(IOCFG054) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart2_cfg_func:	uart2_cfg_func {
+				pinctrl-single,pins = <
+					0xdc   0x0	/* UART2_CTS_N	(IOCFG055) */
+					0xe0   0x0	/* UART2_RTS_N	(IOCFG056) */
+					0xe4   0x0	/* UART2_RXD	(IOCFG057) */
+					0xe8   0x0	/* UART2_TXD	(IOCFG058) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart3_cfg_func:	uart3_cfg_func {
+				pinctrl-single,pins = <
+					0x190  0x0	/* UART3_CTS_N	(IOCFG100) */
+					0x194  0x0	/* UART3_RTS_N	(IOCFG101) */
+					0x198  0x0	/* UART3_RXD	(IOCFG102) */
+					0x19c  0x0	/* UART3_TXD	(IOCFG103) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart4_cfg_func:	uart4_cfg_func {
+				pinctrl-single,pins = <
+					0x1e0  0x0	/* UART4_CTS_N	(IOCFG120) */
+					0x1e4  0x0	/* UART4_RTS_N	(IOCFG121) */
+					0x1e8  0x0	/* UART4_RXD	(IOCFG122) */
+					0x1ec  0x0	/* UART4_TXD	(IOCFG123) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			uart5_cfg_func:	uart5_cfg_func {
+				pinctrl-single,pins = <
+					0x1d8  0x0	/* UART4_RXD	(IOCFG118) */
+					0x1dc  0x0	/* UART4_TXD	(IOCFG119) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DOWN PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			i2c0_cfg_func: i2c0_cfg_func {
+				pinctrl-single,pins = <
+					0xec   0x0	/* I2C0_SCL	(IOCFG059) */
+					0xf0   0x0	/* I2C0_SDA	(IOCFG060) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			i2c1_cfg_func: i2c1_cfg_func {
+				pinctrl-single,pins = <
+					0xf4   0x0	/* I2C1_SCL	(IOCFG061) */
+					0xf8   0x0	/* I2C1_SDA	(IOCFG062) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			i2c2_cfg_func: i2c2_cfg_func {
+				pinctrl-single,pins = <
+					0xfc   0x0	/* I2C2_SCL	(IOCFG063) */
+					0x100  0x0	/* I2C2_SDA	(IOCFG064) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+		};
+
+		pmx2: pinmux at f8001800 {
+
+			pinctrl-names =	"default";
+			pinctrl-0 = <
+				&rstout_n_cfg_func
+				>;
+
+			rstout_n_cfg_func: rstout_n_cfg_func {
+				pinctrl-single,pins = <
+					0x0    0x0	/* RSTOUT_N	(IOCFG000) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			pmu_peri_en_cfg_func: pmu_peri_en_cfg_func {
+				pinctrl-single,pins = <
+					0x4    0x0	/* PMU_PERI_EN	(IOCFG001) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			sysclk0_en_cfg_func: sysclk0_en_cfg_func {
+				pinctrl-single,pins = <
+					0x8    0x0	/* SYSCLK0_EN	(IOCFG002) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+
+			jtag_tdo_cfg_func: jtag_tdo_cfg_func {
+				pinctrl-single,pins = <
+					0xc    0x0	/* JTAG_TDO	(IOCFG003) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_08MA DRIVE_MASK>;
+			};
+
+			rf_reset_cfg_func: rf_reset_cfg_func {
+				pinctrl-single,pins = <
+					0x70   0x0	/* RF_RESET0	(IOCFG028) */
+					0x74   0x0	/* RF_RESET1	(IOCFG029) */
+				>;
+				pinctrl-single,bias-pulldown  =	<PULL_DIS  PULL_DOWN PULL_DIS  PULL_DOWN>;
+				pinctrl-single,bias-pullup    =	<PULL_DIS  PULL_UP   PULL_DIS  PULL_UP>;
+				pinctrl-single,drive-strength =	<DRIVE1_02MA DRIVE_MASK>;
+			};
+		};
+	};
+};
diff --git a/include/dt-bindings/pinctrl/hisi.h b/include/dt-bindings/pinctrl/hisi.h
new file mode 100644
index 0000000..38f1ea8
--- /dev/null
+++ b/include/dt-bindings/pinctrl/hisi.h
@@ -0,0 +1,59 @@
+/*
+ * This header provides constants for hisilicon pinctrl bindings.
+ *
+ * Copyright (c) 2015 Hisilicon Limited.
+ * Copyright (c) 2015 Linaro Limited.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _DT_BINDINGS_PINCTRL_HISI_H
+#define _DT_BINDINGS_PINCTRL_HISI_H
+
+/* iomg bit definition */
+#define MUX_M0		0
+#define MUX_M1		1
+#define MUX_M2		2
+#define MUX_M3		3
+#define MUX_M4		4
+#define MUX_M5		5
+#define MUX_M6		6
+#define MUX_M7		7
+
+/* iocg bit definition */
+#define PULL_MASK	(3)
+#define PULL_DIS	(0)
+#define PULL_UP		(1 << 0)
+#define PULL_DOWN	(1 << 1)
+
+/* drive strength definition */
+#define DRIVE_MASK	(7 << 4)
+#define DRIVE1_02MA	(0 << 4)
+#define DRIVE1_04MA	(1 << 4)
+#define DRIVE1_08MA	(2 << 4)
+#define DRIVE1_10MA	(3 << 4)
+#define DRIVE2_02MA	(0 << 4)
+#define DRIVE2_04MA	(1 << 4)
+#define DRIVE2_08MA	(2 << 4)
+#define DRIVE2_10MA	(3 << 4)
+#define DRIVE3_04MA	(0 << 4)
+#define DRIVE3_08MA	(1 << 4)
+#define DRIVE3_12MA	(2 << 4)
+#define DRIVE3_16MA	(3 << 4)
+#define DRIVE3_20MA	(4 << 4)
+#define DRIVE3_24MA	(5 << 4)
+#define DRIVE3_32MA	(6 << 4)
+#define DRIVE3_40MA	(7 << 4)
+#define DRIVE4_02MA	(0 << 4)
+#define DRIVE4_04MA	(2 << 4)
+#define DRIVE4_08MA	(4 << 4)
+#define DRIVE4_10MA	(6 << 4)
+
+#endif
-- 
1.9.1
