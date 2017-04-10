From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 10 Apr 2017 22:37:52 +0800
Subject: [GIT PULL 1/5] i.MX driver changes for 4.12
Message-ID: <1491835076-1995-1-git-send-email-shawnguo@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c1ae3cfa0e89fa1a7ecc4c99031f5e9ae99d9201:

  Linux 4.11-rc1 (2017-03-05 12:59:56 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.12

for you to fetch changes up to 44c43c98213fb123819c67c128a5d6c9a9a12280:

  soc: imx: gpc: add workaround for i.MX6QP to the GPC PD driver (2017-04-07 20:47:34 +0800)

----------------------------------------------------------------
i.MX drivers updates for 4.12:
 - A series from Lucas Stach which partly rewrites the imx gpc driver
   to support multiple power domains, and moves the related code from
   imx platform into drivers folder.
 - A series from Dong Aisheng which fixes the issues with Lucas' code
   changes and improves things.
 - Add workaround for i.MX6QP hardware erratum ERR009619 that is PRE
   clocks may be stalled during the power up sequencing of the PU power
   domain.
 - Add imx-gpcv2 driver to support power domains managed by GPCv2 IP
   block found on i.MX7 series of SoCs.

----------------------------------------------------------------
Andrey Smirnov (2):
      dt-bindings: Add GPCv2 power gating driver
      soc: imx: Add GPCv2 power gating driver

Dong Aisheng (8):
      soc: imx: gpc: fix gpc clk get error handling
      soc: imx: gpc: fix the wrong using of regmap cache
      soc: imx: gpc: fix domain_index sanity check issue
      soc: imx: gpc: fix imx6sl gpc power domain regression
      soc: imx: gpc: fix comment when power up domain
      soc: imx: gpc: keep PGC_X_CTRL name align with reference manual
      dt-bindings: imx-gpc: correct the DOMAIN_INDEX using
      soc: imx: gpc: remove unnecessary readable_reg callback

Lucas Stach (5):
      dt-bindings: add multidomain support to i.MX GPC DT binding
      soc: imx: move PGC handling to a new GPC driver
      soc: imx: gpc: add defines for domain index
      dt-bindings: imx-gpc: add i.MX6 QuadPlus compatible
      soc: imx: gpc: add workaround for i.MX6QP to the GPC PD driver

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |  85 ++--
 .../devicetree/bindings/power/fsl,imx-gpcv2.txt    |  71 +++
 MAINTAINERS                                        |   1 +
 arch/arm/mach-imx/gpc.c                            | 217 ---------
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/imx/Kconfig                            |   9 +
 drivers/soc/imx/Makefile                           |   2 +
 drivers/soc/imx/gpc.c                              | 489 +++++++++++++++++++++
 drivers/soc/imx/gpcv2.c                            | 363 +++++++++++++++
 include/dt-bindings/power/imx7-power.h             |  16 +
 11 files changed, 1010 insertions(+), 245 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,imx-gpcv2.txt
 create mode 100644 drivers/soc/imx/Kconfig
 create mode 100644 drivers/soc/imx/Makefile
 create mode 100644 drivers/soc/imx/gpc.c
 create mode 100644 drivers/soc/imx/gpcv2.c
 create mode 100644 include/dt-bindings/power/imx7-power.h
