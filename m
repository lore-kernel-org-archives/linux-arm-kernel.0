From: gustavo@embeddedor.com (Gustavo A. R. Silva)
Date: Sat, 4 Aug 2018 20:02:01 -0500
Subject: [PATCH] soc: mediatek: pwrap: use true and false for boolean values
Message-ID: <20180805010201.GA7320@embeddedor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Return statements in functions returning bool should use true or false
instead of an integer value.

This issue was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/soc/mediatek/mtk-pmic-wrap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/mediatek/mtk-pmic-wrap.c b/drivers/soc/mediatek/mtk-pmic-wrap.c
index 4e931fd..932470a 100644
--- a/drivers/soc/mediatek/mtk-pmic-wrap.c
+++ b/drivers/soc/mediatek/mtk-pmic-wrap.c
@@ -1096,7 +1096,7 @@ static bool pwrap_is_pmic_cipher_ready(struct pmic_wrapper *wrp)
 	ret = pwrap_read(wrp, wrp->slave->dew_regs[PWRAP_DEW_CIPHER_RDY],
 			 &rdata);
 	if (ret)
-		return 0;
+		return false;
 
 	return rdata == 1;
 }
-- 
2.7.4
