From: matthias.bgg@gmail.com (Matthias Brugger)
Date: Sat, 21 Oct 2017 10:25:28 +0200
Subject: [PATCH 1/2] soc: mediatek: pwrap: fix compiler errors
Message-ID: <20171021082529.31351-1-matthias.bgg@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When compiling using sparse, we got the following error:
drivers/soc/mediatek/mtk-pmic-wrap.c:686:25: error: dubious one-bit signed bitfield

Changing the data type to unsigned fixes this.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 5d61d127e1d7..912edf93c192 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -683,7 +683,7 @@ struct pmic_wrapper_type {
 	u32 int_en_all;
 	u32 spi_w;
 	u32 wdt_src;
-	int has_bridge:1;
+	unsigned int has_bridge:1;
 	int (*init_reg_clock)(struct pmic_wrapper *wrp);
 	int (*init_soc_specific)(struct pmic_wrapper *wrp);
 };
-- 
2.14.2
