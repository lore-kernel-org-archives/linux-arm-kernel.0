From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 15 Sep 2015 10:47:24 +0200
Subject: [PATCH 00/11] arm: tegra: colibri_t30: fix hdmi, power i2c,
 wakeup and activate touch
In-Reply-To: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
References: <1440777586-19545-1-git-send-email-marcel.ziswiler@toradex.com>
Message-ID: <20150915084723.GD25970@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 28, 2015 at 05:59:35PM +0200, Marcel Ziswiler wrote:
> This series finally continues on my previous Easter efforts (BTW:
> thanks all for the feedback and all the patches thereof already having
> been applied) and additionally to activating the STMPE811 touch
> controller also fixes HDMI, power I2C and the wake-up key.
> 
> 
> Marcel Ziswiler (11):
>   arm: tegra: colibri_t30: update hardware revisions compatible comment
>   arm: tegra: colibri_t30: fix hdmi supply
>   arm: tegra: colibri_t30: improve comment about thermal alert pin
>   arm: tegra: colibri_t30: add pin muxing for on-module power i2c
>   arm: tegra: colibri_t30: fix comment about 3v3 fixed supply
>   arm: tegra: colibri_t30: add touch pen interrupt pin muxing
>   arm: tegra: colibri_t30: activate stmpe811 touch controller
>   arm: tegra: colibri_t30: replace emmc label by comment
>   arm: tegra: colibri_t30: fix vendor string of m41t0m6 rtc on eval
>     board
>   arm: tegra: colibri_t30: add comment concerning sd/mmc for eval board
>   arm: tegra: colibri_t30: fix power/wakeup key for eval board
> 
>  arch/arm/boot/dts/tegra30-colibri-eval-v3.dts |   9 +-
>  arch/arm/boot/dts/tegra30-colibri.dtsi        | 124 ++++++++++++++++++++++----
>  2 files changed, 111 insertions(+), 22 deletions(-)

Applied all of these with fixups for the subject similar to the Apalis
series. I also applied the following on top to consistently align pin
names.

Thanks,
Thierry

--- >8 ---

>From e675c68545ffc4c404cc3f4aa2062b34994efdaf Mon Sep 17 00:00:00 2001
From: Thierry Reding <treding@nvidia.com>
Date: Tue, 15 Sep 2015 10:29:57 +0200
Subject: [PATCH] ARM: tegra: colibri: Properly align pin names

Align pin names on subsequent lines with the first the name of the first
pin in the first line.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm/boot/dts/tegra30-colibri.dtsi | 72 +++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm/boot/dts/tegra30-colibri.dtsi b/arch/arm/boot/dts/tegra30-colibri.dtsi
index 67ba9431e386..2d8c58fd9357 100644
--- a/arch/arm/boot/dts/tegra30-colibri.dtsi
+++ b/arch/arm/boot/dts/tegra30-colibri.dtsi
@@ -39,7 +39,7 @@
 
 			/* Colibri Backlight PWM<A> */
 			sdmmc3_dat3_pb4 {
-				nvidia,pins =	"sdmmc3_dat3_pb4";
+				nvidia,pins = "sdmmc3_dat3_pb4";
 				nvidia,function = "pwm0";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -74,11 +74,11 @@
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			kb_row11_ps3 {
-				nvidia,pins =	"kb_row11_ps3",
-						"kb_row12_ps4",
-						"kb_row13_ps5",
-						"kb_row14_ps6",
-						"kb_row15_ps7";
+				nvidia,pins = "kb_row11_ps3",
+					      "kb_row12_ps4",
+					      "kb_row13_ps5",
+					      "kb_row14_ps6",
+					      "kb_row15_ps7";
 				nvidia,function = "sdmmc2";
 				nvidia,pull = <TEGRA_PIN_PULL_UP>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -86,17 +86,17 @@
 
 			/* Colibri SSP */
 			ulpi_clk_py0 {
-				nvidia,pins =   "ulpi_clk_py0",
-						"ulpi_dir_py1",
-						"ulpi_nxt_py2",
-						"ulpi_stp_py3";
+				nvidia,pins = "ulpi_clk_py0",
+					      "ulpi_dir_py1",
+					      "ulpi_nxt_py2",
+					      "ulpi_stp_py3";
 				nvidia,function = "spi1";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
 			};
 			sdmmc3_dat6_pd3 {
-				nvidia,pins =	"sdmmc3_dat6_pd3",
-						"sdmmc3_dat7_pd4";
+				nvidia,pins = "sdmmc3_dat6_pd3",
+					      "sdmmc3_dat7_pd4";
 				nvidia,function = "spdif";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_ENABLE>;
@@ -104,14 +104,14 @@
 
 			/* Colibri UART_A */
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
@@ -119,10 +119,10 @@
 
 			/* Colibri UART_B */
 			gmi_a16_pj7 {
-				nvidia,pins =   "gmi_a16_pj7",
-						"gmi_a17_pb0",
-						"gmi_a18_pb1",
-						"gmi_a19_pk7";
+				nvidia,pins = "gmi_a16_pj7",
+					      "gmi_a17_pb0",
+					      "gmi_a18_pb1",
+					      "gmi_a19_pk7";
 				nvidia,function = "uartd";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -130,8 +130,8 @@
 
 			/* Colibri UART_C */
 			uart2_rxd {
-				nvidia,pins =   "uart2_rxd_pc3",
-						"uart2_txd_pc2";
+				nvidia,pins = "uart2_rxd_pc3",
+					      "uart2_txd_pc2";
 				nvidia,function = "uartb";
 				nvidia,pull = <TEGRA_PIN_PULL_NONE>;
 				nvidia,tristate = <TEGRA_PIN_DISABLE>;
@@ -139,21 +139,21 @@
 
 			/* eMMC */
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
-- 
2.5.0

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150915/4666741d/attachment.sig>
