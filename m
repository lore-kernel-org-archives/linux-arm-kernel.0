From: lee.jones@linaro.org (Lee Jones)
Date: Thu,  4 Aug 2016 10:21:47 +0100
Subject: [PATCH 3/9] remoteproc: core: Remove pointless OOM print
In-Reply-To: <20160804092153.23032-1-lee.jones@linaro.org>
References: <20160804092153.23032-1-lee.jones@linaro.org>
Message-ID: <20160804092153.23032-4-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These types of error prints are superfluous.  The system will
pick up on OOM issues and let the user know.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/remoteproc/remoteproc_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
index 5654a81..4914482 100644
--- a/drivers/remoteproc/remoteproc_core.c
+++ b/drivers/remoteproc/remoteproc_core.c
@@ -619,7 +619,6 @@ static int rproc_handle_carveout(struct rproc *rproc,
 	if (rproc->domain) {
 		mapping = kzalloc(sizeof(*mapping), GFP_KERNEL);
 		if (!mapping) {
-			dev_err(dev, "kzalloc mapping failed\n");
 			ret = -ENOMEM;
 			goto dma_free;
 		}
-- 
2.9.0
