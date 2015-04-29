From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Wed, 29 Apr 2015 14:08:27 +0530
Subject: [PATCH 0/5] Add support for Exynos SROM Controller driver
Message-ID: <1430296712-10287-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch set adds support for Exynos SROM controller DT based driver.
Currently SROM register sets are used only during S2R, so driver
basically added for taking care of S2R. It will help us in removing
static mapping from exynos.c and other extra code handline during S2R.

This patch set also updated exynos4 and exynos5 dtsi files for with device
node for srom, and added binding documentation for the same.

Pankaj Dubey (5):
  drivers: soc: add support for exynos SROM driver
  ARM: EXYNOS: Remove SROM related register settings from mach-exynos
  ARM: EXYNOS: DTS: add SROM device node for exynos4
  ARM: EXYNOS: DTS: add SROM device node for exynos5
  Documentation: dt-bindings: add exynos-srom binding information

 .../bindings/arm/samsung/exynos-srom.txt           |  12 ++
 arch/arm/boot/dts/exynos4.dtsi                     |   5 +
 arch/arm/boot/dts/exynos5.dtsi                     |   5 +
 arch/arm/mach-exynos/Kconfig                       |   2 +
 arch/arm/mach-exynos/exynos.c                      |  10 --
 arch/arm/mach-exynos/include/mach/map.h            |   3 -
 arch/arm/mach-exynos/suspend.c                     |  20 +--
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
 arch/arm/plat-samsung/include/plat/regs-srom.h     |  54 --------
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/samsung/Kconfig                        |  14 ++
 drivers/soc/samsung/Makefile                       |   1 +
 drivers/soc/samsung/exynos-srom.c                  | 142 +++++++++++++++++++++
 drivers/soc/samsung/exynos-srom.h                  |  51 ++++++++
 15 files changed, 236 insertions(+), 86 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
 delete mode 100644 arch/arm/plat-samsung/include/plat/regs-srom.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-srom.c
 create mode 100644 drivers/soc/samsung/exynos-srom.h

-- 
2.2.0
