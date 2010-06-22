From: rabin.vincent@stericsson.com (Rabin Vincent)
Date: Tue, 22 Jun 2010 14:47:37 +0530
Subject: [PATCH 02/12] mmci: fix multi block transfers
In-Reply-To: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
References: <1277198267-10860-1-git-send-email-rabin.vincent@stericsson.com>
Message-ID: <1277198267-10860-2-git-send-email-rabin.vincent@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix the data transfer size to allow multi block transfers to work.

Acked-by: Linus Walleij <linus.walleij@stericsson.com>
Signed-off-by: Rabin Vincent <rabin.vincent@stericsson.com>
---
 drivers/mmc/host/mmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 683516b..84d782b 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -120,7 +120,7 @@ static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 		data->blksz, data->blocks, data->flags);
 
 	host->data = data;
-	host->size = data->blksz;
+	host->size = data->blksz * data->blocks;
 	host->data_xfered = 0;
 
 	mmci_init_sg(host, data);
-- 
1.7.0
