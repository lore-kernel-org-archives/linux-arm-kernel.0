From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Wed, 27 Apr 2016 11:10:56 +0200
Subject: [GIT PULL 3/3] ARM: drivers: memory: SROM controller for v4.7
In-Reply-To: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
References: <1461748256-4394-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <1461748256-4394-4-git-send-email-k.kozlowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Finally, I hope the SROM controller can be split from mach-exynos into
drivers/memory. This is a very long standing patchset. The delay was
caused (twice) by very late comments, including comments for already
acked patch by the acker. Endless work... but I think entire feedback
was addressed (not ignored!).

This includes internal dependency: samsung-dt-exynos-srom-fixup-4.7.

Please, be so kind and pick it up.

Best regards,
Krzysztof


The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  kernel.org:/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-exynos-srom-4.7

for you to fetch changes up to 8ac2266d88318d348fa5f1dad5b525e0d2c665ef:

  memory: samsung: exynos-srom: Add support for bank configuration (2016-04-18 14:25:29 +0200)

----------------------------------------------------------------
Topic branch for Samsung soc/drivers update for v4.7:

This moves Samsung SROM controller code from arm/mach-exynos into to
separate driver under drivers/memory/samsung. In the future this driver
will be re-used on ARM64 Exynos platform.

----------------------------------------------------------------
Krzysztof Kozlowski (1):
      Merge tag 'samsung-dt-exynos-srom-fixup-4.7' into for-v4.7/drivers-memory-exynos-srom

Pankaj Dubey (5):
      ARM: dts: change SROM node compatible from generic to model specific
      dt-bindings: EXYNOS: Add exynos-srom device tree binding
      memory: Add support for Exynos SROM driver
      MAINTAINERS: Add maintainers entry for drivers/memory/samsung
      ARM: EXYNOS: Remove SROM related register settings from mach-exynos

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
