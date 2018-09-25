From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Wed, 26 Sep 2018 00:27:55 +0800
Subject: [PATCH V7 0/3] soc: imx: add scu firmware api support
Message-ID: <1537892878-30933-1-git-send-email-aisheng.dong@nxp.com>
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

Dong Aisheng (3):
  dt-bindings: arm: fsl: add scu binding doc
  firmware: imx: add SCU firmware driver support
  firmware: imx: add misc svc support

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  | 183 ++++++
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/imx/Kconfig                       |  11 +
 drivers/firmware/imx/Makefile                      |   2 +
 drivers/firmware/imx/imx-scu.c                     | 224 ++++++++
 drivers/firmware/imx/misc.c                        | 110 ++++
 include/soc/imx/scu/ipc.h                          |  59 ++
 include/soc/imx/scu/sci.h                          |  17 +
 include/soc/imx/scu/svc/misc.h                     |  55 ++
 include/soc/imx/scu/types.h                        | 636 +++++++++++++++++++++
 11 files changed, 1299 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 drivers/firmware/imx/Kconfig
 create mode 100644 drivers/firmware/imx/Makefile
 create mode 100644 drivers/firmware/imx/imx-scu.c
 create mode 100644 drivers/firmware/imx/misc.c
 create mode 100644 include/soc/imx/scu/ipc.h
 create mode 100644 include/soc/imx/scu/sci.h
 create mode 100644 include/soc/imx/scu/svc/misc.h
 create mode 100644 include/soc/imx/scu/types.h

-- 
2.7.4
