From: Julia.Lawall@lip6.fr (Julia Lawall)
Date: Mon,  7 Aug 2017 11:50:43 +0200
Subject: [PATCH 4/5] mmc: sdhci-of-arasan: constify sdhci_pltfm_data and
 sdhci_ops structures
In-Reply-To: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1502099444-10473-1-git-send-email-Julia.Lawall@lip6.fr>
Message-ID: <1502099444-10473-5-git-send-email-Julia.Lawall@lip6.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdhci_pltfm_data structure is only passed as the second argument
of sdhci_pltfm_init, which is const, while the sdhci_ops structure
is only stored in the ops field of a sdhci_pltfm_data structure,
which is also const.  Thus both kinds of structures can be const as
well.

Done with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/mmc/host/sdhci-of-arasan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 528a5d2..0720ea7 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -262,7 +262,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	return -EINVAL;
 }
 
-static struct sdhci_ops sdhci_arasan_ops = {
+static const struct sdhci_ops sdhci_arasan_ops = {
 	.set_clock = sdhci_arasan_set_clock,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
@@ -271,7 +271,7 @@ static int sdhci_arasan_voltage_switch(struct mmc_host *mmc,
 	.set_uhs_signaling = sdhci_set_uhs_signaling,
 };
 
-static struct sdhci_pltfm_data sdhci_arasan_pdata = {
+static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
