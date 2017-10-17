From: narmstrong@baylibre.com (Neil Armstrong)
Date: Tue, 17 Oct 2017 12:19:34 +0200
Subject: [PATCH] reset: meson: remove unneeded check in meson_reset_reset
Message-ID: <1508235574-24929-1-git-send-email-narmstrong@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The if (bank >= REG_COUNT) is not need since already checked
by the default rcdev->of_xlate implementation which guarantees that
id < rcdev->nr_resets.

Suggested-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/reset/reset-meson.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/reset/reset-meson.c b/drivers/reset/reset-meson.c
index f3b9d69..c419a37 100644
--- a/drivers/reset/reset-meson.c
+++ b/drivers/reset/reset-meson.c
@@ -83,9 +83,6 @@ static int meson_reset_reset(struct reset_controller_dev *rcdev,
 	unsigned int offset = id % BITS_PER_REG;
 	void __iomem *reg_addr = data->reg_base + (bank << 2);
 
-	if (bank >= REG_COUNT)
-		return -EINVAL;
-
 	writel(BIT(offset), reg_addr);
 
 	return 0;
-- 
2.7.4
