From: ryder.lee@mediatek.com (Ryder Lee)
Date: Thu, 15 Nov 2018 14:26:25 +0800
Subject: [PATCH 3/4] mtd: spi-nor: mtk-quadspi: add SNOR_HWCAPS_READ for
 capcity setting
In-Reply-To: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
References: <1dc7b27cbad59c413d7076ff7d16b6757014d727.1542262833.git.ryder.lee@mediatek.com>
Message-ID: <991d85ccb62ca8c68706a1b5df304bdd11a64bcd.1542262833.git.ryder.lee@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Guochun Mao <guochun.mao@mediatek.com>

SNOR_HWCAPS_READ is a basic read mode for both flash and controller,
it should be supported, so add the capcity for mtk-quadspi.

Signed-off-by: Guochun Mao <guochun.mao@mediatek.com>
Tested-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/mtd/spi-nor/mtk-quadspi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/mtk-quadspi.c b/drivers/mtd/spi-nor/mtk-quadspi.c
index 2278677..c198fd2 100644
--- a/drivers/mtd/spi-nor/mtk-quadspi.c
+++ b/drivers/mtd/spi-nor/mtk-quadspi.c
@@ -433,7 +433,8 @@ static int mtk_nor_init(struct mtk_nor *mtk_nor,
 			struct device_node *flash_node)
 {
 	const struct spi_nor_hwcaps hwcaps = {
-		.mask = SNOR_HWCAPS_READ_FAST |
+		.mask = SNOR_HWCAPS_READ |
+			SNOR_HWCAPS_READ_FAST |
 			SNOR_HWCAPS_READ_1_1_2 |
 			SNOR_HWCAPS_PP,
 	};
-- 
1.9.1
