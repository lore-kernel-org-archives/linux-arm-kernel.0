From: lakshmi.sai.krishna.potthuri@xilinx.com (P L Sai Krishna)
Date: Tue, 19 Jan 2016 19:47:35 +0530
Subject: [LINUX PATCH 5/5] mmc: host: Update the quirks for this controller.
In-Reply-To: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
References: <1453213055-35563-1-git-send-email-lakshmis@xilinx.com>
Message-ID: <1453213055-35563-5-git-send-email-lakshmis@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds SDHCI_QUIRK2_STOP_WITH_TC quirk to remove
the following error message.
"mmc0: Got data interrupt 0x00000002 even though no data
operation was in progress"

Signed-off-by: P L Sai Krishna <lakshmis@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 7f30577..751623f 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -83,7 +83,8 @@ static struct sdhci_pltfm_data sdhci_arasan_pdata = {
 	.ops = &sdhci_arasan_ops,
 	.quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
 	.quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
-			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
+			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
+			SDHCI_QUIRK2_STOP_WITH_TC,
 };
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.1.2
