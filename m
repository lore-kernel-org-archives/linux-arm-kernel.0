From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 25 Oct 2016 09:55:31 -0500
Subject: [PATCH v21 0/9] Device Tree support for FPGA Programming
Message-ID: <20161025145540.3722-1-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset supports FPGA programming under the control
of Device Tree overlays.

Changes since v20 are minor:
 * s/Mangager/Manager/
 * altera-hps2fpga bridge: remove a clk_put
 * altera-hps2fpga bridge: don't need to look up l3regs for f2h
   bridge

The following were acked so they are no longer in this patch set:
 * DT bindings for Altera Freeze Bridges
    https://patchwork.kernel.org/patch/9379803/
 * DT bindings for Altera SOCFPGA bridges
    https://patchwork.kernel.org/patch/9226093/
 * DT bindings for Arria 10 FPGA Mgr
    https://patchwork.kernel.org/patch/9226111/
 * "[PATCH v3] of/overlay: add of overlay notifications"
    https://patchwork.kernel.org/patch/8493481/

The patchset is dependent on:
 * Pantelis Antonious's dtc changes for dynamic device tree.
    https://github.com/pantoniou/dtc.git
 * Pantelis' configfs interface patches and fixes
    https://github.com/pantoniou/linux-beagle-track-mainline

Alan

Alan Tull (9):
  fpga: add bindings document for fpga region
  doc: fpga-mgr: add fpga image info to api
  add sysfs document for fpga bridge class
  fpga-mgr: add fpga image information struct
  fpga: add fpga bridge framework
  fpga: fpga-region: device tree control for FPGA
  ARM: socfpga: fpga bridge driver support
  fpga: add altera freeze bridge support
  fpga-manager: Add Socfpga Arria10 support

 Documentation/ABI/testing/sysfs-class-fpga-bridge  |  11 +
 .../devicetree/bindings/fpga/fpga-region.txt       | 494 +++++++++++++++++
 Documentation/fpga/fpga-mgr.txt                    |  32 +-
 drivers/fpga/Kconfig                               |  36 ++
 drivers/fpga/Makefile                              |   9 +
 drivers/fpga/altera-fpga2sdram.c                   | 180 ++++++
 drivers/fpga/altera-freeze-bridge.c                | 273 ++++++++++
 drivers/fpga/altera-hps2fpga.c                     | 222 ++++++++
 drivers/fpga/fpga-bridge.c                         | 395 ++++++++++++++
 drivers/fpga/fpga-mgr.c                            |  17 +-
 drivers/fpga/fpga-region.c                         | 603 +++++++++++++++++++++
 drivers/fpga/socfpga-a10.c                         | 556 +++++++++++++++++++
 drivers/fpga/socfpga.c                             |   7 +-
 drivers/fpga/zynq-fpga.c                           |  10 +-
 include/linux/fpga/fpga-bridge.h                   |  60 ++
 include/linux/fpga/fpga-mgr.h                      |  25 +-
 16 files changed, 2900 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-fpga-bridge
 create mode 100644 Documentation/devicetree/bindings/fpga/fpga-region.txt
 create mode 100644 drivers/fpga/altera-fpga2sdram.c
 create mode 100644 drivers/fpga/altera-freeze-bridge.c
 create mode 100644 drivers/fpga/altera-hps2fpga.c
 create mode 100644 drivers/fpga/fpga-bridge.c
 create mode 100644 drivers/fpga/fpga-region.c
 create mode 100644 drivers/fpga/socfpga-a10.c
 create mode 100644 include/linux/fpga/fpga-bridge.h

-- 
2.10.1
