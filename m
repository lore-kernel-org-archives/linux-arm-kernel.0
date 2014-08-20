From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 20 Aug 2014 21:39:20 +0800
Subject: [PATCH] mmc: sunxi: Declare ERASE capability
Message-ID: <1408541960-14788-1-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Declare ERASE capability so we can use filesystems with the discard
option and the fstrim tool.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 drivers/mmc/host/sunxi-mmc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 024f67c..7bf5c1c 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -990,7 +990,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	/* 400kHz ~ 50MHz */
 	mmc->f_min		=   400000;
 	mmc->f_max		= 50000000;
-	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED;
+	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
+				  MMC_CAP_ERASE;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.1.0
