From: s-anna@ti.com (Suman Anna)
Date: Mon, 23 Jul 2018 18:27:57 -0500
Subject: [PATCH] remoteproc/davinci: Mark error recovery as disabled
Message-ID: <20180723232757.9147-1-s-anna@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Davinci remoteproc driver does not support error recovery at
present, so mark the corresponding remoteproc flag appropriately
so that the debugfs flag shows the value as 'disabled' by default.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 drivers/remoteproc/da8xx_remoteproc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/remoteproc/da8xx_remoteproc.c b/drivers/remoteproc/da8xx_remoteproc.c
index b668e32996e2..53160d5ed543 100644
--- a/drivers/remoteproc/da8xx_remoteproc.c
+++ b/drivers/remoteproc/da8xx_remoteproc.c
@@ -284,6 +284,9 @@ static int da8xx_rproc_probe(struct platform_device *pdev)
 		goto free_mem;
 	}
 
+	/* error recovery is not supported at present */
+	rproc->recovery_disabled = true;
+
 	drproc = rproc->priv;
 	drproc->rproc = rproc;
 	drproc->dsp_clk = dsp_clk;
-- 
2.18.0
