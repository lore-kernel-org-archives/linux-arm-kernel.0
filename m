From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:26 +0900
Subject: [GIT PULL] Renesas ARM Based SoC sh73a0 Multiplatform Updates for v4.1
Message-ID: <cover.1425518682.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC sh73a0 multiplatform updates for v4.1.

This pull request is based on the previous round of
such requests, tagged as sh73a0-multiplatform-for-v4.1.base,
which I have already sent a pull-request for.


This pull request is based on a merge of the following pull requests
which you have already pulled:

* "Renesas ARM Based SoC Simple PM Bus Updates for v4.1",
  tagged as renesas-simple-pm-bus-for-v4.1.

* "Renesas ARM Based SoC DT Updates for v4.1", tagged as renesas-dt-for-v4.1.


This pull requests has a number of minor conflicts with "Renesas ARM Based
SoC sh7372 SoC Removal Updates for v4.1", tagged as
renesas-sh7372-soc-removal-for-v4.1, which you have already pulled.

The conflicts are in the following files:
        arch/arm/boot/dts/Makefile
        arch/arm/mach-shmobile/Makefile
        arch/arm/mach-shmobile/Makefile.boot
        arch/arm/mach-shmobile/include/mach/zboot.h

In general the solution is to delete both. A resolution of the conflicts
can be found in the renesas-next-20150305v2-v4.0-rc1 tag of the renesas tree.


The following changes since commit ded416ff3ae664c37ec4c270a3ab273b01218838:

  Merge branch 'heads/dt-for-v4.1' into sh73a0-multiplatform-for-v4.1.base (2015-02-24 08:22:10 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-sh73a0-multiplatform-for-v4.1

for you to fetch changes up to 3c7585b9901c335d10a04c8495164cb113c0b8f2:

  ARM: shmobile: sh73a0: Remove restart callback (2015-02-24 08:22:50 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC sh73a0 Multiplatform Updates for v4.1

* Add multiplatform support to sh73a0 and its kzm9g board
* Use Bus State Controller to enable ethernet for multiplatform sh73a0/kzm9g
* Add PM domain support to multiplatform sh73a0

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: sh73a0 dtsi: Add Bus State Controller node
      ARM: shmobile: kzm9g dts: Move Ethernet node to BSC
      ARM: shmobile: sh73a0 dtsi: Add Cortex-A9 TWD node
      ARM: shmobile: sh73a0: Remove unused sh73a0_add_standard_devices_dt()
      ARM: shmobile: sh73a0 dtsi: Add PM domain support
      ARM: shmobile: sh73a0: Remove restart callback

Magnus Damm (4):
      ARM: shmobile: sh73a0: Introduce generic setup callback
      ARM: shmobile: sh73a0: Add Multiplatform support
      ARM: shmobile: kzm9g dts: Sync with kzm9g-reference dts
      ARM: shmobile: kzm9g: Build DTS for Multiplatform

Simon Horman (1):
      ARM: shmobile: kzm9g-reference: Remove board C code and DT file

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 arch/arm/boot/dts/Makefile                         |   6 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       | 398 ---------------------
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 | 376 ++++++++++++++++++-
 arch/arm/boot/dts/sh73a0.dtsi                      | 163 ++++++++-
 arch/arm/mach-shmobile/Kconfig                     |  19 +-
 arch/arm/mach-shmobile/Makefile                    |   5 +-
 arch/arm/mach-shmobile/Makefile.boot               |   1 -
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |  62 ----
 arch/arm/mach-shmobile/include/mach/zboot.h        |   2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c              |  19 +-
 arch/arm/mach-shmobile/sh73a0.h                    |   1 -
 arch/arm/mach-shmobile/smp-sh73a0.c                |   2 +-
 13 files changed, 554 insertions(+), 502 deletions(-)
 delete mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 delete mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c
