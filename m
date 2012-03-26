From: robherring2@gmail.com (Rob Herring)
Date: Sun, 25 Mar 2012 20:36:44 -0500
Subject: [GIT PULL] pxa io.h clean-up fixes
Message-ID: <4F6FC82C.2040303@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof,

Here's a couple more fixes for pxa from mach/io.h cleanup. This is based
on my previous pull request.

This still doesn't get pxa completely working on my branch. I had to add
commit e23e8c0690d (ARM/PCI: Remove ARM's duplicate definition of
'pcibios_max_latency') to get my tree building for pxa. This commit is
already in final 3.3.

There's some new breakage when I merged the current next in and built
with Russell's pxa test config. The failures are due to struct device
removal in this commit:

commit 737f360d5bef5e01c6cfa755dca0b449a154c1e0
Author: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date:   Thu Feb 2 00:10:51 2012 +0000

    regulator: Remove support for supplies specified by struct device

    This has been deprecated for a very long time now.

    Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
    Acked-by: Liam Girdwood <lrg@ti.com>

Rob

The following changes since commit a2a47ca36642e3995e982957bc42678cf11ca6ac:

  ARM: __io abuse cleanup (2012-03-13 21:25:21 -0500)

are available in the git repository at:
  git://sources.calxeda.com/kernel/linux.git io-cleanup-for-3.4

Rob Herring (2):
      ARM: dma-mapping: convert ARCH_HAS_DMA_SET_COHERENT_MASK to
kconfig symbol
      ARM: pxa: use common IOMEM definition

 arch/arm/Kconfig                             |    4 ++++
 arch/arm/mach-ixp4xx/include/mach/hardware.h |    2 --
 arch/arm/mach-pxa/Kconfig                    |    1 +
 arch/arm/mach-pxa/clock-pxa2xx.c             |    1 +
 arch/arm/mach-pxa/corgi_pm.c                 |    1 +
 arch/arm/mach-pxa/cpufreq-pxa3xx.c           |    1 +
 arch/arm/mach-pxa/include/mach/hardware.h    |    6 ------
 arch/arm/mach-pxa/mfp-pxa2xx.c               |    1 +
 arch/arm/mach-pxa/pxa2xx.c                   |    1 +
 arch/arm/mach-pxa/pxa300.c                   |    1 +
 arch/arm/mach-pxa/pxa320.c                   |    1 +
 arch/arm/mach-pxa/sharpsl_pm.c               |    1 +
 drivers/rtc/rtc-sa1100.c                     |    1 +
 drivers/watchdog/sa1100_wdt.c                |    1 +
 include/linux/dma-mapping.h                  |    2 +-
 sound/arm/pxa2xx-ac97-lib.c                  |    1 +
 sound/arm/pxa2xx-ac97.c                      |    1 +
 sound/soc/pxa/pxa2xx-ac97.c                  |    1 +
 18 files changed, 19 insertions(+), 9 deletions(-)
