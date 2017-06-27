From: laurentiu.tudor@nxp.com (laurentiu.tudor at nxp.com)
Date: Tue, 27 Jun 2017 17:41:25 +0300
Subject: [PATCH v2 05/15] staging: fsl-mc: delete duplicated function
 prototypes
In-Reply-To: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
References: <20170627144135.15599-1-laurentiu.tudor@nxp.com>
Message-ID: <20170627144135.15599-6-laurentiu.tudor@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurentiu Tudor <laurentiu.tudor@nxp.com>

These functions already have their prototypes in fsl-mc-private.h
header file so delete them from mc-bus.h.

Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
---
v2:
 - no changes

 drivers/staging/fsl-mc/include/mc-bus.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/fsl-mc/include/mc-bus.h b/drivers/staging/fsl-mc/include/mc-bus.h
index 42700de..8f9bf8d 100644
--- a/drivers/staging/fsl-mc/include/mc-bus.h
+++ b/drivers/staging/fsl-mc/include/mc-bus.h
@@ -75,14 +75,6 @@ int dprc_scan_container(struct fsl_mc_device *mc_bus_dev);
 int dprc_scan_objects(struct fsl_mc_device *mc_bus_dev,
 		      unsigned int *total_irq_count);
 
-int __init dprc_driver_init(void);
-
-void dprc_driver_exit(void);
-
-int __init fsl_mc_allocator_driver_init(void);
-
-void fsl_mc_allocator_driver_exit(void);
-
 struct irq_domain *fsl_mc_msi_create_irq_domain(struct fwnode_handle *fwnode,
 						struct msi_domain_info *info,
 						struct irq_domain *parent);
-- 
2.9.4
