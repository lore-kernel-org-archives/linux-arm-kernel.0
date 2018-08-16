From: wendy.liang@xilinx.com (Wendy Liang)
Date: Thu, 16 Aug 2018 00:06:23 -0700
Subject: [PATCH 0/7] Add Xilinx ZynqMP R5 remoteproc driver
Message-ID: <1534403190-28523-1-git-send-email-jliang@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are Cortex-R5 processors on Xilinx ZynqMP UltraScale+
MPSoC.
This patch is to add an Xilinx ZynqMP R5 remoteproc driver to
enable Linux kernel to bringup R5, and enable communication
between Linux kernel and R5.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

Wendy Liang (7):
  firmware: xlnx-zynqmp: Add RPU ioctl enums
  firmware: xlnx-zynqmp: Add request ack enums
  firmware: xilinx-zynqmp: Add request access capability macro
  firmware: xlnx-zynqmp: Add request/release node
  firmware: xlnx-zynqmp: Add shutdown/wakeup request
  remoteproc: Add Xilinx ZynqMP R5 remoteproc
  Documentation: devicetree: Add Xilinx R5 rproc binding

 .../remoteproc/xlnx,zynqmp-r5-remoteproc.txt       |  81 +++
 drivers/firmware/xilinx/zynqmp.c                   |  65 ++
 drivers/remoteproc/Kconfig                         |   9 +
 drivers/remoteproc/Makefile                        |   1 +
 drivers/remoteproc/zynqmp_r5_remoteproc.c          | 692 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  43 ++
 6 files changed, 891 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5-remoteproc.txt
 create mode 100644 drivers/remoteproc/zynqmp_r5_remoteproc.c

-- 
2.7.4
