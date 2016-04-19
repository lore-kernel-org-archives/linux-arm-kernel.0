From: oliver@schinagl.nl (Olliver Schinagl)
Date: Tue, 19 Apr 2016 09:12:14 +0200
Subject: [PATCH 2/2] mmc: sunxi: Mark the HPI of the mmc controller broken by
 default
In-Reply-To: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
References: <1461049934-12848-1-git-send-email-oliver@schinagl.nl>
Message-ID: <1461049934-12848-3-git-send-email-oliver@schinagl.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

So far it seems all sunxi MMC controllers have a broken HPI. Until
proved otherwise, mark all sunxi mmc controllers as having a broken HPI.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 drivers/mmc/host/sunxi-mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 8372a41..acf24fb 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1126,8 +1126,8 @@ static int sunxi_mmc_probe(struct platform_device *pdev)
 	mmc->f_min		=   400000;
 	mmc->f_max		= 52000000;
 	mmc->caps	       |= MMC_CAP_MMC_HIGHSPEED | MMC_CAP_SD_HIGHSPEED |
-				  MMC_CAP_1_8V_DDR |
-				  MMC_CAP_ERASE | MMC_CAP_SDIO_IRQ;
+				  MMC_CAP_1_8V_DDR | MMC_CAP_ERASE |
+				  MMC_CAP_SDIO_IRQ | MMC_CAP_BROKEN_HPI;
 
 	ret = mmc_of_parse(mmc);
 	if (ret)
-- 
2.8.0.rc3
