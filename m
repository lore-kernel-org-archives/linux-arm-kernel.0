From: zhongkaihua@huawei.com (Zhong Kaihua)
Date: Sat, 31 Oct 2015 10:24:18 +0800
Subject: [PATCH 1/3] arm64: dts: Add Hi6220 gpio configuration nodes
Message-ID: <1446258260-72902-1-git-send-email-zhongkaihua@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

arm64: dts: Add Hi6220 gpio configuration nodes

Signed-off-by: Zhong Kaihua <zhongkaihua@huawei.com>
---
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts |   1 +
 arch/arm64/boot/dts/hisilicon/hi6220.dtsi      |  38 +++++
 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi  | 195 +++++++++++++++++++++++++
 3 files changed, 234 insertions(+)
 create mode 100644 arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
index e36a539..f2b9c98 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts
@@ -11,6 +11,7 @@
 /memreserve/ 0x05e00000 0x00100000;
 
 #include "hi6220.dtsi"
+#include "hikey-gpio.dtsi"
 
 / {
 	model = "HiKey Development Board";
diff --git a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
index 3f03380..c2b8925 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220.dtsi
@@ -167,5 +167,43 @@
 			clocks = <&ao_ctrl 36>, <&ao_ctrl 36>;
 			clock-names = "uartclk", "apb_pclk";
 		};
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
 	};
 };
diff --git a/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
new file mode 100644
index 0000000..6eabf40
--- /dev/null
+++ b/arch/arm64/boot/dts/hisilicon/hikey-gpio.dtsi
@@ -0,0 +1,195 @@
+/*
+ * gpio dts file for Hisilicon HiKey development board
+ *
+ */
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
+	gpio_pmu_ssi:gpio_pmu_ssi {
+		gpios;
+	};
+	gpio_unused_002:gpio_unused_002 {
+		gpios;
+	};
+	gpio_hkadc_ssi:gpio_hkadc_ssi {
+		gpios;
+	};
+	gpio_codec_clk:gpio_codec_clk {
+		gpios;
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
+	gpio_unused_007:gpio_unused_007 {
+		gpios;
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
+};
-- 
1.9.1
