From: thunder.leizhen@huawei.com (Zhen Lei)
Date: Fri, 26 Jun 2015 16:32:56 +0800
Subject: [PATCH 0/8] iommu/arm-smmu: bugfixs and add support for non-pci
 devices
Message-ID: <1435307584-9812-1-git-send-email-thunder.leizhen@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As Documentation\devicetree\bindings\iommu\iommu.txt mentioned, a master may
belongs to many SMMUs or have more than one device-id(stream id). But on current
arm/arm64 platforms, a master with only one stream id. So I directly add two
members(of_smmu and device-id) in struct dev_archdata, and only support a master
with only one stream id. If some platforms that a master belongs to more than one
SMMUs or have more than one device-id, we should dynamic memory allocation to record
all information.

Zhen Lei (8):
  iommu/arm-smmu: fix the assignment of log2size field
  iommu/arm-smmu: fix the index calculation of strtab
  iommu/arm-smmu: fix the values of ARM64_TCR_IRGN0_SHIFT and
    ARM64_TCR_ORGN0_SHIFT
  iommu/arm-smmu: set EPD1 to disable TT1 translation table walk
  iommu/arm-smmu: rename __arm_smmu_get_pci_sid
  iommu/arm-smmu: add support for non-pci devices
  iommu/arm-smmu: enlarge STRTAB_L1_SZ_SHIFT to support larger sidsize
  iommu/arm-smmu: suppress fault information about CMD_PREFETCH_CONFIG
    execution

 arch/arm64/include/asm/device.h |   2 +
 drivers/iommu/arm-smmu-v3.c     | 135 +++++++++++++++++++++++++++++++++-------
 2 files changed, 116 insertions(+), 21 deletions(-)

--
1.8.0
