From: john@metanate.com (John Keeping)
Date: Wed,  9 Dec 2015 10:32:27 +0000
Subject: [PATCH 2/2] ASoC: rockchip: i2s: remove unused variables
In-Reply-To: <1449657147-26959-1-git-send-email-john@metanate.com>
References: <1449657147-26959-1-git-send-email-john@metanate.com>
Message-ID: <1449657147-26959-2-git-send-email-john@metanate.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous commit removed the only use of these variables.

Signed-off-by: John Keeping <john@metanate.com>
---
 sound/soc/rockchip/rockchip_i2s.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index acc6225..8b0a588 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -34,13 +34,6 @@ struct rk_i2s_dev {
 
 	struct regmap *regmap;
 
-/*
- * Used to indicate the tx/rx status.
- * I2S controller hopes to start the tx and rx together,
- * also to stop them when they are both try to stop.
-*/
-	bool tx_start;
-	bool rx_start;
 	bool is_master_mode;
 };
 
@@ -84,11 +77,7 @@ static void rockchip_snd_txctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_XFER,
 				   I2S_XFER_TXS_START,
 				   I2S_XFER_TXS_START);
-
-		i2s->tx_start = true;
 	} else {
-		i2s->tx_start = false;
-
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_TDE_ENABLE, I2S_DMACR_TDE_DISABLE);
 
@@ -126,11 +115,7 @@ static void rockchip_snd_rxctrl(struct rk_i2s_dev *i2s, int on)
 		regmap_update_bits(i2s->regmap, I2S_XFER,
 				   I2S_XFER_RXS_START,
 				   I2S_XFER_RXS_START);
-
-		i2s->rx_start = true;
 	} else {
-		i2s->rx_start = false;
-
 		regmap_update_bits(i2s->regmap, I2S_DMACR,
 				   I2S_DMACR_RDE_ENABLE, I2S_DMACR_RDE_DISABLE);
 
-- 
2.6.3.462.gbe2c914
