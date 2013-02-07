From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 7 Feb 2013 13:07:11 +0800
Subject: [PATCH] clk: tegra30: fix wrong clock index between se to sata_cold
Message-ID: <1360213631-16893-1-git-send-email-josephl@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The index of se should be 127. And the previous clock index was 125. So
we need to set up the index for se to get the correct index between se
to sata_cold.

Signed-off-by: Joseph Lo <josephl@nvidia.com>
---
 drivers/clk/tegra/clk-tegra30.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clk/tegra/clk-tegra30.c b/drivers/clk/tegra/clk-tegra30.c
index a163812..1d41b35 100644
--- a/drivers/clk/tegra/clk-tegra30.c
+++ b/drivers/clk/tegra/clk-tegra30.c
@@ -332,9 +332,9 @@ enum tegra30_clk {
 	cdev1, cdev2, cpu_g = 96, cpu_lp, gr3d2, mselect, tsensor, i2s3, i2s4,
 	i2c4, sbc5, sbc6, d_audio, apbif, dam0, dam1, dam2, hda2codec_2x,
 	atomics, audio0_2x, audio1_2x, audio2_2x, audio3_2x, audio4_2x,
-	spdif_2x, actmon, extern1, extern2, extern3, sata_oob, sata, hda, se,
-	hda2hdmi, sata_cold, uartb = 160, vfir, spdif_out, spdif_in, vi,
-	vi_sensor, fuse, fuse_burn, cve, tvo, clk_32k, clk_m, clk_m_div2,
+	spdif_2x, actmon, extern1, extern2, extern3, sata_oob, sata, hda,
+	se = 127, hda2hdmi, sata_cold, uartb = 160, vfir, spdif_out, spdif_in,
+	vi, vi_sensor, fuse, fuse_burn, cve, tvo, clk_32k, clk_m, clk_m_div2,
 	clk_m_div4, pll_ref, pll_c, pll_c_out1, pll_m, pll_m_out1, pll_p,
 	pll_p_out1, pll_p_out2, pll_p_out3, pll_p_out4, pll_a, pll_a_out0,
 	pll_d, pll_d_out0, pll_d2, pll_d2_out0, pll_u, pll_x, pll_x_out0, pll_e,
-- 
1.8.1.1
