From: tony.lin@freescale.com (Tony Lin)
Date: Thu, 1 Sep 2011 13:51:15 +0800
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock from
	100ms to 1ms
Message-ID: <1314856275-12131-1-git-send-email-tony.lin@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1ms is enough for hardware to change the clock to stable.
100ms is too long.

Signed-off-by: Tony Lin <tony.lin@freescale.com>
---
 drivers/mmc/host/sdhci-esdhc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc.h b/drivers/mmc/host/sdhci-esdhc.h
index c3b08f1..b97b2f5 100644
--- a/drivers/mmc/host/sdhci-esdhc.h
+++ b/drivers/mmc/host/sdhci-esdhc.h
@@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host *host, unsigned int clock)
 		| (div << ESDHC_DIVIDER_SHIFT)
 		| (pre_div << ESDHC_PREDIV_SHIFT));
 	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
-	mdelay(100);
+	mdelay(1);
 out:
 	host->clock = clock;
 }
-- 
1.7.0.4
