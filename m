From: robin.murphy@arm.com (Robin Murphy)
Date: Thu, 16 Mar 2017 17:00:15 +0000
Subject: [PATCH v2 0/4] IOMMU reserved region tweaks
Message-ID: <cover.1489683129.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Here's v2 incorporating Eric's feedback and R-b tags, with patch #4 added
to finish the job. Whilst presented as a logical series because it's all
touching the same code, it doesn't necessarily need merging as such - I'd
be happier with patch #1 going into 4.11 before anyone starts using the
sysfs region info in anger, but it's your call; #2 is really a standalone
fix (other than context conflicts) but is non-urgent; #3 and #4 can
happily wait for 4.12.

Robin.

Robin Murphy (4):
  iommu: Disambiguate MSI region types
  iommu/dma: Don't reserve PCI I/O windows
  iommu/dma: Handle IOMMU API reserved regions
  iommu/dma: Make PCI window reservation generic

 drivers/iommu/amd_iommu.c       |   2 +-
 drivers/iommu/arm-smmu-v3.c     |   4 +-
 drivers/iommu/arm-smmu.c        |   4 +-
 drivers/iommu/dma-iommu.c       | 111 ++++++++++++++++++++++++++++++++++------
 drivers/iommu/intel-iommu.c     |   2 +-
 drivers/iommu/iommu.c           |   5 +-
 drivers/vfio/vfio_iommu_type1.c |   7 ++-
 include/linux/dma-iommu.h       |   5 ++
 include/linux/iommu.h           |  18 +++++--
 9 files changed, 127 insertions(+), 31 deletions(-)

-- 
2.11.0.dirty
