From: hdoyu@nvidia.com (Hiroshi DOYU)
Date: Fri, 18 May 2012 09:10:25 +0300
Subject: [RFC 0/2] dma-mapping: Introduce new IOVA API with address specified
Message-ID: <1337321427-27748-1-git-send-email-hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The following patchset is our enhancement for the upstream DMA mapping
API(v9), where new IOVA API is introduced with the version of IOVA
address specified. The current upstream DMA mapping API cannot specify
any specific IOVA address at allocation. We need to specify IOVA
address. This is necessary because some HWAs requre some specific
address, for example,  AVP vector and also some data buffer alignement
can improve better performance from H/W constraints POV.

Hiroshi DOYU (2):
  dma-mapping: Export arm_iommu_{alloc,free}_iova() functions
  dma-mapping: Enable IOVA mapping with specific address

 arch/arm/include/asm/dma-iommu.h   |   31 ++++++
 arch/arm/include/asm/dma-mapping.h |    1 +
 arch/arm/mm/dma-mapping.c          |  181 +++++++++++++++++++++++++++++-------
 3 files changed, 180 insertions(+), 33 deletions(-)

-- 
1.7.5.4
