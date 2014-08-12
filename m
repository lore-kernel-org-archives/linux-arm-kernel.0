From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 12 Aug 2014 17:14:26 +0100
Subject: [PATCH 2/5] mmc: dw_mmc-pci: Remove superflous #else condition on
 CONFIG_PM_SLEEP
In-Reply-To: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
References: <1407860069-12706-1-git-send-email-peter.griffin@linaro.org>
Message-ID: <1407860069-12706-3-git-send-email-peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As the code is using SIMPLE_DEV_PM_OPS helper, this compiles away to
nothing if CONFIG_PM_SLEEP is disabled. Thus we don't need to #define
the suspend/resume callbacks to NULL.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/mmc/host/dw_mmc-pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index f70546a..5523b84 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -95,9 +95,6 @@ static int dw_mci_pci_resume(struct device *dev)
 
 	return dw_mci_resume(host);
 }
-#else
-#define dw_mci_pci_suspend	NULL
-#define dw_mci_pci_resume	NULL
 #endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(dw_mci_pci_pmops, dw_mci_pci_suspend, dw_mci_pci_resume);
-- 
1.9.1
