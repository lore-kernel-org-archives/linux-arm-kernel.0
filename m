From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 12 Aug 2015 12:12:28 +0200
Subject: [PATCH 03/20] regmap: Fix integertypes for register address and value
In-Reply-To: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
References: <1439374365-20623-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1439374365-20623-4-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These values are defined as unsigned int in the struct and are assigned
to int values.

This patch fixes the type to be unsigned int instead.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 drivers/base/regmap/regmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index 64a106af174f..4fe5f63edb54 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1763,8 +1763,8 @@ static int _regmap_raw_multi_reg_write(struct regmap *map,
 	u8 = buf;
 
 	for (i = 0; i < num_regs; i++) {
-		int reg = regs[i].reg;
-		int val = regs[i].def;
+		unsigned int reg = regs[i].reg;
+		unsigned int val = regs[i].def;
 		trace_regmap_hw_write_start(map, reg, 1);
 		map->format.format_reg(u8, reg, map->reg_shift);
 		u8 += reg_bytes + pad_bytes;
-- 
2.4.6
