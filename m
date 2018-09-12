From: jolly.shah@xilinx.com (Jolly Shah)
Date: Wed, 12 Sep 2018 12:38:34 -0700
Subject: [PATCH v12 0/6] drivers: Introduce firmware driver for ZynqMP core
Message-ID: <1536781120-22794-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Firmware driver enables APU to communicate to PMUFW(Platform Management Unit) via ATF by 
using SMC instructions. This patchset is adding support for base firmware driver with query 
and clock control APIs. More API support will be added with incremental patchsets along with 
their user driver.

v12:
 - Removed clock driver patches from set
 - Removed ioctl api support
 - Incorporated minor review comments from v11 patch series

v11:
 - Removed "Reveiwed-by:Stephen Boyd" tag from firmware binding
 - Updated clock and firmware driver to use probe method instead of init
 - Marked PMU payload arguments with __le32 for proper endienness code
 
v10:
 - Incorporated code review comments from v9 patch series. Discussed below:
	https://patchwork.kernel.org/patch/10478575/
	https://patchwork.kernel.org/patch/10478457/
	https://patchwork.kernel.org/patch/10478461/
	https://patchwork.kernel.org/patch/10478463/
	
v9:
 - Fixed minor typo comments

v8:
 - Corrected typo in clk Kconfig
 
v7:
 - Removed xilinx specific clock debugfs API support
 - Added reviewed-by tags for FW and clock bindings
 - Updated clock node name to clock-controller

v6:
 - Broke patch series to have base FW driver and Clock driver user
 - Incorporated code review comments from last FW and Clock driver patch series. Discussed below:
	https://patchwork.kernel.org/patch/10230759/
	https://patchwork.kernel.org/patch/10250047/

v5:
 - Added ATF version check support
 - Updated some functions to be static 
 - Minor function name corrections

v4:
 - Changed clock setrate/getrate API prototype to support 64 bit rate
 - Defined macros for get_node_status return values
 - Moved DT node as a child of firmware
 - Changed debugfs APIs to return data to debugfs buffer instead of dumping to kernel log
 - Minor changes to incorporate other review comments from v3 patch series

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

Rajan Vaja (6):
  dt-bindings: firmware: Add bindings for ZynqMP firmware
  firmware: xilinx: Add Zynqmp firmware driver
  firmware: xilinx: Add query data API
  firmware: xilinx: Add clock APIs
  firmware: xilinx: Add debugfs interface
  firmware: xilinx: Add debugfs for query data API

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  29 ++
 arch/arm64/Kconfig.platforms                       |   1 +
 drivers/firmware/Kconfig                           |   1 +
 drivers/firmware/Makefile                          |   1 +
 drivers/firmware/xilinx/Kconfig                    |  23 +
 drivers/firmware/xilinx/Makefile                   |   5 +
 drivers/firmware/xilinx/zynqmp-debug.c             | 250 ++++++++++
 drivers/firmware/xilinx/zynqmp-debug.h             |  24 +
 drivers/firmware/xilinx/zynqmp.c                   | 523 +++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               | 113 +++++
 10 files changed, 970 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
 create mode 100644 drivers/firmware/xilinx/Kconfig
 create mode 100644 drivers/firmware/xilinx/Makefile
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.c
 create mode 100644 drivers/firmware/xilinx/zynqmp-debug.h
 create mode 100644 drivers/firmware/xilinx/zynqmp.c
 create mode 100644 include/linux/firmware/xlnx-zynqmp.h

-- 
2.7.4
