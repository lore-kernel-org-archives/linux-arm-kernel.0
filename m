From: olof@lixom.net (Olof Johansson)
Date: Tue, 28 May 2013 17:56:11 -0700
Subject: [GIT PULL] ARM: Exynos fixes for 3.10-rc
Message-ID: <20130529005611.GA17319@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit f4ae176c626311d6507c9a2d263657c4cc4e1667:

  Merge tag 'sunxi-fixes-for-3.10' of git://github.com/mripard/linux into fixes (2013-05-24 15:50:28 -0700)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to da9d0fbf5e9aa47492a19588bd0efd18d6d172e0:

  ARM: exynos: defconfig update (2013-05-28 17:21:41 -0700)

----------------------------------------------------------------
ARM: Exynos fixes for 3.10-rc

Here's a shorter set of fixes for 3.10, all for Samsung Exynos platforms.

It also includes a defconfig update so that exynos_defconfig provides
a meaningful set of drivers to boot an unmodified kernel on the Samsung
ARM-based Chromebooks.

----------------------------------------------------------------
Jungseok Lee (1):
      ARM: EXYNOS: fix software reset logic for EXYNOS5440 SOC

Olof Johansson (2):
      Merge tag 'samsung-fixes-3' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      ARM: exynos: defconfig update

Tomasz Figa (2):
      ARM: EXYNOS: Fix support of Exynos4210 rev0 SoC
      ARM: SAMSUNG: Add names to fimd0 IRQ resources

Vivek Gautam (1):
      ARM: dts: Enabling samsung-usb2phy driver for exynos5250

 arch/arm/boot/dts/exynos5250.dtsi          | 15 +++++++++
 arch/arm/configs/exynos_defconfig          | 54 +++++++++++++++++++++++++-----
 arch/arm/mach-exynos/Kconfig               |  3 +-
 arch/arm/mach-exynos/common.c              | 39 +++++++++++++++++++--
 arch/arm/mach-exynos/common.h              |  2 ++
 arch/arm/mach-exynos/mach-universal_c210.c |  5 ++-
 arch/arm/plat-samsung/devs.c               |  6 ++--
 7 files changed, 107 insertions(+), 17 deletions(-)
