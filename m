From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 31 Dec 2015 10:59:01 +0800
Subject: [PATCH 2/4] spi: mediatek: Add spi support for mt2701 IC
In-Reply-To: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
References: <1451530743-8995-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1451530743-8995-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds spi support for mt2701 IC.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 3573c09..fe95f3f 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -111,6 +111,9 @@ static const struct mtk_chip_config mtk_default_chip_info = {
 };
 
 static const struct of_device_id mtk_spi_of_match[] = {
+	{ .compatible = "mediatek,mt2701-spi",
+		.data = (void *)&mtk_common_compat,
+	},
 	{ .compatible = "mediatek,mt6589-spi",
 		.data = (void *)&mtk_common_compat,
 	},
-- 
1.7.9.5
