From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 7 Jul 2015 11:30:21 +0800
Subject: [PATCH v2 8/9] iommu/arm-smmu: rename __arm_smmu_get_pci_sid
In-Reply-To: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
References: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
Message-ID: <1436239822-14132-9-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the words "pci", to make this function can also be used by
non-pci devices.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/iommu/arm-smmu-v3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
index 39c55f6..274d059 100644
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
@@ -1805,7 +1805,7 @@ static int arm_smmu_add_device(struct device *dev, u32 sid)
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
