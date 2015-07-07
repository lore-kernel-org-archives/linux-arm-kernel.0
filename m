From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Tue, 7 Jul 2015 11:30:13 +0800
Subject: [PATCH v2 0/9] bugfixs and add support for non-pci devices
Message-ID: <1436239822-14132-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
v1 -> v2:
update the implementation of patch 1/9 according to Will Deacon's suggestion.
update the comment of patch 3/9 and 4/9.
use arm_smmu_options to skip the execution of command CMD_PREFETCH_CONFIG, see patch 5/9.
patch 6/9 is base on Laurent's series, to support probe deferral.
patch 7/9 according to Robin Murphy's suggestion, remove global variable arm_smmu_devices, thanks.
patch 9/9 add support for a master with multiple stream IDs.

Addition:
scripts/checkpatch 6/9 reports a warning, this is temporary. I don't want
patch 9/9 to display too many differences just because of add tabs.

scripts/checkpatch.pl 0006-iommu-arm-smmu-to-support-probe-deferral.patch
WARNING: else is not generally useful after a break or return
#161: FILE: drivers/iommu/arm-smmu-v3.c:1938:
+		return -ENODEV;
+	} else {

Zhen Lei (9):
  iommu/arm-smmu: fix the assignment of L1 table log2entries
  iommu/arm-smmu: fix the index calculation of strtab
  iommu/arm-smmu: fix the values of ARM64_TCR_IRGN0_SHIFT and
    ARM64_TCR_ORGN0_SHIFT
  iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support larger sidsize
  iommu/arm-smmu: skip the execution of CMD_PREFETCH_CONFIG
  iommu/arm-smmu: to support probe deferral
  iommu/arm-smmu: remove arm_smmu_devices
  iommu/arm-smmu: rename __arm_smmu_get_pci_sid
  iommu/arm-smmu: add support for non-pci devices

 drivers/iommu/arm-smmu-v3.c | 238 ++++++++++++++++++++++++++++++++------------
 1 file changed, 173 insertions(+), 65 deletions(-)

--
1.8.0
