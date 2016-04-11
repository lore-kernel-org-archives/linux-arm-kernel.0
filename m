From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Mon, 11 Apr 2016 13:12:22 +0530
Subject: [RESPIN v2 0/6] Add support for Exynos SROM Controller driver
Message-ID: <1460360548-32127-1-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is second attemp for making in this series. This is a collection of patches
already reviewed and merged in maintainer's tree, but could not make it thorugh main linus tree,
due to last moment suggestion of proper location of driver should be
"drivers/memory" instead of "drivers/soc". I have rebased all the patches
and moved into "drivers/memory/samsung". Second time due to some suggestions in binding document.

As this is just a movement without changing actual driver code,
I have not removed "Reviewed-By", "Tested-By" or "Acked-By".

To make sure everything is fine, I have again tested it on Exynos5880 based
Chromebook for normal boot, S2R functionality and its working fine.

This series has been prepared on top of next-soc branch of Krzysztof's tree.

Changes since RESPIN-v1:
 - Addressed review comments in srom binding documentation mainly from Rob Herring.
 - Modified compatibility from "samsung, exynos-srom" to "samsung, exynos4210-srom"
 - Changed type of optional property "samsung,srom-page-mode" from int to bool
 - Adjusted exynos-srom driver code for reflecting change in type of above property.
 - Renamed exynos SROM dt node as "memory-controller" instead of "sromc".


Pankaj Dubey (5):
  dt-bindings: EXYNOS: Add exynos-srom device tree binding
  memory: Add support for Exynos SROM driver
  MAINTAINERS: Add maintainers entry for drivers/memory/samsung
  ARM: EXYNOS: Remove SROM related register settings from mach-exynos
  ARM: dts: change SROM node compatible from generic to model specific

Pavel Fedin (1):
  memory: samsung: exynos-srom: Add support for bank configuration

 .../bindings/memory-controllers/exynos-srom.txt    |  79 +++++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   4 +-
 arch/arm/boot/dts/exynos5.dtsi                     |   4 +-
 arch/arm/boot/dts/exynos5410-smdk5410.dts          |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   4 +-
 arch/arm/mach-exynos/Kconfig                       |   3 +
 arch/arm/mach-exynos/exynos.c                      |  17 --
 arch/arm/mach-exynos/include/mach/map.h            |   3 -
 arch/arm/mach-exynos/regs-srom.h                   |  53 -----
 arch/arm/mach-exynos/suspend.c                     |  20 +-
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
 drivers/memory/Kconfig                             |   1 +
 drivers/memory/Makefile                            |   1 +
 drivers/memory/samsung/Kconfig                     |  13 ++
 drivers/memory/samsung/Makefile                    |   1 +
 drivers/memory/samsung/exynos-srom.c               | 231 +++++++++++++++++++++
 drivers/memory/samsung/exynos-srom.h               |  51 +++++
 18 files changed, 390 insertions(+), 99 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/exynos-srom.txt
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 create mode 100644 drivers/memory/samsung/Kconfig
 create mode 100644 drivers/memory/samsung/Makefile
 create mode 100644 drivers/memory/samsung/exynos-srom.c
 create mode 100644 drivers/memory/samsung/exynos-srom.h

-- 
2.4.5
