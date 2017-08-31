From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 31 Aug 2017 14:44:24 +0100
Subject: [PATCH v2 0/4] SMMUv3 CMD_SYNC optimisation
Message-ID: <cover.1504182142.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Since Nate reported a reasonable performance boost from the out-of-line
MSI polling in v1 [1], I've now implemented the equivalent for cons
polling as well - that has been boot-tested on D05 with some trivial I/O
and at least doesn't seem to lock up or explode. There's also a little
cosmetic tweaking to make the patches a bit cleaner as a series.

Robin.

[1] https://www.mail-archive.com/iommu at lists.linux-foundation.org/msg19657.html

Robin Murphy (5):
  iommu/arm-smmu-v3: Specialise CMD_SYNC handling
  iommu/arm-smmu-v3: Forget about cmdq-sync interrupt
  iommu/arm-smmu-v3: Use CMD_SYNC completion interrupt
  iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
  iommu/arm-smmu-v3: Use burst-polling for sync completion

 drivers/iommu/arm-smmu-v3.c | 194 ++++++++++++++++++++++++++++++--------------
 1 file changed, 135 insertions(+), 59 deletions(-)

-- 
2.13.4.dirty
