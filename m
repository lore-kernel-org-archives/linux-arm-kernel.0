From: olof@lixom.net (Olof Johansson)
Date: Sat, 30 Jun 2012 15:51:31 -0700
Subject: [GIT PULL] ARM: SoC fixes
Message-ID: <CAOesGMjDajmGmQvoamojpM55h9wG5UOy6RGpn-BY-Xc3dUQMqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

The following changes since commit 6b16351acbd415e66ba16bf7d473ece1574cf0bc:

  Linux 3.5-rc4 (2012-06-24 12:53:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git
tags/fixes-for-linus

for you to fetch changes up to 5d5474df64d49564f297d9259932452ea64b745d:

  Merge branch 'v3.5-samsung-fixes-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung into
fixes (2012-06-30 15:27:52 -0700)

----------------------------------------------------------------

ARM: SoC fixes

Another week, another batch of fixes.

All are small, contained, targeted fixes for explicit problems -- mostly
build and boot failures across i.MX, OMAP, Renesas/Shmobile and Samsung.

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: mach-shmobile: add missing GPIO IRQ configuration on mackerel

Jon Hunter (1):
      ARM: OMAP4470: Fix OMAP4470 boot failure

Jonghwan Choi (1):
      ARM: SAMSUNG: Should check for IS_ERR(clk) instead of NULL

Jose Miguel Goncalves (1):
      ARM: SAMSUNG: Fix for S3C2412 EBI memory mapping

Kevin Hilman (1):
      ARM: OMAP2+: nand: fix build error when CONFIG_MTD_ONENAND_OMAP2=n

Kuninori Morimoto (4):
      ARM: shmobile: sh73a0: bugfix: SY-DMAC number
      ARM: shmobile: sh7372: bugfix: chclr_offset base
      ARM: shmobile: kzm9g: use late init machine hook
      ARM: shmobile: kzm9d: use late init machine hook

Laurent Pinchart (1):
      ARM: mach-shmobile: armadillo800eva: Use late init machine hook

Nobuhiro Iwamatsu (1):
      ARM: mach-shmobile: Fix build when SMP is enabled and EMEV2 is not enabled

Olof Johansson (3):
      Merge branch 'fixes' of git://git.kernel.org/.../rafael/renesas into fixes
      Merge tag 'omap-fixes-for-v3.5-rc4' of
git://git.kernel.org/.../tmlind/linux-omap into fixes
      Merge branch 'v3.5-samsung-fixes-1' of
git://git.kernel.org/.../kgene/linux-samsung into fixes

Phil Edworthy (1):
      ARM: shmobile: r8a7779: Route all interrupts to ARM

Sachin Kamat (1):
      ARM: EXYNOS: Fix EXYNOS_DEV_DMA Kconfig entry

Shawn Guo (1):
      ARM: imx6q: fix suspend regression caused by common clk migration

 arch/arm/mach-exynos/Kconfig                        | 8 ++++----
 arch/arm/mach-imx/clk-imx6q.c                       | 6 ++++--
 arch/arm/mach-omap2/board-flash.c                   | 5 -----
 arch/arm/mach-omap2/clock44xx_data.c                | 5 ++++-
 arch/arm/mach-shmobile/board-armadillo800eva.c      | 1 +
 arch/arm/mach-shmobile/board-kzm9d.c                | 1 +
 arch/arm/mach-shmobile/board-kzm9g.c                | 1 +
 arch/arm/mach-shmobile/board-mackerel.c             | 3 +++
 arch/arm/mach-shmobile/clock-sh73a0.c               | 8 ++++----
 arch/arm/mach-shmobile/intc-r8a7779.c               | 7 +++++++
 arch/arm/mach-shmobile/platsmp.c                    | 5 +++++
 arch/arm/mach-shmobile/setup-sh7372.c               | 2 +-
 arch/arm/plat-samsung/include/plat/map-s3c.h        | 2 +-
 arch/arm/plat-samsung/include/plat/watchdog-reset.h | 2 +-
 14 files changed, 37 insertions(+), 19 deletions(-)
