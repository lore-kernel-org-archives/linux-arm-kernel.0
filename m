From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Mon, 5 Feb 2018 18:20:20 +0530
Subject: [PATCH v2 07/16] mmc: sdhci_omap: Fix sdhci-omap quirks
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
Message-ID: <20180205125029.21570-8-kishon@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add SDHCI_QUIRK2_PRESET_VALUE_BROKEN quirk as setting preset values loads
incorrect CLKD values (for UHS modes).

Remove SDHCI_QUIRK2_NO_1_8_V quirk as sdhci-omap now supports UHS modes.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/sdhci-omap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 8b6170cd689b..d5a9e688dc1b 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -710,8 +710,8 @@ static const struct sdhci_pltfm_data sdhci_omap_pdata = {
 		  SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN |
 		  SDHCI_QUIRK_NO_HISPD_BIT |
 		  SDHCI_QUIRK_BROKEN_ADMA_ZEROLEN_DESC,
-	.quirks2 = SDHCI_QUIRK2_NO_1_8_V |
-		   SDHCI_QUIRK2_ACMD23_BROKEN |
+	.quirks2 = SDHCI_QUIRK2_ACMD23_BROKEN |
+		   SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
 		   SDHCI_QUIRK2_RSP_136_HAS_CRC,
 	.ops = &sdhci_omap_ops,
 };
-- 
2.11.0
