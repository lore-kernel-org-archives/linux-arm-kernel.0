From: sugar.zhang@rock-chips.com (Sugar Zhang)
Date: Mon, 22 Feb 2016 15:56:54 +0800
Subject: [PATCH v1 1/2] ASoC: rockchip: i2s: add default values for registers
In-Reply-To: <1456127815-68575-1-git-send-email-sugar.zhang@rock-chips.com>
References: <1456127815-68575-1-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <1456127815-68575-2-git-send-email-sugar.zhang@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add default values for registers according description from TRM.

Signed-off-by: Sugar Zhang <sugar.zhang@rock-chips.com>
---

 sound/soc/rockchip/rockchip_i2s.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/rockchip/rockchip_i2s.c b/sound/soc/rockchip/rockchip_i2s.c
index 6561c4c..a0b0942 100644
--- a/sound/soc/rockchip/rockchip_i2s.c
+++ b/sound/soc/rockchip/rockchip_i2s.c
@@ -440,11 +440,21 @@ static bool rockchip_i2s_precious_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+static const struct reg_default rockchip_i2s_reg_defaults[] = {
+	{0x00, 0x0000000f},
+	{0x04, 0x0000000f},
+	{0x08, 0x00071f1f},
+	{0x10, 0x001f0000},
+	{0x14, 0x01f00000},
+};
+
 static const struct regmap_config rockchip_i2s_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
 	.max_register = I2S_RXDR,
+	.reg_defaults = rockchip_i2s_reg_defaults,
+	.num_reg_defaults = ARRAY_SIZE(rockchip_i2s_reg_defaults),
 	.writeable_reg = rockchip_i2s_wr_reg,
 	.readable_reg = rockchip_i2s_rd_reg,
 	.volatile_reg = rockchip_i2s_volatile_reg,
-- 
1.9.1
