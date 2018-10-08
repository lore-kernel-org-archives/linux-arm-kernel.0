From: jolly.shah@xilinx.com (Jolly Shah)
Date: Mon, 8 Oct 2018 11:21:42 -0700
Subject: [PATCH v6 0/4] drivers: clk: Add ZynqMP clock driver support
Message-ID: <1539022906-18073-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds CCF compliant clock driver for ZynqMP.Clock driver queries 
supported clock information from firmware and regiters pll and output clocks with CCF.

This patch series is earlier reveiwed as part of FW patchset (https://patchwork.kernel.org/cover/10555405/). 
FW driver from that patchset is merged. This patchset contains only clock driver and is based on top of 
xilinx firmware patch set available in below tree:
https://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git/log/?h=next/drivers

v6:
 - Updated eemi return payload type to be u32 instead of le32 and Eemi ops in FW driver will be updated to take care of endianess
 - Added Stephen's review tag
 
v5:
 - Added "Acked-by: Olof Johansson <olof@lixom.net>" for patches
 
v4:
 - Fixed minor review comments received for v3 patchset
 
v3:
 - Added check to pass only valid ioctls for ioctl eemi api
 - Added eemi documentation including ioctl details

Jolly Shah (1):
  drivers: clk: Add ZynqMP clock driver

Rajan Vaja (3):
  Documentation: xilinx: Add documentation for eemi APIs
  firmware: xilinx: Add zynqmp IOCTL API for device control
  dt-bindings: clock: Add bindings for ZynqMP clock driver

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       |  53 ++
 Documentation/xilinx/eemi.txt                      |  67 ++
 drivers/clk/Kconfig                                |   1 +
 drivers/clk/Makefile                               |   1 +
 drivers/clk/zynqmp/Kconfig                         |  10 +
 drivers/clk/zynqmp/Makefile                        |   4 +
 drivers/clk/zynqmp/clk-gate-zynqmp.c               | 144 +++++
 drivers/clk/zynqmp/clk-mux-zynqmp.c                | 141 ++++
 drivers/clk/zynqmp/clk-zynqmp.h                    |  68 ++
 drivers/clk/zynqmp/clkc.c                          | 716 +++++++++++++++++++++
 drivers/clk/zynqmp/divider.c                       | 217 +++++++
 drivers/clk/zynqmp/pll.c                           | 335 ++++++++++
 drivers/firmware/xilinx/zynqmp.c                   |  42 ++
 include/dt-bindings/clock/xlnx,zynqmp-clk.h        | 116 ++++
 include/linux/firmware/xlnx-zynqmp.h               |   5 +-
 15 files changed, 1919 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/xilinx/eemi.txt
 create mode 100644 drivers/clk/zynqmp/Kconfig
 create mode 100644 drivers/clk/zynqmp/Makefile
 create mode 100644 drivers/clk/zynqmp/clk-gate-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-mux-zynqmp.c
 create mode 100644 drivers/clk/zynqmp/clk-zynqmp.h
 create mode 100644 drivers/clk/zynqmp/clkc.c
 create mode 100644 drivers/clk/zynqmp/divider.c
 create mode 100644 drivers/clk/zynqmp/pll.c
 create mode 100644 include/dt-bindings/clock/xlnx,zynqmp-clk.h

-- 
2.7.4
