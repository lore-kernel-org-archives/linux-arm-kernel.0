From: marex@denx.de (Marek Vasut)
Date: Mon, 21 May 2012 03:02:19 +0200
Subject: [PATCH 3/4] MXS-MMC: Move of_match_table out of CONFIG_PM
In-Reply-To: <1337562140-5739-1-git-send-email-marex@denx.de>
References: <1337562140-5739-1-git-send-email-marex@denx.de>
Message-ID: <1337562140-5739-3-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>
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
