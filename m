From: shawnguo@kernel.org (Shawn Guo)
Date: Mon, 8 Oct 2018 22:56:03 +0800
Subject: [GIT PULL] i.MX drivers change for 4.20, round 2 (late)
Message-ID: <20181008145600.GT3587@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8d8e3b7d8f06f69005d829d4a195b00ef976004b:

  soc: imx: gpcv2: Switch to SPDX identifier (2018-10-01 13:24:15 +0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git tags/imx-drivers-4.20-2

for you to fetch changes up to b912de514a8759ef558096d7f1c3a0000e0e37f0:

  MAINTAINERS: imx: include drivers/firmware/imx path (2018-10-08 22:11:02 +0800)

----------------------------------------------------------------
i.MX drivers change for 4.20, round 2:
 - A series from Aisheng Dong to add SCU firmware driver for i.MX8
   SoCs.  It implements IPC mechanism based on mailbox for message
   exchange between AP and SCU firmware, and a set of SCU IPC
   service APIs used by clients like i.MX8 power domain and clock
   drivers.

----------------------------------------------------------------
Dong Aisheng (4):
      dt-bindings: arm: fsl: add scu binding doc
      firmware: imx: add SCU firmware driver support
      firmware: imx: add misc svc support
      MAINTAINERS: imx: include drivers/firmware/imx path

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
 MAINTAINERS                                        |   2 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/imx-scu.c                     | 270 +++++++++
 drivers/firmware/imx/misc.c                        |  99 ++++
 include/linux/firmware/imx/ipc.h                   |  59 ++
 include/linux/firmware/imx/sci.h                   |  17 +
 include/linux/firmware/imx/svc/misc.h              |  55 ++
 include/linux/firmware/imx/types.h                 | 617 +++++++++++++++++++++
 12 files changed, 1317 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 drivers/firmware/imx/Kconfig
 create mode 100644 drivers/firmware/imx/Makefile
 create mode 100644 drivers/firmware/imx/imx-scu.c
 create mode 100644 drivers/firmware/imx/misc.c
 create mode 100644 include/linux/firmware/imx/ipc.h
 create mode 100644 include/linux/firmware/imx/sci.h
 create mode 100644 include/linux/firmware/imx/svc/misc.h
 create mode 100644 include/linux/firmware/imx/types.h
