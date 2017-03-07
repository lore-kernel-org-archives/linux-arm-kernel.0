From: robin.murphy@arm.com (Robin Murphy)
Date: Tue,  7 Mar 2017 18:09:03 +0000
Subject: [PATCH 0/4] ARM SMMU per-context TLB sync
Message-ID: <cover.1488907474.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The discussion around context-level access for Qualcomm SMMUs reminded
me to dig up this patch I started ages ago and finish it off. As it's
ended up, it's now a mini-series, with some new preparatory cleanup
manifesting as patches 2 and 3. Patch 1 is broken out of patch 3 for
clarity as somewhat of a fix in its own right, in that it's really an
entirely unrelated thing which came up in parallel, but happens to
be inherent to code I'm touching here anyway.

Robin.

Robin Murphy (4):
  iommu/arm-smmu: Handle size mismatches better
  iommu/arm-smmu: Simplify ASID/VMID handling
  iommu/arm-smmu: Tidy up context bank indexing
  iommu/arm-smmu: Use per-context TLB sync as appropriate

 drivers/iommu/arm-smmu.c | 207 +++++++++++++++++++++++++++++------------------
 1 file changed, 127 insertions(+), 80 deletions(-)

-- 
2.11.0.dirty
