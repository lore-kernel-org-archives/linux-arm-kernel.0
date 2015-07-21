From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 21 Jul 2015 15:30:31 +0800
Subject: [PATCH v3 3/5] iommu/arm-smmu: rename __arm_smmu_get_pci_sid
In-Reply-To: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
References: <1437463833-16112-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1437463833-16112-4-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the words "pci", to make this function can also be used by
non-pci devices.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 9daf4cc..216c9d4 100644
--- a/drivers/iommu/arm-smmu-v3.c
+++ b/drivers/iommu/arm-smmu-v3.c
@@ -1734,7 +1734,7 @@ static int __arm_smmu_get_pci_sid(struct pci_dev *pdev, u16 alias, void *sidp)
 	return 0; /* Continue walking */
 }

-static void __arm_smmu_release_pci_iommudata(void *data)
+static void __arm_smmu_release_iommudata(void *data)
 {
 	kfree(data);
 }
@@ -1811,7 +1811,7 @@ static int __arm_smmu_add_device(struct device *dev, u32 sid)
 		smmu_group->ste.valid	= true;
 		smmu_group->smmu	= smmu;
 		iommu_group_set_iommudata(group, smmu_group,
-					  __arm_smmu_release_pci_iommudata);
+					  __arm_smmu_release_iommudata);
 	} else {
 		smmu = smmu_group->smmu;
 	}
--
1.8.0
