From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Thu, 22 Jun 2017 16:35:53 +0300
Subject: [PATCH 07/14] staging: fsl-mc: move irq domain creation prototype to
 public header
In-Reply-To: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
References: <20170622133600.31694-1-laurentiu.tudor@nxp.com>
Message-ID: <20170622133600.31694-8-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

fsl_mc_msi_create_irq_domain() will is used from the irqchip glue code
so it needs to be in the public headers.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
 drivers/staging/fsl-mc/include/mc-bus.h | 7 -------
 drivers/staging/fsl-mc/include/mc.h     | 7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/fsl-mc/include/mc-bus.h b/drivers/staging/fsl-mc/include/mc-bus.h
index c1df433..0860681 100644
--- a/drivers/staging/fsl-mc/include/mc-bus.h
+++ b/drivers/staging/fsl-mc/include/mc-bus.h
@@ -14,9 +14,6 @@
 #include "../include/mc.h"
 #include <linux/mutex.h>
 
-struct irq_domain;
-struct msi_domain_info;
-
 /**
  * Maximum number of total IRQs that can be pre-allocated for an MC bus'
  * IRQ pool
@@ -70,10 +67,6 @@ struct fsl_mc_bus {
 #define to_fsl_mc_bus(_mc_dev) \
 	container_of(_mc_dev, struct fsl_mc_bus, mc_dev)
 
-struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
-						struct msi_domain_info *info,
-						struct irq_domain *parent);
-
 int fsl_mc_find_msi_domain(struct device *mc_platform_dev,
 			   struct irq_domain **mc_msi_domain);
 
diff --git a/drivers/staging/fsl-mc/include/mc.h b/drivers/staging/fsl-mc/include/mc.h
index 60c7067..adb2378 100644
--- a/drivers/staging/fsl-mc/include/mc.h
+++ b/drivers/staging/fsl-mc/include/mc.h
@@ -18,6 +18,9 @@
 
 #define FSL_MC_VENDOR_FREESCALE	0x1957
 
+struct irq_domain;
+struct msi_domain_info;
+
 struct fsl_mc_device;
 struct fsl_mc_io;
 
@@ -233,6 +236,10 @@ int __must_check fsl_mc_object_allocate(struct fsl_mc_device *mc_dev,
 
 void fsl_mc_object_free(struct fsl_mc_device *mc_adev);
 
+struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
+						struct msi_domain_info *info,
+						struct irq_domain *parent);
+
 int __must_check fsl_mc_allocate_irqs(struct fsl_mc_device *mc_dev);
 
 void fsl_mc_free_irqs(struct fsl_mc_device *mc_dev);
-- 
2.9.4
