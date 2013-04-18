From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 18 Apr 2013 11:11:58 +0100
Subject: [PATCH 16/32] dmaengine: ste_dma40: Remove unnecessary call to
 d40_phy_cfg()
In-Reply-To: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
References: <1366279934-30761-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1366279934-30761-17-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All configuration left in d40_phy_cfg() is runtime configurable and
there is already a call into it from d40_runtime_config(), so let's
rely on that.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 178a03c..1c570b6 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2437,9 +2437,6 @@ static int d40_alloc_chan_resources(struct dma_chan *chan)
 	}
 
 	pm_runtime_get_sync(d40c->base->dev);
-	/* Fill in basic CFG register values */
-	d40_phy_cfg(&d40c->dma_cfg, &d40c->src_def_cfg,
-		    &d40c->dst_def_cfg, chan_is_logical(d40c));
 
 	d40_set_prio_realtime(d40c);
 
-- 
1.7.10.4
