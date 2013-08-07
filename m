From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed,  7 Aug 2013 13:28:09 +0900
Subject: [GIT PULL 00/19] Second round of Renesas ARM-based SoC DT updates for
 v3.12
Message-ID: <cover.1375838900.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Hi Arnd,

please consider this second round of Renesas ARM-based SoC DT updates for
v3.12.

This pull-request is based on renesas-soc-for-v3.12 which I have
previously sent a pull request-for. That is in turn based on
renesas-dt-for-v3.12. So there is a semi-circular dependency,
but it is not at all clear to me how this could be nicely avoided.

This pull-request has minor conflicts.

* There is a conflict with renesas-cleanup2-for-v3.12,
  which I have previously sent a pull-request for,
  in arch/arm/mach-shmobile/Makefile.boot.

* There is a conflict with renesas-pinmux-for-v3.12,
  which I have previously sent a pull-request for,
  in arch/arm/boot/dts/r8a7740.dtsi.

I have provided an example of how to merge these as part of
the renesas-devel-20180807 tag in the renesas tree.


The following changes since commit 81b9d5351fa96caad4accc6711bc1b9342927d4a:

  ARM: shmobile: Setup r8a7790 arch timer based on MD pins (2013-07-17 14:26:56 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-dt2-for-v3.12

for you to fetch changes up to 8b3e32c1fe5dce55e28e76b20361841dc863ec17:

  ARM: shmobile: r8a7740: Add TPU node to the device tree (2013-08-06 18:06:23 +0900)

----------------------------------------------------------------
Second round of Renesas ARM-based SoC DT updates for v3.12

* Add TPU node to the device tree of r8a7740 SoC

* Enable nfsroot in the device tree of the lager baord

* Use device tree to initialise GIC on armadillo800eva and marzen boards

* Mount root file systems in r/w mode for all Renesas boards

* Add PMU information to .dtsi for the emev2, sh73a0 and r8a7740 SoCs

* Rely on DT for SMP CPU info on the sh73a0 and r8a7779 SoCs

* Switch marzen board to use DT_MACHINE_START
  - This is was the last the last board in the tree

* Add DT reference for ape6evm, lager and bockw boards
  - This is intended as method to develop DT coverage for these
    boards and their associated SoCs while leaving the existing mostly-C
    version of the code in place. This allows a clear distinction to be
    made between DT work and hardware support. And once the DT coverage is
    complete the mostly-C code can be removed.
  - This pattern is already used for a number of Renesas boards including
    the kzm9g and marzen.

----------------------------------------------------------------
Guennadi Liakhovetski (3):
      ARM: shmobile: ape6evm: add DT reference
      ARM: shmobile: ape6evm-reference: add CPUFreq support
      ARM: shmobile: ape6evm-reference: switch PFC to DT

Kuninori Morimoto (3):
      ARM: shmobile: bockw: add DT reference
      ARM: shmobile: armadillo800eva: Use DT for GIC
      ARM: shmobile: marzen: Use DT for GIC

Laurent Pinchart (3):
      ARM: shmobile: lager-reference: Add LED6-LED8 to the device tree
      ARM: shmobile: Mount root file systems in r/w mode for all DT platforms
      ARM: shmobile: r8a7740: Add TPU node to the device tree

Magnus Damm (6):
      ARM: shmobile: Minor update for the Lager DT reference code
      ARM: shmobile: sh73a0: Rely on DT for SMP CPU info
      ARM: shmobile: marzen: Switch to DT_MACHINE_START
      ARM: shmobile: r8a7740: add PMU information to r8a7740.dtsi
      ARM: shmobile: sh73a0: add PMU information to sh73a0.dtsi
      ARM: shmobile: emev2: add PMU information to emev2.dtsi

Simon Horman (4):
      ARM: shmobile: lager: Add DT reference
      ARM: shmobile: marzen: Add  r8a7779-marzen.dtb
      ARM: shmobile: r8a7779: Rely on DT for SMP CPU info
      ARM: shmobile: lager: enable nfsroot in DTS

 arch/arm/boot/dts/Makefile                       |  4 ++
 arch/arm/boot/dts/emev2.dtsi                     |  6 +++
 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts  | 65 ++++++++++++++++++++++++
 arch/arm/boot/dts/r8a73a4-ape6evm.dts            |  2 +-
 arch/arm/boot/dts/r8a7740.dtsi                   | 12 +++++
 arch/arm/boot/dts/r8a7778-bockw-reference.dts    | 32 ++++++++++++
 arch/arm/boot/dts/r8a7778-bockw.dts              |  2 +-
 arch/arm/boot/dts/r8a7779-marzen-reference.dts   |  2 +-
 arch/arm/boot/dts/r8a7779-marzen.dts             | 27 ++++++++++
 arch/arm/boot/dts/r8a7790-lager-reference.dts    | 45 ++++++++++++++++
 arch/arm/boot/dts/r8a7790-lager.dts              |  2 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts     |  2 +-
 arch/arm/boot/dts/sh73a0-kzm9g.dts               |  2 +-
 arch/arm/boot/dts/sh73a0.dtsi                    |  6 +++
 arch/arm/mach-shmobile/Kconfig                   | 37 ++++++++++++++
 arch/arm/mach-shmobile/Makefile                  |  3 ++
 arch/arm/mach-shmobile/Makefile.boot             |  3 ++
 arch/arm/mach-shmobile/board-ape6evm-reference.c | 64 +++++++++++++++++++++++
 arch/arm/mach-shmobile/board-armadillo800eva.c   |  2 +-
 arch/arm/mach-shmobile/board-bockw-reference.c   | 62 ++++++++++++++++++++++
 arch/arm/mach-shmobile/board-lager-reference.c   | 45 ++++++++++++++++
 arch/arm/mach-shmobile/board-marzen.c            | 11 ++--
 arch/arm/mach-shmobile/include/mach/r8a73a4.h    |  1 +
 arch/arm/mach-shmobile/include/mach/r8a7740.h    |  1 -
 arch/arm/mach-shmobile/include/mach/r8a7778.h    |  1 +
 arch/arm/mach-shmobile/include/mach/r8a7779.h    |  1 -
 arch/arm/mach-shmobile/include/mach/r8a7790.h    |  1 +
 arch/arm/mach-shmobile/intc-r8a7740.c            | 20 ++------
 arch/arm/mach-shmobile/intc-r8a7779.c            | 22 ++------
 arch/arm/mach-shmobile/setup-r8a73a4.c           |  9 +++-
 arch/arm/mach-shmobile/setup-r8a7778.c           |  7 ++-
 arch/arm/mach-shmobile/setup-r8a7790.c           |  9 +++-
 arch/arm/mach-shmobile/smp-r8a7779.c             | 12 ++---
 arch/arm/mach-shmobile/smp-sh73a0.c              | 11 +---
 34 files changed, 461 insertions(+), 70 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a73a4-ape6evm-reference.dts
 create mode 100644 arch/arm/boot/dts/r8a7778-bockw-reference.dts
 create mode 100644 arch/arm/boot/dts/r8a7779-marzen.dts
 create mode 100644 arch/arm/boot/dts/r8a7790-lager-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-ape6evm-reference.c
 create mode 100644 arch/arm/mach-shmobile/board-bockw-reference.c
 create mode 100644 arch/arm/mach-shmobile/board-lager-reference.c
