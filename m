From: yauhen.kharuzhy@promwad.com (Yauhen Kharuzhy)
Date: Thu, 24 Dec 2009 15:37:11 +0200
Subject: [PATCH] at91_mci: Enable 4-bit bus mode for AT91SAM9RL64 CPU
Message-ID: <1261661831-750-1-git-send-email-yauhen.kharuzhy@promwad.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

AT91SAM9RL64 CPU has 4-bit SD/MMC mode support, so enable them.

Signed-off-by: Yauhen Kharuzhy <yauhen.kharuzhy@promwad.com>
---
 drivers/mmc/host/at91_mci.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index 63924e0..cb4a63b 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -1017,7 +1017,8 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	host->bus_mode = 0;
 	host->board = pdev->dev.platform_data;
 	if (host->board->wire4) {
-		if (cpu_is_at91sam9260() || cpu_is_at91sam9263())
+		if (cpu_is_at91sam9260() || cpu_is_at91sam9263()
+			|| cpu_is_at91sam9rl())
 			mmc->caps |= MMC_CAP_4_BIT_DATA;
 		else
 			dev_warn(&pdev->dev, "4 wire bus mode not supported"
-- 
1.6.5.7
