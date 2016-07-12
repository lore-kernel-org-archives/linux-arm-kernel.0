From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 12 Jul 2016 14:36:39 -0500
Subject: [PATCH v18 0/6] Device Tree support for FPGA Programming
Message-ID: <20160712193645.9098-1-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

v18 has very minimal changes to address comments about the device
tree bindings and device tree examples in the bindings document.

The diffstat from v17 is:
  4 files changed, 11 insertions(+), 18 deletions(-)
If there are more changes, it would be easier to
send these upstream and just start adding small
patches to fix whatever else.

Alan Tull (6):
  fpga: add bindings document for fpga region
  ARM: socfpga: add bindings document for fpga bridge drivers
  add sysfs document for fpga bridge class
  fpga: add fpga bridge framework
  fpga: fpga-region: device tree control for FPGA
  ARM: socfpga: fpga bridge driver support

 Documentation/ABI/testing/sysfs-class-fpga-bridge  |  11 +
 .../bindings/fpga/altera-fpga2sdram-bridge.txt     |  16 +
 .../bindings/fpga/altera-hps2fpga-bridge.txt       |  39 ++
 .../devicetree/bindings/fpga/fpga-region.txt       | 491 ++++++++++++++++++
 drivers/fpga/Kconfig                               |  21 +
 drivers/fpga/Makefile                              |   7 +
 drivers/fpga/altera-fpga2sdram.c                   | 174 +++++++
 drivers/fpga/altera-hps2fpga.c                     | 213 ++++++++
 drivers/fpga/fpga-bridge.c                         | 388 ++++++++++++++
 drivers/fpga/fpga-region.c                         | 555 +++++++++++++++++++++
 include/linux/fpga/fpga-bridge.h                   |  55 ++
 include/linux/fpga/fpga-mgr.h                      |   2 +
 12 files changed, 1972 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-bridge
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-fpga2sdram-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/altera-hps2fpga-bridge.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
 create mode 100644 drivers/fpga/altera-fpga2sdram.c
 create mode 100644 drivers/fpga/altera-hps2fpga.c
 create mode 100644 drivers/fpga/fpga-bridge.c
 create mode 100644 drivers/fpga/fpga-region.c
 create mode 100644 include/linux/fpga/fpga-bridge.h

-- 
2.9.1
