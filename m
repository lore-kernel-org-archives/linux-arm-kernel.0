From: robherring2@gmail.com (Rob Herring)
Date: Mon, 13 Aug 2012 22:49:03 -0500
Subject: [PATCH 0/4] Per device coherent DMA map ops
Message-ID: <1344916147-13546-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

This is series adds coherent DMA map operations which can be set per device.
Expanding on the first RFC[1], this version adds iommu ops and implements
support on highbank platform.

arch_is_coherent is never defined true since removing ixp2xxx, so we can 
remove it altogether.

Rob

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2012-August/113921.html

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
 arch/arm/mm/dma-mapping.c                          |  254 ++++++++++++++++----
 arch/arm/mm/mmu.c                                  |   17 +-
 10 files changed, 271 insertions(+), 78 deletions(-)

-- 
1.7.9.5
