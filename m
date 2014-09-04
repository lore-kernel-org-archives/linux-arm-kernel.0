From: will.deacon@arm.com (Will Deacon)
Date: Thu,  4 Sep 2014 17:49:58 +0100
Subject: [PATCH 0/7] iommu/arm-smmu: misc. driver updates targetting 3.18
Message-ID: <1409849405-17347-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This series is a collection of ARM SMMU updates I have in my tree that
I'd like to get merged for 3.18. This has mostly come out of the vSMMU
work (which is still some way off, as proper testing is proving to be
difficult), but Robin has also added minimal support for MMU-401.

There are a couple of other things on my radar (fixing our reporting of
IOMMU_CAP_CACHE_COHERENCY and wiring up iommu_group_get_for_dev), but
they needn't block sending this series out for review.

Feedback welcome,

Will

--->8

Robin Murphy (2):
  iommu/arm-smmu: fix architecture version detection
  iommu/arm-smmu: support MMU-401

Will Deacon (5):
  iommu/arm-smmu: allow translation stage to be forced on the cmdline
  iommu/arm-smmu: add support for multi-master iommu groups
  iommu/arm-smmu: put iommu_domain pointer in dev->archdata.iommu
  iommu/arm-smmu: use page shift instead of page size to avoid division
  iommu/arm-smmu: don't bother truncating the s1 output size to VA_BITS

 .../devicetree/bindings/iommu/arm,smmu.txt         |   1 +
 drivers/iommu/arm-smmu.c                           | 197 ++++++++++++---------
 2 files changed, 115 insertions(+), 83 deletions(-)

-- 
2.1.0
