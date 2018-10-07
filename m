From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  7 Oct 2018 21:04:40 +0800
Subject: [PATCH V9 0/3] soc: imx: add scu firmware api support
Message-ID: <1538917483-1818-1-git-send-email-aisheng.dong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unlike the former i.MX Architectures, the new generation i.MX8 SoCs
(e.g. MX8QXP and MX8QM) contain a system controller which runs on a
dedicated Cortex-M core to provide power, clock, Pad, and resource
management. Communication between the host processor running
an OS and the system controller happens through a SCU protocol.
This patchset adds the SCU APIs which is implemented based on MU
and will be used by different system components.

It mainly consists of below parts:
1) SCU IPC
   Basic IPC mechanism implemention based on mailbox which is used
   for communication between AP and SCU firmware.
2) SCU IPC Service API

v8->v9:
 * only scu headfile path update from include/soc/imx to
   include/linux/firmware/imx

Dong Aisheng (3):
  dt-bindings: arm: fsl: add scu binding doc
  firmware: imx: add SCU firmware driver support
  firmware: imx: add misc svc support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/imx-scu.c                     | 269 +++++++++
 drivers/firmware/imx/misc.c                        |  99 ++++
 include/linux/firmware/imx/ipc.h                   |  59 ++
 include/linux/firmware/imx/sci.h                   |  17 +
 include/linux/firmware/imx/svc/misc.h              |  55 ++
 include/linux/firmware/imx/types.h                 | 617 +++++++++++++++++++++
 11 files changed, 1314 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 drivers/firmware/imx/Kconfig
 create mode 100644 drivers/firmware/imx/Makefile
 create mode 100644 drivers/firmware/imx/imx-scu.c
 create mode 100644 drivers/firmware/imx/misc.c
 create mode 100644 include/linux/firmware/imx/ipc.h
 create mode 100644 include/linux/firmware/imx/sci.h
 create mode 100644 include/linux/firmware/imx/svc/misc.h
 create mode 100644 include/linux/firmware/imx/types.h

-- 
2.7.4
