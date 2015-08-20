From: leilk.liu@mediatek.com (Leilk Liu)
Date: Thu, 20 Aug 2015 17:19:07 +0800
Subject: [PATCH v2 2/4] spi: medaitek: revise quirks compatibility style
In-Reply-To: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
References: <1440062349-25513-1-git-send-email-leilk.liu@mediatek.com>
Message-ID: <1440062349-25513-3-git-send-email-leilk.liu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The quirks are true/false, so define these as bool.

Signed-off-by: Leilk Liu <leilk.liu@mediatek.com>
---
 drivers/spi/spi-mt65xx.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/spi/spi-mt65xx.c b/drivers/spi/spi-mt65xx.c
index 79286c8..4fa4332 100644
--- a/drivers/spi/spi-mt65xx.c
+++ b/drivers/spi/spi-mt65xx.c
@@ -71,10 +71,6 @@
 #define SPI_CMD_FINISH_IE            BIT(16)
 #define SPI_CMD_PAUSE_IE             BIT(17)
 
-#define MTK_SPI_QUIRK_PAD_SELECT 1
-/* Must explicitly send dummy Tx bytes to do Rx only transfer */
-#define MTK_SPI_QUIRK_MUST_TX 1
-
 #define MT8173_SPI_MAX_PAD_SEL 3
 
 #define MTK_SPI_IDLE 0
@@ -84,8 +80,9 @@
 #define MTK_SPI_PACKET_SIZE 1024
 
 struct mtk_spi_compatible {
-	u32 need_pad_sel;
-	u32 must_tx;
+	bool need_pad_sel;
+	/* Must explicitly send dummy Tx bytes to do Rx only transfer */
+	bool must_tx;
 };
 
 struct mtk_spi {
@@ -100,19 +97,11 @@ struct mtk_spi {
 	const struct mtk_spi_compatible *dev_comp;
 };
 
-static const struct mtk_spi_compatible mt6589_compat = {
-	.need_pad_sel = 0,
-	.must_tx = 0,
-};
-
-static const struct mtk_spi_compatible mt8135_compat = {
-	.need_pad_sel = 0,
-	.must_tx = 0,
-};
-
+static const struct mtk_spi_compatible mt6589_compat;
+static const struct mtk_spi_compatible mt8135_compat;
 static const struct mtk_spi_compatible mt8173_compat = {
-	.need_pad_sel = MTK_SPI_QUIRK_PAD_SELECT,
-	.must_tx = MTK_SPI_QUIRK_MUST_TX,
+	.need_pad_sel = true,
+	.must_tx = true,
 };
 
 /*
-- 
1.8.1.1.dirty
