From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:04:43 +0900
Subject: [GIT PULL 0/3] Second Round of Renesas ARM based SoC Fixes for v3.13
Message-ID: <cover.1387856124.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM based SoC fixes for v3.13.
It is based on the first round of fixes, tagged as renesas-fixes-for-v3.13,
which you have previously pulled.


The following changes since commit 23de2278ebc3a2f971ce45ca5e5e35c9d5a74040:

  ARM: shmobile: r8a7790: Fix GPIO resources in DTS (2013-11-28 17:04:39 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-fixes2-for-v3.13

for you to fetch changes up to d721a15c300c5f638a11573a6dd492158e737d6a:

  ARM: shmobile: r8a7790: fix shdi resource sizes (2013-12-19 18:14:48 +0900)

----------------------------------------------------------------
Second Round of Renesas ARM based SoC Fixes for v3.13

* r8a7790 (R-Car H2) based Lager board

  - Correct SHDI resource sizes

    This bug has been present since sdhi resources were added to the r8a7790 by
    8c9b1aa41853272a ("ARM: shmobile: r8a7790: add MMCIF and SDHI DT
    templates") in v3.11-rc2.

* r8a7778 (R-Car M1) based Bock-W board

  - Correct DMA mask

    This resolves a regression introduced by 4dcfa60071b3d23f
    ("ARM: DMA-API: better handing of DMA masks for coherent allocations")
    in v3.12-rc1.

* r8a7740 (R-Mobile A1) based Armadillo board

  - Add PWM backlight power supply

    This resolves a regression introduced by 22ceeee16eb8f0d0
    ("pwm-backlight: Add power supply support") in v3.12.

----------------------------------------------------------------
Ben Dooks (1):
      ARM: shmobile: r8a7790: fix shdi resource sizes

Kuninori Morimoto (1):
      ARM: shmobile: bockw: fixup DMA mask

Laurent Pinchart (1):
      ARM: shmobile: armadillo: Add PWM backlight power supply

 arch/arm/boot/dts/r8a7790.dtsi                 | 4 ++--
 arch/arm/mach-shmobile/board-armadillo800eva.c | 7 +++++++
 arch/arm/mach-shmobile/board-bockw.c           | 2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)
