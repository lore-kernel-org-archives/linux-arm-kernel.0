From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon,  7 Aug 2017 11:50:44 +0200
Subject: [PATCH 5/5] mmc: sdhci-brcmstb: constify sdhci_pltfm_data structures
In-Reply-To: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502099444-10473-6-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci_pltfm_data structure is only passed as the second argument
of sdhci_pltfm_init, which is const, so the sdhci_pltfm_data structure
can be const as well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sdhci-brcmstb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index e2f6383..3a64c13 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -63,7 +63,7 @@ static SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
+static const struct sdhci_pltfm_data sdhci_brcmstb_pdata = {
 	.ops = &sdhci_brcmstb_ops,
 };
 
