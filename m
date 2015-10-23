From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Oct 2015 06:26:27 +0900
Subject: [GIT PULL 4/5] Late Samsung driver updates for v4.4
In-Reply-To: <562AA40E.4050407@kernel.org>
References: <562AA40E.4050407@kernel.org>
Message-ID: <562AA603.7040600@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6ff33f3902c3b1c5d0db6b1e2c70b6d76fba357f:

  Linux 4.3-rc1 (2015-09-12 16:35:56 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
tags/samsung-driver

for you to fetch changes up to c612d5a7785b307df96938d590c3a1edfb624ccf:

  cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs (2015-10-24
04:34:50 +0900)

----------------------------------------------------------------
Samsung driver udpates for v4.4

- add support for exynos SROM controller DT based driver
  (drivers/soc/samsung/exynos-srom.c)
  : Since the exynos SROM registers are used during Suspend to RAM
    so the exynos SROM driver handles the S2R and then we can remove
    static mapping for SROM registers.
  : Pankaj tested boot and S2R functionality on Peach-Pi chromebook
  : Pavel tested on SMDK5410 board
  : Krzysztof tested on Trats2 (exynos4412) board
- update Maintainer entry accordingly
- remove superfluous CONFIG_PM ifdefs with Viresh's ack

----------------------------------------------------------------
Bartlomiej Zolnierkiewicz (1):
      cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs

Pankaj Dubey (8):
      ARM: EXYNOS: remove unused static mapping of CMU for exynos5
      ARM: EXYNOS: code cleanup in map.h
      dt-bindings: add exynos-srom device tree binding
      ARM: dts: add SROM device node for exynos4
      ARM: dts: add SROM device node for exynos5
      drivers: soc: add support for exynos SROM driver
      MAINTAINERS: add maintainers entry for drivers/soc/samsung
      ARM: EXYNOS: Remove SROM related register settings from mach-exynos

 .../bindings/arm/samsung/exynos-srom.txt           |  12 ++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/exynos4.dtsi                     |   5 +
 arch/arm/boot/dts/exynos5.dtsi                     |   5 +
 arch/arm/mach-exynos/Kconfig                       |   2 +
 arch/arm/mach-exynos/exynos.c                      |  22 ---
 arch/arm/mach-exynos/include/mach/map.h            |   8 -
 arch/arm/mach-exynos/regs-srom.h                   |  53 -------
 arch/arm/mach-exynos/suspend.c                     |  20 +--
 arch/arm/plat-samsung/include/plat/map-s5p.h       |   1 -
 drivers/cpufreq/s5pv210-cpufreq.c                  |   2 -
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/samsung/Kconfig                        |  13 ++
 drivers/soc/samsung/Makefile                       |   1 +
 drivers/soc/samsung/exynos-srom.c                  | 175
+++++++++++++++++++++
 drivers/soc/samsung/exynos-srom.h                  |  51 ++++++
 17 files changed, 269 insertions(+), 104 deletions(-)
 create mode 100644
Documentation/devicetree/bindings/arm/samsung/exynos-srom.txt
 delete mode 100644 arch/arm/mach-exynos/regs-srom.h
 create mode 100644 drivers/soc/samsung/Kconfig
 create mode 100644 drivers/soc/samsung/Makefile
 create mode 100644 drivers/soc/samsung/exynos-srom.c
 create mode 100644 drivers/soc/samsung/exynos-srom.h
