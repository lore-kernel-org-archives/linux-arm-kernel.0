From: rrichter@cavium.com (Robert Richter)
Date: Mon, 13 Mar 2017 11:39:01 +0100
Subject: [PATCH] iommu/arm-smmu: Print message when Cavium erratum 27704 was
 detected
Message-ID: <20170313103902.17423-1-rrichter@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Firmware is responsible for properly enabling smmu workarounds. Print
a message for better diagnostics when Cavium erratum 27704 was
detected.

Signed-off-by: Robert Richter <rrichter@cavium.com>
---
 drivers/iommu/arm-smmu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index abf6496843a6..c88bf8deb958 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1887,6 +1887,7 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
 			atomic_add_return(smmu->num_context_banks,
 					  &cavium_smmu_context_count);
 		smmu->cavium_id_base -= smmu->num_context_banks;
+		dev_notice(smmu->dev, "\tenabling workaround for Cavium erratum 27704\n");
 	}
 
 	/* ID2 */
-- 
2.11.0
