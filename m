From: olof@lixom.net (Olof Johansson)
Date: Sun, 13 Oct 2013 09:43:33 -0700
Subject: [GIT PULL] ARM: SoC fixes for 3.12-rc
Message-ID: <20131013164333.GA10894@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,


The following changes since commit d0e639c9e06d44e713170031fe05fb60ebe680af:

  Linux 3.12-rc4 (2013-10-06 14:00:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git tags/fixes-for-linus

for you to fetch changes up to 4d594dd3028ba8cdfcbd854bde3811a1ee4e36d7:

  ARM: exynos: dts: Update 5250 arch timer node with clock frequency (2013-10-13 09:33:54 -0700)

----------------------------------------------------------------
ARM: SoC fixes for 3.12-rc

A small batch of fixes this week, mostly OMAP related. Nothing stands out
as particularly controversial.

Also a fix for a 3.12-rc1 timer regression for Exynos platforms, including
the Chromebooks.

----------------------------------------------------------------
Aaro Koskinen (1):
      ARM: OMAP2: gpmc-onenand: fix sync mode setup with DT

Nishanth Menon (1):
      ARM: OMAP3: Fix hardware detection for omap3630 when booted with device tree

Olof Johansson (1):
      Merge tag 'fixes-against-v3.12-rc3-take2' of git://git.kernel.org/.../tmlind/linux-omap into fixes

Pali Roh?r (1):
      ARM: OMAP2: RX-51: Add missing max_current to rx51_lp5523_led_config

Simon Barth (1):
      ARM: mach-omap2: board-generic: fix undefined symbol

Tony Lindgren (1):
      ARM: dts: Fix pinctrl mask for omap3

Yuvaraj Kumar C D (1):
      ARM: exynos: dts: Update 5250 arch timer node with clock frequency

 arch/arm/boot/dts/exynos5250.dtsi            |  5 +++++
 arch/arm/boot/dts/omap3-beagle-xm.dts        |  2 +-
 arch/arm/boot/dts/omap3.dtsi                 |  4 ++--
 arch/arm/mach-omap2/board-generic.c          | 18 ++++++++++++++++++
 arch/arm/mach-omap2/board-rx51-peripherals.c |  9 +++++++++
 arch/arm/mach-omap2/gpmc-onenand.c           | 12 +++++++++++-
 arch/arm/mach-omap2/mux.h                    |  4 +---
 arch/arm/mach-omap2/timer.c                  |  4 ++--
 include/dt-bindings/pinctrl/omap.h           |  4 +---
 9 files changed, 50 insertions(+), 12 deletions(-)
