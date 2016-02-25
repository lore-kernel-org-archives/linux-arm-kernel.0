From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 25 Feb 2016 14:03:36 +0530
Subject: [RESPIN 0/6] Add support for Exynos SROM Controller driver.
Message-ID: <1456389222-12738-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series is collection of patches already reviewed and merged in
maintainer's tree, but could not make it thorugh main linus tree, due
to last moment suggestion of proper location of driver should be
"drivers/memory" instead of "drivers/soc". I have rebased all the patches
and moved into "drivers/memory/samsung".

As this is just a movement without changing actual driver code,
I have not removed "Reviewed-By", "Tested-By" or "Acked-By".

To make sure everything is fine, I have again tested it on Exynos5880 based
Chromebook for normal boot, S2R functionality and its working fine.

This series has been prepared on top of next-soc branch of Krzysztof's tree.

Changes w.r.t. original merged patches:
 - Moved exynos-srom driver into "drivers/memory/samsung"
 - Moved DT binding documentation into "bindings/memory-controller"
 - Added new patch for entry of new directory in MAINTAINERS file.
 - Added new CONFIG as SAMSUNG_MC for grouping Samsung's memory controller drivers.
 - Added my Signed-off-by for patch 5/6 and 6/6 for touching it.

Pankaj Dubey (4):
  dt-bindings: EXYNOS: Add exynos-srom device tree binding
  drivers: memory: Add support for exynos SROM driver
  MAINTAINERS: Add maintainers entry for drivers/memory/samsung
  ARM: EXYNOS: Remove SROM related register settings from mach-exynos

Pavel Fedin (2):
  dt-bindings: EXYNOS: Describe SROMc configuration
  drivers: memory: exynos-srom: Add support for bank configuration

 .../bindings/memory-controllers/exynos-srom.txt    |  81 +++++++
 MAINTAINERS                                        |   1 +
 arch/arm/mach-exynos/Kconfig                       |   2 +
 arch/arm/mach-exynos/exynos.c                      |  17 --
 arch/arm/mach-exynos/include/mach/map.h            |   3 -
 arch/arm/mach-exynos/regs-srom.h                   |  53 -----
 arch/arm/mach-exynos/suspend.c                     |  20 +-
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
 drivers/memory/Kconfig                             |   1 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/samsung/Kconfig                     |  12 ++
 drivers/memory/samsung/Makefile                    |   1 +
 drivers/memory/samsung/exynos-srom.c               | 232 +++++++++++++++++++++
 drivers/memory/samsung/exynos-srom.h               |  51 +++++
 14 files changed, 384 insertions(+), 92 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 create mode 100644 drivers/memory/samsung/Kconfig
 create mode 100644 drivers/memory/samsung/Makefile
 create mode 100644 drivers/memory/samsung/exynos-srom.c
 create mode 100644 drivers/memory/samsung/exynos-srom.h

-- 
2.4.5
