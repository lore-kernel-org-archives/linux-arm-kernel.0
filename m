From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 29 Oct 2012 10:59:52 +0100
Subject: [PATCH 0/4] DMA: PL330 fixes
Message-ID: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The first patch fixes lockup caused by pl330 driver.  It doesn't add
any dependencies to later patches and can be applied independently.

The second patch fixes PL330 regression on ARM Exynos 4210 revision 0
SOC (used by Universal C210 board).

The third patch adds PL330 MDMA1 controller node to device tree on
ARM Exynos4 SOCs.

The fourth patch adds device tree property for PL330 driver to be used
by controllers that have DMA_MEMCPY capability and updates device tree
files for ARM platforms using PL330.  Since this patch depends on
patches #2-3 it would be probably best to also push it through Kukjin's
tree (with the relevant ACKs added of course).


Bartlomiej Zolnierkiewicz (4):
  DMA: PL330: fix locking in pl330_free_chan_resources()
  ARM: EXYNOS: PL330 MDMA1 fix for revision 0 of Exynos4210 SOC
  ARM: dts: exynos4: add node for PL330 MDMA1 controller
  DMA: PL330: add device tree property for DMA_MEMCPY capability

 Documentation/devicetree/bindings/dma/arm-pl330.txt |  1 +
 arch/arm/boot/dts/exynos4.dtsi                      |  7 +++++++
 arch/arm/boot/dts/exynos5250.dtsi                   |  2 ++
 arch/arm/boot/dts/highbank.dts                      |  1 +
 arch/arm/boot/dts/socfpga.dtsi                      |  1 +
 arch/arm/boot/dts/vexpress-v2p-ca15-tc1.dts         |  1 +
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts          |  1 +
 arch/arm/mach-exynos/dma.c                          |  5 ++++-
 arch/arm/mach-exynos/include/mach/map.h             |  3 ++-
 arch/arm/mach-exynos/mach-exynos4-dt.c              |  1 +
 drivers/dma/pl330.c                                 | 15 ++++++++++-----
 11 files changed, 31 insertions(+), 7 deletions(-)

-- 
1.8.0
