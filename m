From: horms@verge.net.au (Simon Horman)
Date: Wed,  7 Nov 2012 17:50:29 +0900
Subject: [RFC 00/15] SH/ARM shmobile DT initialisation of INTC and GIC
Message-ID: <1352278244-26702-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series by Iwamatsu-san and myself is a first pass at:

* Adding DT support to INTC
* Allowing relevant ARM shmobile SoCs to use DT to initialise INTC
* Allowing relevant ARM shmobile boards to use DT to initialise INTC
* Allowing the sh73a0 SoC use DT to initialise GIC
* Allowing the sh73a0 SoC use DT to initialise GIC, which in
  turn allows the kzm9g board to use DT to initialise GIC

Review would be greatly appreciated.

Diffstat and git information is provided to aid review

----------------------------------------------------------------
The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel/of

for you to fetch changes up to f94f73ccfa8701f02a0b9528605d89a42710d806:

  ARM: shmobile: sh73a0: Use DT for GIC (2012-11-07 17:41:56 +0900)

----------------------------------------------------------------
Nobuhiro Iwamatsu (12):
      ARM: shmobile: Add support OF for INTC of shmobile
      SH: intc: Add support OF of IRQ
      ARM: shmobile: Add support OF of INTC for r8a7740
      ARM: shmobile: Add support OF of INTC for sh73a0
      ARM: shmobile: Add support OF of INTC for sh7372
      ARM: shmobile: Add DT table of INTC for sh73a0
      ARM: shmobile: Add DT table of INTC for sh7372
      ARM: shmobile: Add DT table of INTC for r8a7740
      ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
      ARM: shmobile: Include DTSI of sh73a0 to kzm9g board
      ARM: shmobile: r8a7740: Use DT initialisation of INTC
      ARM: shmobile: sh7372: Use DT initialisation of INTC

Simon Horman (3):
      ARM: shmobile: kzm9g: Use DT initialisation of INTC
      ARM: shmobile: Add DT table of GIC for sh73a0
      ARM: shmobile: sh73a0: Use DT for GIC

 Documentation/devicetree/bindings/sh/intc.txt |  163 ++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                |  965 ++++++++++++++++++++-
 arch/arm/boot/dts/sh7372.dtsi                 | 1138 +++++++++++++++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g.dts            |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi                 |  819 ++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h  |    3 +
 arch/arm/mach-shmobile/intc-r8a7740.c         |  136 ++-
 arch/arm/mach-shmobile/intc-sh7372.c          |  210 ++++-
 arch/arm/mach-shmobile/intc-sh73a0.c          |  248 +++++-
 arch/arm/mach-shmobile/setup-r8a7740.c        |    2 +-
 arch/arm/mach-shmobile/setup-sh7372.c         |    2 +-
 drivers/sh/intc/Kconfig                       |    7 +
 drivers/sh/intc/Makefile                      |    1 +
 drivers/sh/intc/core.c                        |    2 +-
 drivers/sh/intc/internals.h                   |    3 +-
 drivers/sh/intc/irqdomain.c                   |    6 +-
 drivers/sh/intc/of_intc.c                     |  646 ++++++++++++++
 include/linux/sh_intc.h                       |   84 ++
 20 files changed, 4361 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
 create mode 100644 drivers/sh/intc/of_intc.c
