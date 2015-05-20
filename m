From: 21cnbao@gmail.com (Barry Song)
Date: Wed, 20 May 2015 08:08:27 +0000
Subject: [PATCH] ARM: dts: atlas7: add pinctrl and gpio descriptions
Message-ID: <1432109307-19720-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

This patch adds pinctrl and gpio stuff according to the atlas7
pinctrl driver.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 1042 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 1041 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index a753178..1928f78 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -120,6 +120,1025 @@
 			compatible = "sirf,atlas7-ioc";
 			reg = <0x18880000 0x1000>,
 				<0x10E40000 0x1000>;
+
+			audio_ac97_pmx: audio_ac97 at 0 {
+				audio_ac97 {
+					groups = "audio_ac97_grp";
+					function = "audio_ac97";
+				};
+			};
+
+			audio_func_dbg_pmx: audio_func_dbg at 0 {
+				audio_func_dbg {
+					groups = "audio_func_dbg_grp";
+					function = "audio_func_dbg";
+				};
+			};
+
+			audio_i2s_pmx: audio_i2s at 0 {
+				audio_i2s {
+					groups = "audio_i2s_grp";
+					function = "audio_i2s";
+				};
+			};
+
+			audio_i2s_2ch_pmx: audio_i2s_2ch at 0 {
+				audio_i2s_2ch {
+					groups = "audio_i2s_2ch_grp";
+					function = "audio_i2s_2ch";
+				};
+			};
+
+			audio_i2s_extclk_pmx: audio_i2s_extclk at 0 {
+				audio_i2s_extclk {
+					groups = "audio_i2s_extclk_grp";
+					function = "audio_i2s_extclk";
+				};
+			};
+
+			audio_uart0_pmx: audio_uart0 at 0 {
+				audio_uart0 {
+					groups = "audio_uart0_grp";
+					function = "audio_uart0";
+				};
+			};
+
+			audio_uart1_pmx: audio_uart1 at 0 {
+				audio_uart1 {
+					groups = "audio_uart1_grp";
+					function = "audio_uart1";
+				};
+			};
+
+			audio_uart2_pmx0: audio_uart2 at 0 {
+				audio_uart2_0 {
+					groups = "audio_uart2_grp0";
+					function = "audio_uart2_m0";
+				};
+			};
+
+			audio_uart2_pmx1: audio_uart2 at 1 {
+				audio_uart2_1 {
+					groups = "audio_uart2_grp1";
+					function = "audio_uart2_m1";
+				};
+			};
+
+			c_can_trnsvr_pmx: c_can_trnsvr at 0 {
+				c_can_trnsvr {
+					groups = "c_can_trnsvr_grp";
+					function = "c_can_trnsvr";
+				};
+			};
+
+			c0_can_pmx0: c0_can at 0 {
+				c0_can_0 {
+					groups = "c0_can_grp0";
+					function = "c0_can_m0";
+				};
+			};
+
+			c0_can_pmx1: c0_can at 1 {
+				c0_can_1 {
+					groups = "c0_can_grp1";
+					function = "c0_can_m1";
+				};
+			};
+
+			c1_can_pmx0: c1_can at 0 {
+				c1_can_0 {
+					groups = "c1_can_grp0";
+					function = "c1_can_m0";
+				};
+			};
+
+			c1_can_pmx1: c1_can at 1 {
+				c1_can_1 {
+					groups = "c1_can_grp1";
+					function = "c1_can_m1";
+				};
+			};
+
+			c1_can_pmx2: c1_can at 2 {
+				c1_can_2 {
+					groups = "c1_can_grp2";
+					function = "c1_can_m2";
+				};
+			};
+
+			ca_audio_lpc_pmx: ca_audio_lpc at 0 {
+				ca_audio_lpc {
+					groups = "ca_audio_lpc_grp";
+					function = "ca_audio_lpc";
+				};
+			};
+
+			ca_bt_lpc_pmx: ca_bt_lpc at 0 {
+				ca_bt_lpc {
+					groups = "ca_bt_lpc_grp";
+					function = "ca_bt_lpc";
+				};
+			};
+
+			ca_coex_pmx: ca_coex at 0 {
+				ca_coex {
+					groups = "ca_coex_grp";
+					function = "ca_coex";
+				};
+			};
+
+			ca_curator_lpc_pmx: ca_curator_lpc at 0 {
+				ca_curator_lpc {
+					groups = "ca_curator_lpc_grp";
+					function = "ca_curator_lpc";
+				};
+			};
+
+			ca_pcm_debug_pmx: ca_pcm_debug at 0 {
+				ca_pcm_debug {
+					groups = "ca_pcm_debug_grp";
+					function = "ca_pcm_debug";
+				};
+			};
+
+			ca_pio_pmx: ca_pio at 0 {
+				ca_pio {
+					groups = "ca_pio_grp";
+					function = "ca_pio";
+				};
+			};
+
+			ca_sdio_debug_pmx: ca_sdio_debug at 0 {
+				ca_sdio_debug {
+					groups = "ca_sdio_debug_grp";
+					function = "ca_sdio_debug";
+				};
+			};
+
+			ca_spi_pmx: ca_spi at 0 {
+				ca_spi {
+					groups = "ca_spi_grp";
+					function = "ca_spi";
+				};
+			};
+
+			ca_trb_pmx: ca_trb at 0 {
+				ca_trb {
+					groups = "ca_trb_grp";
+					function = "ca_trb";
+				};
+			};
+
+			ca_uart_debug_pmx: ca_uart_debug at 0 {
+				ca_uart_debug {
+					groups = "ca_uart_debug_grp";
+					function = "ca_uart_debug";
+				};
+			};
+
+			clkc_pmx0: clkc at 0 {
+				clkc_0 {
+					groups = "clkc_grp0";
+					function = "clkc_m0";
+				};
+			};
+
+			clkc_pmx1: clkc at 1 {
+				clkc_1 {
+					groups = "clkc_grp1";
+					function = "clkc_m1";
+				};
+			};
+
+			gn_gnss_i2c_pmx: gn_gnss_i2c at 0 {
+				gn_gnss_i2c {
+					groups = "gn_gnss_i2c_grp";
+					function = "gn_gnss_i2c";
+				};
+			};
+
+			gn_gnss_uart_nopause_pmx: gn_gnss_uart_nopause at 0 {
+				gn_gnss_uart_nopause {
+					groups = "gn_gnss_uart_nopause_grp";
+					function = "gn_gnss_uart_nopause";
+				};
+			};
+
+			gn_gnss_uart_pmx: gn_gnss_uart at 0 {
+				gn_gnss_uart {
+					groups = "gn_gnss_uart_grp";
+					function = "gn_gnss_uart";
+				};
+			};
+
+			gn_trg_spi_pmx0: gn_trg_spi at 0 {
+				gn_trg_spi_0 {
+					groups = "gn_trg_spi_grp0";
+					function = "gn_trg_spi_m0";
+				};
+			};
+
+			gn_trg_spi_pmx1: gn_trg_spi at 1 {
+				gn_trg_spi_1 {
+					groups = "gn_trg_spi_grp1";
+					function = "gn_trg_spi_m1";
+				};
+			};
+
+			cvbs_dbg_pmx: cvbs_dbg at 0 {
+				cvbs_dbg {
+					groups = "cvbs_dbg_grp";
+					function = "cvbs_dbg";
+				};
+			};
+
+			cvbs_dbg_test_pmx0: cvbs_dbg_test at 0 {
+				cvbs_dbg_test_0 {
+					groups = "cvbs_dbg_test_grp0";
+					function = "cvbs_dbg_test_m0";
+				};
+			};
+
+			cvbs_dbg_test_pmx1: cvbs_dbg_test at 1 {
+				cvbs_dbg_test_1 {
+					groups = "cvbs_dbg_test_grp1";
+					function = "cvbs_dbg_test_m1";
+				};
+			};
+
+			cvbs_dbg_test_pmx2: cvbs_dbg_test at 2 {
+				cvbs_dbg_test_2 {
+					groups = "cvbs_dbg_test_grp2";
+					function = "cvbs_dbg_test_m2";
+				};
+			};
+
+			cvbs_dbg_test_pmx3: cvbs_dbg_test at 3 {
+				cvbs_dbg_test_3 {
+					groups = "cvbs_dbg_test_grp3";
+					function = "cvbs_dbg_test_m3";
+				};
+			};
+
+			cvbs_dbg_test_pmx4: cvbs_dbg_test at 4 {
+				cvbs_dbg_test_4 {
+					groups = "cvbs_dbg_test_grp4";
+					function = "cvbs_dbg_test_m4";
+				};
+			};
+
+			cvbs_dbg_test_pmx5: cvbs_dbg_test at 5 {
+				cvbs_dbg_test_5 {
+					groups = "cvbs_dbg_test_grp5";
+					function = "cvbs_dbg_test_m5";
+				};
+			};
+
+			cvbs_dbg_test_pmx6: cvbs_dbg_test at 6 {
+				cvbs_dbg_test_6 {
+					groups = "cvbs_dbg_test_grp6";
+					function = "cvbs_dbg_test_m6";
+				};
+			};
+
+			cvbs_dbg_test_pmx7: cvbs_dbg_test at 7 {
+				cvbs_dbg_test_7 {
+					groups = "cvbs_dbg_test_grp7";
+					function = "cvbs_dbg_test_m7";
+				};
+			};
+
+			cvbs_dbg_test_pmx8: cvbs_dbg_test at 8 {
+				cvbs_dbg_test_8 {
+					groups = "cvbs_dbg_test_grp8";
+					function = "cvbs_dbg_test_m8";
+				};
+			};
+
+			cvbs_dbg_test_pmx9: cvbs_dbg_test at 9 {
+				cvbs_dbg_test_9 {
+					groups = "cvbs_dbg_test_grp9";
+					function = "cvbs_dbg_test_m9";
+				};
+			};
+
+			cvbs_dbg_test_pmx10: cvbs_dbg_test at 10 {
+				cvbs_dbg_test_10 {
+					groups = "cvbs_dbg_test_grp10";
+					function = "cvbs_dbg_test_m10";
+				};
+			};
+
+			cvbs_dbg_test_pmx11: cvbs_dbg_test at 11 {
+				cvbs_dbg_test_11 {
+					groups = "cvbs_dbg_test_grp11";
+					function = "cvbs_dbg_test_m11";
+				};
+			};
+
+			cvbs_dbg_test_pmx12: cvbs_dbg_test at 12 {
+				cvbs_dbg_test_12 {
+					groups = "cvbs_dbg_test_grp12";
+					function = "cvbs_dbg_test_m12";
+				};
+			};
+
+			cvbs_dbg_test_pmx13: cvbs_dbg_test at 13 {
+				cvbs_dbg_test_13 {
+					groups = "cvbs_dbg_test_grp13";
+					function = "cvbs_dbg_test_m13";
+				};
+			};
+
+			cvbs_dbg_test_pmx14: cvbs_dbg_test at 14 {
+				cvbs_dbg_test_14 {
+					groups = "cvbs_dbg_test_grp14";
+					function = "cvbs_dbg_test_m14";
+				};
+			};
+
+			cvbs_dbg_test_pmx15: cvbs_dbg_test at 15 {
+				cvbs_dbg_test_15 {
+					groups = "cvbs_dbg_test_grp15";
+					function = "cvbs_dbg_test_m15";
+				};
+			};
+
+			gn_gnss_power_pmx: gn_gnss_power at 0 {
+				gn_gnss_power {
+					groups = "gn_gnss_power_grp";
+					function = "gn_gnss_power";
+				};
+			};
+
+			gn_gnss_sw_status_pmx: gn_gnss_sw_status at 0 {
+				gn_gnss_sw_status {
+					groups = "gn_gnss_sw_status_grp";
+					function = "gn_gnss_sw_status";
+				};
+			};
+
+			gn_gnss_eclk_pmx: gn_gnss_eclk at 0 {
+				gn_gnss_eclk {
+					groups = "gn_gnss_eclk_grp";
+					function = "gn_gnss_eclk";
+				};
+			};
+
+			gn_gnss_irq1_pmx0: gn_gnss_irq1 at 0 {
+				gn_gnss_irq1_0 {
+					groups = "gn_gnss_irq1_grp0";
+					function = "gn_gnss_irq1_m0";
+				};
+			};
+
+			gn_gnss_irq2_pmx0: gn_gnss_irq2 at 0 {
+				gn_gnss_irq2_0 {
+					groups = "gn_gnss_irq2_grp0";
+					function = "gn_gnss_irq2_m0";
+				};
+			};
+
+			gn_gnss_tm_pmx: gn_gnss_tm at 0 {
+				gn_gnss_tm {
+					groups = "gn_gnss_tm_grp";
+					function = "gn_gnss_tm";
+				};
+			};
+
+			gn_gnss_tsync_pmx: gn_gnss_tsync at 0 {
+				gn_gnss_tsync {
+					groups = "gn_gnss_tsync_grp";
+					function = "gn_gnss_tsync";
+				};
+			};
+
+			gn_io_gnsssys_sw_cfg_pmx: gn_io_gnsssys_sw_cfg at 0 {
+				gn_io_gnsssys_sw_cfg {
+					groups = "gn_io_gnsssys_sw_cfg_grp";
+					function = "gn_io_gnsssys_sw_cfg";
+				};
+			};
+
+			gn_trg_pmx0: gn_trg at 0 {
+				gn_trg_0 {
+					groups = "gn_trg_grp0";
+					function = "gn_trg_m0";
+				};
+			};
+
+			gn_trg_pmx1: gn_trg at 1 {
+				gn_trg_1 {
+					groups = "gn_trg_grp1";
+					function = "gn_trg_m1";
+				};
+			};
+
+			gn_trg_shutdown_pmx0: gn_trg_shutdown at 0 {
+				gn_trg_shutdown_0 {
+					groups = "gn_trg_shutdown_grp0";
+					function = "gn_trg_shutdown_m0";
+				};
+			};
+
+			gn_trg_shutdown_pmx1: gn_trg_shutdown at 1 {
+				gn_trg_shutdown_1 {
+					groups = "gn_trg_shutdown_grp1";
+					function = "gn_trg_shutdown_m1";
+				};
+			};
+
+			gn_trg_shutdown_pmx2: gn_trg_shutdown at 2 {
+				gn_trg_shutdown_2 {
+					groups = "gn_trg_shutdown_grp2";
+					function = "gn_trg_shutdown_m2";
+				};
+			};
+
+			gn_trg_shutdown_pmx3: gn_trg_shutdown at 3 {
+				gn_trg_shutdown_3 {
+					groups = "gn_trg_shutdown_grp3";
+					function = "gn_trg_shutdown_m3";
+				};
+			};
+
+			i2c0_pmx: i2c0 at 0 {
+				i2c0 {
+					groups = "i2c0_grp";
+					function = "i2c0";
+				};
+			};
+
+			i2c1_pmx: i2c1 at 0 {
+				i2c1 {
+					groups = "i2c1_grp";
+					function = "i2c1";
+				};
+			};
+
+			jtag_pmx0: jtag at 0 {
+				jtag_0 {
+					groups = "jtag_grp0";
+					function = "jtag_m0";
+				};
+			};
+
+			ks_kas_spi_pmx0: ks_kas_spi at 0 {
+				ks_kas_spi_0 {
+					groups = "ks_kas_spi_grp0";
+					function = "ks_kas_spi_m0";
+				};
+			};
+
+			ld_ldd_pmx: ld_ldd at 0 {
+				ld_ldd {
+					groups = "ld_ldd_grp";
+					function = "ld_ldd";
+				};
+			};
+
+			ld_ldd_16bit_pmx: ld_ldd_16bit at 0 {
+				ld_ldd_16bit {
+					groups = "ld_ldd_16bit_grp";
+					function = "ld_ldd_16bit";
+				};
+			};
+
+			ld_ldd_fck_pmx: ld_ldd_fck at 0 {
+				ld_ldd_fck {
+					groups = "ld_ldd_fck_grp";
+					function = "ld_ldd_fck";
+				};
+			};
+
+			ld_ldd_lck_pmx: ld_ldd_lck at 0 {
+				ld_ldd_lck {
+					groups = "ld_ldd_lck_grp";
+					function = "ld_ldd_lck";
+				};
+			};
+
+			lr_lcdrom_pmx: lr_lcdrom at 0 {
+				lr_lcdrom {
+					groups = "lr_lcdrom_grp";
+					function = "lr_lcdrom";
+				};
+			};
+
+			lvds_analog_pmx: lvds_analog at 0 {
+				lvds_analog {
+					groups = "lvds_analog_grp";
+					function = "lvds_analog";
+				};
+			};
+
+			nd_df_pmx: nd_df at 0 {
+				nd_df {
+					groups = "nd_df_grp";
+					function = "nd_df";
+				};
+			};
+
+			nd_df_nowp_pmx: nd_df_nowp at 0 {
+				nd_df_nowp {
+					groups = "nd_df_nowp_grp";
+					function = "nd_df_nowp";
+				};
+			};
+
+			ps_pmx: ps at 0 {
+				ps {
+					groups = "ps_grp";
+					function = "ps";
+				};
+			};
+
+			pwc_core_on_pmx: pwc_core_on at 0 {
+				pwc_core_on {
+					groups = "pwc_core_on_grp";
+					function = "pwc_core_on";
+				};
+			};
+
+			pwc_ext_on_pmx: pwc_ext_on at 0 {
+				pwc_ext_on {
+					groups = "pwc_ext_on_grp";
+					function = "pwc_ext_on";
+				};
+			};
+
+			pwc_gpio3_clk_pmx: pwc_gpio3_clk at 0 {
+				pwc_gpio3_clk {
+					groups = "pwc_gpio3_clk_grp";
+					function = "pwc_gpio3_clk";
+				};
+			};
+
+			pwc_io_on_pmx: pwc_io_on at 0 {
+				pwc_io_on {
+					groups = "pwc_io_on_grp";
+					function = "pwc_io_on";
+				};
+			};
+
+			pwc_lowbatt_b_pmx0: pwc_lowbatt_b at 0 {
+				pwc_lowbatt_b_0 {
+					groups = "pwc_lowbatt_b_grp0";
+					function = "pwc_lowbatt_b_m0";
+				};
+			};
+
+			pwc_mem_on_pmx: pwc_mem_on at 0 {
+				pwc_mem_on {
+					groups = "pwc_mem_on_grp";
+					function = "pwc_mem_on";
+				};
+			};
+
+			pwc_on_key_b_pmx0: pwc_on_key_b at 0 {
+				pwc_on_key_b_0 {
+					groups = "pwc_on_key_b_grp0";
+					function = "pwc_on_key_b_m0";
+				};
+			};
+
+			pwc_wakeup_src0_pmx: pwc_wakeup_src0 at 0 {
+				pwc_wakeup_src0 {
+					groups = "pwc_wakeup_src0_grp";
+					function = "pwc_wakeup_src0";
+				};
+			};
+
+			pwc_wakeup_src1_pmx: pwc_wakeup_src1 at 0 {
+				pwc_wakeup_src1 {
+					groups = "pwc_wakeup_src1_grp";
+					function = "pwc_wakeup_src1";
+				};
+			};
+
+			pwc_wakeup_src2_pmx: pwc_wakeup_src2 at 0 {
+				pwc_wakeup_src2 {
+					groups = "pwc_wakeup_src2_grp";
+					function = "pwc_wakeup_src2";
+				};
+			};
+
+			pwc_wakeup_src3_pmx: pwc_wakeup_src3 at 0 {
+				pwc_wakeup_src3 {
+					groups = "pwc_wakeup_src3_grp";
+					function = "pwc_wakeup_src3";
+				};
+			};
+
+			pw_cko0_pmx0: pw_cko0 at 0 {
+				pw_cko0_0 {
+					groups = "pw_cko0_grp0";
+					function = "pw_cko0_m0";
+				};
+			};
+
+			pw_cko0_pmx1: pw_cko0 at 1 {
+				pw_cko0_1 {
+					groups = "pw_cko0_grp1";
+					function = "pw_cko0_m1";
+				};
+			};
+
+			pw_cko0_pmx2: pw_cko0 at 2 {
+				pw_cko0_2 {
+					groups = "pw_cko0_grp2";
+					function = "pw_cko0_m2";
+				};
+			};
+
+			pw_cko1_pmx0: pw_cko1 at 0 {
+				pw_cko1_0 {
+					groups = "pw_cko1_grp0";
+					function = "pw_cko1_m0";
+				};
+			};
+
+			pw_cko1_pmx1: pw_cko1 at 1 {
+				pw_cko1_1 {
+					groups = "pw_cko1_grp1";
+					function = "pw_cko1_m1";
+				};
+			};
+
+			pw_i2s01_clk_pmx0: pw_i2s01_clk at 0 {
+				pw_i2s01_clk_0 {
+					groups = "pw_i2s01_clk_grp0";
+					function = "pw_i2s01_clk_m0";
+				};
+			};
+
+			pw_i2s01_clk_pmx1: pw_i2s01_clk at 1 {
+				pw_i2s01_clk_1 {
+					groups = "pw_i2s01_clk_grp1";
+					function = "pw_i2s01_clk_m1";
+				};
+			};
+
+			pw_pwm0_pmx: pw_pwm0 at 0 {
+				pw_pwm0 {
+					groups = "pw_pwm0_grp";
+					function = "pw_pwm0";
+				};
+			};
+
+			pw_pwm1_pmx: pw_pwm1 at 0 {
+				pw_pwm1 {
+					groups = "pw_pwm1_grp";
+					function = "pw_pwm1";
+				};
+			};
+
+			pw_pwm2_pmx0: pw_pwm2 at 0 {
+				pw_pwm2_0 {
+					groups = "pw_pwm2_grp0";
+					function = "pw_pwm2_m0";
+				};
+			};
+
+			pw_pwm2_pmx1: pw_pwm2 at 1 {
+				pw_pwm2_1 {
+					groups = "pw_pwm2_grp1";
+					function = "pw_pwm2_m1";
+				};
+			};
+
+			pw_pwm3_pmx0: pw_pwm3 at 0 {
+				pw_pwm3_0 {
+					groups = "pw_pwm3_grp0";
+					function = "pw_pwm3_m0";
+				};
+			};
+
+			pw_pwm3_pmx1: pw_pwm3 at 1 {
+				pw_pwm3_1 {
+					groups = "pw_pwm3_grp1";
+					function = "pw_pwm3_m1";
+				};
+			};
+
+			pw_pwm_cpu_vol_pmx0: pw_pwm_cpu_vol at 0 {
+				pw_pwm_cpu_vol_0 {
+					groups = "pw_pwm_cpu_vol_grp0";
+					function = "pw_pwm_cpu_vol_m0";
+				};
+			};
+
+			pw_pwm_cpu_vol_pmx1: pw_pwm_cpu_vol at 1 {
+				pw_pwm_cpu_vol_1 {
+					groups = "pw_pwm_cpu_vol_grp1";
+					function = "pw_pwm_cpu_vol_m1";
+				};
+			};
+
+			pw_backlight_pmx0: pw_backlight at 0 {
+				pw_backlight_0 {
+					groups = "pw_backlight_grp0";
+					function = "pw_backlight_m0";
+				};
+			};
+
+			pw_backlight_pmx1: pw_backlight at 1 {
+				pw_backlight_1 {
+					groups = "pw_backlight_grp1";
+					function = "pw_backlight_m1";
+				};
+			};
+
+			rg_eth_mac_pmx: rg_eth_mac at 0 {
+				rg_eth_mac {
+					groups = "rg_eth_mac_grp";
+					function = "rg_eth_mac";
+				};
+			};
+
+			rg_gmac_phy_intr_n_pmx: rg_gmac_phy_intr_n at 0 {
+				rg_gmac_phy_intr_n {
+					groups = "rg_gmac_phy_intr_n_grp";
+					function = "rg_gmac_phy_intr_n";
+				};
+			};
+
+			rg_rgmii_mac_pmx: rg_rgmii_mac at 0 {
+				rg_rgmii_mac {
+					groups = "rg_rgmii_mac_grp";
+					function = "rg_rgmii_mac";
+				};
+			};
+
+			rg_rgmii_phy_ref_clk_pmx0: rg_rgmii_phy_ref_clk at 0 {
+				rg_rgmii_phy_ref_clk_0 {
+					groups =
+						"rg_rgmii_phy_ref_clk_grp0";
+					function =
+						"rg_rgmii_phy_ref_clk_m0";
+				};
+			};
+
+			rg_rgmii_phy_ref_clk_pmx1: rg_rgmii_phy_ref_clk at 1 {
+				rg_rgmii_phy_ref_clk_1 {
+					groups =
+						"rg_rgmii_phy_ref_clk_grp1";
+					function =
+						"rg_rgmii_phy_ref_clk_m1";
+				};
+			};
+
+			sd0_pmx: sd0 at 0 {
+				sd0 {
+					groups = "sd0_grp";
+					function = "sd0";
+				};
+			};
+
+			sd0_4bit_pmx: sd0_4bit at 0 {
+				sd0_4bit {
+					groups = "sd0_4bit_grp";
+					function = "sd0_4bit";
+				};
+			};
+
+			sd1_pmx: sd1 at 0 {
+				sd1 {
+					groups = "sd1_grp";
+					function = "sd1";
+				};
+			};
+
+			sd1_4bit_pmx0: sd1_4bit at 0 {
+				sd1_4bit_0 {
+					groups = "sd1_4bit_grp0";
+					function = "sd1_4bit_m0";
+				};
+			};
+
+			sd1_4bit_pmx1: sd1_4bit at 1 {
+				sd1_4bit_1 {
+					groups = "sd1_4bit_grp1";
+					function = "sd1_4bit_m1";
+				};
+			};
+
+			sd2_pmx0: sd2 at 0 {
+				sd2_0 {
+					groups = "sd2_grp0";
+					function = "sd2_m0";
+				};
+			};
+
+			sd2_no_cdb_pmx0: sd2_no_cdb at 0 {
+				sd2_no_cdb_0 {
+					groups = "sd2_no_cdb_grp0";
+					function = "sd2_no_cdb_m0";
+				};
+			};
+
+			sd3_pmx: sd3 at 0 {
+				sd3 {
+					groups = "sd3_grp";
+					function = "sd3";
+				};
+			};
+
+			sd5_pmx: sd5 at 0 {
+				sd5 {
+					groups = "sd5_grp";
+					function = "sd5";
+				};
+			};
+
+			sd6_pmx0: sd6 at 0 {
+				sd6_0 {
+					groups = "sd6_grp0";
+					function = "sd6_m0";
+				};
+			};
+
+			sd6_pmx1: sd6 at 1 {
+				sd6_1 {
+					groups = "sd6_grp1";
+					function = "sd6_m1";
+				};
+			};
+
+			sp0_ext_ldo_on_pmx: sp0_ext_ldo_on at 0 {
+				sp0_ext_ldo_on {
+					groups = "sp0_ext_ldo_on_grp";
+					function = "sp0_ext_ldo_on";
+				};
+			};
+
+			sp0_qspi_pmx: sp0_qspi at 0 {
+				sp0_qspi {
+					groups = "sp0_qspi_grp";
+					function = "sp0_qspi";
+				};
+			};
+
+			sp1_spi_pmx: sp1_spi at 0 {
+				sp1_spi {
+					groups = "sp1_spi_grp";
+					function = "sp1_spi";
+				};
+			};
+
+			tpiu_trace_pmx: tpiu_trace at 0 {
+				tpiu_trace {
+					groups = "tpiu_trace_grp";
+					function = "tpiu_trace";
+				};
+			};
+
+			uart0_pmx: uart0 at 0 {
+				uart0 {
+					groups = "uart0_grp";
+					function = "uart0";
+				};
+			};
+
+			uart0_nopause_pmx: uart0_nopause at 0 {
+				uart0_nopause {
+					groups = "uart0_nopause_grp";
+					function = "uart0_nopause";
+				};
+			};
+
+			uart1_pmx: uart1 at 0 {
+				uart1 {
+					groups = "uart1_grp";
+					function = "uart1";
+				};
+			};
+
+			uart2_pmx: uart2 at 0 {
+				uart2 {
+					groups = "uart2_grp";
+					function = "uart2";
+				};
+			};
+
+			uart3_pmx0: uart3 at 0 {
+				uart3_0 {
+					groups = "uart3_grp0";
+					function = "uart3_m0";
+				};
+			};
+
+			uart3_pmx1: uart3 at 1 {
+				uart3_1 {
+					groups = "uart3_grp1";
+					function = "uart3_m1";
+				};
+			};
+
+			uart3_pmx2: uart3 at 2 {
+				uart3_2 {
+					groups = "uart3_grp2";
+					function = "uart3_m2";
+				};
+			};
+
+			uart3_pmx3: uart3 at 3 {
+				uart3_3 {
+					groups = "uart3_grp3";
+					function = "uart3_m3";
+				};
+			};
+
+			uart3_nopause_pmx0: uart3_nopause at 0 {
+				uart3_nopause_0 {
+					groups = "uart3_nopause_grp0";
+					function = "uart3_nopause_m0";
+				};
+			};
+
+			uart3_nopause_pmx1: uart3_nopause at 1 {
+				uart3_nopause_1 {
+					groups = "uart3_nopause_grp1";
+					function = "uart3_nopause_m1";
+				};
+			};
+
+			uart4_pmx0: uart4 at 0 {
+				uart4_0 {
+					groups = "uart4_grp0";
+					function = "uart4_m0";
+				};
+			};
+
+			uart4_pmx1: uart4 at 1 {
+				uart4_1 {
+					groups = "uart4_grp1";
+					function = "uart4_m1";
+				};
+			};
+
+			uart4_pmx2: uart4 at 2 {
+				uart4_2 {
+					groups = "uart4_grp2";
+					function = "uart4_m2";
+				};
+			};
+
+			uart4_nopause_pmx: uart4_nopause at 0 {
+				uart4_nopause {
+					groups = "uart4_nopause_grp";
+					function = "uart4_nopause";
+				};
+			};
+
+			usb0_drvvbus_pmx: usb0_drvvbus at 0 {
+				usb0_drvvbus {
+					groups = "usb0_drvvbus_grp";
+					function = "usb0_drvvbus";
+				};
+			};
+
+			usb1_drvvbus_pmx: usb1_drvvbus at 0 {
+				usb1_drvvbus {
+					groups = "usb1_drvvbus_grp";
+					function = "usb1_drvvbus";
+				};
+			};
+
+			visbus_dout_pmx: visbus_dout at 0 {
+				visbus_dout {
+					groups = "visbus_dout_grp";
+					function = "visbus_dout";
+				};
+			};
+
+			vi_vip1_pmx: vi_vip1 at 0 {
+				vi_vip1 {
+					groups = "vi_vip1_grp";
+					function = "vi_vip1";
+				};
+			};
+
+			vi_vip1_ext_pmx: vi_vip1_ext at 0 {
+				vi_vip1_ext {
+					groups = "vi_vip1_ext_grp";
+					function = "vi_vip1_ext";
+				};
+			};
+
+			vi_vip1_low8bit_pmx: vi_vip1_low8bit at 0 {
+				vi_vip1_low8bit {
+					groups = "vi_vip1_low8bit_grp";
+					function = "vi_vip1_low8bit";
+				};
+			};
+
+			vi_vip1_high8bit_pmx: vi_vip1_high8bit at 0 {
+				vi_vip1_high8bit {
+					groups = "vi_vip1_high8bit_grp";
+					function = "vi_vip1_high8bit";
+				};
+			};
 		};
 
 		pmipc {
@@ -341,6 +1360,12 @@
 				clock-names = "gpio0_io";
 				gpio-controller;
 				interrupt-controller;
+
+				gpio-banks = <2>;
+				gpio-ranges = <&pinctrl 0 0 0>,
+						<&pinctrl 32 0 0>;
+				gpio-ranges-group-names = "lvds_gpio_grp",
+							"uart_nand_gpio_grp";
 			};
 
 			nand at 17050000 {
@@ -446,11 +1471,22 @@
 				#interrupt-cells = <2>;
 				compatible = "sirf,atlas7-gpio";
 				reg = <0x13300000 0x1000>;
-				interrupts = <0 43 0>, <0 44 0>, <0 45 0>;
+				interrupts = <0 43 0>, <0 44 0>,
+						<0 45 0>, <0 46 0>;
 				clocks = <&car 84>;
 				clock-names = "gpio1_io";
 				gpio-controller;
 				interrupt-controller;
+
+				gpio-banks = <4>;
+				gpio-ranges = <&pinctrl 0 0 0>,
+						<&pinctrl 32 0 0>,
+						<&pinctrl 64 0 0>,
+						<&pinctrl 96 0 0>;
+				gpio-ranges-group-names = "gnss_gpio_grp",
+							"lcd_vip_gpio_grp",
+							"sdio_i2s_gpio_grp",
+							"sp_rgmii_gpio_grp";
 			};
 
 			sd2: sdhci at 14200000 {
@@ -729,6 +1765,10 @@
 				interrupts = <0 47 0>;
 				gpio-controller;
 				interrupt-controller;
+
+				gpio-banks = <1>;
+				gpio-ranges = <&pinctrl 0 0 0>;
+				gpio-ranges-group-names = "rtc_gpio_grp";
 			};
 
 			rtc-iobg at 18840000 {
-- 
1.9.1
