From: robin.murphy@arm.com (Robin Murphy)
Date: Tue, 26 Jan 2016 18:06:33 +0000
Subject: [PATCH 0/4] Miscellaneous ARM SMMU patches
Message-ID: <cover.1453830752.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Here's my current "miscellaneous SMMU enhancements" branch for your
consideration. Patch #1 solves a subtle corner case that cropped up
while exercising stage 1 context formats on the DMA330-MMU500 model;
#3 will be wanted fairly soon for DMA ops integration so may as well
get some exposure now; #2 and #4 are more nice-to-haves.

Thanks,
Robin.

Robin Murphy (4):
  iommu/arm-smmu: Treat all device transactions as unprivileged
  iommu/arm-smmu: Allow disabling unmatched stream bypass
  iommu/arm-smmu: Support DMA-API domains
  iommu/arm-smmu: Use per-context TLB sync as appropriate

 drivers/iommu/arm-smmu-v3.c | 10 +++++-
 drivers/iommu/arm-smmu.c    | 79 ++++++++++++++++++++++++++++++++++-----------
 2 files changed, 69 insertions(+), 20 deletions(-)

-- 
2.7.0.25.gfc10eb5.dirty
