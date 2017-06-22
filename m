From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:36:00 +0300
Subject: [PATCH 14/14] staging: fsl-mc: make dprc.h header private
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-15-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

dprc.h is only used in the mc bus driver so move it together with the
sources thus making it private.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/bus/dprc.c              | 2 +-
 drivers/staging/fsl-mc/{include => bus}/dprc.h | 0
 drivers/staging/fsl-mc/bus/fsl-mc-private.h    | 1 +
 drivers/staging/fsl-mc/include/mc.h            | 1 -
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/staging/fsl-mc/{include => bus}/dprc.h (100%)

diff --git a/drivers/staging/fsl-mc/bus/dprc.c b/drivers/staging/fsl-mc/bus/dprc.c
index 138fe80..6f6c65a 100644
--- a/drivers/staging/fsl-mc/bus/dprc.c
+++ b/drivers/staging/fsl-mc/bus/dprc.c
@@ -31,7 +31,7 @@
  */
 #include <linux/kernel.h>
 #include "../include/mc.h"
-#include "../include/dprc.h"
+#include "dprc.h"
 
 #include "dprc-cmd.h"
 
diff --git a/drivers/staging/fsl-mc/include/dprc.h b/drivers/staging/fsl-mc/bus/dprc.h
similarity index 100%
rename from drivers/staging/fsl-mc/include/dprc.h
rename to drivers/staging/fsl-mc/bus/dprc.h
diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-private.h b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
index e583999..62d3989 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-private.h
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-private.h
@@ -11,6 +11,7 @@
 #define _FSL_MC_PRIVATE_H_
 
 #include "../include/mc.h"
+#include "dprc.h"
 #include <linux/mutex.h>
 
 /**
diff --git a/drivers/staging/fsl-mc/include/mc.h b/drivers/staging/fsl-mc/include/mc.h
index 38f8714..aafe63a 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/drivers/staging/fsl-mc/include/mc.h
@@ -14,7 +14,6 @@
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 #include <linux/interrupt.h>
-#include "../include/dprc.h"
 
 #define FSL_MC_VENDOR_FREESCALE	0x1957
 
-- 
2.9.4
