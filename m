From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Oct 2017 17:00:46 +0100
Subject: [PATCH v2 2/3] ACPI/IORT: Improve functions return type/storage class
 specifier indentation
In-Reply-To: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1507824047-17045-3-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some functions definition indentations are using a style that is frowned
upon with return value type/storage class specifier in a separate line.

Reindent the function definitions to fix them.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/acpi/arm64/iort.c | 36 +++++++++++++++++-------------------
 include/linux/acpi_iort.h |  4 ++--
 2 files changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 69f21f3..2e54f87 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -88,8 +88,8 @@ static inline int iort_set_fwnode(struct acpi_iort_node *iort_node,
  *
  * Returns: fwnode_handle pointer on success, NULL on failure
  */
-static inline
-struct fwnode_handle *iort_get_fwnode(struct acpi_iort_node *node)
+static inline struct fwnode_handle *iort_get_fwnode(
+			struct acpi_iort_node *node)
 {
 	struct iort_fwnode *curr;
 	struct fwnode_handle *fwnode = NULL;
@@ -306,9 +306,8 @@ static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 	return 0;
 }
 
-static
-struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
-					u32 *id_out, int index)
+static struct acpi_iort_node *iort_node_get_id(struct acpi_iort_node *node,
+					       u32 *id_out, int index)
 {
 	struct acpi_iort_node *parent;
 	struct acpi_iort_id_mapping *map;
@@ -392,10 +391,9 @@ static struct acpi_iort_node *iort_node_map_id(struct acpi_iort_node *node,
 	return NULL;
 }
 
-static
-struct acpi_iort_node *iort_node_map_platform_id(struct acpi_iort_node *node,
-						 u32 *id_out, u8 type_mask,
-						 int index)
+static struct acpi_iort_node *iort_node_map_platform_id(
+		struct acpi_iort_node *node, u32 *id_out, u8 type_mask,
+		int index)
 {
 	struct acpi_iort_node *parent;
 	u32 id;
@@ -623,14 +621,14 @@ static inline bool iort_iommu_driver_enabled(u8 type)
 }
 
 #ifdef CONFIG_IOMMU_API
-static inline
-const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(
+				struct iommu_fwspec *fwspec)
 {
 	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
 }
 
-static inline
-int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
+static inline int iort_add_device_replay(const struct iommu_ops *ops,
+					 struct device *dev)
 {
 	int err = 0;
 
@@ -640,11 +638,11 @@ int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
 	return err;
 }
 #else
-static inline
-const struct iommu_ops *iort_fwspec_iommu_ops(struct iommu_fwspec *fwspec)
+static inline const struct iommu_ops *iort_fwspec_iommu_ops(
+				struct iommu_fwspec *fwspec)
 { return NULL; }
-static inline
-int iort_add_device_replay(const struct iommu_ops *ops, struct device *dev)
+static inline int iort_add_device_replay(const struct iommu_ops *ops,
+					 struct device *dev)
 { return 0; }
 #endif
 
@@ -1077,8 +1075,8 @@ static const struct iort_iommu_config iort_arm_smmu_cfg __initconst = {
 	.iommu_init_resources = arm_smmu_init_resources
 };
 
-static __init
-const struct iort_iommu_config *iort_get_iommu_cfg(struct acpi_iort_node *node)
+static __init const struct iort_iommu_config *iort_get_iommu_cfg(
+			struct acpi_iort_node *node)
 {
 	switch (node->type) {
 	case ACPI_IORT_NODE_SMMU_V3:
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 8d3f0bf..2f7a292 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -49,8 +49,8 @@ static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 /* IOMMU interface */
 static inline void iort_dma_setup(struct device *dev, u64 *dma_addr,
 				  u64 *size) { }
-static inline
-const struct iommu_ops *iort_iommu_configure(struct device *dev)
+static inline const struct iommu_ops *iort_iommu_configure(
+				      struct device *dev)
 { return NULL; }
 #endif
 
-- 
2.4.12
