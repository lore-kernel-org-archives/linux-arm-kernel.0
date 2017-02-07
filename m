From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 7 Feb 2017 09:43:50 -0600
Subject: [PATCH v3 07/10] staging: fsl-mc: dpmng: drop unused prototype
In-Reply-To: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
References: <20170207154353.20691-1-laurentiu.tudor@nxp.com>
Message-ID: <20170207154353.20691-8-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

The implementation was removed in commit:

decd3d0cf (staging: fsl-mc: uprev binary interface to match MC v10.x)

but the prototype was left behind.

Also fix a message that was wrongly mentioning it.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v3:
 - no changes

 drivers/staging/fsl-mc/bus/fsl-mc-bus.c | 2 +-
 drivers/staging/fsl-mc/include/dpmng.h  | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
index e607e98..47acb0a 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-bus.c
@@ -752,7 +752,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
 	error = dprc_get_container_id(mc_io, 0, &container_id);
 	if (error < 0) {
 		dev_err(&pdev->dev,
-			"dpmng_get_container_id() failed: %d\n", error);
+			"dprc_get_container_id() failed: %d\n", error);
 		goto error_cleanup_mc_io;
 	}
 
diff --git a/drivers/staging/fsl-mc/include/dpmng.h b/drivers/staging/fsl-mc/include/dpmng.h
index 7d8e255..170c07d 100644
--- a/drivers/staging/fsl-mc/include/dpmng.h
+++ b/drivers/staging/fsl-mc/include/dpmng.h
@@ -64,8 +64,4 @@ int mc_get_version(struct fsl_mc_io *mc_io,
 		   u32 cmd_flags,
 		   struct mc_version *mc_ver_info);
 
-int dpmng_get_container_id(struct fsl_mc_io *mc_io,
-			   u32 cmd_flags,
-			   int *container_id);
-
 #endif /* __FSL_DPMNG_H */
-- 
1.8.3.1
