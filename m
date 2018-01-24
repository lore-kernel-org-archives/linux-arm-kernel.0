From: jolly.shah@xilinx.com (Jolly Shah)
Date: Wed, 24 Jan 2018 15:21:10 -0800
Subject: [PATCH v3 0/4] drivers: firmware: xilinx: Add firmware driver support
Message-ID: <1516836074-4149-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Introduce firmware driver for ZynqMP core.
This patchset is adding communication layer with firmware.
Firmware driver provides an interface to firmware APIs.
Interface APIs can be used by any driver to communicate to
PMUFW(Platform Management Unit). All requests go through ATF.

v3:
 - added some fixes to firmware-ggs.c
 - updated pinmux get/set function argument names to specify function id instead of node id
 - added new pinctrl query macros
 - incorporated review comments from v2 patch series

v2:
 - change SPDX-License-Identifier license text style
 - split patch into multiple patches
 - Updated copyrights
 - Added ABI documentation
 - incorporated logical review comments from previuos patch. Discussed below:
	https://patchwork.kernel.org/patch/10150665/

Jolly Shah (4):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  drivers: firmware: xilinx: Add ZynqMP firmware driver
  drivers: firmware: xilinx: Add sysfs interface
  drivers: firmware: xilinx: Add debugfs interface

 .../ABI/stable/sysfs-driver-zynqmp-firmware        |   50 +
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |   16 +
 arch/arm64/Kconfig.platforms                       |    1 +
 drivers/firmware/Kconfig                           |    1 +
 drivers/firmware/Makefile                          |    1 +
 drivers/firmware/xilinx/Kconfig                    |    4 +
 drivers/firmware/xilinx/Makefile                   |    4 +
 drivers/firmware/xilinx/zynqmp/Kconfig             |   23 +
 drivers/firmware/xilinx/zynqmp/Makefile            |    5 +
 drivers/firmware/xilinx/zynqmp/firmware-debug.c    |  511 ++++++++++
 drivers/firmware/xilinx/zynqmp/firmware-ggs.c      |  297 ++++++
 drivers/firmware/xilinx/zynqmp/firmware.c          | 1035 ++++++++++++++++++++
 .../linux/firmware/xilinx/zynqmp/firmware-debug.h  |   31 +
 include/linux/firmware/xilinx/zynqmp/firmware.h    |  578 +++++++++++
 14 files changed, 2557 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-zynqmp-firmware
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/firmware/xilinx/zynqmp/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware-ggs.c
 create mode 100644 drivers/firmware/xilinx/zynqmp/firmware.c
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware-debug.h
 create mode 100644 include/linux/firmware/xilinx/zynqmp/firmware.h

-- 
2.7.4
