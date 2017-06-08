From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 8 Jun 2017 17:28:49 +0300
Subject: [PATCH v7 04/10] staging: fsl-mc: drop a few useless #includes
In-Reply-To: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
References: <20170608142855.10455-1-laurentiu.tudor@nxp.com>
Message-ID: <20170608142855.10455-5-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Some #includes were needlessly done from header files. Drop them from
there and update the only .c file that implicitly needed one of those
#includes.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---

Notes:
    -v7
      -rewrapped commit message

 drivers/staging/fsl-mc/bus/fsl-mc-msi.c     | 1 +
 drivers/staging/fsl-mc/bus/fsl-mc-private.h | 1 -
 drivers/staging/fsl-mc/include/dprc.h       | 2 --
 3 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
index b8b2c86..a92fa5a 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
@@ -17,6 +17,7 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 #include "../include/mc-bus.h"
+#include "../include/mc-cmd.h"
 #include "fsl-mc-private.h"
 
 /*
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
index 5c49c9d..01ef9329 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
@@ -11,7 +11,6 @@
 #define _FSL_MC_PRIVATE_H_
 
 #include "../include/mc.h"
-#include "../include/mc-bus.h"
 
 int __must_check fsl_mc_device_add(struct dprc_obj_desc *obj_desc,
 				   struct fsl_mc_io *mc_io,
diff --git a/drivers/staging/fsl-mc/include/dprc.h b/drivers/staging/fsl-mc/include/dprc.h
index dc985cc..8498a5e 100644
--- a/drivers/staging/fsl-mc/include/dprc.h
+++ b/drivers/staging/fsl-mc/include/dprc.h
@@ -33,8 +33,6 @@
 #ifndef _FSL_DPRC_H
 #define _FSL_DPRC_H
 
-#include "mc-cmd.h"
-
 /*
  * Data Path Resource Container API
  * Contains DPRC API for managing and querying DPAA resources
-- 
2.9.4
