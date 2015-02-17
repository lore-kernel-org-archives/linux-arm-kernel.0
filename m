From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 17 Feb 2015 11:57:45 -0700
Subject: [PATCH] ARM: tegra: import latest Jetson TK1 pinmux
Message-ID: <1424199465-11041-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

syseng has revamped the Jetson TK1 pinmux spreadsheet, basing the content
completely on correct configuration for the board/schematic, rather than
the previous version which was based on the bare minimum changes relative
to another reference board.

This content comes from Jetson_TK1_customer_pinmux.xlsm (v09) downloaded
from https://developer.nvidia.com/hardware-design-and-development.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 arch/arm/boot/dts/tegra124-jetson-tk1.dts | 557 ++++++++++++++----------------
 1 file changed, 254 insertions(+), 303 deletions(-)

diff --git a/arch/arm/boot/dts/tegra124-jetson-tk1.dts b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
index 4eb540be368f..256da8e99638 100644
--- a/arch/arm/boot/dts/tegra124-jetson-tk1.dts
+++ b/arch/arm/boot/dts/tegra124-jetson-tk1.dts
@@ -60,35 +60,35 @@
 				nvidia,pins = "clk_32k_out_pa0";
 				nvidia,function = "soc";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			uart3_cts_n_pa1 {
 				nvidia,pins = "uart3_cts_n_pa1";
-				nvidia,function = "uartc";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap2_fs_pa2 {
 				nvidia,pins = "dap2_fs_pa2";
 				nvidia,function = "i2s1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap2_sclk_pa3 {
 				nvidia,pins = "dap2_sclk_pa3";
 				nvidia,function = "i2s1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap2_din_pa4 {
 				nvidia,pins = "dap2_din_pa4";
 				nvidia,function = "i2s1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			dap2_dout_pa5 {
@@ -96,14 +96,14 @@
 				nvidia,function = "i2s1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_clk_pa6 {
 				nvidia,pins = "sdmmc3_clk_pa6";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc3_cmd_pa7 {
 				nvidia,pins = "sdmmc3_cmd_pa7";
@@ -116,14 +116,14 @@
 				nvidia,pins = "pb0";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pb1 {
 				nvidia,pins = "pb1";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc3_dat3_pb4 {
@@ -156,9 +156,9 @@
 			};
 			uart3_rts_n_pc0 {
 				nvidia,pins = "uart3_rts_n_pc0";
-				nvidia,function = "uartc";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "gmi";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			uart2_txd_pc2 {
@@ -172,7 +172,7 @@
 				nvidia,pins = "uart2_rxd_pc3";
 				nvidia,function = "irda";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			gen1_i2c_scl_pc4 {
@@ -194,44 +194,39 @@
 			pc7 {
 				nvidia,pins = "pc7";
 				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pg0 {
 				nvidia,pins = "pg0";
-				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pg1 {
 				nvidia,pins = "pg1";
-				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pg2 {
 				nvidia,pins = "pg2";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pg3 {
 				nvidia,pins = "pg3";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pg4 {
 				nvidia,pins = "pg4";
-				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pg5 {
 				nvidia,pins = "pg5";
@@ -251,7 +246,7 @@
 				nvidia,pins = "pg7";
 				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			ph0 {
@@ -270,7 +265,6 @@
 			};
 			ph2 {
 				nvidia,pins = "ph2";
-				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -278,57 +272,53 @@
 			ph3 {
 				nvidia,pins = "ph3";
 				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ph4 {
 				nvidia,pins = "ph4";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			ph5 {
 				nvidia,pins = "ph5";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ph6 {
 				nvidia,pins = "ph6";
 				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ph7 {
 				nvidia,pins = "ph7";
-				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pi0 {
 				nvidia,pins = "pi0";
-				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pi1 {
 				nvidia,pins = "pi1";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pi2 {
 				nvidia,pins = "pi2";
 				nvidia,function = "rsvd4";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pi3 {
@@ -341,22 +331,21 @@
 			pi4 {
 				nvidia,pins = "pi4";
 				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pi5 {
 				nvidia,pins = "pi5";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pi6 {
 				nvidia,pins = "pi6";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pi7 {
@@ -368,23 +357,22 @@
 			};
 			pj0 {
 				nvidia,pins = "pj0";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pj2 {
 				nvidia,pins = "pj2";
 				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			uart2_cts_n_pj5 {
 				nvidia,pins = "uart2_cts_n_pj5";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			uart2_rts_n_pj6 {
@@ -403,35 +391,32 @@
 			};
 			pk0 {
 				nvidia,pins = "pk0";
-				nvidia,function = "soc";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "rsvd1";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pk1 {
 				nvidia,pins = "pk1";
-				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pk2 {
 				nvidia,pins = "pk2";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pk3 {
 				nvidia,pins = "pk3";
 				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pk4 {
 				nvidia,pins = "pk4";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -439,13 +424,12 @@
 			spdif_out_pk5 {
 				nvidia,pins = "spdif_out_pk5";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			spdif_in_pk6 {
 				nvidia,pins = "spdif_in_pk6";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -459,17 +443,17 @@
 			};
 			dap1_fs_pn0 {
 				nvidia,pins = "dap1_fs_pn0";
-				nvidia,function = "i2s0";
+				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap1_din_pn1 {
 				nvidia,pins = "dap1_din_pn1";
-				nvidia,function = "i2s0";
+				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap1_dout_pn2 {
 				nvidia,pins = "dap1_dout_pn2";
@@ -480,108 +464,104 @@
 			};
 			dap1_sclk_pn3 {
 				nvidia,pins = "dap1_sclk_pn3";
-				nvidia,function = "i2s0";
+				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			usb_vbus_en0_pn4 {
 				nvidia,pins = "usb_vbus_en0_pn4";
 				nvidia,function = "usb";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			usb_vbus_en1_pn5 {
 				nvidia,pins = "usb_vbus_en1_pn5";
 				nvidia,function = "usb";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			hdmi_int_pn7 {
 				nvidia,pins = "hdmi_int_pn7";
-				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 				nvidia,rcv-sel = <TEGRA_PIN_DISABLE>;
 			};
 			ulpi_data7_po0 {
 				nvidia,pins = "ulpi_data7_po0";
 				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ulpi_data0_po1 {
 				nvidia,pins = "ulpi_data0_po1";
-				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			ulpi_data1_po2 {
 				nvidia,pins = "ulpi_data1_po2";
 				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ulpi_data2_po3 {
 				nvidia,pins = "ulpi_data2_po3";
 				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ulpi_data3_po4 {
 				nvidia,pins = "ulpi_data3_po4";
-				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			ulpi_data4_po5 {
 				nvidia,pins = "ulpi_data4_po5";
 				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ulpi_data5_po6 {
 				nvidia,pins = "ulpi_data5_po6";
 				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			ulpi_data6_po7 {
 				nvidia,pins = "ulpi_data6_po7";
 				nvidia,function = "ulpi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap3_fs_pp0 {
 				nvidia,pins = "dap3_fs_pp0";
 				nvidia,function = "i2s2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap3_din_pp1 {
 				nvidia,pins = "dap3_din_pp1";
 				nvidia,function = "i2s2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap3_dout_pp2 {
 				nvidia,pins = "dap3_dout_pp2";
-				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -595,91 +575,87 @@
 			};
 			dap4_fs_pp4 {
 				nvidia,pins = "dap4_fs_pp4";
-				nvidia,function = "i2s3";
+				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap4_din_pp5 {
 				nvidia,pins = "dap4_din_pp5";
-				nvidia,function = "i2s3";
+				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap4_dout_pp6 {
 				nvidia,pins = "dap4_dout_pp6";
-				nvidia,function = "i2s3";
+				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap4_sclk_pp7 {
 				nvidia,pins = "dap4_sclk_pp7";
-				nvidia,function = "i2s3";
+				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_col0_pq0 {
 				nvidia,pins = "kb_col0_pq0";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_col1_pq1 {
 				nvidia,pins = "kb_col1_pq1";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_col2_pq2 {
 				nvidia,pins = "kb_col2_pq2";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_col3_pq3 {
 				nvidia,pins = "kb_col3_pq3";
-				nvidia,function = "kbc";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_col4_pq4 {
 				nvidia,pins = "kb_col4_pq4";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_col5_pq5 {
 				nvidia,pins = "kb_col5_pq5";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_col6_pq6 {
 				nvidia,pins = "kb_col6_pq6";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_col7_pq7 {
 				nvidia,pins = "kb_col7_pq7";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row0_pr0 {
 				nvidia,pins = "kb_row0_pr0";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -687,121 +663,115 @@
 			kb_row1_pr1 {
 				nvidia,pins = "kb_row1_pr1";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row2_pr2 {
 				nvidia,pins = "kb_row2_pr2";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row3_pr3 {
 				nvidia,pins = "kb_row3_pr3";
-				nvidia,function = "sys";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "kbc";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row4_pr4 {
 				nvidia,pins = "kb_row4_pr4";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_row5_pr5 {
 				nvidia,pins = "kb_row5_pr5";
 				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row6_pr6 {
 				nvidia,pins = "kb_row6_pr6";
 				nvidia,function = "displaya_alt";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_row7_pr7 {
 				nvidia,pins = "kb_row7_pr7";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_row8_ps0 {
 				nvidia,pins = "kb_row8_ps0";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row9_ps1 {
 				nvidia,pins = "kb_row9_ps1";
-				nvidia,function = "rsvd2";
+				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row10_ps2 {
 				nvidia,pins = "kb_row10_ps2";
-				nvidia,function = "rsvd2";
+				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_row11_ps3 {
 				nvidia,pins = "kb_row11_ps3";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row12_ps4 {
 				nvidia,pins = "kb_row12_ps4";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row13_ps5 {
 				nvidia,pins = "kb_row13_ps5";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row14_ps6 {
 				nvidia,pins = "kb_row14_ps6";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row15_ps7 {
 				nvidia,pins = "kb_row15_ps7";
-				nvidia,function = "soc";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			kb_row16_pt0 {
 				nvidia,pins = "kb_row16_pt0";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row17_pt1 {
 				nvidia,pins = "kb_row17_pt1";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			gen2_i2c_scl_pt5 {
 				nvidia,pins = "gen2_i2c_scl_pt5";
@@ -828,72 +798,63 @@
 			};
 			pu0 {
 				nvidia,pins = "pu0";
-				nvidia,function = "rsvd4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pu1 {
 				nvidia,pins = "pu1";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pu2 {
 				nvidia,pins = "pu2";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pu3 {
 				nvidia,pins = "pu3";
-				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pu4 {
 				nvidia,pins = "pu4";
-				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pu5 {
 				nvidia,pins = "pu5";
-				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pu6 {
 				nvidia,pins = "pu6";
-				nvidia,function = "rsvd3";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pv0 {
 				nvidia,pins = "pv0";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pv1 {
 				nvidia,pins = "pv1";
-				nvidia,function = "rsvd1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc3_cd_n_pv2 {
 				nvidia,pins = "sdmmc3_cd_n_pv2";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			sdmmc1_wp_n_pv3 {
@@ -922,16 +883,16 @@
 			gpio_w2_aud_pw2 {
 				nvidia,pins = "gpio_w2_aud_pw2";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			gpio_w3_aud_pw3 {
 				nvidia,pins = "gpio_w3_aud_pw3";
 				nvidia,function = "spi6";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap_mclk1_pw4 {
 				nvidia,pins = "dap_mclk1_pw4";
@@ -949,17 +910,17 @@
 			};
 			uart3_txd_pw6 {
 				nvidia,pins = "uart3_txd_pw6";
-				nvidia,function = "uartc";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			uart3_rxd_pw7 {
 				nvidia,pins = "uart3_rxd_pw7";
-				nvidia,function = "uartc";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dvfs_pwm_px0 {
 				nvidia,pins = "dvfs_pwm_px0";
@@ -970,10 +931,9 @@
 			};
 			gpio_x1_aud_px1 {
 				nvidia,pins = "gpio_x1_aud_px1";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			dvfs_clk_px2 {
 				nvidia,pins = "dvfs_clk_px2";
@@ -985,34 +945,32 @@
 			gpio_x3_aud_px3 {
 				nvidia,pins = "gpio_x3_aud_px3";
 				nvidia,function = "rsvd4";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			gpio_x4_aud_px4 {
 				nvidia,pins = "gpio_x4_aud_px4";
-				nvidia,function = "gmi";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			gpio_x5_aud_px5 {
 				nvidia,pins = "gpio_x5_aud_px5";
 				nvidia,function = "rsvd4";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			gpio_x6_aud_px6 {
 				nvidia,pins = "gpio_x6_aud_px6";
 				nvidia,function = "gmi";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			gpio_x7_aud_px7 {
 				nvidia,pins = "gpio_x7_aud_px7";
-				nvidia,function = "rsvd1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -1027,8 +985,8 @@
 			ulpi_dir_py1 {
 				nvidia,pins = "ulpi_dir_py1";
 				nvidia,function = "spi1";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			ulpi_nxt_py2 {
@@ -1048,44 +1006,44 @@
 			sdmmc1_dat3_py4 {
 				nvidia,pins = "sdmmc1_dat3_py4";
 				nvidia,function = "sdmmc1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc1_dat2_py5 {
 				nvidia,pins = "sdmmc1_dat2_py5";
 				nvidia,function = "sdmmc1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc1_dat1_py6 {
 				nvidia,pins = "sdmmc1_dat1_py6";
 				nvidia,function = "sdmmc1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc1_dat0_py7 {
 				nvidia,pins = "sdmmc1_dat0_py7";
-				nvidia,function = "sdmmc1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "rsvd2";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc1_clk_pz0 {
 				nvidia,pins = "sdmmc1_clk_pz0";
-				nvidia,function = "sdmmc1";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,function = "rsvd3";
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc1_cmd_pz1 {
 				nvidia,pins = "sdmmc1_cmd_pz1";
 				nvidia,function = "sdmmc1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pwr_i2c_scl_pz6 {
 				nvidia,pins = "pwr_i2c_scl_pz6";
@@ -1184,7 +1142,6 @@
 			};
 			pbb3 {
 				nvidia,pins = "pbb3";
-				nvidia,function = "vgp3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -1198,21 +1155,18 @@
 			};
 			pbb5 {
 				nvidia,pins = "pbb5";
-				nvidia,function = "rsvd3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pbb6 {
 				nvidia,pins = "pbb6";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pbb7 {
 				nvidia,pins = "pbb7";
-				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -1226,15 +1180,13 @@
 			};
 			pcc1 {
 				nvidia,pins = "pcc1";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pcc2 {
 				nvidia,pins = "pcc2";
-				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
@@ -1248,8 +1200,8 @@
 			clk2_req_pcc5 {
 				nvidia,pins = "clk2_req_pcc5";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			pex_l0_rst_n_pdd1 {
@@ -1262,15 +1214,15 @@
 			pex_l0_clkreq_n_pdd2 {
 				nvidia,pins = "pex_l0_clkreq_n_pdd2";
 				nvidia,function = "pe0";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pex_wake_n_pdd3 {
 				nvidia,pins = "pex_wake_n_pdd3";
 				nvidia,function = "pe";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			pex_l1_rst_n_pdd5 {
@@ -1283,8 +1235,8 @@
 			pex_l1_clkreq_n_pdd6 {
 				nvidia,pins = "pex_l1_clkreq_n_pdd6";
 				nvidia,function = "pe1";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			clk3_out_pee0 {
@@ -1297,13 +1249,12 @@
 			clk3_req_pee1 {
 				nvidia,pins = "clk3_req_pee1";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap_mclk1_req_pee2 {
 				nvidia,pins = "dap_mclk1_req_pee2";
-				nvidia,function = "sata";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -1314,7 +1265,7 @@
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
-				nvidia,open-drain = <TEGRA_PIN_ENABLE>;
+				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_clk_lb_out_pee4 {
 				nvidia,pins = "sdmmc3_clk_lb_out_pee4";
@@ -1333,24 +1284,24 @@
 			dp_hpd_pff0 {
 				nvidia,pins = "dp_hpd_pff0";
 				nvidia,function = "dp";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			usb_vbus_en2_pff1 {
 				nvidia,pins = "usb_vbus_en2_pff1";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			pff2 {
 				nvidia,pins = "pff2";
 				nvidia,function = "rsvd2";
-				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
+				nvidia,pull = <TEGRA_PIN_PULL_DOWN>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
+				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 				nvidia,open-drain = <TEGRA_PIN_DISABLE>;
 			};
 			core_pwr_req {
@@ -1362,7 +1313,7 @@
 			};
 			cpu_pwr_req {
 				nvidia,pins = "cpu_pwr_req";
-				nvidia,function = "rsvd2";
+				nvidia,function = "cpu";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
@@ -1371,7 +1322,7 @@
 				nvidia,pins = "pwr_int_n";
 				nvidia,function = "pmi";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			reset_out_n {
@@ -1379,7 +1330,7 @@
 				nvidia,function = "reset_out_n";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
+				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			owr {
 				nvidia,pins = "owr";
@@ -1391,9 +1342,9 @@
 			};
 			clk_32k_in {
 				nvidia,pins = "clk_32k_in";
-				nvidia,function = "rsvd2";
+				nvidia,function = "clk";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
-				nvidia,tristate = <TEGRA_PIN_DISABLE>;
+				nvidia,tristate = <TEGRA_PIN_ENABLE>;
 				nvidia,enable-input = <TEGRA_PIN_ENABLE>;
 			};
 			jtag_rtck {
-- 
1.9.1
