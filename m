From: leilk.liu@mediatek.com (Leilk Liu)
Date: Mon, 12 Jun 2017 09:24:40 +0800
Subject: [PATCH v3 2/2] spi: mediatek: add spi support for mt7622 IC
In-Reply-To: <1497230680-20448-1-git-send-email-leilk.liu@mediatek.com>
References: <1497230680-20448-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1497230680-20448-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add support for mt7622 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index eae73b5..ec7755b 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -104,6 +104,12 @@ struct mtk_spi {
 };
 
 static const struct mtk_spi_compatible mtk_common_compat;
+
+static const struct mtk_spi_compatible mt7622_compat = {
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 static const struct mtk_spi_compatible mt8173_compat = {
 	.need_pad_sel = true,
 	.must_tx = true,
@@ -127,6 +133,9 @@ struct mtk_spi {
 	{ .compatible = "mediatek,mt6589-spi",
 		.data = (void *)&mtk_common_compat,
 	},
+	{ .compatible = "mediatek,mt7622-spi",
+		.data = (void *)&mt7622_compat,
+	},
 	{ .compatible = "mediatek,mt8135-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
1.7.9.5
