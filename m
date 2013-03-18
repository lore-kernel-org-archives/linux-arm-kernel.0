From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 18 Mar 2013 20:59:27 +0900
Subject: [GIT PULL] Renesas ARM-based SoC board updates for v3.10
Message-ID: <1363607980-22153-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

The following changes since commit 3e4ca5183625b525520a73d9ce630ab8898dbd0e:

  Merge branch 'pinmux/3.9/functions' of git://linuxtv.org/pinchartl/fbdev into boards-base (2013-03-15 23:41:21 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.10

for you to fetch changes up to 7f9ed6b16338a19a33bd1e7d87ccf34b304dcf27:

  ARM: shmobile: kzm9g: correct smsc regulator registration (2013-03-16 00:25:39 +0900)

----------------------------------------------------------------
Renesas ARM-based SoC board updates for v3.10

This is based on a merge of the following:

git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-pinmux-for-v3.10
git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git renesas-soc-for-v3.10

----------------------------------------------------------------
Arnd Bergmann (1):
      ARM: shmobile: mark mackerel sh_mmcif_device __maybe_unused

Guennadi Liakhovetski (6):
      ARM: shmobile: use GPIO SD-card detection on armadillo800eva
      ARM: shmobile: switch SDHI0 to GPIO regulator on armadillo800eva
      ARM: shmobile: streamline mackerel SD and MMC devices
      ARM: shmobile: parse DT and configure pinmux early on kzm9g-reference
      ARM: shmobile: SDHI and MMCIF interfaces to kzm9g-reference
      ARM: shmobile: simplify kzm9g Kconfig dependencies

Kuninori Morimoto (1):
      ARM: shmobile: marzen: Use gic_iid macro for ICCIAR / interrupt ID

Simon Horman (5):
      ARM: shmobile: marzen: Reference DT implementation
      ARM: shmobile: kzm9g: Reference DT implementation
      ARM: shmobile: kzm9g: Remove warning about SMP
      ARM: shmobile: kzm9g: Trim reference DT_MACHINE_START
      ARM: shmobile: kzm9g: correct smsc regulator registration

 arch/arm/boot/dts/Makefile                      |    2 +
 arch/arm/boot/dts/r8a7779-marzen-reference.dts  |   47 +++++++++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts    |   77 +++++++++++++++
 arch/arm/mach-shmobile/Kconfig                  |   27 ++++++
 arch/arm/mach-shmobile/Makefile                 |    2 +
 arch/arm/mach-shmobile/board-armadillo800eva.c  |  111 ++++++++++++++++++----
 arch/arm/mach-shmobile/board-kzm9g-reference.c  |  108 +++++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c            |    4 +-
 arch/arm/mach-shmobile/board-mackerel.c         |  115 ++++++++++++-----------
 arch/arm/mach-shmobile/board-marzen-reference.c |   75 +++++++++++++++
 arch/arm/mach-shmobile/board-marzen.c           |   12 +--
 11 files changed, 496 insertions(+), 84 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen-reference.dts
 create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
 create mode 100644 arch/arm/mach-shmobile/board-marzen-reference.c
