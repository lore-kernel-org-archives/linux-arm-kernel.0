From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 24 May 2016 22:03:32 +0200
Subject: [GIT PULL] ARM: SoC fixes for v4.7
Message-ID: <6880123.QJWf7jilUK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 4a5219edcdae52bfb5eea0dfc2a7bd575961dad7:

  Merge tag 'armsoc-drivers' of git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc (2016-05-18 13:14:02 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/armsoc-fixes

for you to fetch changes up to 09564b7d84d753e4aa1198017b5a5e86c7b0539f:

  ARM: lpc32xx: fix NR_IRQS confict (2016-05-24 19:32:46 +0000)

----------------------------------------------------------------
ARM: SoC fixes for 4.7

This is a first set of bug fixes on top of what was merged for 4.7.
Two patches for lpc32xx address a harmless build warning that was
just introduced, one patch for the mediatek soc driver fixes a warning
for arm64, and the pxa changes are minor cleanups that should have
been part of the original pull requests but that I forgot to apply
to the cleanup-fixes branch earlier.

----------------------------------------------------------------
Arnd Bergmann (3):
      soc: mtk-pmic-wrap: avoid integer overflow warning
      Merge tag 'pxa-for-4.7' of https://github.com/rjarzmik/linux into fixes
      ARM: lpc32xx: fix NR_IRQS confict

Robert Jarzmik (1):
      ARM: pxa: activate pinctrl for device-tree machines

Stephen Boyd (1):
      ARM: pxa: Remove CLK_IS_ROOT

Vladimir Zapolskiy (1):
      ARM: lpc32xx: remove legacy irq controller driver

 arch/arm/mach-lpc32xx/Makefile            |   2 +-
 arch/arm/mach-lpc32xx/include/mach/irqs.h |   2 +-
 arch/arm/mach-lpc32xx/irq.c               | 477 ------------------------------
 arch/arm/mach-pxa/Kconfig                 |   2 +
 arch/arm/mach-pxa/eseries.c               |   2 +-
 drivers/soc/mediatek/mtk-pmic-wrap.c      |   6 +-
 6 files changed, 8 insertions(+), 483 deletions(-)
 delete mode 100644 arch/arm/mach-lpc32xx/irq.c
