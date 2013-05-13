From: gmbnomis@gmail.com (Simon Baatz)
Date: Mon, 13 May 2013 23:18:55 +0200
Subject: [PATCH V2 04/10] mmc: mxcmmc: handle mmc_of_parse() errors during
 probe
In-Reply-To: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
References: <1368479941-10084-1-git-send-email-gmbnomis@gmail.com>
Message-ID: <1368479941-10084-5-git-send-email-gmbnomis@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Simon Baatz <gmbnomis@gmail.com>
---
 drivers/mmc/host/mxcmmc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index d503635..f47546f 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -1067,7 +1067,9 @@ static int mxcmci_probe(struct platform_device *pdev)
 		goto out_release_mem;
 	}
 
-	mmc_of_parse(mmc);
+	ret = mmc_of_parse(mmc);
+	if (ret)
+		goto out_free;
 	mmc->ops = &mxcmci_ops;
 
 	/* For devicetree parsing, the bus width is read from devicetree */
-- 
1.7.9.5
