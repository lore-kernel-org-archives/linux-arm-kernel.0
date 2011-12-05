From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Mon, 5 Dec 2011 18:35:47 +0100
Subject: [PATCH 01/14] mmc: mmci: Support MMC_PM_KEEP_POWER
In-Reply-To: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
References: <1323106560-5218-1-git-send-email-ulf.hansson@stericsson.com>
Message-ID: <1323106560-5218-2-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add MMC_PM_KEEP_POWER to pm_caps so SDIO clients are able
to use this option to prevent power off in suspend.

Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
---
 drivers/mmc/host/mmci.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 50b5f99..1ac04a2 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1240,6 +1240,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
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
