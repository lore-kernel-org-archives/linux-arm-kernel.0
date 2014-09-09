From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  9 Sep 2014 13:22:01 +0900
Subject: [GIT PULL v2] Renesas ARM Based SoC r8a7740 Multiplatform Updates for
 v3.18
Message-ID: <cover.1410235700.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a7740 multiplatform updates
for v3.18.

This pull request is based on
"Renesas ARM Based SoC R8a7740 CCF and Timers Updates for v3.18"
tagged as renesas-r8a7740-ccf-and-timers-for-v3.18,
which you have previously pulled.

This pull request is a revised version of an earlier
pull-request of the same name. The previous version truncated
one of the patches due to an error on my part.


The following changes since commit 433306747791845677ba662435a9bbbafaa21df3:

  ARM: shmobile: r8a7740: Remove r8a7740_add_standard_devices_dt (2014-08-23 19:58:57 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a7740-multiplatform-for-v3.18

for you to fetch changes up to 968d1af17b01b5eb343e17f64281561e1e169bb6:

  ARM: shmobile: armadillo800eva reference: Remove DTS (2014-09-04 12:59:55 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC r8a7740 Multiplatform Updates for v3.18

* Enable multiplatform support for r8a7740 SoC and remove
  its DT-reference C board DTS files.

----------------------------------------------------------------
Magnus Damm (6):
      ARM: shmobile: r8a7740: Multiplatform support
      ARM: shmobile: armadillo800eva: Sync DTS
      ARM: shmobile: armadillo800eva: Build DTS for multiplatform
      ARM: shmobile: r8a7740: Add restart callback
      ARM: shmobile: armadillo800eva reference: Remove C board code
      ARM: shmobile: armadillo800eva reference: Remove DTS

 arch/arm/boot/dts/Makefile                         |   2 +-
 .../boot/dts/r8a7740-armadillo800eva-reference.dts | 300 ---------------------
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      | 276 ++++++++++++++++++-
 arch/arm/mach-shmobile/Kconfig                     |  20 +-
 arch/arm/mach-shmobile/Makefile                    |   1 -
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 .../board-armadillo800eva-reference.c              | 199 --------------
 arch/arm/mach-shmobile/pm-r8a7740.c                |   5 +-
 arch/arm/mach-shmobile/r8a7740.h                   |   4 +-
 arch/arm/mach-shmobile/setup-r8a7740.c             |  16 +-
 10 files changed, 300 insertions(+), 524 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-armadillo800eva-reference.c
