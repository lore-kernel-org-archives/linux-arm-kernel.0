From: m-karicheri2@ti.com (Murali Karicheri)
Date: Tue, 20 Dec 2016 17:24:22 -0500
Subject: [PATCH 1/2] soc: ti: knav_dma: fix typos in trace message
Message-ID: <1482272663-29829-1-git-send-email-m-karicheri2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes some typos in the trace message

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/soc/ti/knav_dma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index 1a7b5ca..ecebe2e 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -395,7 +395,7 @@ static int of_channel_match_helper(struct device_node *np, const char *name,
 
 	if (of_parse_phandle_with_fixed_args(np, "ti,navigator-dmas",
 					1, index, &args)) {
-		dev_err(kdev->dev, "Missing the pahndle args name %s\n", name);
+		dev_err(kdev->dev, "Missing the phandle args name %s\n", name);
 		return -ENODEV;
 	}
 
@@ -436,7 +436,7 @@ void *knav_dma_open_channel(struct device *dev, const char *name,
 	}
 
 	dev_dbg(kdev->dev, "initializing %s channel %d from DMA %s\n",
-		  config->direction == DMA_MEM_TO_DEV   ? "transmit" :
+		  config->direction == DMA_MEM_TO_DEV ? "transmit" :
 		  config->direction == DMA_DEV_TO_MEM ? "receive"  :
 		  "unknown", chan_num, instance);
 
-- 
1.9.1
