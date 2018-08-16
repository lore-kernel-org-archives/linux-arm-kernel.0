From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 16 Aug 2018 12:08:00 -0700
Subject: [PATCH v2 0/3] drivers: soc: xilinx: Add support for ZynqMP PM driver
Message-ID: <1534446483-12156-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add ZynqMP PM driver. PM driver provides power management
support for ZynqMP.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver to use shared interrupt instead of mailbox
 
Rajan Vaja (3):
  dt-bindings: soc: Add ZynqMP PM bindings
  firmware: xilinx: Implement ZynqMP power management APIs
  drivers: soc: xilinx: Add ZynqMP PM driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  16 ++
 drivers/firmware/xilinx/zynqmp.c                   |  29 +++
 drivers/soc/xilinx/Kconfig                         |  11 +
 drivers/soc/xilinx/Makefile                        |   1 +
 drivers/soc/xilinx/zynqmp_power.c                  | 230 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |  20 ++
 6 files changed, 307 insertions(+)
 create mode 100644 drivers/soc/xilinx/zynqmp_power.c

-- 
2.7.4
