From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 31 Dec 2015 10:59:00 +0800
Subject: [PATCH 1/4] spi: mediatek: merge all identical compat to
 mtk_common_compat
In-Reply-To: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
References: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1451530743-8995-2-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch merge all identical compat into on mtk_common_compat
and used for all compatible soc.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 563954a..3573c09 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -95,8 +95,7 @@ struct mtk_spi {
 	const struct mtk_spi_compatible *dev_comp;
 };
 
-static const struct mtk_spi_compatible mt6589_compat;
-static const struct mtk_spi_compatible mt8135_compat;
+static const struct mtk_spi_compatible mtk_common_compat;
 static const struct mtk_spi_compatible mt8173_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
@@ -112,9 +111,15 @@ static const struct mtk_chip_config mtk_default_chip_info = {
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
-	{ .compatible = "mediatek,mt6589-spi", .data = (void *)&mt6589_compat },
-	{ .compatible = "mediatek,mt8135-spi", .data = (void *)&mt8135_compat },
-	{ .compatible = "mediatek,mt8173-spi", .data = (void *)&mt8173_compat },
+	{ .compatible = "mediatek,mt6589-spi",
+		.data = (void *)&mtk_common_compat,
+	},
+	{ .compatible = "mediatek,mt8135-spi",
+		.data = (void *)&mtk_common_compat,
+	},
+	{ .compatible = "mediatek,mt8173-spi",
+		.data = (void *)&mt8173_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
-- 
1.7.9.5
