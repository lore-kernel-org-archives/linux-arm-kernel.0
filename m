From: robin.murphy@arm.com (Robin Murphy)
Date: Fri, 13 Oct 2017 19:23:38 +0100
Subject: [PATCH 0/4] ipmmu-vmsa cleanup
Message-ID: <cover.1507918320.git.robin.murphy@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd reports a build warning[1] thanks to me missing ipmmu-vmsa's second
set of ops when converting io-pgtable-arm users to the new iommu_iotlb_*
callbacks. Rather than just treat the symptom with a point fix, this
seemed like a good excuse to clean up the messy #ifdeffery and
duplication in the driver that led to the oversight in the first place.

Build-tested successfully for arm64, ARM, and ARM + CONFIG_IOMMU_DMA.

Robin.

[1]:https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1510423.html

Robin Murphy (4):
  iommu/ipmmu-vmsa: Unify domain alloc/free
  iommu/ipmmu-vmsa: Simplify group allocation
  iommu/ipmmu-vmsa: Clean up struct ipmmu_vmsa_iommu_priv
  iommu/ipmmu-vmsa: Unify ipmmu_ops

 drivers/iommu/ipmmu-vmsa.c | 251 ++++++++++++++-------------------------------
 1 file changed, 78 insertions(+), 173 deletions(-)

-- 
2.13.4.dirty
