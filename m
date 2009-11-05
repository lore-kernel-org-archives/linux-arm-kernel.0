From: daniel@caiaq.de (Daniel Mack)
Date: Thu,  5 Nov 2009 18:13:35 +0100
Subject: [PATCH 2/3] ARM: MXC: mxcmmc: Fix max_seg_size assignment
In-Reply-To: <1257441216-19604-2-git-send-email-daniel@caiaq.de>
References: <1257441216-19604-1-git-send-email-daniel@caiaq.de>
	<1257441216-19604-2-git-send-email-daniel@caiaq.de>
Message-ID: <1257441216-19604-3-git-send-email-daniel@caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Daniel Mack <daniel@caiaq.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 drivers/mmc/host/mxcmmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
index 32ac139..8aa6de0 100644
--- a/drivers/mmc/host/mxcmmc.c
+++ b/drivers/mmc/host/mxcmmc.c
@@ -714,7 +714,7 @@ static int mxcmci_probe(struct platform_device *pdev)
 	mmc->max_blk_size = 2048;
 	mmc->max_blk_count = 65535;
 	mmc->max_req_size = mmc->max_blk_size * mmc->max_blk_count;
-	mmc->max_seg_size = mmc->max_seg_size;
+	mmc->max_seg_size = mmc->max_req_size;
 
 	host = mmc_priv(mmc);
 	host->base = ioremap(r->start, resource_size(r));
-- 
1.6.5.2
