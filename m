From: weiyj_lk@163.com (weiyj_lk at 163.com)
Date: Wed,  6 Jul 2016 13:30:13 +0000
Subject: [PATCH -next] net: mediatek: remove .owner field for driver
Message-ID: <1467811813-4864-1-git-send-email-weiyj_lk@163.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Remove .owner field since calls to module_platform_driver() will
set it automatically.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 682797e..760f3d7 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -1910,7 +1910,6 @@ static struct platform_driver mtk_driver = {
 	.remove = mtk_remove,
 	.driver = {
 		.name = "mtk_soc_eth",
-		.owner = THIS_MODULE,
 		.of_match_table = of_mtk_match,
 	},
 };
