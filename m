From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 16 Apr 2018 16:23:00 +0200
Subject: [PATCH v3 2/7] mmc: sunxi: Change sunxi_mmc_init_host argument type
In-Reply-To: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
References: <cover.e9b9c0ab5bc9ffcc52a15e1c2f41462729da5b61.1523888566.git-series.maxime.ripard@bootlin.com>
Message-ID: <0f3761e74651c81206d1ea7ed51d7da4ad846163.1523888566.git-series.maxime.ripard@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All the other functions in the driver take a struct sunxi_mmc_host pointer.
Let's make it consistent.

Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
---
 drivers/mmc/host/sunxi-mmc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 91feed8045fd..9fdaea37aa74 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -319,10 +319,9 @@ static int sunxi_mmc_reset_host(struct sunxi_mmc_host *host)
 	return 0;
 }
 
-static int sunxi_mmc_init_host(struct mmc_host *mmc)
+static int sunxi_mmc_init_host(struct sunxi_mmc_host *host)
 {
 	u32 rval;
-	struct sunxi_mmc_host *host = mmc_priv(mmc);
 
 	if (sunxi_mmc_reset_host(host))
 		return -EIO;
@@ -885,7 +884,7 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 			host->vqmmc_enabled = true;
 		}
 
-		host->ferror = sunxi_mmc_init_host(mmc);
+		host->ferror = sunxi_mmc_init_host(host);
 		if (host->ferror)
 			return;
 
-- 
git-series 0.9.1
