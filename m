From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Feb 2013 12:34:02 -0700
Subject: [PATCH] clk: tegra: fix driver to match DT binding
Message-ID: <1360697642-22620-1-git-send-email-swarren@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Stephen Warren <swarren@nvidia.com>

enum tegra*_clk is intended to match the IDs listed in the Tegra clock
bindings. There are a few mismatches, which this patch fixes:

1) pll_s and cop were left out of the Tegra20 enum.

2) spdif_in and spdif_out were swapped relative to the Tegra30 binding.

3) i2cslow was misnamed as i2c_slow, and a duplicate i2cslow clock added
   to the Tegra30 enum.

Signed-off-by: Stephen Warren <swarren@nvidia.com>
---
 drivers/clk/tegra/clk-tegra20.c |    4 ++--
 drivers/clk/tegra/clk-tegra30.c |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra20.c b/drivers/clk/tegra/clk-tegra20.c
index 8b5241e..143ce1f 100644
--- a/drivers/clk/tegra/clk-tegra20.c
+++ b/drivers/clk/tegra/clk-tegra20.c
@@ -240,8 +240,8 @@ enum tegra20_clk {
 	uartb = 96, vfir, spdif_in, spdif_out, vi, vi_sensor, tvo, cve,
 	osc, clk_32k, clk_m, sclk, cclk, hclk, pclk, blink, pll_a, pll_a_out0,
 	pll_c, pll_c_out1, pll_d, pll_d_out0, pll_e, pll_m, pll_m_out1,
-	pll_p, pll_p_out1, pll_p_out2, pll_p_out3, pll_p_out4, pll_u,
-	pll_x, audio, pll_ref, twd, clk_max,
+	pll_p, pll_p_out1, pll_p_out2, pll_p_out3, pll_p_out4, pll_s, pll_u,
+	pll_x, cop, audio, pll_ref, twd, clk_max,
 };
 
 static struct clk *clks[clk_max];
diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index 56925e1..32c61cb 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -328,13 +328,13 @@ enum tegra30_clk {
 	kbc = 36, statmon, pmc, kfuse = 40, sbc1, nor, sbc2 = 44, sbc3 = 46,
 	i2c5, dsia, mipi = 50, hdmi, csi, tvdac, i2c2, uartc, emc = 57, usb2,
 	usb3, mpe, vde, bsea, bsev, speedo, uartd, uarte, i2c3, sbc4, sdmmc3,
-	pcie, owr, afi, csite, pciex, avpucq, la, dtv = 79, ndspeed, i2c_slow,
+	pcie, owr, afi, csite, pciex, avpucq, la, dtv = 79, ndspeed, i2cslow,
 	dsib, irama = 84, iramb, iramc, iramd, cram2, audio_2x = 90, csus = 92,
 	cdev1, cdev2, cpu_g = 96, cpu_lp, gr3d2, mselect, tsensor, i2s3, i2s4,
 	i2c4, sbc5, sbc6, d_audio, apbif, dam0, dam1, dam2, hda2codec_2x,
 	atomics, audio0_2x, audio1_2x, audio2_2x, audio3_2x, audio4_2x,
 	spdif_2x, actmon, extern1, extern2, extern3, sata_oob, sata, hda,
-	se = 127, hda2hdmi, sata_cold, uartb = 160, vfir, spdif_out, spdif_in,
+	se = 127, hda2hdmi, sata_cold, uartb = 160, vfir, spdif_in, spdif_out,
 	vi, vi_sensor, fuse, fuse_burn, cve, tvo, clk_32k, clk_m, clk_m_div2,
 	clk_m_div4, pll_ref, pll_c, pll_c_out1, pll_m, pll_m_out1, pll_p,
 	pll_p_out1, pll_p_out2, pll_p_out3, pll_p_out4, pll_a, pll_a_out0,
@@ -342,7 +342,7 @@ enum tegra30_clk {
 	spdif_in_sync, i2s0_sync, i2s1_sync, i2s2_sync, i2s3_sync, i2s4_sync,
 	vimclk_sync, audio0, audio1, audio2, audio3, audio4, spdif, clk_out_1,
 	clk_out_2, clk_out_3, sclk, blink, cclk_g, cclk_lp, twd, cml0, cml1,
-	i2cslow, hclk, pclk, clk_out_1_mux = 300, clk_max
+	hclk, pclk, clk_out_1_mux = 300, clk_max
 };
 
 static struct clk *clks[clk_max];
-- 
1.7.10.4
