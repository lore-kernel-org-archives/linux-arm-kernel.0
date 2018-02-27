From: jolly.shah@xilinx.com (Jolly Shah)
Date: Tue, 27 Feb 2018 15:55:48 -0800
Subject: [PATCH 0/2] drivers: soc: xilinx: Add support for ZynqMP power domain
 driver
Message-ID: <1519775750-21297-1-git-send-email-jollys@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The zynqmp power domain driver communicates the usage requirements
for logical power domains / devices to the platform FW.
FW is responsible for choosing appropriate power states,
taking Linux' usage information into account.

This patchset has dependency on below drivers:
Firmware Driver:     https://patchwork.kernel.org/patch/10230773/

Jolly Shah (2):
  dt-bindings: power: Add ZynqMP power domain bindings
  drivers: soc: xilinx: Add ZynqMP power domain driver

 .../devicetree/bindings/power/zynqmp-genpd.txt     |  46 +++
 drivers/soc/xilinx/Kconfig                         |   2 +
 drivers/soc/xilinx/Makefile                        |   2 +
 drivers/soc/xilinx/zynqmp/Kconfig                  |  16 +
 drivers/soc/xilinx/zynqmp/Makefile                 |   4 +
 drivers/soc/xilinx/zynqmp/pm_domains.c             | 339 +++++++++++++++++++++
 6 files changed, 409 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/zynqmp-genpd.txt
 create mode 100644 drivers/soc/xilinx/zynqmp/Kconfig
 create mode 100644 drivers/soc/xilinx/zynqmp/Makefile
 create mode 100644 drivers/soc/xilinx/zynqmp/pm_domains.c

-- 
2.7.4
