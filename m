From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 19 Dec 2012 10:27:20 -0800
Subject: [GIT PULL 1/2] Samsung fixes-1 for v3.8-rc1
Message-ID: <008401cdde16$7cfe2690$76fa73b0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof

Here is Samsung fixes-1 for v3.8-rc1.
Most of them are trivial fixes which are for NULL pointer dereference, MSHC
clocks instance names and exynos5440 stuff.

Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.8-samsung-fixes-1

If any problems, please kindly let me know.

Thanks.

Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

The following changes since commit 752451f01c4567b506bf4343082682dbb8fb30dd:

  Merge branch 'i2c-embedded/for-next' of
git://git.pengutronix.de/git/wsa/linux (2012-12-18 16:51:10 -0800)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
v3.8-samsung-fixes-1

for you to fetch changes up to 454696fdc864aacaab978755d44d73d418c59788:

  ARM: EXYNOS: Fix MSHC clocks instance names (2012-12-19 09:25:27 -0800)

----------------------------------------------------------------
Axel Lin (1):
      pinctrl: exynos5440/samsung: Staticize pcfgs

Dongjin Kim (1):
      ARM: EXYNOS: Fix MSHC clocks instance names

Kukjin Kim (3):
      ARM: EXYNOS: fix build error when MFC is not selected
      ARM: EXYNOS: fix GIC using for EXYNOS5440
      ARM: EXYNOS: fix skip scu_enable() for EXYNOS5440

Michael Spang (1):
      ARM: SAMSUNG: Add missing include guard to gpio-core.h

Sachin Kamat (4):
      pinctrl: samsung: Fix a typo in pinctrl-samsung.h
      ARM: EXYNOS: Fix NULL pointer dereference bug in Origen
      ARM: EXYNOS: Fix NULL pointer dereference bug in SMDK4X12
      ARM: EXYNOS: Fix NULL pointer dereference bug in SMDKV310

 arch/arm/mach-exynos/clock-exynos4.c           |    4 ++--
 arch/arm/mach-exynos/common.c                  |    3 ++-
 arch/arm/mach-exynos/mach-exynos5-dt.c         |    2 ++
 arch/arm/mach-exynos/mach-origen.c             |    4 ++--
 arch/arm/mach-exynos/mach-smdk4x12.c           |    4 ++--
 arch/arm/mach-exynos/mach-smdkv310.c           |    4 ++--
 arch/arm/mach-exynos/platsmp.c                 |    2 +-
 arch/arm/plat-samsung/include/plat/gpio-core.h |    5 +++++
 drivers/pinctrl/pinctrl-exynos5440.c           |    2 +-
 drivers/pinctrl/pinctrl-samsung.c              |    2 +-
 drivers/pinctrl/pinctrl-samsung.h              |    2 +-
 11 files changed, 21 insertions(+), 13 deletions(-)
