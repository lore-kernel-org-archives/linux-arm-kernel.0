From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Mon, 19 May 2014 19:30:38 +0200
Subject: [PATCH] ASoC: samsung: Allow setting OP_CLK of the IIS Multi Audio
 Interface
Message-ID: <1400520638-6907-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds support for setting source clock of the "Core CLK"
of the IIS Multi Audio Interface.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 sound/soc/samsung/i2s.c |    4 ++++
 sound/soc/samsung/i2s.h |    1 +
 2 files changed, 5 insertions(+)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index 048ead9..ae02811 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -451,6 +451,10 @@ static int i2s_set_sysclk(struct snd_soc_dai *dai,
 	u32 mod = readl(i2s->addr + I2SMOD);
 
 	switch (clk_id) {
+	case SAMSUNG_I2S_OPCLK:
+		mod &= ~MOD_OPCLK_MASK;
+		mod |= dir;
+		break;
 	case SAMSUNG_I2S_CDCLK:
 		/* Shouldn't matter in GATING(CLOCK_IN) mode */
 		if (dir == SND_SOC_CLOCK_IN)
diff --git a/sound/soc/samsung/i2s.h b/sound/soc/samsung/i2s.h
index 7966afc..21ff24e 100644
--- a/sound/soc/samsung/i2s.h
+++ b/sound/soc/samsung/i2s.h
@@ -18,5 +18,6 @@
 #define SAMSUNG_I2S_RCLKSRC_0	0
 #define SAMSUNG_I2S_RCLKSRC_1	1
 #define SAMSUNG_I2S_CDCLK		2
+#define SAMSUNG_I2S_OPCLK		3
 
 #endif /* __SND_SOC_SAMSUNG_I2S_H */
-- 
1.7.9.5
