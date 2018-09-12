From: anurag.kumar.vulisha@xilinx.com (Anurag Kumar Vulisha)
Date: Wed, 12 Sep 2018 21:52:44 +0530
Subject: [PATCH v4 0/2] phy: zynqmp: Add phy driver for xilinx zynqmp phy core
Message-ID: <1536769366-31398-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ZynqMP serial input output unit (SIOU) is a high-speed serial interface block
that acts as a phy interface for the PCIe, USB 3.0, DisplayPort, SATA, and
Ethernet controllers. These controllers use any one among the available four
multigigabit transceivers for high-speed communication with their link partners
outside the SOC

ZynqMP SIOU supports multiple protocols working at different reference clock
frequencies to operate simultaneously. Each of the four lanes will be having
a dedicated PLL associated which generates the desired frequency required by
the protocol configured based on the reference clock input given. Using this
driver, user can select the desired reference clock frequency for each of
lane 0, lane 1, lane 2, and lane 3 respectively. Each lane can be programmed
to have its own reference clock or can share reference clock from its
neighboring lane, this is called as "Clock Sharing". This driver supports
clock sharing aswell.

These set of patches add support SIOU support by adding zynqmp-phy driver to
linux.

Changes in v4:
	1. Fixed the changes in phy-zynqmp.txt as suggested by "Rob Herring"
	2. Moved the dt-bindings patch from 2nd to 1st

Changes in v3:
	1. Corrected the Documentation as suggested by "Vivek Gautam"

Changes in v2:
	1. Fixed the compilation error when compiled phy-zynqmp.c as a module
	2. Added CONFIG_PM macro in phy-zynqmp.c driver

Anurag Kumar Vulisha (2):
  phy: zynqmp: Add dt bindings for ZynqMP phy
  phy: zynqmp: Add phy driver for xilinx zynqmp phy core

 .../devicetree/bindings/phy/phy-zynqmp.txt         |  109 ++
 drivers/phy/Kconfig                                |    8 +
 drivers/phy/Makefile                               |    1 +
 drivers/phy/phy-zynqmp.c                           | 1581 ++++++++++++++++++++
 include/dt-bindings/phy/phy.h                      |    2 +
 include/linux/phy/phy-zynqmp.h                     |   52 +
 6 files changed, 1753 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-zynqmp.txt
 create mode 100644 drivers/phy/phy-zynqmp.c
 create mode 100644 include/linux/phy/phy-zynqmp.h

-- 
2.1.1
