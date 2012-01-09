From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon,  9 Jan 2012 10:32:47 +0100
Subject: [PATCH 1/4] mmc: mxcmmc: add missing dma_async_issue_pending
In-Reply-To: <1326101570-3716-1-git-send-email-s.hauer@pengutronix.de>
References: <1326101570-3716-1-git-send-email-s.hauer@pengutronix.de>
Message-ID: <1326101570-3716-2-git-send-email-s.hauer@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/mmc/host/mxcmmc.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 8e0fbe9..d1c2c31 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -263,6 +263,7 @@ static int mxcmci_setup_data(struct mxcmci_host *host, struct mmc_data *data)
 	wmb();
 
 	dmaengine_submit(host->desc);
+	dma_async_issue_pending(host->dma);
 
 	return 0;
 }
-- 
1.7.7.3
