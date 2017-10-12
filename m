From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 12 Oct 2017 17:00:45 +0100
Subject: [PATCH v2 1/3] ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID
 guard
In-Reply-To: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1507824047-17045-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <1507824047-17045-2-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The conditional ACPI_IORT_SMMU_V3_PXM_VALID guard around
arm_smmu_v3_set_proximity() was added to manage a cross tree
ACPICA merge dependency; with ACPICA changes merged in:

commit c944230064eb ("ACPICA: iasl: Update to IORT SMMUv3
disassembling")

the guard has become useless. Remove it.

Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Acked-by: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Hanjun Guo <hanjun.guo@linaro.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
---
 drivers/acpi/arm64/iort.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index de56394..69f21f3 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -968,7 +968,7 @@ static bool __init arm_smmu_v3_is_coherent(struct acpi_iort_node *node)
 	return smmu->flags & ACPI_IORT_SMMU_V3_COHACC_OVERRIDE;
 }
 
-#if defined(CONFIG_ACPI_NUMA) && defined(ACPI_IORT_SMMU_V3_PXM_VALID)
+#if defined(CONFIG_ACPI_NUMA)
 /*
  * set numa proximity domain for smmuv3 device
  */
-- 
2.4.12
