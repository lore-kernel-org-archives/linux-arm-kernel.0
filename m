From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 18 Jul 2017 16:37:18 +0300
Subject: [PATCH v2 3/8] staging: fsl-mc: drop useless gic v3 related #include
In-Reply-To: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
References: <20170718133723.12709-1-laurentiu.tudor@nxp.com>
Message-ID: <20170718133723.12709-4-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

Nothing from linux/irqchip/arm-gic-v3.h is used, so the #include can be
safely dropped.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
Notes:
    -v2
      -no changes

 drivers/staging/fsl-mc/bus/fsl-mc-msi.c                | 1 -
 drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
index c04a2f2..ee6e3b7 100644
--- a/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/fsl-mc-msi.c
@@ -11,7 +11,6 @@
 
 #include <linux/of_device.h>
 #include <linux/of_address.h>
-#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/of_irq.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
diff --git a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
index 865d385..e798ea4 100644
--- a/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/irq-gic-v3-its-fsl-mc-msi.c
@@ -11,7 +11,6 @@
 
 #include <linux/of_device.h>
 #include <linux/of_address.h>
-#include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irq.h>
 #include <linux/msi.h>
 #include <linux/of.h>
-- 
2.9.4
