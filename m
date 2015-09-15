From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Sep 2015 10:33:47 +0200
Subject: [PATCH 0/9] arm: tegra: apalis_t30: fix pin mux, hdmi, wakeup
 and enable hda
In-Reply-To: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440765756-1382-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20150915083346.GC25970@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 02:42:27PM +0200, Marcel Ziswiler wrote:
> This series finally continues on my previous Easter efforts (BTW:
> thanks all for the feedback and all the patches thereof already having
> been applied) and additionally to fixing the pin muxing and enabling
> HDA audio also fixes HDMI and the wake-up key.
> 
> 
> Marcel Ziswiler (9):
>   arm: tegra: apalis_t30: update hardware revisions compatibility
>     comment
>   arm: tegra: apalis_t30: fix hdmi supply
>   arm: tegra: apalis_t30: fix pin muxing
>   arm: tegra: apalis_t30: add comment concerning emmc
>   arm: tegra: apalis_t30: add digital audio pin muxing
>   arm: tegra: apalis_t30: enable hda for eval board
>   arm: tegra: apalis_t30: set otg dr_mode for eval board
>   arm: tegra: apalis_t30: fix backlight pwm comment for eval board
>   arm: tegra: apalis_t30: fix power/wakeup key for eval board
> 
>  arch/arm/boot/dts/tegra30-apalis-eval.dts | 13 +++--
>  arch/arm/boot/dts/tegra30-apalis.dtsi     | 80 ++++++++++++++++++++++++-------
>  2 files changed, 73 insertions(+), 20 deletions(-)

Applied with minor tweaks to the subjects (to match the "ARM: tegra: "
prefix) and commit messages.

I've also applied the following on top to make pin names consistently
aligned.

Thierry

--- >8 ---

>From f330bb512f4f2bff9d7e73f2a39dc265099faefb Mon Sep 17 00:00:00 2001
From: Thierry Reding <treding@nvidia.com>
Date: Tue, 15 Sep 2015 10:29:57 +0200
Subject: [PATCH] ARM: tegra: apalis: Properly align pins in pinmux

Align pin names on subsequent lines with the first the name of the first
pin in the first line.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30-apalis.dtsi | 152 +++++++++++++++++-----------------
 1 file changed, 76 insertions(+), 76 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-apalis.dtsi b/arch/arm/boot/dts/tegra30-apalis.dtsi
