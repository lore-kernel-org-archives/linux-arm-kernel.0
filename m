From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 1 Nov 2018 14:02:19 +0800
Subject: [PATCH 2/2] spi: mediatek: add spi support for mt8183 IC
In-Reply-To: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
References: <1541052139-8845-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1541052139-8845-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

this patch add support for mt8183 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 0c2867d..9ee1fe9 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -120,6 +120,12 @@ struct mtk_spi {
 	.must_tx = true,
 };
 
+static const struct mtk_spi_compatible mt8183_compat = {
+	.need_pad_sel = true,
+	.must_tx = true,
+	.enhance_timing = true,
+};
+
 /*
  * A piece of default chip info unless the platform
  * supplies it.
@@ -150,6 +156,9 @@ struct mtk_spi {
 	{ .compatible = "mediatek,mt8173-spi",
 		.data = (void *)&mt8173_compat,
 	},
+	{ .compatible = "mediatek,mt8183-spi",
+		.data = (void *)&mt8183_compat,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_spi_of_match);
-- 
1.7.9.5
