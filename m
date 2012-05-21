From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 06:33:27 +0200
Subject: [PATCH] mmc: mxs-mmc: Move of_match_table out of CONFIG_PM
Message-ID: <1337574807-8637-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
Cc: linux-mmc at vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/mmc/host/mxs-mmc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index 34a9026..277161d 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -894,8 +894,8 @@ static struct platform_driver mxs_mmc_driver = {
 		.owner	= THIS_MODULE,
 #ifdef CONFIG_PM
 		.pm	= &mxs_mmc_pm_ops,
-		.of_match_table = mxs_mmc_dt_ids,
 #endif
+		.of_match_table = mxs_mmc_dt_ids,
 	},
 };
 
-- 
1.7.10
