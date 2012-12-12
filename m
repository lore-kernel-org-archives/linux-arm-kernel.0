From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 12 Dec 2012 14:13:40 +0100
Subject: [PATCH] mmc: mmci: Support MMC_PM_KEEP_POWER
Message-ID: <1355318020-8169-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

Add MMC_PM_KEEP_POWER to pm_caps so SDIO clients are able
to use this option to prevent power off in suspend.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..2fe532e 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -20,6 +20,7 @@
 #include <linux/err.h>
 #include <linux/highmem.h>
 #include <linux/log2.h>
+#include <linux/mmc/pm.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
 #include <linux/amba/bus.h>
@@ -1386,6 +1387,9 @@ static int __devinit mmci_probe(struct amba_device *dev,
 	mmc->caps = plat->capabilities;
 	mmc->caps2 = plat->capabilities2;
 
+	/* We support these PM capabilities. */
+	mmc->pm_caps = MMC_PM_KEEP_POWER;
+
 	/*
 	 * We can do SGIO
 	 */
-- 
1.7.10
