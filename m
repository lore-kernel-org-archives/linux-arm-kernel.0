From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Sep 2011 23:21:30 +0200
Subject: [GIT PULL] arm-soc fixes for v3.1-rc7
Message-ID: <201109202321.30320.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here are the latest bug fixes for integration into 3.1. It's mostly
samsung stuff, which was missing in the last round, plus three
small regression fixes in other platforms. 

Please pull for the next -rc.

Thanks,

	Arnd

The following changes since commit b6fd41e29dea9c6753b1843a77e50433e6123bcb:

  Linux 3.1-rc6 (2011-09-12 14:02:02 -0700)

are available in the git repository at:
  git://git.linaro.org/people/arnd/arm-soc.git fixes

Arnd Bergmann (1):
      Merge branch 'samsung-fixes-2' of git://github.com/kgene/linux-samsung into HEAD

Banajit Goswami (1):
      ARM: S3C64XX: Remove un-used code backlight code on SMDK6410

Changhwan Youn (1):
      ARM: EXYNOS4: restart clocksource while system resumes

Jonghwan Choi (1):
      ARM: EXYNOS4: Fix wrong pll type for vpll

Kukjin Kim (3):
      ARM: EXYNOS4: Fix return type of local_timer_setup()
      ARM: EXYNOS4: Fix routing timer interrupt to offline CPU
      ARM: SAMSUNG: fix to prevent declaring duplicated

Linus Walleij (1):
      mach-integrator: fix VGA base regression

Marek Szyprowski (1):
      ARM: SAMSUNG: fix watchdog reset issue with clk_get()

Nicolas Pitre (1):
      ARM: Dove: fix second SPI initialization call

Stephen Warren (1):
      arm/dt: Tegra: Update SDHCI nodes to match bindings

Thomas Abraham (1):
      ARM: EXYNOS4: fix incorrect pad configuration for keypad row lines

 arch/arm/boot/dts/tegra-harmony.dts                |   12 +++---
 arch/arm/boot/dts/tegra-seaboard.dts               |    6 ++--
 arch/arm/mach-dove/common.c                        |    2 +-
 arch/arm/mach-exynos4/clock.c                      |    2 +-
 arch/arm/mach-exynos4/mct.c                        |   10 +++++-
 arch/arm/mach-exynos4/platsmp.c                    |    2 +
 arch/arm/mach-exynos4/setup-keypad.c               |   11 +++---
 arch/arm/mach-integrator/integrator_ap.c           |    2 +
 arch/arm/mach-integrator/pci_v3.c                  |    2 -
 arch/arm/mach-s3c64xx/mach-smdk6410.c              |   39 --------------------
 arch/arm/plat-samsung/clock.c                      |   11 ++++++
 arch/arm/plat-samsung/include/plat/clock.h         |    8 ++++
 .../arm/plat-samsung/include/plat/watchdog-reset.h |   10 ++----
 13 files changed, 52 insertions(+), 65 deletions(-)
