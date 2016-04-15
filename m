From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sat, 16 Apr 2016 01:29:29 +0800
Subject: [PATCH 05/23] mmc: core: mmc_regulator_set_vqmmc not return error if
 vqmmc/vmmc not exist
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Message-ID: <1460741387-23815-6-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Treat vqmmc/vmmc regulator the same way as mmc_regulator_get_supply()
in mmc_regulator_set_vqmmc(), since they're optional, do not return an
error if not exist.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 99275e4..52bfaf0 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1440,7 +1440,7 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	/* If no vqmmc supply then we can't change the voltage */
 	if (IS_ERR(mmc->supply.vqmmc))
-		return -EINVAL;
+		return 0;
 
 	switch (ios->signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_120:
-- 
1.9.1
