From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 30 Sep 2013 13:00:08 +0900
Subject: [GIT PULL 0/5] Fourth Round of Renesas ARM based SoC fixes for v3.12
Message-ID: <cover.1380513421.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider this third round of Renesas ARM based SoC DT fixes for v3.12.

This pull request is based on v3.12-rc1 which includes the previous
rounds of fixes.

The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes4-for-v3.12

for you to fetch changes up to 3786f86b60833f32e3eeb016fcf8c324f8147e00:

  ARM: shmobile: Remove #gpio-ranges-cells DT property (2013-09-22 21:28:18 +0900)

----------------------------------------------------------------
Fourth Round of Renesas ARM based SoC fixes for v3.12

* Remove unused #gpio-ranges-cells DT property

* Remove usage of deprecated #gpio-range-cells DT property
  from GPIO R-Car

  Property was deprecated in v3.11-rc2

* Correct ether pinctl naming for armadillo800eva board

  Regression introduced in v3.10-rc5

* Add Micrel KSZ8041 PHY fixup to lager board

  This resolves a problem that has been present since 3.11-rc2

* Update SDHI DT compatibility string to the <unit>-<soc> format

  This makes compatibility strings consistent across all renesas
  hardware which currently supports DT.

  The bindings which are being updated where intorodiced on
  a per-SoC basis starting in v3.8-rc7. They may have
  been internally consistent when originally added.

----------------------------------------------------------------
Guennadi Liakhovetski (1):
      ARM: shmobile: update SDHI DT compatibility string to the <unit>-<soc> format

Kuninori Morimoto (1):
      ARM: shmobile: armadillo: fixup ether pinctrl naming

Laurent Pinchart (2):
      gpio: rcar: Remove #gpio-range-cells DT property usage
      ARM: shmobile: Remove #gpio-ranges-cells DT property

Sergei Shtylyov (1):
      ARM: shmobile: Lager: add Micrel KSZ8041 PHY fixup

 Documentation/devicetree/bindings/mmc/tmio_mmc.txt | 17 ++++++++------
 arch/arm/boot/dts/r8a73a4.dtsi                     |  6 ++---
 arch/arm/boot/dts/r8a7778.dtsi                     |  1 -
 arch/arm/boot/dts/r8a7779.dtsi                     |  1 -
 arch/arm/boot/dts/r8a7790.dtsi                     |  9 ++++----
 arch/arm/boot/dts/sh73a0.dtsi                      |  6 ++---
 arch/arm/mach-shmobile/board-armadillo800eva.c     |  4 ++--
 arch/arm/mach-shmobile/board-lager.c               | 27 +++++++++++++++++++++-
 drivers/gpio/gpio-rcar.c                           |  7 +++---
 drivers/mmc/host/sh_mobile_sdhi.c                  | 16 ++++++-------
 10 files changed, 59 insertions(+), 35 deletions(-)
