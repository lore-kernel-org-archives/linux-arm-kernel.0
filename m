From: nobuhiro.iwamatsu.yj@renesas.com (Nobuhiro Iwamatsu)
Date: Thu, 22 Nov 2012 16:59:57 +0900
Subject: [PATCH v5 00/15] shmobile DT initialisation of INTC and GIC
Message-ID: <1353571213-26006-1-git-send-email-nobuhiro.iwamatsu.yj@renesas.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, simon and Magnus.

I updated patch series for shmobile DT support.
This version fixes definition of interrupt-controller. By this, I fixed
external interrupt issuse on sh7372.
And update r8a7740 and sh73a0 DT INTC init code to reduce the number of #ifdefs.

---

The aims of this series are:

* Adding DT support to INTC
* Allowing relevant ARM shmobile SoCs to use DT to initialise INTC
* Allowing relevant ARM shmobile boards to use DT to initialise INTC
* Allowing the sh73a0 SoC use DT to initialise GIC
* Allowing the sh73a0 SoC use DT to initialise GIC, which in
  turn allows the kzm9g board to use DT to initialise GIC

Nobuhiro Iwamatsu (12):
  ARM: mach-shmobile: Add support OF for INTC of shmobile
  SH: intc: Add support OF of IRQ
  ARM: mach-shmobile: Add support OF of INTC for r8a7740
  ARM: mach-shmobile: Add support OF of INTC for sh73a0
  ARM: mach-shmobile: Add support OF of INTC for sh7372
  ARM: mach-shmobile: Add DT table of INTC for sh73a0
  ARM: mach-shmobile: Add DT table of INTC for sh7372
  ARM: mach-shmobile: Add DT table of INTC for r8a7740
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
 arch/arm/boot/dts/r8a7740.dtsi                |  967 ++++++++++++++++++++-
 arch/arm/boot/dts/sh7372.dtsi                 | 1140 +++++++++++++++++++++++++
 arch/arm/boot/dts/sh73a0-kzm9g.dts            |    2 +-
 arch/arm/boot/dts/sh73a0.dtsi                 |  821 ++++++++++++++++++
 arch/arm/mach-shmobile/board-kzm9g.c          |    2 +-
 arch/arm/mach-shmobile/include/mach/common.h  |    3 +
 arch/arm/mach-shmobile/intc-r8a7740.c         |   69 +-
 arch/arm/mach-shmobile/intc-sh7372.c          |  112 ++-
 arch/arm/mach-shmobile/intc-sh73a0.c          |  163 ++--
 arch/arm/mach-shmobile/setup-r8a7740.c        |    2 +-
 arch/arm/mach-shmobile/setup-sh7372.c         |    2 +-
 drivers/sh/intc/Makefile                      |    1 +
 drivers/sh/intc/core.c                        |    2 +-
 drivers/sh/intc/internals.h                   |    3 +-
 drivers/sh/intc/irqdomain.c                   |    6 +-
 drivers/sh/intc/of_intc.c                     |  646 ++++++++++++++
 include/linux/sh_intc.h                       |   84 ++
 19 files changed, 4096 insertions(+), 94 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/sh/intc.txt
 create mode 100644 arch/arm/boot/dts/sh73a0.dtsi
 create mode 100644 drivers/sh/intc/of_intc.c

-- 
1.7.10.4
