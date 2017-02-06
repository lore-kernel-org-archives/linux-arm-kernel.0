From: baoyou.xie@linaro.org (Baoyou Xie)
Date: Mon,  6 Feb 2017 21:50:18 +0800
Subject: [PATCH v1 1/3] clk: zte: add i2s clocks for zx296718
Message-ID: <1486389020-29432-1-git-send-email-baoyou.xie@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The i2s related clock support is missing from the existing zx296718
clock driver. This patch adds it, so that the upstream ZX I2S driver
can work out.

Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
---
 drivers/clk/zte/clk-zx296718.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/zte/clk-zx296718.c b/drivers/clk/zte/clk-zx296718.c
index ad5d1df..f106d40 100644
--- a/drivers/clk/zte/clk-zx296718.c
+++ b/drivers/clk/zte/clk-zx296718.c
@@ -941,6 +941,10 @@ static struct zx_clk_gate audio_gate_clk[] = {
 	GATE(AUDIO_SPDIF1_WCLK, "spdif1_wclk", "spdif1_wclk_div", AUDIO_SPDIF1_CLK, 9, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_TDM_WCLK, "tdm_wclk", "tdm_wclk_div", AUDIO_TDM_CLK, 17, CLK_SET_RATE_PARENT, 0),
 	GATE(AUDIO_TS_PCLK, "tempsensor_pclk", "clk49m5", AUDIO_TS_CLK, 1, 0, 0),
+	GATE(AUDIO_I2S0_PCLK, "i2s0_pclk", "clk49m5", AUDIO_I2S0_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S1_PCLK, "i2s1_pclk", "clk49m5", AUDIO_I2S1_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S2_PCLK, "i2s2_pclk", "clk49m5", AUDIO_I2S2_CLK, 8, 0, 0),
+	GATE(AUDIO_I2S3_PCLK, "i2s3_pclk", "clk49m5", AUDIO_I2S3_CLK, 8, 0, 0),
 };
 
 static struct clk_hw_onecell_data audio_hw_onecell_data = {
-- 
2.7.4
