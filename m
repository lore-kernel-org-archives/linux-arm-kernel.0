From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 21 Jul 2017 13:12:34 +0100
Subject: [PATCH 0/4] IOMMU group cleanup
Message-ID: <cover.1500637633.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Prompted by some discussion around the questionable usefulness of
iommu_present() for SoC topologies, I took a look at what was left to
finish off the intention of making groups mandatory. Turns out it
wasn't much, so here it is. As well as the general rationalisation
aspect, between this and the probe-deferral changes in 4.12, we should
now be able to rely on the presence of a group unambiguously indicating
whether a given device is associated with an IOMMU or not.

Robin.

Robin Murphy (4):
  iommu/msm: Add iommu_group support
  iommu/tegra-smmu: Add iommu_group support
  iommu/tegra-gart: Add iommu_group support
  iommu: Finish making iommu_group support mandatory

 drivers/iommu/iommu.c      | 19 ++++---------------
 drivers/iommu/msm_iommu.c  | 15 ++++++++++++++-
 drivers/iommu/tegra-gart.c | 19 +++++++++++++++++++
 drivers/iommu/tegra-smmu.c |  9 +++++++++
 4 files changed, 46 insertions(+), 16 deletions(-)

-- 
2.12.2.dirty
