From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 12:46:14 +0100
Subject: [PATCH 2/5] mmc: core: Indicate that vmmcq may be absent
In-Reply-To: <1375184777-25404-1-git-send-email-broonie@kernel.org>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Message-ID: <1375184777-25404-2-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Use regulator_get_optional() to tell the core that requests for the vmmcq
regulator can fail in a real system.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mmc/core/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 49a5bca..5d08855 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1313,7 +1313,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 
 	supply = devm_regulator_get(dev, "vmmc");
 	mmc->supply.vmmc = supply;
-	mmc->supply.vqmmc = devm_regulator_get(dev, "vqmmc");
+	mmc->supply.vqmmc = devm_regulator_get_optional(dev, "vqmmc");
 
 	if (IS_ERR(supply))
 		return PTR_ERR(supply);
-- 
1.8.3.2
