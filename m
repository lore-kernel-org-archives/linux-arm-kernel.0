From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 27 Mar 2013 12:02:41 +0100
Subject: [PATCH 04/21] clk: samsung: exynos4: Add missing sclk_audio0 clock
In-Reply-To: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
References: <1364382178-25248-1-git-send-email-t.figa@samsung.com>
Message-ID: <1364382178-25248-5-git-send-email-t.figa@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This clock is a parent of mout_spdif and sclk_pcm0.

Signed-off-by: Tomasz Figa <t.figa@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/clk/samsung/clk-exynos4.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/samsung/clk-exynos4.c b/drivers/clk/samsung/clk-exynos4.c
index 42c098d..0e89d97 100644
--- a/drivers/clk/samsung/clk-exynos4.c
+++ b/drivers/clk/samsung/clk-exynos4.c
@@ -508,6 +508,8 @@ struct samsung_gate_clock exynos4_gate_clks[] __initdata = {
 			CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_mipi0, "sclk_mipi0", "div_mipi_pre0",
 			SRC_MASK_LCD0, 12, CLK_SET_RATE_PARENT, 0),
+	GATE(sclk_audio0, "sclk_audio0", "div_audio0", SRC_MASK_MAUDIO, 0,
+			CLK_SET_RATE_PARENT, 0),
 	GATE(sclk_audio1, "sclk_audio1", "div_audio1", 0xc354, 0,
 			CLK_SET_RATE_PARENT, 0),
 	GATE_D(vp, "s5p-mixer", "vp", "aclk160", GATE_IP_TV, 0, 0, 0),
-- 
1.8.1.5
