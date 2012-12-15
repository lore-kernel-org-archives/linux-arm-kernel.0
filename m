From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 15 Dec 2012 18:03:34 +0900
Subject: [RFC v7 00/10] ARM: shmobile: DT initialisation of INTC and GIC
Message-ID: <1355562224-29448-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aims of this series are:

* Add DT bindings to to INTC
* Allowing sh7372 and r8a7740 ARM shmobile SoCs to use DT
  to initialise INTCA

Key Changes since v5 (previous public revision of this series)
* Drop support for sh73a0 SoC.
  To be useful this requires a fuller initialisation than jsut INCA.
  In particular, cascade IRQs that are shared between INTC and GIC
  need to be handled.
* Drop board support
  This will be revisited on a per-board basis, ideally with
  filler INTC initialisation via DT in place
* Drop GIC initialisation
  This will also be revisited on a per-board basis.
* Remove unused INTC DT helper functions


Status:

I am reasonably happy with this series and plan to merge the shmobile portions.

Paul, I forget if I asked you this before or not, but could you let me know
if you would like to handle the intc patches, the first two patches in the
series, or if you are comfortable with them going through my tree.

Git and diffstat information provided for review.

----------------------------------------------------------------------


The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel/intc-of

for you to fetch changes up to 91cb8c20ebbaaf35482cc256b9ab97279bbe753c:

  ARM: shmobile: sh7372: Use DT initialisation of INTC (2012-12-15 17:50:28 +0900)

----------------------------------------------------------------
Nobuhiro Iwamatsu (9):
      ARM: shmobile: Add support OF for INTC of shmobile
      SH: intc: Add support OF of IRQ
      ARM: shmobile: Add support OF of INTC for r8a7740
      ARM: shmobile: Add support OF of INTC for sh7372
      ARM: shmobile: Add DT table of INTC for sh7372
      ARM: shmobile: Add DT table of INTC for r8a7740
      ARM: shmobile: Include DTSI of r8a7740 to armadillo800eva
      ARM: shmobile: r8a7740: Use DT initialisation of INTC
      ARM: shmobile: sh7372: Use DT initialisation of INTC

Simon Horman (1):
      ARM: shmobile: sh7372: Do not initialise TMU when using DT

 Documentation/devicetree/bindings/sh/intc.txt |  152 +++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts |    2 +-
 arch/arm/boot/dts/r8a7740.dtsi                |  743 ++++++++++++++++++++++-
 arch/arm/boot/dts/sh7372.dtsi                 |  784 +++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h  |    2 +
 arch/arm/mach-shmobile/intc-r8a7740.c         |   70 ++-
 arch/arm/mach-shmobile/intc-sh7372.c          |  113 +++-
 arch/arm/mach-shmobile/setup-r8a7740.c        |    2 +-
 arch/arm/mach-shmobile/setup-sh7372.c         |   19 +-
 drivers/sh/intc/Makefile                      |    1 +
 drivers/sh/intc/core.c                        |    2 +-
 drivers/sh/intc/internals.h                   |    3 +-
 drivers/sh/intc/irqdomain.c                   |    6 +-
 drivers/sh/intc/of_intc.c                     |  571 ++++++++++++++++++
 include/linux/sh_intc.h                       |   56 ++
 15 files changed, 2481 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
 create mode 100644 drivers/sh/intc/of_intc.c
