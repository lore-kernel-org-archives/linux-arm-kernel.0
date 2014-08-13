From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 12 Aug 2014 17:51:33 -0700
Subject: [PATCH 0/6] iommu/arm-smmu: misc features, new DT bindings
Message-ID: <1407891099-24641-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains a some enhancements to the ARM SMMU driver. These
are mostly distinct but I'm sending them out in a single series since
they depend on each other for clean application.

The first two patches are related to power-saving features (clocks and
regulators).

The third adds support for doing iova_to_phys through the SMMU
hardware on platforms that support it.

The fourth implements the recently merged generic DT bindings. For
reference, the discussion around the generic DT bindings is here:

    http://lists.linuxfoundation.org/pipermail/iommu/2014-July/009357.html

The fifth and sixth handle some implementation-specific issues,
providing knobs in the device tree and a new domain attribute.

This series is based on on Will's iommu/pci branch.



Mitchel Humpherys (6):
  iommu/arm-smmu: add support for specifying clocks
  iommu/arm-smmu: add support for specifying regulators
  iommu/arm-smmu: add support for iova_to_phys through ATS1PR
  iommu/arm-smmu: implement generic DT bindings
  iommu/arm-smmu: support buggy implementations with invalidate-on-map
  iommu/arm-smmu: add .domain_{set,get}_attr for coherent walk control

 .../devicetree/bindings/iommu/arm,smmu.txt         |  18 +
 drivers/iommu/arm-smmu.c                           | 444 ++++++++++++++++++---
 include/linux/iommu.h                              |   1 +
 3 files changed, 406 insertions(+), 57 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
