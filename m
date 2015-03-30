From: leo.yan@linaro.org (Leo Yan)
Date: Mon, 30 Mar 2015 13:24:19 +0800
Subject: [PATCH v2 0/5] clk: hisilicon: support stub clock
Message-ID: <1427693064-11062-1-git-send-email-leo.yan@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for hisilicon stub clock driver. On hi6220,
the bootloader needs load the firmware image and set info for OPPs;
after run into kernel, the stub clock driver is used to communicate
w/t firmware for cpu dynamic frequency scaling. So finally s/w will
simply write request in sram and send ipc to power controller.

These patches have been tested on 96board hikey and will be used by
cpufreq driver.

Changes from v1:
* Refine parameter checking for init flow
* Remove unnecessary debugging info
* Modify to check spinlock pointer when register clocks


Leo Yan (5):
  clk: hisi: refine parameter checking for init
  clk: hisi: add API for allocation clk data struct
  dt-bindings: clk: hisilicon: Document stub clock driver
  clk: hisi: add stub clk driver
  clk: hisi: add stub clock register function

 .../devicetree/bindings/clock/hisi,stub-clock.txt  |  38 +++
 drivers/clk/hisilicon/Makefile                     |   2 +-
 drivers/clk/hisilicon/clk-stub.c                   | 282 +++++++++++++++++++++
 drivers/clk/hisilicon/clk.c                        |  64 ++++-
 drivers/clk/hisilicon/clk.h                        |  17 ++
 include/dt-bindings/clock/hisi,stub-clock.h        |  26 ++
 6 files changed, 416 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/hisi,stub-clock.txt
 create mode 100644 drivers/clk/hisilicon/clk-stub.c
 create mode 100644 include/dt-bindings/clock/hisi,stub-clock.h

-- 
1.9.1
