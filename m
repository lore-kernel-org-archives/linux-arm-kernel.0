From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Aug 2014 10:10:14 +0900
Subject: [GIT PULL] Renesas ARM Based SoC Init Delay Updates For v3.18
Message-ID: <cover.1408927601.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC init delay updates for v3.18.

This pull request is based on a merge of:

* Renesas ARM Based SoC Boards Updates for v3.18,
  tagged as renesas-boards-for-v3.18,
  which I have previously sent a pull-request for

* Renesas ARM Based SoC Updates for v3.18,
  tagged as renesas-soc-for-v3.18,
  which I have previously sent a pull-request for


The following changes since commit 93acbd2cd2482cb51bec70a1494fddf2c172c073:

  Merge branch 'boards-for-v3.18' into soc-init-delay-for-v3.18.base (2014-08-22 11:31:47 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-init-delay-for-v3.18

for you to fetch changes up to fc35ca258c079411b64ed94e517eb04e7d89bc44:

  ARM: shmobile: kzm9g: Use shmobile_init_delay() (2014-08-22 11:32:13 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC Init Delay Updates For v3.18

* Use shmobile_init_delay across a wider range of SoCs

----------------------------------------------------------------
Magnus Damm (10):
      ARM: shmobile: sh7372: Update DTS to include CPU frequency
      ARM: shmobile: sh73a0: Update DTS to include CPU frequency
      ARM: shmobile: r8a7778: Update DTS to include CPU frequency
      ARM: shmobile: sh7372: Use shmobile_init_delay()
      ARM: shmobile: r8a73a4: Use shmobile_init_delay()
      ARM: shmobile: Remove shmobile_setup_delay()
      ARM: shmobile: sh73a0: Use shmobile_init_delay()
      ARM: shmobile: r8a7778: Use shmobile_init_delay()
      ARM: shmobile: bockw: Use shmobile_init_delay()
      ARM: shmobile: kzm9g: Use shmobile_init_delay()

 arch/arm/boot/dts/r8a7778.dtsi                 |  6 ++++++
 arch/arm/boot/dts/sh7372.dtsi                  |  1 +
 arch/arm/boot/dts/sh73a0.dtsi                  |  2 ++
 arch/arm/mach-shmobile/board-bockw-reference.c |  2 +-
 arch/arm/mach-shmobile/board-bockw.c           |  2 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |  2 +-
 arch/arm/mach-shmobile/common.h                |  2 --
 arch/arm/mach-shmobile/r8a73a4.h               |  1 -
 arch/arm/mach-shmobile/setup-r8a73a4.c         |  9 +--------
 arch/arm/mach-shmobile/setup-r8a7778.c         |  2 +-
 arch/arm/mach-shmobile/setup-sh7372.c          |  2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c          |  2 +-
 arch/arm/mach-shmobile/timer.c                 | 21 ++-------------------
 13 files changed, 18 insertions(+), 36 deletions(-)
