From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Oct 2017 15:04:25 +0100
Subject: [PATCH v3 0/3] SMMUv3 CMD_SYNC optimisation
Message-ID: <cover.1508334262.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a quick v3 to address enough comments to move the cons-polling
discussion forward, at least ;)

Since the preparatory two patches are now queued I'm not reposting them
here.

Robin.


Robin Murphy (3):
  iommu/arm-smmu-v3: Use CMD_SYNC completion MSI
  iommu/arm-smmu-v3: Poll for CMD_SYNC outside cmdq lock
  iommu/arm-smmu-v3: Use burst-polling for sync completion

 drivers/iommu/arm-smmu-v3.c | 142 +++++++++++++++++++++++++++++++++++++-------
 1 file changed, 119 insertions(+), 23 deletions(-)

-- 
2.13.4.dirty
