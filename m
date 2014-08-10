From: olof@lixom.net (Olof Johansson)
Date: Sat, 9 Aug 2014 22:14:08 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <20140810051408.GA14964@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit c309bfa9b481e7dbd3e1ab819271bf3009f44859:

  Merge tag 'for-linus-20140808' of git://git.infradead.org/linux-mtd (2014-08-08 18:13:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to ee34fb97a96ceac3334705ebab8b541ca291699f:

  ARM: dts: exynos5420: remove disp_pd (2014-08-09 08:25:50 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 3.17 merge window

- A short branch of OMAP fixes that we didn't merge before the window opened.
- A small cleanup that sorts the rk3288 dts entries properly
- A build fix due to a reference to a removed DT node on exynos

----------------------------------------------------------------
Doug Anderson (1):
      ARM: dts: Fix the sort ordering of EHCI and HSIC in rk3288.dtsi

Jeremy Vial (2):
      ARM: OMAP3: Fix choice of omap3_restore_es function in OMAP34XX rev3.1.2 case.
      ARM: OMAP3: Fix coding style problems in arch/arm/mach-omap2/control.c

Olof Johansson (1):
      Merge tag 'omap-for-v3.17/soc-fixes' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Paul Walmsley (1):
      ARM: OMAP2+: clock: allow omap2_dpll_round_rate() to round to next-lowest rate

Stephen Rothwell (1):
      ARM: dts: exynos5420: remove disp_pd

Tomasz Figa (1):
      ARM: EXYNOS: Fix suspend/resume sequences

Tony Lindgren (1):
      Merge tag 'for-v3.17/omap-clock-b' of git://git.kernel.org/.../pjw/omap-pending into omap-for-v3.17/soc

 arch/arm/boot/dts/exynos5420.dtsi |   1 -
 arch/arm/boot/dts/rk3288.dtsi     |  40 +++++-----
 arch/arm/mach-exynos/pm.c         | 163 ++++++++++++++++++--------------------
 arch/arm/mach-omap2/clkt_dpll.c   |  28 +++++--
 arch/arm/mach-omap2/control.c     |   6 +-
 arch/arm/mach-omap2/dpll3xxx.c    |  13 ++-
 drivers/cpuidle/cpuidle-exynos.c  |  25 +-----
 7 files changed, 135 insertions(+), 141 deletions(-)
