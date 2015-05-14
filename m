From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Fri, 15 May 2015 02:00:08 +0300
Subject: [RFC/PATCH 7/9] iommu: of: Document the of_iommu_configure() function
In-Reply-To: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1431644410-2997-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1431644410-2997-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The function isn't trivial, document its behaviour.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/iommu/of_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 43429ab62228..b922ed4f9fb3 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -133,6 +133,19 @@ struct iommu_ops *of_iommu_get_ops(struct device_node *np)
 	return ops;
 }
 
+/**
+ * of_iommu_configure - Configure and return the IOMMU for a device
+ * @dev: device for which to configure the IOMMU
+ * @master_np: device node of the bus master connected to the IOMMU
+ *
+ * The master_np parameter specifies the device node of the bus master seen by
+ * the IOMMU. This is usually the device node of the dev device, but can be the
+ * device node of a bridge when the device is dynamically discovered and
+ * instantiated and thus has no device node (such as PCI devices for instance).
+ *
+ * Return a pointer to the iommu_ops for the device, NULL if the device isn't
+ * connected to an IOMMU, or a negative value if an error occurs.
+ */
 struct iommu_ops *of_iommu_configure(struct device *dev,
 				     struct device_node *master_np)
 {
-- 
2.3.6
