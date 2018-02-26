From: yong.deng@magewell.com (Yong Deng)
Date: Mon, 26 Feb 2018 10:43:52 +0800
Subject: [PATCH] ASoC: sun4i-i2s: Fix RX slot number of SUN8I
Message-ID: <1519613032-10244-1-git-send-email-yong.deng@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I2S's RX slot number of SUN8I should be shifted 4 bit to left.

Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")

Signed-off-by: Yong Deng <yong.deng@magewell.com>
---
 sound/soc/sunxi/sun4i-i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
index dca1143c1150..a4aa931ebfae 100644
--- a/sound/soc/sunxi/sun4i-i2s.c
+++ b/sound/soc/sunxi/sun4i-i2s.c
@@ -104,7 +104,7 @@
 
 #define SUN8I_I2S_CHAN_CFG_REG		0x30
 #define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM_MASK	GENMASK(6, 4)
-#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	(chan - 1)
+#define SUN8I_I2S_CHAN_CFG_RX_SLOT_NUM(chan)	((chan - 1) << 4)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM_MASK	GENMASK(2, 0)
 #define SUN8I_I2S_CHAN_CFG_TX_SLOT_NUM(chan)	(chan - 1)
 
-- 
1.8.3.1
