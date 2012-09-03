From: anilkumar@ti.com (AnilKumar Ch)
Date: Mon, 3 Sep 2012 17:22:15 +0530
Subject: [PATCH 0/4] can: c_can: Add suspend/resume and pinctrl support
Message-ID: <1346673139-14540-1-git-send-email-anilkumar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adds suspend/resume functionality of d_can driver along with d_can
raminit support which is required to initialize RAM while data
transmission.

This patch series also adds pinctrl support to c_can driver. These
patches were tested on AM335x-EVM.

This patch-series is based ontop of runtimePM patch submitted
earlier - https://patchwork.kernel.org/patch/1348081/

AnilKumar Ch (4):
  can: c_can: Adopt pinctrl support
  can: c_can: Add d_can raminit support
  ARM: AM33XX: board-generic: Add of_dev_auxdata to pass d_can raminit
  can: c_can: Add d_can suspend resume support

 arch/arm/mach-omap2/board-generic.c    |   40 +++++++++++++-
 arch/arm/mach-omap2/control.h          |    4 ++
 drivers/net/can/c_can/c_can.c          |   91 ++++++++++++++++++++++++++++++++
 drivers/net/can/c_can/c_can.h          |    7 +++
 drivers/net/can/c_can/c_can_platform.c |   87 ++++++++++++++++++++++++++++--
 include/linux/can/platform/c_can.h     |   36 +++++++++++++
 6 files changed, 261 insertions(+), 4 deletions(-)
 create mode 100644 include/linux/can/platform/c_can.h

-- 
1.7.9.5
