From: yangbo.lu@nxp.com (Yangbo Lu)
Date: Mon, 27 Mar 2017 15:49:40 +0800
Subject: [v3, 5/7] mmc: sdhci-of-esdhc: add delay between tuning cycles
In-Reply-To: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
References: <1490600982-5410-1-git-send-email-yangbo.lu@nxp.com>
Message-ID: <1490600982-5410-6-git-send-email-yangbo.lu@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It's observed that eSDHC needed delay between tuning cycles for
HS200 successful tuning. This patch is to set 1ms delay for that.

Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
---
Changes for v2:
	- None
Changes for v3:
	- Used a host member for tuning delay instead of a quirk.
---
 drivers/mmc/host/sdhci-of-esdhc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 8c8e147..0754ef4 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -807,6 +807,7 @@ static int sdhci_esdhc_probe(struct platform_device *pdev)
 	host->mmc_host_ops.start_signal_voltage_switch =
 		esdhc_signal_voltage_switch;
 	host->mmc_host_ops.execute_tuning = esdhc_execute_tuning;
+	host->tuning_delay = 1;
 
 	esdhc_init(pdev, host);
 
-- 
2.1.0.27.g96db324
