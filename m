From: shawnguo@kernel.org (Shawn Guo)
Date: Sat, 17 Jun 2017 22:21:05 +0800
Subject: [PATCH] clk: zx296718: export I2S mux clocks
Message-ID: <1497709265-22944-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Shawn Guo <shawn.guo@linaro.org>

Export I2S mux clocks, so that device tree can refer to them for setting
a better parent clock for I2S work clock.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c             | 8 ++++----
 include/dt-bindings/clock/zx296718-clock.h | 6 +++++-
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index a10962988ba8..27f853d4c76b 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -932,10 +932,10 @@ static int __init lsp1_clocks_init(struct device_node *np)
 };
 
 static struct zx_clk_mux audio_mux_clk[] = {
-	MUX(0, "i2s0_wclk_mux", audio_wclk_common_p, AUDIO_I2S0_CLK, 0, 1),
-	MUX(0, "i2s1_wclk_mux", audio_wclk_common_p, AUDIO_I2S1_CLK, 0, 1),
-	MUX(0, "i2s2_wclk_mux", audio_wclk_common_p, AUDIO_I2S2_CLK, 0, 1),
-	MUX(0, "i2s3_wclk_mux", audio_wclk_common_p, AUDIO_I2S3_CLK, 0, 1),
+	MUX(I2S0_WCLK_MUX, "i2s0_wclk_mux", audio_wclk_common_p, AUDIO_I2S0_CLK, 0, 1),
+	MUX(I2S1_WCLK_MUX, "i2s1_wclk_mux", audio_wclk_common_p, AUDIO_I2S1_CLK, 0, 1),
+	MUX(I2S2_WCLK_MUX, "i2s2_wclk_mux", audio_wclk_common_p, AUDIO_I2S2_CLK, 0, 1),
+	MUX(I2S3_WCLK_MUX, "i2s3_wclk_mux", audio_wclk_common_p, AUDIO_I2S3_CLK, 0, 1),
 	MUX(0, "i2c0_wclk_mux", audio_wclk_common_p, AUDIO_I2C0_CLK, 0, 1),
 	MUX(0, "spdif0_wclk_mux", audio_wclk_common_p, AUDIO_SPDIF0_CLK, 0, 1),
 	MUX(0, "spdif1_wclk_mux", audio_wclk_common_p, AUDIO_SPDIF1_CLK, 0, 1),
diff --git a/include/dt-bindings/clock/zx296718-clock.h b/include/dt-bindings/clock/zx296718-clock.h
index 822d52385080..092c9751a697 100644
--- a/include/dt-bindings/clock/zx296718-clock.h
+++ b/include/dt-bindings/clock/zx296718-clock.h
@@ -157,7 +157,11 @@
 #define AUDIO_TDM_WCLK		17
 #define AUDIO_TDM_PCLK		18
 #define AUDIO_TS_PCLK		19
+#define I2S0_WCLK_MUX		20
+#define I2S1_WCLK_MUX		21
+#define I2S2_WCLK_MUX		22
+#define I2S3_WCLK_MUX		23
 
-#define AUDIO_NR_CLKS		20
+#define AUDIO_NR_CLKS		24
 
 #endif
-- 
1.9.1
