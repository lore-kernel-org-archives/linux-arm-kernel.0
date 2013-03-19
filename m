From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 19 Mar 2013 11:17:48 +0900
Subject: [GIT PULL v2] Renesas ARM-based SoC board updates for v3.10
Message-ID: <1363659481-5922-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Hi Olof,

The following changes since commit a9cc2c88aa9514296f868c9ea740b8addc7b8115:

  Merge branches 'soc' and 'pinmux' into boards-base (2013-03-18 21:26:33 +0900)

are available in the git repository at:


  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-boards-for-v3.10

for you to fetch changes up to 48296a13e7f411402f080d0603724623fa3eee14:

  ARM: shmobile: kzm9g: correct smsc regulator registration (2013-03-18 21:27:03 +0900)

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
