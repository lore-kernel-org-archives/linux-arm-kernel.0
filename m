From: ulf.hansson@linaro.org (Ulf Hansson)
Date: Fri, 21 Mar 2014 13:14:09 +0100
Subject: [PATCH 12/20] mmc: mmci: Enable MMC_CAP_CMD23
In-Reply-To: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
References: <1395404057-27835-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <1395404057-27835-13-git-send-email-ulf.hansson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is pure software configuration, which mmci has been supporting for
a while. Let's enable it as default so we can take benefit from it.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 2e1d1b2..edf3cfd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1532,6 +1532,9 @@ static int mmci_probe(struct amba_device *dev,
 		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
 	}
 
+	/* We support these capabilities. */
+	mmc->caps |= MMC_CAP_CMD23;
+
 	if (variant->busy_detect) {
 		mmci_ops.card_busy = mmci_card_busy;
 		mmci_write_datactrlreg(host, MCI_ST_DPSM_BUSYMODE);
-- 
1.7.9.5
