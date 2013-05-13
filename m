From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 13 May 2013 23:18:54 +0200
Subject: [PATCH V2 03/10] mmc: tmio-mmc: handle mmc_of_parse() errors during
 probe
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1368479941-10084-4-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/tmio_mmc_pio.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index f508ecb..f1a9d4a 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -988,7 +988,9 @@ int tmio_mmc_host_probe(struct tmio_mmc_host **host,
 	if (!mmc)
 		return -ENOMEM;
 
-	mmc_of_parse(mmc);
+	ret = mmc_of_parse(mmc);
+	if (ret < 0)
+		goto host_free;
 
 	pdata->dev = &pdev->dev;
 	_host = mmc_priv(mmc);
-- 
1.7.9.5
