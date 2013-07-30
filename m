From: broonie@kernel.org (Mark Brown)
Date: Tue, 30 Jul 2013 12:46:17 +0100
Subject: [PATCH 5/5] mmc: pxamci: Indicate that regulators may be absent
In-Reply-To: <1375184777-25404-1-git-send-email-broonie@kernel.org>
References: <1375184777-25404-1-git-send-email-broonie@kernel.org>
Message-ID: <1375184777-25404-5-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mark Brown <broonie@linaro.org>

Use regulator_get_optional() to tell the core that requests for regulators
can fail in a real system.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mmc/host/pxamci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/pxamci.c b/drivers/mmc/host/pxamci.c
index 2c5a91b..1956a3d 100644
--- a/drivers/mmc/host/pxamci.c
+++ b/drivers/mmc/host/pxamci.c
@@ -83,7 +83,7 @@ struct pxamci_host {
 static inline void pxamci_init_ocr(struct pxamci_host *host)
 {
 #ifdef CONFIG_REGULATOR
-	host->vcc = regulator_get(mmc_dev(host->mmc), "vmmc");
+	host->vcc = regulator_get_optional(mmc_dev(host->mmc), "vmmc");
 
 	if (IS_ERR(host->vcc))
 		host->vcc = NULL;
-- 
1.8.3.2
