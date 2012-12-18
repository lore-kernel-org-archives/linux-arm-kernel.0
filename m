From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 18 Dec 2012 09:46:04 +0900
Subject: [RFC v8 00/9] ARM: shmobile: DT initialisation of INTC and GIC
Message-ID: <1355791573-20281-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The aims of this series are:

* Add DT bindings to to INTC
* Allowing sh7372 and r8a7740 ARM shmobile SoCs to use DT
  to initialise INTCA

Change since v7
* Squash the first and second patch of the series and rename there result
  "SH: intc: Add support OF for INTC"

Changes v5 and v7 (v6 was not publicly released)
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
if you would like to handle the intc patch, the first patch of the
series, or if you are comfortable with it going through my tree.

Git and diffstat information provided for review.

----------------------------------------------------------------------

The following changes since commit ddffeb8c4d0331609ef2581d84de4d763607bd37:

  Linux 3.7-rc1 (2012-10-14 14:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git devel/intc-of

for you to fetch changes up to 9a68d0806201ff048e2919b35108645c15076300:

  ARM: shmobile: sh7372: Use DT initialisation of INTC (2012-12-18 09:35:43 +0900)

----------------------------------------------------------------
Nobuhiro Iwamatsu (8):
      SH: intc: Add support OF for INTC
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
