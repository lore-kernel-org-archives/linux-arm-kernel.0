From: ulf.hansson@stericsson.com (Ulf Hansson)
Date: Wed, 3 Apr 2013 01:06:24 +0200
Subject: [PATCH 0/3] clk: ux500: Add support for ab850x clocks
Message-ID: <1364943987-1338-1-git-send-email-ulf.hansson@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulf Hansson <ulf.hansson@linaro.org>

This patchset implements a new clock hw type called sysctrl used for abx500
clocks. It will then setup the first version of clock tree specfic for ab850x.

The new sysctrl clk hw type depends on the ab8500-sysctrl API. The last patch
is a mfd patch which alignes the probe order between the abx500-clk driver and
the ab8500-sysctrl driver.

The intent is to merge the patchset together, preferably through Mike's
clk tree. I would thus try to fetch an ack from Samuel regarding the mfd
patch.

Ulf Hansson (3):
  clk: ux500: Add support for sysctrl clocks
  clk: ux500: abx500: Define clock tree for ab850x
  mfd: ab8500: sysctrl: Initialize driver at arch_initcall

 drivers/clk/ux500/Makefile      |    1 +
 drivers/clk/ux500/abx500-clk.c  |   71 ++++++++++++-
 drivers/clk/ux500/clk-sysctrl.c |  224 +++++++++++++++++++++++++++++++++++++++
 drivers/clk/ux500/clk.h         |   29 +++++
 drivers/mfd/ab8500-sysctrl.c    |    2 +-
 5 files changed, 323 insertions(+), 4 deletions(-)
 create mode 100644 drivers/clk/ux500/clk-sysctrl.c

-- 
1.7.10
