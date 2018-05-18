From: scott.branden@broadcom.com (Scott Branden)
Date: Fri, 18 May 2018 15:03:57 -0700
Subject: [PATCH 3/3] mmc: sdhci-iproc: add SDHCI_QUIRK2_HOST_OFF_CARD_ON for
 cygnus
In-Reply-To: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
References: <1526681037-2074-1-git-send-email-scott.branden@broadcom.com>
Message-ID: <1526681037-2074-4-git-send-email-scott.branden@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Corneliu Doban <corneliu.doban@broadcom.com>

The SDHCI_QUIRK2_HOST_OFF_CARD_ON is needed for the driver to
properly reset the host controller (reset all) on initialization
after exiting deep sleep.

Signed-off-by: Corneliu Doban <corneliu.doban@broadcom.com>
Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Srinath Mannam <srinath.mannam@broadcom.com>
---
 drivers/mmc/host/sdhci-iproc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 1f0ab08..d0e83db 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -186,7 +186,7 @@ static const struct sdhci_ops sdhci_iproc_32only_ops = {
 
 static const struct sdhci_pltfm_data sdhci_iproc_cygnus_pltfm_data = {
 	.quirks = SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK,
-	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN,
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN | SDHCI_QUIRK2_HOST_OFF_CARD_ON,
 	.ops = &sdhci_iproc_32only_ops,
 };
 
-- 
2.5.0
