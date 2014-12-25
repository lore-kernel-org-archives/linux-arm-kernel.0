From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 25 Dec 2014 16:31:32 +0800
Subject: [PATCH 2/2] ARM: dts: atlas7: add pinctrl groups and properties
Message-ID: <1419496292-4878-1-git-send-email-21cnbao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Chen <Wei.Chen@csr.com>

this patch adds pinctrl groups, and builds the mapping between gpio
and pins.

Signed-off-by: Wei Chen <Wei.Chen@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/boot/dts/atlas7.dtsi | 920 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 920 insertions(+)

diff --git a/arch/arm/boot/dts/atlas7.dtsi b/arch/arm/boot/dts/atlas7.dtsi
index 43d707a..216a5a4 100644
--- a/arch/arm/boot/dts/atlas7.dtsi
+++ b/arch/arm/boot/dts/atlas7.dtsi
@@ -120,6 +120,906 @@
 			compatible = "sirf,atlas7-ioc";
 			reg = <0x18880000 0x1000>,
 				<0x10E40000 0x1000>;
+
+			audio_ac97_pmx: audio_ac97 at 0 {
+				audio_ac97 {
+					sirf,pins = "audio_ac97_grp";
+					sirf,function = "audio_ac97";
+				};
+			};
+
+			audio_func_dbg_pmx: audio_func_dbg at 0 {
+				audio_func_dbg {
+					sirf,pins = "audio_func_dbg_grp";
+					sirf,function = "audio_func_dbg";
+				};
+			};
+
+			audio_i2s_pmx: audio_i2s at 0 {
+				audio_i2s {
+					sirf,pins = "audio_i2s_grp";
+					sirf,function = "audio_i2s";
+				};
+			};
+
+			audio_i2s_extclk_pmx: audio_i2s_extclk at 0 {
+				audio_i2s_extclk {
+					sirf,pins = "audio_i2s_extclk_grp";
+					sirf,function = "audio_i2s_extclk";
+				};
+			};
+
+			audio_uart0_pmx: audio_uart0 at 0 {
+				audio_uart0 {
+					sirf,pins = "audio_uart0_grp";
+					sirf,function = "audio_uart0";
+				};
+			};
+
+			audio_uart1_pmx: audio_uart1 at 0 {
+				audio_uart1 {
+					sirf,pins = "audio_uart1_grp";
+					sirf,function = "audio_uart1";
+				};
+			};
+
+			audio_uart2_pmx0: audio_uart2 at 0 {
+				audio_uart2_0 {
+					sirf,pins = "audio_uart2_grp0";
+					sirf,function = "audio_uart2_m0";
+				};
+			};
+
+			audio_uart2_pmx1: audio_uart2 at 1 {
+				audio_uart2_1 {
+					sirf,pins = "audio_uart2_grp1";
+					sirf,function = "audio_uart2_m1";
+				};
+			};
+
+			c_can_trnsvr_pmx: c_can_trnsvr at 0 {
+				c_can_trnsvr {
+					sirf,pins = "c_can_trnsvr_grp";
+					sirf,function = "c_can_trnsvr";
+				};
+			};
+
+			c0_can_pmx0: c0_can at 0 {
+				c0_can_0 {
+					sirf,pins = "c0_can_grp0";
+					sirf,function = "c0_can_m0";
+				};
+			};
+
+			c0_can_pmx1: c0_can at 1 {
+				c0_can_1 {
+					sirf,pins = "c0_can_grp1";
+					sirf,function = "c0_can_m1";
+				};
+			};
+
+			c1_can_pmx0: c1_can at 0 {
+				c1_can_0 {
+					sirf,pins = "c1_can_grp0";
+					sirf,function = "c1_can_m0";
+				};
+			};
+
+			c1_can_pmx1: c1_can at 1 {
+				c1_can_1 {
+					sirf,pins = "c1_can_grp1";
+					sirf,function = "c1_can_m1";
+				};
+			};
+
+			c1_can_pmx2: c1_can at 2 {
+				c1_can_2 {
+					sirf,pins = "c1_can_grp2";
+					sirf,function = "c1_can_m2";
+				};
+			};
+
+			ca_audio_lpc_pmx: ca_audio_lpc at 0 {
+				ca_audio_lpc {
+					sirf,pins = "ca_audio_lpc_grp";
+					sirf,function = "ca_audio_lpc";
+				};
+			};
+
+			ca_bt_lpc_pmx: ca_bt_lpc at 0 {
+				ca_bt_lpc {
+					sirf,pins = "ca_bt_lpc_grp";
+					sirf,function = "ca_bt_lpc";
+				};
+			};
+
+			ca_coex_pmx: ca_coex at 0 {
+				ca_coex {
+					sirf,pins = "ca_coex_grp";
+					sirf,function = "ca_coex";
+				};
+			};
+
+			ca_curator_lpc_pmx: ca_curator_lpc at 0 {
+				ca_curator_lpc {
+					sirf,pins = "ca_curator_lpc_grp";
+					sirf,function = "ca_curator_lpc";
+				};
+			};
+
+			ca_pcm_debug_pmx: ca_pcm_debug at 0 {
+				ca_pcm_debug {
+					sirf,pins = "ca_pcm_debug_grp";
+					sirf,function = "ca_pcm_debug";
+				};
+			};
+
+			ca_pio_pmx: ca_pio at 0 {
+				ca_pio {
+					sirf,pins = "ca_pio_grp";
+					sirf,function = "ca_pio";
+				};
+			};
+
+			ca_sdio_debug_pmx: ca_sdio_debug at 0 {
+				ca_sdio_debug {
+					sirf,pins = "ca_sdio_debug_grp";
+					sirf,function = "ca_sdio_debug";
+				};
+			};
+
+			ca_spi_pmx: ca_spi at 0 {
+				ca_spi {
+					sirf,pins = "ca_spi_grp";
+					sirf,function = "ca_spi";
+				};
+			};
+
+			ca_trb_pmx: ca_trb at 0 {
+				ca_trb {
+					sirf,pins = "ca_trb_grp";
+					sirf,function = "ca_trb";
+				};
+			};
+
+			ca_uart_debug_pmx: ca_uart_debug at 0 {
+				ca_uart_debug {
+					sirf,pins = "ca_uart_debug_grp";
+					sirf,function = "ca_uart_debug";
+				};
+			};
+
+			clkc_pmx0: clkc at 0 {
+				clkc_0 {
+					sirf,pins = "clkc_grp0";
+					sirf,function = "clkc_m0";
+				};
+			};
+
+			clkc_pmx1: clkc at 1 {
+				clkc_1 {
+					sirf,pins = "clkc_grp1";
+					sirf,function = "clkc_m1";
+				};
+			};
+
+			gn_gnss_i2c_pmx: gn_gnss_i2c at 0 {
+				gn_gnss_i2c {
+					sirf,pins = "gn_gnss_i2c_grp";
+					sirf,function = "gn_gnss_i2c";
+				};
+			};
+
+			gn_gnss_uart_pmx: gn_gnss_uart at 0 {
+				gn_gnss_uart {
+					sirf,pins = "gn_gnss_uart_grp";
+					sirf,function = "gn_gnss_uart";
+				};
+			};
+
+			gn_trg_spi_pmx0: gn_trg_spi at 0 {
+				gn_trg_spi_0 {
+					sirf,pins = "gn_trg_spi_grp0";
+					sirf,function = "gn_trg_spi_m0";
+				};
+			};
+
+			gn_trg_spi_pmx1: gn_trg_spi at 1 {
+				gn_trg_spi_1 {
+					sirf,pins = "gn_trg_spi_grp1";
+					sirf,function = "gn_trg_spi_m1";
+				};
+			};
+
+			cvbs_dbg_pmx: cvbs_dbg at 0 {
+				cvbs_dbg {
+					sirf,pins = "cvbs_dbg_grp";
+					sirf,function = "cvbs_dbg";
+				};
+			};
+
+			cvbs_dbg_test_pmx0: cvbs_dbg_test at 0 {
+				cvbs_dbg_test_0 {
+					sirf,pins = "cvbs_dbg_test_grp0";
+					sirf,function = "cvbs_dbg_test_m0";
+				};
+			};
+
+			cvbs_dbg_test_pmx1: cvbs_dbg_test at 1 {
+				cvbs_dbg_test_1 {
+					sirf,pins = "cvbs_dbg_test_grp1";
+					sirf,function = "cvbs_dbg_test_m1";
+				};
+			};
+
+			cvbs_dbg_test_pmx2: cvbs_dbg_test at 2 {
+				cvbs_dbg_test_2 {
+					sirf,pins = "cvbs_dbg_test_grp2";
+					sirf,function = "cvbs_dbg_test_m2";
+				};
+			};
+
+			cvbs_dbg_test_pmx3: cvbs_dbg_test at 3 {
+				cvbs_dbg_test_3 {
+					sirf,pins = "cvbs_dbg_test_grp3";
+					sirf,function = "cvbs_dbg_test_m3";
+				};
+			};
+
+			cvbs_dbg_test_pmx4: cvbs_dbg_test at 4 {
+				cvbs_dbg_test_4 {
+					sirf,pins = "cvbs_dbg_test_grp4";
+					sirf,function = "cvbs_dbg_test_m4";
+				};
+			};
+
+			cvbs_dbg_test_pmx5: cvbs_dbg_test at 5 {
+				cvbs_dbg_test_5 {
+					sirf,pins = "cvbs_dbg_test_grp5";
+					sirf,function = "cvbs_dbg_test_m5";
+				};
+			};
+
+			cvbs_dbg_test_pmx6: cvbs_dbg_test at 6 {
+				cvbs_dbg_test_6 {
+					sirf,pins = "cvbs_dbg_test_grp6";
+					sirf,function = "cvbs_dbg_test_m6";
+				};
+			};
+
+			cvbs_dbg_test_pmx7: cvbs_dbg_test at 7 {
+				cvbs_dbg_test_7 {
+					sirf,pins = "cvbs_dbg_test_grp7";
+					sirf,function = "cvbs_dbg_test_m7";
+				};
+			};
+
+			cvbs_dbg_test_pmx8: cvbs_dbg_test at 8 {
+				cvbs_dbg_test_8 {
+					sirf,pins = "cvbs_dbg_test_grp8";
+					sirf,function = "cvbs_dbg_test_m8";
+				};
+			};
+
+			cvbs_dbg_test_pmx9: cvbs_dbg_test at 9 {
+				cvbs_dbg_test_9 {
+					sirf,pins = "cvbs_dbg_test_grp9";
+					sirf,function = "cvbs_dbg_test_m9";
+				};
+			};
+
+			cvbs_dbg_test_pmx10: cvbs_dbg_test at 10 {
+				cvbs_dbg_test_10 {
+					sirf,pins = "cvbs_dbg_test_grp10";
+					sirf,function = "cvbs_dbg_test_m10";
+				};
+			};
+
+			cvbs_dbg_test_pmx11: cvbs_dbg_test at 11 {
+				cvbs_dbg_test_11 {
+					sirf,pins = "cvbs_dbg_test_grp11";
+					sirf,function = "cvbs_dbg_test_m11";
+				};
+			};
+
+			cvbs_dbg_test_pmx12: cvbs_dbg_test at 12 {
+				cvbs_dbg_test_12 {
+					sirf,pins = "cvbs_dbg_test_grp12";
+					sirf,function = "cvbs_dbg_test_m12";
+				};
+			};
+
+			cvbs_dbg_test_pmx13: cvbs_dbg_test at 13 {
+				cvbs_dbg_test_13 {
+					sirf,pins = "cvbs_dbg_test_grp13";
+					sirf,function = "cvbs_dbg_test_m13";
+				};
+			};
+
+			cvbs_dbg_test_pmx14: cvbs_dbg_test at 14 {
+				cvbs_dbg_test_14 {
+					sirf,pins = "cvbs_dbg_test_grp14";
+					sirf,function = "cvbs_dbg_test_m14";
+				};
+			};
+
+			cvbs_dbg_test_pmx15: cvbs_dbg_test at 15 {
+				cvbs_dbg_test_15 {
+					sirf,pins = "cvbs_dbg_test_grp15";
+					sirf,function = "cvbs_dbg_test_m15";
+				};
+			};
+
+			gn_gnss_pmx: gn_gnss at 0 {
+				gn_gnss {
+					sirf,pins = "gn_gnss_grp";
+					sirf,function = "gn_gnss";
+				};
+			};
+
+			gn_io_gnsssys_sw_cfg_pmx: gn_io_gnsssys_sw_cfg at 0 {
+				gn_io_gnsssys_sw_cfg {
+					sirf,pins = "gn_io_gnsssys_sw_cfg_grp";
+					sirf,function = "gn_io_gnsssys_sw_cfg";
+				};
+			};
+
+			gn_trg_pmx0: gn_trg at 0 {
+				gn_trg_0 {
+					sirf,pins = "gn_trg_grp0";
+					sirf,function = "gn_trg_m0";
+				};
+			};
+
+			gn_trg_pmx1: gn_trg at 1 {
+				gn_trg_1 {
+					sirf,pins = "gn_trg_grp1";
+					sirf,function = "gn_trg_m1";
+				};
+			};
+
+			gn_trg_shutdown_pmx0: gn_trg_shutdown at 0 {
+				gn_trg_shutdown_0 {
+					sirf,pins = "gn_trg_shutdown_grp0";
+					sirf,function = "gn_trg_shutdown_m0";
+				};
+			};
+
+			gn_trg_shutdown_pmx1: gn_trg_shutdown at 1 {
+				gn_trg_shutdown_1 {
+					sirf,pins = "gn_trg_shutdown_grp1";
+					sirf,function = "gn_trg_shutdown_m1";
+				};
+			};
+
+			gn_trg_shutdown_pmx2: gn_trg_shutdown at 2 {
+				gn_trg_shutdown_2 {
+					sirf,pins = "gn_trg_shutdown_grp2";
+					sirf,function = "gn_trg_shutdown_m2";
+				};
+			};
+
+			gn_trg_shutdown_pmx3: gn_trg_shutdown at 3 {
+				gn_trg_shutdown_3 {
+					sirf,pins = "gn_trg_shutdown_grp3";
+					sirf,function = "gn_trg_shutdown_m3";
+				};
+			};
+
+			i2c0_pmx: i2c0 at 0 {
+				i2c0 {
+					sirf,pins = "i2c0_grp";
+					sirf,function = "i2c0";
+				};
+			};
+
+			i2c1_pmx: i2c1 at 0 {
+				i2c1 {
+					sirf,pins = "i2c1_grp";
+					sirf,function = "i2c1";
+				};
+			};
+
+			jtag_pmx0: jtag at 0 {
+				jtag_0 {
+					sirf,pins = "jtag_grp0";
+					sirf,function = "jtag_m0";
+				};
+			};
+
+			ks_kas_spi_pmx0: ks_kas_spi at 0 {
+				ks_kas_spi_0 {
+					sirf,pins = "ks_kas_spi_grp0";
+					sirf,function = "ks_kas_spi_m0";
+				};
+			};
+
+			ld_ldd_pmx: ld_ldd at 0 {
+				ld_ldd {
+					sirf,pins = "ld_ldd_grp";
+					sirf,function = "ld_ldd";
+				};
+			};
+
+			ld_ldd_16bit_pmx: ld_ldd_16bit at 0 {
+				ld_ldd_16bit {
+					sirf,pins = "ld_ldd_16bit_grp";
+					sirf,function = "ld_ldd_16bit";
+				};
+			};
+
+			ld_ldd_fck_pmx: ld_ldd_fck at 0 {
+				ld_ldd_fck {
+					sirf,pins = "ld_ldd_fck_grp";
+					sirf,function = "ld_ldd_fck";
+				};
+			};
+
+			ld_ldd_lck_pmx: ld_ldd_lck at 0 {
+				ld_ldd_lck {
+					sirf,pins = "ld_ldd_lck_grp";
+					sirf,function = "ld_ldd_lck";
+				};
+			};
+
+			lr_lcdrom_pmx: lr_lcdrom at 0 {
+				lr_lcdrom {
+					sirf,pins = "lr_lcdrom_grp";
+					sirf,function = "lr_lcdrom";
+				};
+			};
+
+			lvds_analog_pmx: lvds_analog at 0 {
+				lvds_analog {
+					sirf,pins = "lvds_analog_grp";
+					sirf,function = "lvds_analog";
+				};
+			};
+
+			nd_df_pmx: nd_df at 0 {
+				nd_df {
+					sirf,pins = "nd_df_grp";
+					sirf,function = "nd_df";
+				};
+			};
+
+			nd_df_nowp_pmx: nd_df_nowp at 0 {
+				nd_df_nowp {
+					sirf,pins = "nd_df_nowp_grp";
+					sirf,function = "nd_df_nowp";
+				};
+			};
+
+			ps_pmx: ps at 0 {
+				ps {
+					sirf,pins = "ps_grp";
+					sirf,function = "ps";
+				};
+			};
+
+			pwc_core_on_pmx: pwc_core_on at 0 {
+				pwc_core_on {
+					sirf,pins = "pwc_core_on_grp";
+					sirf,function = "pwc_core_on";
+				};
+			};
+
+			pwc_ext_on_pmx: pwc_ext_on at 0 {
+				pwc_ext_on {
+					sirf,pins = "pwc_ext_on_grp";
+					sirf,function = "pwc_ext_on";
+				};
+			};
+
+			pwc_gpio3_clk_pmx: pwc_gpio3_clk at 0 {
+				pwc_gpio3_clk {
+					sirf,pins = "pwc_gpio3_clk_grp";
+					sirf,function = "pwc_gpio3_clk";
+				};
+			};
+
+			pwc_io_on_pmx: pwc_io_on at 0 {
+				pwc_io_on {
+					sirf,pins = "pwc_io_on_grp";
+					sirf,function = "pwc_io_on";
+				};
+			};
+
+			pwc_lowbatt_b_pmx0: pwc_lowbatt_b at 0 {
+				pwc_lowbatt_b_0 {
+					sirf,pins = "pwc_lowbatt_b_grp0";
+					sirf,function = "pwc_lowbatt_b_m0";
+				};
+			};
+
+			pwc_mem_on_pmx: pwc_mem_on at 0 {
+				pwc_mem_on {
+					sirf,pins = "pwc_mem_on_grp";
+					sirf,function = "pwc_mem_on";
+				};
+			};
+
+			pwc_on_key_b_pmx0: pwc_on_key_b at 0 {
+				pwc_on_key_b_0 {
+					sirf,pins = "pwc_on_key_b_grp0";
+					sirf,function = "pwc_on_key_b_m0";
+				};
+			};
+
+			pwc_wakeup_src0_pmx: pwc_wakeup_src0 at 0 {
+				pwc_wakeup_src0 {
+					sirf,pins = "pwc_wakeup_src0_grp";
+					sirf,function = "pwc_wakeup_src0";
+				};
+			};
+
+			pwc_wakeup_src1_pmx: pwc_wakeup_src1 at 0 {
+				pwc_wakeup_src1 {
+					sirf,pins = "pwc_wakeup_src1_grp";
+					sirf,function = "pwc_wakeup_src1";
+				};
+			};
+
+			pwc_wakeup_src2_pmx: pwc_wakeup_src2 at 0 {
+				pwc_wakeup_src2 {
+					sirf,pins = "pwc_wakeup_src2_grp";
+					sirf,function = "pwc_wakeup_src2";
+				};
+			};
+
+			pwc_wakeup_src3_pmx: pwc_wakeup_src3 at 0 {
+				pwc_wakeup_src3 {
+					sirf,pins = "pwc_wakeup_src3_grp";
+					sirf,function = "pwc_wakeup_src3";
+				};
+			};
+
+			pw_cko0_pmx0: pw_cko0 at 0 {
+				pw_cko0_0 {
+					sirf,pins = "pw_cko0_grp0";
+					sirf,function = "pw_cko0_m0";
+				};
+			};
+
+			pw_cko0_pmx1: pw_cko0 at 1 {
+				pw_cko0_1 {
+					sirf,pins = "pw_cko0_grp1";
+					sirf,function = "pw_cko0_m1";
+				};
+			};
+
+			pw_cko0_pmx2: pw_cko0 at 2 {
+				pw_cko0_2 {
+					sirf,pins = "pw_cko0_grp2";
+					sirf,function = "pw_cko0_m2";
+				};
+			};
+
+			pw_cko1_pmx0: pw_cko1 at 0 {
+				pw_cko1_0 {
+					sirf,pins = "pw_cko1_grp0";
+					sirf,function = "pw_cko1_m0";
+				};
+			};
+
+			pw_cko1_pmx1: pw_cko1 at 1 {
+				pw_cko1_1 {
+					sirf,pins = "pw_cko1_grp1";
+					sirf,function = "pw_cko1_m1";
+				};
+			};
+
+			pw_i2s01_clk_pmx0: pw_i2s01_clk at 0 {
+				pw_i2s01_clk_0 {
+					sirf,pins = "pw_i2s01_clk_grp0";
+					sirf,function = "pw_i2s01_clk_m0";
+				};
+			};
+
+			pw_i2s01_clk_pmx1: pw_i2s01_clk at 1 {
+				pw_i2s01_clk_1 {
+					sirf,pins = "pw_i2s01_clk_grp1";
+					sirf,function = "pw_i2s01_clk_m1";
+				};
+			};
+
+			pw_pwm_pmx0: pw_pwm at 0 {
+				pw_pwm_0 {
+					sirf,pins = "pw_pwm_grp0";
+					sirf,function = "pw_pwm_m0";
+				};
+			};
+
+			pw_pwm_pmx1: pw_pwm at 1 {
+				pw_pwm_1 {
+					sirf,pins = "pw_pwm_grp1";
+					sirf,function = "pw_pwm_m1";
+				};
+			};
+
+			rg_eth_mac_pmx: rg_eth_mac at 0 {
+				rg_eth_mac {
+					sirf,pins = "rg_eth_mac_grp";
+					sirf,function = "rg_eth_mac";
+				};
+			};
+
+			rg_gmac_phy_intr_n_pmx: rg_gmac_phy_intr_n at 0 {
+				rg_gmac_phy_intr_n {
+					sirf,pins = "rg_gmac_phy_intr_n_grp";
+					sirf,function = "rg_gmac_phy_intr_n";
+				};
+			};
+
+			rg_rgmii_mac_pmx: rg_rgmii_mac at 0 {
+				rg_rgmii_mac {
+					sirf,pins = "rg_rgmii_mac_grp";
+					sirf,function = "rg_rgmii_mac";
+				};
+			};
+
+			rg_rgmii_phy_ref_clk_pmx0: rg_rgmii_phy_ref_clk at 0 {
+				rg_rgmii_phy_ref_clk_0 {
+					sirf,pins =
+						"rg_rgmii_phy_ref_clk_grp0";
+					sirf,function =
+						"rg_rgmii_phy_ref_clk_m0";
+				};
+			};
+
+			rg_rgmii_phy_ref_clk_pmx1: rg_rgmii_phy_ref_clk at 1 {
+				rg_rgmii_phy_ref_clk_1 {
+					sirf,pins =
+						"rg_rgmii_phy_ref_clk_grp1";
+					sirf,function =
+						"rg_rgmii_phy_ref_clk_m1";
+				};
+			};
+
+			sd0_pmx: sd0 at 0 {
+				sd0 {
+					sirf,pins = "sd0_grp";
+					sirf,function = "sd0";
+				};
+			};
+
+			sd0_4bit_pmx: sd0_4bit at 0 {
+				sd0_4bit {
+					sirf,pins = "sd0_4bit_grp";
+					sirf,function = "sd0_4bit";
+				};
+			};
+
+			sd1_pmx: sd1 at 0 {
+				sd1 {
+					sirf,pins = "sd1_grp";
+					sirf,function = "sd1";
+				};
+			};
+
+			sd1_4bit_pmx0: sd1_4bit at 0 {
+				sd1_4bit_0 {
+					sirf,pins = "sd1_4bit_grp0";
+					sirf,function = "sd1_4bit_m0";
+				};
+			};
+
+			sd1_4bit_pmx1: sd1_4bit at 1 {
+				sd1_4bit_1 {
+					sirf,pins = "sd1_4bit_grp1";
+					sirf,function = "sd1_4bit_m1";
+				};
+			};
+
+			sd2_pmx0: sd2 at 0 {
+				sd2_0 {
+					sirf,pins = "sd2_grp0";
+					sirf,function = "sd2_m0";
+				};
+			};
+
+			sd2_no_cdb_pmx0: sd2_no_cdb at 0 {
+				sd2_no_cdb_0 {
+					sirf,pins = "sd2_no_cdb_grp0";
+					sirf,function = "sd2_no_cdb_m0";
+				};
+			};
+
+			sd3_pmx: sd3 at 0 {
+				sd3 {
+					sirf,pins = "sd3_grp";
+					sirf,function = "sd3";
+				};
+			};
+
+			sd5_pmx: sd5 at 0 {
+				sd5 {
+					sirf,pins = "sd5_grp";
+					sirf,function = "sd5";
+				};
+			};
+
+			sd6_pmx0: sd6 at 0 {
+				sd6_0 {
+					sirf,pins = "sd6_grp0";
+					sirf,function = "sd6_m0";
+				};
+			};
+
+			sd6_pmx1: sd6 at 1 {
+				sd6_1 {
+					sirf,pins = "sd6_grp1";
+					sirf,function = "sd6_m1";
+				};
+			};
+
+			sp0_ext_ldo_on_pmx: sp0_ext_ldo_on at 0 {
+				sp0_ext_ldo_on {
+					sirf,pins = "sp0_ext_ldo_on_grp";
+					sirf,function = "sp0_ext_ldo_on";
+				};
+			};
+
+			sp0_qspi_pmx: sp0_qspi at 0 {
+				sp0_qspi {
+					sirf,pins = "sp0_qspi_grp";
+					sirf,function = "sp0_qspi";
+				};
+			};
+
+			sp1_spi_pmx: sp1_spi at 0 {
+				sp1_spi {
+					sirf,pins = "sp1_spi_grp";
+					sirf,function = "sp1_spi";
+				};
+			};
+
+			tpiu_trace_pmx: tpiu_trace at 0 {
+				tpiu_trace {
+					sirf,pins = "tpiu_trace_grp";
+					sirf,function = "tpiu_trace";
+				};
+			};
+
+			uart0_pmx: uart0 at 0 {
+				uart0 {
+					sirf,pins = "uart0_grp";
+					sirf,function = "uart0";
+				};
+			};
+
+			uart0_nopause_pmx: uart0_nopause at 0 {
+				uart0_nopause {
+					sirf,pins = "uart0_nopause_grp";
+					sirf,function = "uart0_nopause";
+				};
+			};
+
+			uart1_pmx: uart1 at 0 {
+				uart1 {
+					sirf,pins = "uart1_grp";
+					sirf,function = "uart1";
+				};
+			};
+
+			uart2_pmx: uart2 at 0 {
+				uart2 {
+					sirf,pins = "uart2_grp";
+					sirf,function = "uart2";
+				};
+			};
+
+			uart3_pmx0: uart3 at 0 {
+				uart3_0 {
+					sirf,pins = "uart3_grp0";
+					sirf,function = "uart3_m0";
+				};
+			};
+
+			uart3_pmx1: uart3 at 1 {
+				uart3_1 {
+					sirf,pins = "uart3_grp1";
+					sirf,function = "uart3_m1";
+				};
+			};
+
+			uart3_pmx2: uart3 at 2 {
+				uart3_2 {
+					sirf,pins = "uart3_grp2";
+					sirf,function = "uart3_m2";
+				};
+			};
+
+			uart3_pmx3: uart3 at 3 {
+				uart3_3 {
+					sirf,pins = "uart3_grp3";
+					sirf,function = "uart3_m3";
+				};
+			};
+
+			uart3_nopause_pmx0: uart3_nopause at 0 {
+				uart3_nopause_0 {
+					sirf,pins = "uart3_nopause_grp0";
+					sirf,function = "uart3_nopause_m0";
+				};
+			};
+
+			uart3_nopause_pmx1: uart3_nopause at 1 {
+				uart3_nopause_1 {
+					sirf,pins = "uart3_nopause_grp1";
+					sirf,function = "uart3_nopause_m1";
+				};
+			};
+
+			uart4_pmx0: uart4 at 0 {
+				uart4_0 {
+					sirf,pins = "uart4_grp0";
+					sirf,function = "uart4_m0";
+				};
+			};
+
+			uart4_pmx1: uart4 at 1 {
+				uart4_1 {
+					sirf,pins = "uart4_grp1";
+					sirf,function = "uart4_m1";
+				};
+			};
+
+			uart4_pmx2: uart4 at 2 {
+				uart4_2 {
+					sirf,pins = "uart4_grp2";
+					sirf,function = "uart4_m2";
+				};
+			};
+
+			uart4_nopause_pmx: uart4_nopause at 0 {
+				uart4_nopause {
+					sirf,pins = "uart4_nopause_grp";
+					sirf,function = "uart4_nopause";
+				};
+			};
+
+			usb0_drvvbus_pmx: usb0_drvvbus at 0 {
+				usb0_drvvbus {
+					sirf,pins = "usb0_drvvbus_grp";
+					sirf,function = "usb0_drvvbus";
+				};
+			};
+
+			usb1_drvvbus_pmx: usb1_drvvbus at 0 {
+				usb1_drvvbus {
+					sirf,pins = "usb1_drvvbus_grp";
+					sirf,function = "usb1_drvvbus";
+				};
+			};
+
+			visbus_dout_pmx: visbus_dout at 0 {
+				visbus_dout {
+					sirf,pins = "visbus_dout_grp";
+					sirf,function = "visbus_dout";
+				};
+			};
+
+			vi_vip1_pmx: vi_vip1 at 0 {
+				vi_vip1 {
+					sirf,pins = "vi_vip1_grp";
+					sirf,function = "vi_vip1";
+				};
+			};
+
+			vi_vip1_low8bit_pmx: vi_vip1_low8bit at 0 {
+				vi_vip1_low8bit {
+					sirf,pins = "vi_vip1_low8bit_grp";
+					sirf,function = "vi_vip1_low8bit";
+				};
+			};
+
+			vi_vip1_high8bit_pmx: vi_vip1_high8bit at 0 {
+				vi_vip1_high8bit {
+					sirf,pins = "vi_vip1_high8bit_grp";
+					sirf,function = "vi_vip1_high8bit";
+				};
+			};
 		};
 
 		pmipc {
@@ -341,11 +1241,19 @@
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
 				compatible = "sirf,atlas7-nand";
 				reg = <0x17050000 0x10000>;
+				pinctrl-names = "default";
+				pinctrl-0 = <&nd_df_pmx>;
 				interrupts = <0 41 0>;
 				clocks = <&car 108>, <&car 112>;
 				clock-names = "nand_io", "nand_nand";
@@ -451,6 +1359,14 @@
 				clock-names = "gpio1_io";
 				gpio-controller;
 				interrupt-controller;
+
+				gpio-banks = <3>;
+				gpio-ranges = <&pinctrl 0 0 0>,
+						<&pinctrl 32 0 0>,
+						<&pinctrl 64 0 0>;
+				gpio-ranges-group-names = "gnss_gpio_grp",
+							"lcd_vip_gpio_grp",
+							"sdio_i2s_gpio_grp";
 			};
 
 			sd2: sdhci at 14200000 {
@@ -729,6 +1645,10 @@
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
2.2.0