index 4a6ca389595c..bf361277fe10 100644
--- a/arch/arm/boot/dts/tegra30-apalis.dtsi
+++ b/arch/arm/boot/dts/tegra30-apalis.dtsi
@@ -58,14 +58,14 @@
 
 			/* Apalis BKL1_PWM */
 			uart3_rts_n_pc0 {
-				nvidia,pins =	"uart3_rts_n_pc0";
+				nvidia,pins = "uart3_rts_n_pc0";
 				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			/* BKL1_PWM_EN#, disable TPS65911 PMIC PWM backlight */
 			uart3_cts_n_pa1 {
-				nvidia,pins =	"uart3_cts_n_pa1";
+				nvidia,pins = "uart3_cts_n_pa1";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -73,10 +73,10 @@
 
 			/* Apalis CAN1 on SPI6 */
 			spi2_cs0_n_px3 {
-				nvidia,pins =   "spi2_cs0_n_px3",
-						"spi2_miso_px1",
-						"spi2_mosi_px0",
-						"spi2_sck_px2";
+				nvidia,pins = "spi2_cs0_n_px3",
+					      "spi2_miso_px1",
+					      "spi2_mosi_px0",
+					      "spi2_sck_px2";
 				nvidia,function = "spi6";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -92,10 +92,10 @@
 
 			/* Apalis CAN2 on SPI4 */
 			gmi_a16_pj7 {
-				nvidia,pins =   "gmi_a16_pj7",
-						"gmi_a17_pb0",
-						"gmi_a18_pb1",
-						"gmi_a19_pk7";
+				nvidia,pins = "gmi_a16_pj7",
+					      "gmi_a17_pb0",
+					      "gmi_a18_pb1",
+					      "gmi_a19_pk7";
 				nvidia,function = "spi4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -111,7 +111,7 @@
 
 			/* Apalis Digital Audio */
 			clk1_req_pee2 {
-				nvidia,pins =	"clk1_req_pee2";
+				nvidia,pins = "clk1_req_pee2";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -124,10 +124,10 @@
 				nvidia,enable-input = <TEGRA_PIN_DISABLE>;
 			};
 			dap1_fs_pn0 {
-				nvidia,pins =	"dap1_fs_pn0",
-						"dap1_din_pn1",
-						"dap1_dout_pn2",
-						"dap1_sclk_pn3";
+				nvidia,pins = "dap1_fs_pn0",
+					      "dap1_din_pn1",
+					      "dap1_dout_pn2",
+					      "dap1_sclk_pn3";
 				nvidia,function = "hda";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -147,21 +147,21 @@
 
 			/* Apalis MMC1 */
 			sdmmc3_clk_pa6 {
-				nvidia,pins =	"sdmmc3_clk_pa6",
-						"sdmmc3_cmd_pa7";
+				nvidia,pins = "sdmmc3_clk_pa6",
+					      "sdmmc3_cmd_pa7";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_dat0_pb7 {
-				nvidia,pins =	"sdmmc3_dat0_pb7",
-						"sdmmc3_dat1_pb6",
-						"sdmmc3_dat2_pb5",
-						"sdmmc3_dat3_pb4",
-						"sdmmc3_dat4_pd1",
-						"sdmmc3_dat5_pd0",
-						"sdmmc3_dat6_pd3",
-						"sdmmc3_dat7_pd4";
+				nvidia,pins = "sdmmc3_dat0_pb7",
+					      "sdmmc3_dat1_pb6",
+					      "sdmmc3_dat2_pb5",
+					      "sdmmc3_dat3_pb4",
+					      "sdmmc3_dat4_pd1",
+					      "sdmmc3_dat5_pd0",
+					      "sdmmc3_dat6_pd3",
+					      "sdmmc3_dat7_pd4";
 				nvidia,function = "sdmmc3";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -177,7 +177,7 @@
 
 			/* Apalis PWM1 */
 			pu6 {
-				nvidia,pins =	"pu6";
+				nvidia,pins = "pu6";
 				nvidia,function = "pwm3";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -185,7 +185,7 @@
 
 			/* Apalis PWM2 */
 			pu5 {
-				nvidia,pins =	"pu5";
+				nvidia,pins = "pu5";
 				nvidia,function = "pwm2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -193,7 +193,7 @@
 
 			/* Apalis PWM3 */
 			pu4 {
-				nvidia,pins =	"pu4";
+				nvidia,pins = "pu4";
 				nvidia,function = "pwm1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -201,7 +201,7 @@
 
 			/* Apalis PWM4 */
 			pu3 {
-				nvidia,pins =	"pu3";
+				nvidia,pins = "pu3";
 				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -223,11 +223,11 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc1_cmd_pz1 {
-				nvidia,pins =	"sdmmc1_cmd_pz1",
-						"sdmmc1_dat0_py7",
-						"sdmmc1_dat1_py6",
-						"sdmmc1_dat2_py5",
-						"sdmmc1_dat3_py4";
+				nvidia,pins = "sdmmc1_cmd_pz1",
+					      "sdmmc1_dat0_py7",
+					      "sdmmc1_dat1_py6",
+					      "sdmmc1_dat2_py5",
+					      "sdmmc1_dat3_py4";
 				nvidia,function = "sdmmc1";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -243,10 +243,10 @@
 
 			/* Apalis SPI1 */
 			spi1_sck_px5 {
-				nvidia,pins =   "spi1_sck_px5",
-						"spi1_mosi_px4",
-						"spi1_miso_px7",
-						"spi1_cs0_n_px6";
+				nvidia,pins = "spi1_sck_px5",
+					      "spi1_mosi_px4",
+					      "spi1_miso_px7",
+					      "spi1_cs0_n_px6";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -254,10 +254,10 @@
 
 			/* Apalis SPI2 */
 			lcd_sck_pz4 {
-				nvidia,pins =   "lcd_sck_pz4",
-						"lcd_sdout_pn5",
-						"lcd_sdin_pz2",
-						"lcd_cs0_n_pn4";
+				nvidia,pins = "lcd_sck_pz4",
+					      "lcd_sdout_pn5",
+					      "lcd_sdin_pz2",
+					      "lcd_cs0_n_pn4";
 				nvidia,function = "spi5";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -265,14 +265,14 @@
 
 			/* Apalis UART1 */
 			ulpi_data0 {
-				nvidia,pins =   "ulpi_data0_po1",
-						"ulpi_data1_po2",
-						"ulpi_data2_po3",
-						"ulpi_data3_po4",
-						"ulpi_data4_po5",
-						"ulpi_data5_po6",
-						"ulpi_data6_po7",
-						"ulpi_data7_po0";
+				nvidia,pins = "ulpi_data0_po1",
+					      "ulpi_data1_po2",
+					      "ulpi_data2_po3",
+					      "ulpi_data3_po4",
+					      "ulpi_data4_po5",
+					      "ulpi_data5_po6",
+					      "ulpi_data6_po7",
+					      "ulpi_data7_po0";
 				nvidia,function = "uarta";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -280,10 +280,10 @@
 
 			/* Apalis UART2 */
 			ulpi_clk_py0 {
-				nvidia,pins =   "ulpi_clk_py0",
-						"ulpi_dir_py1",
-						"ulpi_nxt_py2",
-						"ulpi_stp_py3";
+				nvidia,pins = "ulpi_clk_py0",
+					      "ulpi_dir_py1",
+					      "ulpi_nxt_py2",
+					      "ulpi_stp_py3";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -291,8 +291,8 @@
 
 			/* Apalis UART3 */
 			uart2_rxd_pc3 {
-				nvidia,pins =   "uart2_rxd_pc3",
-						"uart2_txd_pc2";
+				nvidia,pins = "uart2_rxd_pc3",
+					      "uart2_txd_pc2";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -300,8 +300,8 @@
 
 			/* Apalis UART4 */
 			uart3_rxd_pw7 {
-				nvidia,pins =   "uart3_rxd_pw7",
-						"uart3_txd_pw6";
+				nvidia,pins = "uart3_rxd_pw7",
+					      "uart3_txd_pw6";
 				nvidia,function = "uartc";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -337,21 +337,21 @@
 
 			/* eMMC (On-module) */
 			sdmmc4_clk_pcc4 {
-				nvidia,pins =	"sdmmc4_clk_pcc4",
-						"sdmmc4_rst_n_pcc3";
+				nvidia,pins = "sdmmc4_clk_pcc4",
+					      "sdmmc4_rst_n_pcc3";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc4_dat0_paa0 {
-				nvidia,pins =	"sdmmc4_dat0_paa0",
-						"sdmmc4_dat1_paa1",
-						"sdmmc4_dat2_paa2",
-						"sdmmc4_dat3_paa3",
-						"sdmmc4_dat4_paa4",
-						"sdmmc4_dat5_paa5",
-						"sdmmc4_dat6_paa6",
-						"sdmmc4_dat7_paa7";
+				nvidia,pins = "sdmmc4_dat0_paa0",
+					      "sdmmc4_dat1_paa1",
+					      "sdmmc4_dat2_paa2",
+					      "sdmmc4_dat3_paa3",
+					      "sdmmc4_dat4_paa4",
+					      "sdmmc4_dat5_paa5",
+					      "sdmmc4_dat6_paa6",
+					      "sdmmc4_dat7_paa7";
 				nvidia,function = "sdmmc4";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -359,10 +359,10 @@
 
 			/* LVDS Transceiver Configuration */
 			pbb0 {
-				nvidia,pins =	"pbb0",
-						"pbb7",
-						"pcc1",
-						"pcc2";
+				nvidia,pins = "pbb0",
+					      "pbb7",
+					      "pcc1",
+					      "pcc2";
 				nvidia,function = "rsvd2";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -370,10 +370,10 @@
 				nvidia,lock = <TEGRA_PIN_DISABLE>;
 			};
 			pbb3 {
-				nvidia,pins =	"pbb3",
-						"pbb4",
-						"pbb5",
-						"pbb6";
+				nvidia,pins = "pbb3",
+					      "pbb4",
+					      "pbb5",
+					      "pbb6";
 				nvidia,function = "displayb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
-- 
2.5.0

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/37298754/attachment.sig>
