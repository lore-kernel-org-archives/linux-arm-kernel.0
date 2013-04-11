From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 11 Apr 2013 17:18:12 +0200
Subject: [GIT PULL] arm-soc fixes for 3.9-rc6
Message-ID: <201304111718.13017.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A little later during the week than the last few pull requests, since there
was very little that came in before 3.9-rc6. At least things have calmed
down again here.

	Arnd

The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/arm-soc-fixes

for you to fetch changes up to 71bd98aff05a644a2cfc3ac6ca848a586fa210b9:

  Merge tag 'mvebu_fixes_for_v3.9_round3' of git://git.infradead.org/users/jcooper/linux into fixes (2013-04-11 16:55:29 +0200)

----------------------------------------------------------------

arm-soc: bug fixes for 3.9-rc6

Some important bug fixes that came in over the last 10 days,
mostly mvebu and imx:

- Multiple regressions on i.mx following the conversion of
  the clock code, hopefully the last we are seeing of those.
- a regression in the mvebu irq handling code
- An incorrect register offset in the rewritten s3c24xx irq code.
- Two bugs in setting up the iomega_ix2_200 machine
- Turning on an extra bus clock on imx
- A MAINTAINERS file entry for Roland Stigge

----------------------------------------------------------------
Arnd Bergmann (4):
      Merge tag 'mxs-fixes-3.9-4' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes
      Merge tag 'imx-fixes-3.9-5' of git://git.linaro.org/people/shawnguo/linux-2.6 into fixes
      Merge tag 'samsung-fixes-for-v3.9' of git://git.kernel.org/.../kgene/linux-samsung into fixes
      Merge tag 'mvebu_fixes_for_v3.9_round3' of git://git.infradead.org/users/jcooper/linux into fixes

Dirk Behme (1):
      ARM i.MX6: Fix ldb_di clock selection

Gregory CLEMENT (1):
      arm: mvebu: Fix the irq map function in SMP mode

Marek Vasut (1):
      ARM: mxs: Slow down the I2C clock speed

Markus Pargmann (2):
      ARM: clk-imx35: Bugfix iomux clock
      ARM: imx35 Bugfix admux clock

Nigel Roberts (2):
      ARM: Kirkwood: Fix typo in the definition of ix2-200 rebuild LED
      Fix GE0/GE1 init on ix2-200 as GE0 has no PHY

Roland Stigge (1):
      MAINTAINERS: Add maintainer for LPC32xx

Shawn Guo (1):
      ARM: imx: provide twd clock lookup from device tree

Sylwester Nawrocki (2):
      ARM: S3C24XX: Correct NR_IRQS definition for s3c2440
      ARM: S3C24XX: Fix interrupt pending register offset of the EINT controller

 MAINTAINERS                                   |  6 ++++++
 arch/arm/boot/dts/imx28-m28evk.dts            |  1 -
 arch/arm/boot/dts/imx28-sps1.dts              |  1 -
 arch/arm/boot/dts/imx6qdl.dtsi                |  1 +
 arch/arm/boot/dts/kirkwood-iomega_ix2_200.dts | 14 +++++++-------
 arch/arm/mach-imx/clk-imx35.c                 |  2 ++
 arch/arm/mach-imx/clk-imx6q.c                 |  3 +--
 arch/arm/mach-kirkwood/board-iomega_ix2_200.c |  7 ++++++-
 arch/arm/mach-mvebu/irq-armada-370-xp.c       | 16 +++++-----------
 arch/arm/mach-s3c24xx/include/mach/irqs.h     |  4 +---
 arch/arm/mach-s3c24xx/irq.c                   |  2 +-
 11 files changed, 30 insertions(+), 27 deletions(-)
