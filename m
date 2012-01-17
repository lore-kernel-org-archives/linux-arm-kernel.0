From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Tue, 17 Jan 2012 15:34:24 +0100
Subject: [PATCH 5/8] mmc: mmci: Support MMC_PM_KEEP_POWER
In-Reply-To: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
References: <1326810867-5346-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1326810867-5346-6-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MMC_PM_KEEP_POWER to pm_caps so SDIO clients are able
to use this option to prevent power off in suspend.

Tested-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/mmc/host/mmci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 76ce2cd..3defe69 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1319,6 +1319,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		mmc->ocr_avail = plat->ocr_mask;
 	mmc->caps = plat->capabilities;
 
+	/* We support these PM capabilities. */
+	mmc->pm_caps = MMC_PM_KEEP_POWER;
+
 	/*
 	 * We can do SGIO
 	 */
-- 
1.7.5.4
