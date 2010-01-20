From: lars@metafoo.de (Lars-Peter Clausen)
Date: Wed, 20 Jan 2010 09:16:01 +0100
Subject: [PATCH 2/2] s3cmci: s3cmci_card_present: Use no_detect to decide
	whether there is a card detect pin
In-Reply-To: <1263975361-29376-1-git-send-email-lars@metafoo.de>
References: <1263975361-29376-1-git-send-email-lars@metafoo.de>
Message-ID: <1263975361-29376-2-git-send-email-lars@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/s3cmci.c b/drivers/mmc/host/s3cmci.c
index b9c96cc..2fdf768 100644
--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1179,7 +1179,7 @@ static int s3cmci_card_present(struct mmc_host *mmc)
 	struct s3c24xx_mci_pdata *pdata = host->pdata;
 	int ret;
 
-	if (pdata->gpio_detect == 0)
+	if (pdata->no_detect)
 		return -ENOSYS;
 
 	ret = gpio_get_value(pdata->gpio_detect) ? 0 : 1;
-- 
1.5.6.5
