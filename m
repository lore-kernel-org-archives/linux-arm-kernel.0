From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 12 May 2017 11:41:41 +0100
Subject: [PATCH 1/2] acpica: iort: Update SMMU models for IORT rev. C
Message-ID: <0bb462748c0a08dbf1db103d2a96b80c71412817.1494585645.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

IORT revision C has been published with a number of new SMMU
implementation identifiers; define them.

CC: Rafael J. Wysocki <rjw@rjwysocki.net>
CC: Robert Moore <robert.moore@intel.com>
CC: Lv Zheng <lv.zheng@intel.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 include/acpi/actbl2.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h
index 7aee9fb3bd1f..0242be07f292 100644
--- a/include/acpi/actbl2.h
+++ b/include/acpi/actbl2.h
@@ -777,6 +777,8 @@ struct acpi_iort_smmu {
 #define ACPI_IORT_SMMU_V2               0x00000001	/* Generic SMMUv2 */
 #define ACPI_IORT_SMMU_CORELINK_MMU400  0x00000002	/* ARM Corelink MMU-400 */
 #define ACPI_IORT_SMMU_CORELINK_MMU500  0x00000003	/* ARM Corelink MMU-500 */
+#define ACPI_IORT_SMMU_CORELINK_MMU401  0x00000004	/* ARM Corelink MMU-401 */
+#define ACPI_IORT_SMMU_CAVIUM_SMMUV2    0x00000005	/* Cavium ThunderX SMMUv2 */
 
 /* Masks for Flags field above */
 
@@ -795,6 +797,12 @@ struct acpi_iort_smmu_v3 {
 	u32 sync_gsiv;
 };
 
+/* Values for Model field above */
+
+#define ACPI_IORT_SMMU_V3               0x00000000	/* Generic SMMUv3 */
+#define ACPI_IORT_SMMU_HISILICON_HI161X 0x00000001	/* HiSilicon Hi161x SMMUv3 */
+#define ACPI_IORT_SMMU_CAVIUM_CN99XX    0x00000002	/* Cavium CN99xx SMMUv3 */
+
 /* Masks for Flags field above */
 
 #define ACPI_IORT_SMMU_V3_COHACC_OVERRIDE   (1)
-- 
2.12.2.dirty
