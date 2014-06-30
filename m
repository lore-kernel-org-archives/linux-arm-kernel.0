From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jun 2014 11:52:05 +0100
Subject: [PATCH 0/5] iommu/arm-smmu: Updates for 3.17
Message-ID: <1404125530-17984-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here is the set of arm/smmu patches I currently have that I'd like to get
in for 3.17 (pending review comments). The diffstat is bigger than usual,
since I've got my hands on a PCI-capable platform (model) and subsequently
started to get that up and running. I've also been playing with VFIO and
KVM guest device assignment, which revealed some issues with stage-2 mappings.

I'll post further RFC patches relating to VFIO separately, as discussion
is definitely needed there.

The other thing to note is that I plan to move to Thierry's generic IOMMU
devicetree bindings as soon as they are merged:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2014-June/267061.html

That will break any users of the current binding, but I don't believe we
actually have any at the moment (there are certainly none in mainline).
The removal of chained SMMU support in this series is a prerequisite for
that conversion.

All feedback welcome,

Will


Will Deacon (5):
  iommu/arm-smmu: fix calculation of TCR.T0SZ
  iommu/arm-smmu: add support for PCI master devices
  iommu/arm-smmu: caps: add IOMMU_CAP_INTR_REMAP capability
  iommu/arm-smmu: remove support for chained SMMUs
  iommu/arm-smmu: prefer stage-1 mappings where we have a choice

 .../devicetree/bindings/iommu/arm,smmu.txt         |   6 -
 drivers/iommu/arm-smmu.c                           | 431 ++++++++++-----------
 2 files changed, 199 insertions(+), 238 deletions(-)

-- 
2.0.0
