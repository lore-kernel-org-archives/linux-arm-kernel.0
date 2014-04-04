From: t.stanislaws@samsung.com (Tomasz Stanislawski)
Date: Fri, 04 Apr 2014 16:53:20 +0200
Subject: [PATCH 3/4] clk: exynos4: enable clk_set_parent() propagation for
 sclk_hdmi and sclk_mixer clocks
In-Reply-To: <1396623201-26000-1-git-send-email-t.stanislaws@samsung.com>
References: <1396623201-26000-1-git-send-email-t.stanislaws@samsung.com>
Message-ID: <1396623201-26000-4-git-send-email-t.stanislaws@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables clk_set_parent() propagation for clocks used
by s5p-tv and exynos-drm drivers.

Signed-off-by: Tomasz Stanislawski <t.stanislaws@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 528f8eb..87b8264 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -680,7 +680,8 @@ static struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 	 * the device name and clock alias names specified below for some
 	 * of the clocks can be removed.
 	 */
-	GATE(CLK_SCLK_HDMI, "sclk_hdmi", "mout_hdmi", SRC_MASK_TV, 0, 0, 0),
+	GATE(CLK_SCLK_HDMI, "sclk_hdmi", "mout_hdmi", SRC_MASK_TV, 0,
+		CLK_SET_PARENT_PARENT, 0),
 	GATE(CLK_SCLK_SPDIF, "sclk_spdif", "mout_spdif", SRC_MASK_PERIL1, 8, 0,
 		0),
 	GATE(CLK_JPEG, "jpeg", "aclk160", GATE_IP_CAM, 6, 0, 0),
@@ -880,7 +881,8 @@ static struct samsung_gate_clock exynos4210_gate_clks[] __initdata = {
 			E4210_SRC_MASK_LCD1, 12, CLK_SET_RATE_PARENT, 0),
 	GATE(CLK_SCLK_SATA, "sclk_sata", "div_sata",
 			SRC_MASK_FSYS, 24, CLK_SET_RATE_PARENT, 0),
-	GATE(CLK_SCLK_MIXER, "sclk_mixer", "mout_mixer", SRC_MASK_TV, 4, 0, 0),
+	GATE(CLK_SCLK_MIXER, "sclk_mixer", "mout_mixer", SRC_MASK_TV, 4,
+			CLK_SET_PARENT_PARENT, 0),
 	GATE(CLK_SCLK_DAC, "sclk_dac", "mout_dac", SRC_MASK_TV, 8, 0, 0),
 	GATE(CLK_TSADC, "tsadc", "aclk100", GATE_IP_PERIL, 15,
 			0, 0),
-- 
1.7.9.5
