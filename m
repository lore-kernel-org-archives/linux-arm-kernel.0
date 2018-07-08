From: aisheng.dong@nxp.com (Dong Aisheng)
Date: Sun,  8 Jul 2018 22:56:52 +0800
Subject: [PATCH V4 0/5] soc: imx: add scu firmware api support
Message-ID: <1531061817-1980-1-git-send-email-aisheng.dong@nxp.com>
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
1) MU mailbox driver
1) Implementation of the IPC functions based on MUs (client side).

Dong Aisheng (5):
  dt-bindings: mailbox: allow mbox-cells to be equal to 0
  dt-bindings: arm: fsl: add mu binding doc
  mailbox: imx: add imx mu support
  dt-bindings: arm: fsl: add scu binding doc
  soc: imx: add SC firmware IPC and APIs

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |  65 ++
 .../devicetree/bindings/mailbox/fsl,mu.txt         |  34 +
 .../devicetree/bindings/mailbox/mailbox.txt        |   3 +-
 drivers/mailbox/Kconfig                            |   8 +
 drivers/mailbox/Makefile                           |   2 +
 drivers/mailbox/imx-mu.c                           | 341 +++++++++
 drivers/soc/imx/Kconfig                            |   4 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/sc/Makefile                        |   2 +
 drivers/soc/imx/sc/main/ipc.c                      | 185 +++++
 drivers/soc/imx/sc/main/rpc.h                      |  79 +++
 include/soc/imx/sc/ipc.h                           |  45 ++
 include/soc/imx/sc/scfw.h                          |  24 +
 include/soc/imx/sc/types.h                         | 764 +++++++++++++++++++++
 14 files changed, 1555 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/fsl,mu.txt
 create mode 100644 drivers/mailbox/imx-mu.c
 create mode 100644 drivers/soc/imx/sc/Makefile
 create mode 100644 drivers/soc/imx/sc/main/ipc.c
 create mode 100644 drivers/soc/imx/sc/main/rpc.h
 create mode 100644 include/soc/imx/sc/ipc.h
 create mode 100644 include/soc/imx/sc/scfw.h
 create mode 100644 include/soc/imx/sc/types.h

-- 
2.7.4
