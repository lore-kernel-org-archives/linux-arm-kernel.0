From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Oct 2015 22:42:45 +0200
Subject: [GIT PULL] ARM: SoC fixes for 4.3-rc
Message-ID: <5461212.DGcpxjZtNj@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 9ffecb10283508260936b96022d4ee43a7798b4c:

  Linux 4.3-rc3 (2015-09-27 07:50:08 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 5a37b15378659168e1874463ab012f26dcbaf309:

  Merge tag 'renesas-fixes-for-v4.3' of git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas into fixes (2015-10-06 14:31:53 +0200)

----------------------------------------------------------------
ARM: SoC fixes for 4.3-rc

The fixes for this week include one small patch that was years in the
making and that finally fixes using all eight CPUs on exynos542x.

The rest are lots of minor changes for sunxi, imx, exynos and shmobile

* fixing the minimum voltage for Allwinner A20
* thermal boot issue on SMDK5250.
* invalid clock used for FIMD IOMMU.
* audio on Renesas r8a7790/r8a7791
* invalid clock used for FIMD IOMMU
* LEDs on exynos5422-odroidxu3-common
* usb pin control for imx-rex
* imx53: fix PMIC interrupt level
* a Makefile typo

----------------------------------------------------------------
Arnd Bergmann (3):
      Merge tag 'samsung-fixes' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'sunxi-fixes-for-4.3' of https://git.kernel.org/.../mripard/linux into fixes
      Merge tag 'renesas-fixes-for-v4.3' of git://git.kernel.org/.../horms/renesas into fixes

Bartlomiej Zolnierkiewicz (1):
      ARM: dts: add suspend opp to exynos4412

Chanho Park (1):
      ARM: EXYNOS: reset Little cores when cpu is up

Felipe F. Tonello (1):
      ARM: dts: fix usb pin control for imx-rex dts

Geert Uytterhoeven (2):
      ARM: shmobile: r8a7790 dtsi: Add CPG/MSTP Clock Domain for sound
      ARM: shmobile: r8a7791 dtsi: Add CPG/MSTP Clock Domain for sound

Joonyoung Shim (1):
      ARM: dts: Fix wrong clock binding for sysmmu_fimd1_1 on exynos5420

Josh Boyer (1):
      ARM: dts: Fix Makefile target for sun4i-a10-itead-iteaduino-plus

Krzysztof Kozlowski (1):
      ARM: dts: Fix LEDs on exynos5422-odroidxu3

Kukjin Kim (1):
      Merge tag 'samsung-fixes-4.3' of http://github.com/krzk/linux into v4.3-samsung-fixes

Lucas Stach (2):
      ARM: imx53: include IRQ dt-bindings header
      ARM: imx53: qsrb: fix PMIC interrupt level

Olof Johansson (1):
      Merge tag 'imx-fixes-4.3' of git://git.kernel.org/.../shawnguo/linux into fixes

Suzuki K. Poulose (1):
      arm-cci500: Don't enable PMU driver by default

Timo Sigurdsson (1):
      ARM: dts: sunxi: Raise minimum CPU voltage for sun7i-a20 to meet SoC specifications

Yadwinder Singh Brar (1):
      ARM: dts: Fix bootup thermal issue on smdk5250

 arch/arm/boot/dts/Makefile                         |  2 +-
 arch/arm/boot/dts/exynos4412.dtsi                  |  1 +
 arch/arm/boot/dts/exynos5250-smdk5250.dts          |  1 +
 arch/arm/boot/dts/exynos5420.dtsi                  |  2 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  1 -
 arch/arm/boot/dts/imx53-qsrb.dts                   |  2 +-
 arch/arm/boot/dts/imx53.dtsi                       |  1 +
 arch/arm/boot/dts/imx6qdl-rex.dtsi                 |  2 --
 arch/arm/boot/dts/r8a7790.dtsi                     |  1 +
 arch/arm/boot/dts/r8a7791.dtsi                     |  1 +
 arch/arm/boot/dts/sun7i-a20.dtsi                   |  2 +-
 arch/arm/mach-exynos/mcpm-exynos.c                 | 27 +++++++++++++++++++++-
 arch/arm/mach-exynos/regs-pmu.h                    |  6 +++++
 drivers/bus/Kconfig                                |  1 -
 14 files changed, 41 insertions(+), 9 deletions(-)
