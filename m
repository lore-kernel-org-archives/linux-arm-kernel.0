From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Sat, 27 Feb 2016 21:38:58 +0100
Subject: [GIT PULL] pxa for v4.6
Message-ID: <87egbxriql.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd, Kevin and Olof,

This is the pxa pull request for 4.6 cycle. Could you please consider pulling ?

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  https://github.com/rjarzmik/linux.git tags/pxa-for-4.6

for you to fetch changes up to 6bab1c6afdca0371cfa957079b36b78d12dd2cf5:

  dmaengine: pxa_dma: fix the maximum requestor line (2016-02-26 22:57:45 +0100)

----------------------------------------------------------------
This is the pxa changes for v4.6 cycle.

This is a minor cycle with :
 - cleanup fixes from Arnd, mainly build oriented and sparse type ones
 - dma fixes for requestors above 32 (impacting mainly camera driver)
 - some minor cleanup on pxa3xx device-tree side

----------------------------------------------------------------
Arnd Bergmann (8):
      ARM: pxa: define clock registers as __iomem
      ARM: pxa: mark spitz_card_pwr_ctrl as __maybe_unused
      ARM: pxa: mark unused eseries code as __maybe_unused
      ARM: pxa: don't select GPIO_SYSFS for MIOA701
      ARM: pxa: always select one of the two CPU types
      ARM: pxa: move extern declarations to pm.h
      ARM: pxa: fix building without IWMMXT
      ARM: pxa: don't select RFKILL if CONFIG_NET is disabled

Robert Jarzmik (5):
      ARM: pxa: pxa3xx device-tree support cleanup
      dma: mmp_pdma: Add the #dma-requests DT property documentation
      dmaengine: mmp-pdma: add number of requestors
      ARM: pxa: add the number of DMA requestor lines
      dmaengine: pxa_dma: fix the maximum requestor line

 Documentation/devicetree/bindings/dma/mmp-dma.txt |  2 ++
 arch/arm/Kconfig                                  |  1 +
 arch/arm/boot/dts/pxa27x.dtsi                     |  1 +
 arch/arm/boot/dts/pxa3xx.dtsi                     |  1 +
 arch/arm/configs/pxa_defconfig                    |  1 +
 arch/arm/mach-pxa/Kconfig                         |  3 +-
 arch/arm/mach-pxa/devices.c                       |  3 +-
 arch/arm/mach-pxa/eseries.c                       |  4 +--
 arch/arm/mach-pxa/gumstix.c                       |  6 ++--
 arch/arm/mach-pxa/include/mach/pxa2xx-regs.h      |  8 ++---
 arch/arm/mach-pxa/include/mach/pxa3xx-regs.h      |  2 +-
 arch/arm/mach-pxa/pm.h                            |  3 ++
 arch/arm/mach-pxa/pxa-dt.c                        | 24 --------------
 arch/arm/mach-pxa/pxa25x.c                        |  2 +-
 arch/arm/mach-pxa/pxa27x.c                        |  8 +++--
 arch/arm/mach-pxa/pxa3xx.c                        | 11 +++----
 arch/arm/mach-pxa/spitz.c                         |  2 +-
 arch/arm/mach-pxa/zeus.c                          |  2 +-
 arch/arm/plat-pxa/include/plat/dma.h              |  2 +-
 drivers/clk/pxa/clk-pxa25x.c                      | 12 +++----
 drivers/clk/pxa/clk-pxa27x.c                      | 34 ++++++++++----------
 drivers/clk/pxa/clk-pxa3xx.c                      |  3 +-
 drivers/cpufreq/pxa2xx-cpufreq.c                  |  2 +-
 drivers/dma/pxa_dma.c                             | 39 ++++++++++++++++-------
 include/linux/platform_data/mmp_dma.h             |  1 +
 25 files changed, 90 insertions(+), 87 deletions(-)

Cheers.

-- 
Robert
