From: guodong.xu@linaro.org (Guodong Xu)
Date: Tue,  5 Apr 2016 21:27:28 +0800
Subject: [PATCH v3 04/16] arm64: dts: Add Hi6220 gpio configuration nodes
In-Reply-To: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
References: <1459862860-9775-1-git-send-email-guodong.xu@linaro.org>
Message-ID: <1459862860-9775-5-git-send-email-guodong.xu@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Zhong Kaihua <zhongkaihua@huawei.com>

Add Hi6220 gpio configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
Signed-off-by: Kong Xinwei <kong.kongxinwei@hisilicon.com>

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Wei Xu <xuwei5@hisilicon.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |   1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      | 259 +++++++++++
 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi  | 607 +++++++++++++++++++++++++
 3 files changed, 867 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index 17bd793..f9b2d1e 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -8,6 +8,7 @@
 /dts-v1/;
 
 #include "hi6220.dtsi"
+#include "hikey-gpio.dtsi"
 
 / {
 	model = "HiKey Development Board";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index dc7f21a..7b7149b 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -251,5 +251,264 @@
 				 <&ao_ctrl HI6220_TIMER0_PCLK>;
 			clock-names = "timer1", "timer2", "apb_pclk";
 		};
+
+		gpio0: gpio at f8011000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8011000 0x0 0x1000>;
+			interrupts = <0 52 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio1: gpio at f8012000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8012000 0x0 0x1000>;
+			interrupts = <0 53 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio2: gpio at f8013000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8013000 0x0 0x1000>;
+			interrupts = <0 54 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
+
+		gpio3: gpio at f8014000 {
+			compatible = "arm,pl061", "arm,primecell";
+			reg = <0x0 0xf8014000 0x0 0x1000>;
+			interrupts = <0 55 0x4>;
+			gpio-controller;
+			#gpio-cells = <2>;
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
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			clocks = <&ao_ctrl 2>;
+			clock-names = "apb_pclk";
+			status = "ok";
+		};
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
new file mode 100644
index 0000000..09242f0
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
@@ -0,0 +1,607 @@
+/ {
+	gpio_rstout_n:gpio_rstout_n {
+		gpios;
+	};
+	gpio_pmu_peri_en:gpio_pmu_peri_en {
+		gpios;
+	};
+	gpio_sysclk0_en:gpio_sysclk0_en {
+		gpios;
+	};
+	gpio_jtag_tdo:gpio_jtag_tdo {
+		gpios;
+	};
+	/* LCB: PWR_HOLD_GPIO0_0 */
+	gpio_pwr_hold:gpio_pwr_hold {
+		gpios = <&gpio0 0 0>;
+	};
+	/* LCB: DSI_SEL_GPIO0_1 */
+	gpio_dsi_sel:gpio_dsi_sel {
+		gpios = <&gpio0 1 0>;
+	};
+	/* LCB: USB_HUB_RESET_N_GPIO0_2 */
+	gpio_usb_hub_reset_n:gpio_usb_hub_reset_n {
+		gpios = <&gpio0 2 0>;
+	};
+	/* LCB: USB_SEL_GPIO0_3 */
+	gpio_usb_sel:gpio_usb_sel {
+		gpios = <&gpio0 3 0>;
+	};
+	/* LCB: HDMI_PD_GPIO0_4 */
+	gpio_hdmi_pd:gpio_hdmi_pd {
+		gpios = <&gpio0 4 0>;
+	};
+	/* LCB: WL_REG_ON_GPIO0_5 */
+	gpio_wl_en:gpio_wl_en {
+		gpios = <&gpio0 5 0>;
+	};
+	/* LCB: PWRON_DET_GPIO0_6 */
+	gpio_pwron_det:gpio_pwron_det {
+		gpios = <&gpio0 6 0>;
+	};
+	/* LCB: 5V_HUB_EN_GPIO0_7 */
+	gpio_usb_dev_det:gpio_usb_dev_det {
+		gpios = <&gpio0 7 0>;
+	};
+	/* LCB: SD_DET_GPIO1_0 */
+	gpio_sd_det:gpio_sd_det {
+		gpios = <&gpio1 0 0>;
+	};
+	/* LCB: HDMI_INT_GPIO1_1 */
+	gpio_hdmi_int:gpio_hdmi_int {
+		gpios = <&gpio1 1 0>;
+	};
+	/* LCB: PMU_IRQ_N_GPIO1_2 */
+	gpio_pmu_irq_n:gpio_pmu_irq_n {
+		gpios = <&gpio1 2 0>;
+	};
+	/* LCB: WL_HOST_WAKE_GPIO1_3 */
+	gpio_wl_host_wake:gpio_wl_host_wake {
+		gpios = <&gpio1 3 0>;
+	};
+	gpio_nfc_int:gpio_nfc_int {
+		gpios = <&gpio1 4 0>;
+	};
+	gpio_unused_001:gpio_unused_001 {
+		gpios = <&gpio1 5 0>;
+	};
+	/* LCB: BT_REG_ON_GPIO1_7 */
+	gpio_bt_reg_on:gpio_bt_reg_on {
+		gpios = <&gpio1 7 0>;
+	};
+	/* LCB: GPIO2_0, J2 */
+	gpio_j2_2_0:gpio_j2_2_0 {
+		gpios = <&gpio2 0 0>;
+	};
+	/* LCB: GPIO2_1, J2 */
+	gpio_j2_2_1:gpio_j2_2_1 {
+		gpios = <&gpio2 1 0>;
+	};
+	/* LCB: GPIO2_2, J2 */
+	gpio_j2_2_2:gpio_j2_2_2 {
+		gpios = <&gpio2 2 0>;
+	};
+	/* LCB: GPIO2_3, J2 */
+	gpio_j2_2_3:gpio_j2_2_3 {
+		gpios = <&gpio2 3 0>;
+	};
+	/* LCB: GPIO2_4, J2 */
+	gpio_j2_2_4:gpio_j2_2_4 {
+		gpios = <&gpio2 4 0>;
+	};
+	/* LCB: USB_ID_DET_GPIO2_5 */
+	gpio_usb_id_det:gpio_usb_id_det {
+		gpios = <&gpio2 5 0>;
+	};
+	/* LCB: USB_VBUS_DET_GPIO2_6 */
+	gpio_vbus_det:gpio_vbus_det {
+		gpios = <&gpio2 6 0>;
+	};
+	/* LCB: GPIO2_7, J2 */
+	gpio_j2_2_7:gpio_j2_2_7 {
+		gpios = <&gpio2 7 0>;
+	};
+	gpio_rf_reset0:gpio_rf_reset0 {
+		gpios;
+	};
+	gpio_rf_reset1:gpio_rf_reset1 {
+		gpios;
+	};
+	gpio_boot_sel:gpio_boot_sel {
+		gpios = <&gpio10 0 0>;
+	};
+	gpio_pmu_ssi:gpio_pmu_ssi {
+		gpios;
+	};
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
+	gpio_unused_002:gpio_unused_002 {
+		gpios;
+	};
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
+	gpio_hkadc_ssi:gpio_hkadc_ssi {
+		gpios;
+	};
+	gpio_codec_clk:gpio_codec_clk {
+		gpios;
+	};
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
+	gpio_bt_xclk:gpio_bt_xclk {
+		gpios;
+	};
+	gpio_bt_xfs:gpio_bt_xfs {
+		gpios;
+	};
+	gpio_bt_di:gpio_bt_di {
+		gpios;
+	};
+	gpio_bt_do:gpio_bt_do {
+		gpios;
+	};
+	gpio_usim0_clk:gpio_usim0_clk {
+		gpios;
+	};
+	gpio_usim0_data:gpio_usim0_data {
+		gpios;
+	};
+	gpio_usim0_rst:gpio_usim0_rst {
+		gpios;
+	};
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
+	gpio_emmc_clk:gpio_emmc_clk {
+		gpios;
+	};
+	gpio_emmc_cmd:gpio_emmc_cmd {
+		gpios;
+	};
+	gpio_emmc_data0:gpio_emmc_data0 {
+		gpios;
+	};
+	gpio_emmc_data1:gpio_emmc_data1 {
+		gpios;
+	};
+	gpio_emmc_data2:gpio_emmc_data2 {
+		gpios;
+	};
+	gpio_emmc_data3:gpio_emmc_data3 {
+		gpios;
+	};
+	gpio_emmc_data4:gpio_emmc_data4 {
+		gpios;
+	};
+	gpio_emmc_data5:gpio_emmc_data5 {
+		gpios;
+	};
+	gpio_emmc_data6:gpio_emmc_data6 {
+		gpios;
+	};
+	gpio_emmc_data7:gpio_emmc_data7 {
+		gpios;
+	};
+	gpio_emmc_rst_n:gpio_emmc_rst_n {
+		gpios;
+	};
+	gpio_unused_006:gpio_unused_006 {
+		gpios;
+	};
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
+	gpio_unused_007:gpio_unused_007 {
+		gpios;
+	};
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
+	gpio_rf_ssi0:gpio_rf_ssi0 {
+		gpios;
+	};
+	gpio_rf_tcvr_on0:gpio_rf_tcvr_on0 {
+		gpios;
+	};
+	gpio_rf_mipi_clk0:gpio_rf_mipi_clk0 {
+		gpios;
+	};
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
+};
-- 
1.9.1
