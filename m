From: jolly.shah@xilinx.com (Jolly Shah)
Date: Thu, 4 Oct 2018 14:23:37 -0700
Subject: [PATCH v3 0/4] drivers: soc: xilinx: Add support for ZynqMP power
 domain driver
Message-ID: <1538688221-9823-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynqmp power domain driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

This patch series is based on top of Xilinx firmware patch set:
https://patchwork.kernel.org/cover/10555405/

v3:
 - Changed binding to have FW node as a power controller as suggested by Rob
 - Updated FW driver to register it as mfd child devices from firmware probe
 - Move bindings location as suggested

v2:
 - Rebased on top of latest firmware driver patch series
 - Updated driver name from zynqmp-genpd to zynqmp-power-controller
 - Updated device tree bindings to move power controller node under firmware node

Jolly Shah (1):
  drivers: soc: xilinx: Add ZynqMP power domain driver

Rajan Vaja (3):
  dt-bindings: power: Add ZynqMP power domain bindings
  firmware: xilinx: Add APIs to control node status/power
  firmware: xilinx: Add node IDs for zynqmp firmware

 .../bindings/power/xlnx,zynqmp-genpd.txt           |  34 ++
 drivers/firmware/xilinx/Kconfig                    |   1 +
 drivers/firmware/xilinx/zynqmp.c                   |  73 ++++
 drivers/soc/xilinx/Kconfig                         |   9 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/zynqmp_pm_domains.c             | 403 +++++++++++++++++++++
 include/dt-bindings/power/xlnx-zynqmp-power.h      |  39 ++
 include/linux/firmware/xlnx-zynqmp.h               |  98 +++++
 8 files changed, 659 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/xlnx,zynqmp-genpd.txt
 create mode 100644 drivers/soc/xilinx/zynqmp_pm_domains.c
 create mode 100644 include/dt-bindings/power/xlnx-zynqmp-power.h

-- 
2.7.4
