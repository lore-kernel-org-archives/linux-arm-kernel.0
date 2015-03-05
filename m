From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:57:57 +0900
Subject: [GIT PULL] Renesas ARM Based SoC r8a73a4 CCF and Multiplatform
 Updates for v4.1
Message-ID: <cover.1425517246.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Kevin, Hi Arnd,

Please consider these Renesas ARM based SoC r8a73a4 CCF and multiplatform
updates for v4.1.


This pull request is based on "Renesas ARM Based SoC Simple PM Bus Updates
for v4.1", tagged as renesas-simple-pm-bus-for-v4.1, which you have already
pulled. That pull request provides run-time dependencies for this one.


This pull requests has minor conflicts with "Renesas ARM Based SoC sh7372
SoC Removal Updates for v4.1", tagged as
renesas-sh7372-soc-removal-for-v4.1, which you have already pulled.

The conflicts are in the following files:
	arch/arm/mach-shmobile/Kconfig
	arch/arm/mach-shmobile/Makefile

The solution is to delete both.

This solution can be found in the renesas-next-20150305v2-v4.0-rc1 tag of
the renesas tree.


The following changes since commit 89d463ea106dba530786a2815fd174f9e6eab71f:

  drivers: bus: Add Simple Power-Managed Bus Driver (2015-02-24 06:36:18 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-r8a73a4-ccf-and-multiplatform-for-v4.1

for you to fetch changes up to 914d7d148411997c2f76f689338d27c362300b7a:

  ARM: shmobile: r8a73a4: Remove legacy code (2015-02-25 16:14:02 +0900)

----------------------------------------------------------------
Renesas ARM Based SoC r8a73a4 CCF and Multiplatform Updates for v4.1

* Add CCF and them multiplatform support to r8a73a4 SoC and its
  ape6evm board.
* Then remove legacy r8a73a4 SoC and ape6evm board code.

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
      ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
      ARM: shmobile: r8a73a4: Move pfc node to work around probe ordering bug
      ARM: shmobile: ape6evm dts: Drop console= bootargs parameter
      PM / Domains: R-Mobile SYSC: Document R-Mobile APE6 (r8a73a4) binding
      ARM: shmobile: r8a73a4 dtsi: Add PM domain support

Laurent Pinchart (1):
      ARM: shmobile: r8a73a4: Remove legacy code

Simon Horman (1):
      ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform

Ulrich Hecht (5):
      ARM: shmobile: r8a73a4: Add CPG register bits header
      ARM: shmobile: r8a73a4: Common clock framework DT description
      ARM: shmobile: ape6evm: Disable legacy clock initialization
      ARM: shmobile: r8a73a4: Add MSTP clock assignments to DT
      ARM: shmobile: ape6evm-reference: Remove board C code and DT file

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 .../bindings/power/renesas,sysc-rmobile.txt        |   1 +
 MAINTAINERS                                        |   1 -
 arch/arm/boot/dts/Makefile                         |   2 -
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 156 -----
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  37 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 557 ++++++++++++++++-
 arch/arm/configs/ape6evm_defconfig                 | 109 ----
 arch/arm/mach-shmobile/Kconfig                     |  25 -
 arch/arm/mach-shmobile/Makefile                    |   3 -
 arch/arm/mach-shmobile/Makefile.boot               |   2 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  60 --
 arch/arm/mach-shmobile/board-ape6evm.c             | 306 ----------
 arch/arm/mach-shmobile/clock-r8a73a4.c             | 659 ---------------------
 arch/arm/mach-shmobile/r8a73a4.h                   |  17 -
 arch/arm/mach-shmobile/setup-r8a73a4.c             | 273 +--------
 include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++
 17 files changed, 615 insertions(+), 1657 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/configs/ape6evm_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
 delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h

----------------------------------------------------------------
Geert Uytterhoeven (6):
      ARM: shmobile: r8a73a4 dtsi: Add Bus State Controller node
      ARM: shmobile: ape6evm dts: Move Ethernet node to BSC
      ARM: shmobile: r8a73a4: Move pfc node to work around probe ordering bug
      ARM: shmobile: ape6evm dts: Drop console= bootargs parameter
      PM / Domains: R-Mobile SYSC: Document R-Mobile APE6 (r8a73a4) binding
      ARM: shmobile: r8a73a4 dtsi: Add PM domain support

Laurent Pinchart (1):
      ARM: shmobile: r8a73a4: Remove legacy code

Simon Horman (1):
      ARM: shmobile: r8a73a4: ape6evm: Remove legacy platform

Ulrich Hecht (5):
      ARM: shmobile: r8a73a4: Add CPG register bits header
      ARM: shmobile: r8a73a4: Common clock framework DT description
      ARM: shmobile: ape6evm: Disable legacy clock initialization
      ARM: shmobile: r8a73a4: Add MSTP clock assignments to DT
      ARM: shmobile: ape6evm-reference: Remove board C code and DT file

 Documentation/devicetree/bindings/arm/shmobile.txt |   2 -
 .../bindings/power/renesas,sysc-rmobile.txt        |   1 +
 MAINTAINERS                                        |   1 -
 arch/arm/boot/dts/Makefile                         |   2 -
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts    | 156 -----
 arch/arm/boot/dts/r8a73a4-ape6evm.dts              |  37 +-
 arch/arm/boot/dts/r8a73a4.dtsi                     | 557 ++++++++++++++++-
 arch/arm/configs/ape6evm_defconfig                 | 109 ----
 arch/arm/mach-shmobile/Kconfig                     |  25 -
 arch/arm/mach-shmobile/Makefile                    |   3 -
 arch/arm/mach-shmobile/Makefile.boot               |   2 -
 arch/arm/mach-shmobile/board-ape6evm-reference.c   |  60 --
 arch/arm/mach-shmobile/board-ape6evm.c             | 306 ----------
 arch/arm/mach-shmobile/clock-r8a73a4.c             | 659 ---------------------
 arch/arm/mach-shmobile/r8a73a4.h                   |  17 -
 arch/arm/mach-shmobile/setup-r8a73a4.c             | 273 +--------
 include/dt-bindings/clock/r8a73a4-clock.h          |  62 ++
 17 files changed, 615 insertions(+), 1657 deletions(-)
 delete mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 delete mode 100644 arch/arm/configs/ape6evm_defconfig
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 delete mode 100644 arch/arm/mach-shmobile/board-ape6evm.c
 delete mode 100644 arch/arm/mach-shmobile/clock-r8a73a4.c
 delete mode 100644 arch/arm/mach-shmobile/r8a73a4.h
 create mode 100644 include/dt-bindings/clock/r8a73a4-clock.h
