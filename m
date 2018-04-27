From: mdf@kernel.org (Moritz Fischer)
Date: Thu, 26 Apr 2018 18:26:01 -0700
Subject: [PATCH 0/4] FPGA Manager Patches for 4.18
Message-ID: <20180427012605.28981-1-mdf@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

Here's Alan's reworked patchset changing the API
for creating and registering FPGA Managers, Bridges and
Regions following your suggestions on the API.

These go on top of Paolo and Alan's patches that you
queued up the other day.

Thanks,

Moritz

Alan Tull (4):
  fpga: region: don't use drvdata in common fpga code
  fpga: manager: change api, don't use drvdata
  fpga: bridge: change api, don't use drvdata
  fpga: region: change api, add fpga_region_create/free

 Documentation/fpga/fpga-mgr.txt     | 35 ++++++++++---
 Documentation/fpga/fpga-region.txt  |  3 +-
 drivers/fpga/altera-cvp.c           | 19 +++++--
 drivers/fpga/altera-fpga2sdram.c    | 21 ++++++--
 drivers/fpga/altera-freeze-bridge.c | 22 ++++++--
 drivers/fpga/altera-hps2fpga.c      | 24 +++++++--
 drivers/fpga/altera-pr-ip-core.c    | 18 ++++++-
 drivers/fpga/altera-ps-spi.c        | 20 ++++++--
 drivers/fpga/fpga-bridge.c          | 70 +++++++++++++++++---------
 drivers/fpga/fpga-mgr.c             | 78 +++++++++++++++++++----------
 drivers/fpga/fpga-region.c          | 69 +++++++++++++++++++------
 drivers/fpga/ice40-spi.c            | 21 ++++++--
 drivers/fpga/machxo2-spi.c          | 20 ++++++--
 drivers/fpga/of-fpga-region.c       | 14 +++---
 drivers/fpga/socfpga-a10.c          | 14 ++++--
 drivers/fpga/socfpga.c              | 19 +++++--
 drivers/fpga/ts73xx-fpga.c          | 20 ++++++--
 drivers/fpga/xilinx-pr-decoupler.c  | 22 ++++++--
 drivers/fpga/xilinx-spi.c           | 20 ++++++--
 drivers/fpga/zynq-fpga.c            | 14 ++++--
 include/linux/fpga/fpga-bridge.h    |  9 ++--
 include/linux/fpga/fpga-mgr.h       | 10 ++--
 include/linux/fpga/fpga-region.h    | 11 ++--
 23 files changed, 429 insertions(+), 144 deletions(-)

-- 
2.17.0
