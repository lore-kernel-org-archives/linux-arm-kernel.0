From: sebastian.hesselbarth@googlemail.com (Sebastian Hesselbarth)
Date: Thu,  5 Jul 2012 12:14:00 +0200
Subject: [PATCH v1 1/2] mmc: sdhci-dove: Add SDHCI_QUIRK_NO_HISPD_BIT
Message-ID: <1341483241-18300-1-git-send-email-sebastian.hesselbarth@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sdio controller on dove doesn't have a bit to indicate
high-speed. With the quirk set it fixes accessing high-speed
sdcards.

Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>
Cc: Chris Ball <cjb@laptop.org>
Cc: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Shawn Guo <shawn.guo@linaro.org>
Cc: Viresh Kumar <viresh.kumar@st.com>
Cc: Manuel Lauss <manuel.lauss@googlemail.com>
Cc: linux-mmc at vger.kernel.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-kernel at vger.kernel.org
---
 drivers/mmc/host/sdhci-dove.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-dove.c b/drivers/mmc/host/sdhci-dove.c
index 177f697..9c85368 100644
--- a/drivers/mmc/host/sdhci-dove.c
+++ b/drivers/mmc/host/sdhci-dove.c
@@ -66,7 +66,8 @@ static struct sdhci_pltfm_data sdhci_dove_pdata = {
 	.quirks	= SDHCI_QUIRK_NO_SIMULT_VDD_AND_POWER |
 		  SDHCI_QUIRK_NO_BUSY_IRQ |
 		  SDHCI_QUIRK_BROKEN_TIMEOUT_VAL |
-		  SDHCI_QUIRK_FORCE_DMA,
+		  SDHCI_QUIRK_FORCE_DMA |
+		  SDHCI_QUIRK_NO_HISPD_BIT,
 };
 
 static int __devinit sdhci_dove_probe(struct platform_device *pdev)
-- 
1.7.10
