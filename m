From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Tue, 02 Oct 2012 10:18:46 +0200
Subject: [GIT PULL] CMA and DMA-mapping updates for v3.7
Message-ID: <1349165926-12097-1-git-send-email-m.szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

I would like to ask for pulling another set of CMA and DMA-mapping framework
updates for v3.7.

The following changes since commit a0d271cbfed1dd50278c6b06bead3d00ba0a88f9:

  Linux 3.6 (2012-09-30 16:47:46 -0700)

are available in the git repository at:

  git://git.linaro.org/people/mszyprowski/linux-dma-mapping.git for-v3.7

for you to fetch changes up to 461b6f0d3d7d4e556035463b531136b034b7433e:

  Merge branch 'next-cleanup' into for-v3.7 (2012-10-02 09:24:24 +0200)

----------------------------------------------------------------

This time the pull request is rather small, because the further redesign
patches were not ready on time.

This pull request consists of the patches which extend ARM DMA-mapping
subsystem with support for CPU coherent (ACP) DMA busses. The first
client of the new version is HighBank SATA driver. The second part of
the pull request includes various cleanup for both CMA common code and
ARM DMA-mapping subsystem.

Thanks!

Best regards
Marek Szyprowski
Samsung Poland R&D Center


Patch summary:

Hiroshi Doyu (3):
      ARM: dma-mapping: Small logical clean up
      ARM: dma-mapping: Refrain noisy console message
      ARM: dma-mapping: Remove unsed var at arm_coherent_iommu_unmap_page

Marek Szyprowski (1):
      Merge branch 'next-cleanup' into for-v3.7

Michal Nazarewicz (1):
      drivers: dma-contiguous: refactor dma_alloc_from_contiguous()

Rob Herring (4):
      ARM: add coherent dma ops
      ARM: add coherent iommu dma ops
      ARM: kill off arch_is_coherent
      ARM: highbank: add coherent DMA setup

 .../devicetree/bindings/ata/ahci-platform.txt      |    3 +
 .../devicetree/bindings/dma/arm-pl330.txt          |    3 +
 .../devicetree/bindings/net/calxeda-xgmac.txt      |    3 +
 arch/arm/boot/dts/highbank.dts                     |    1 +
 arch/arm/include/asm/barrier.h                     |    7 +-
 arch/arm/include/asm/dma-mapping.h                 |    1 +
 arch/arm/include/asm/memory.h                      |    8 -
 arch/arm/mach-highbank/highbank.c                  |   52 ++++
 arch/arm/mm/dma-mapping.c                          |  264 +++++++++++++++-----
 arch/arm/mm/mmu.c                                  |   17 +-
 drivers/base/dma-contiguous.c                      |   18 +-
 11 files changed, 283 insertions(+), 94 deletions(-)
