From: leo.yan@linaro.org (Leo Yan)
Date: Thu, 26 Mar 2015 19:13:35 +0800
Subject: [PATCH 0/4] clk: hisilicon: support stub clock
Message-ID: <1427368419-22222-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for hisilicon stub clock driver. On hi6220,
the bootloader needs load the firmware image and set info for OPPs;
after run into kernel, the stub clock driver is used to communicate
w/t firmware for cpu dynamic frequency scaling. So finally s/w will
simply write request in sram and send ipc to power controller.

These patches have been tested on 96board hikey and will be used by
cpufreq driver.

Leo Yan (4):
  clk: hisi: add API for allocation clk data struct
  dt-bindings: clk: hisilicon: Document stub clock driver
  clk: hisi: add stub clk driver
  clk: hisi: add stub clock register function

 .../devicetree/bindings/clock/hisi,stub-clock.txt  |  38 +++
 drivers/clk/hisilicon/Makefile                     |   2 +-
 drivers/clk/hisilicon/clk-stub.c                   | 284 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |  71 ++++--
 drivers/clk/hisilicon/clk.h                        |  17 ++
 include/dt-bindings/clock/hisi,stub-clock.h        |  26 ++
 6 files changed, 422 insertions(+), 16 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hisi,stub-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-stub.c
 create mode 100644 include/dt-bindings/clock/hisi,stub-clock.h

-- 
1.9.1
