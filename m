From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Thu,  7 Nov 2013 16:07:04 +0100
Subject: [PATCH 0/4] Socfpga: clk: trivial fixes and cleanup
Message-ID: <1383836828-24886-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series includes two trivial fixes to the code (1,2),
then goes on to split the single clk.c file up into clock-type
specific files (3) and finally adds a divider to the peripheral
clock path.

The patches are rebased to the for-next branch of

        git://git.rocketboards.org/linux-socfpga-next.git

Regards,
Steffen

Steffen Trumtrar (4):
  ARM: socfpga: clk: remove unused field
  ARM: socfpga: clk: fix define typo
  ARM: socfpga: clk: split clk code
  ARM: socfpga: clk: add clk_divider to periph

 drivers/clk/socfpga/Makefile     |   3 +
 drivers/clk/socfpga/clk-gate.c   | 197 ++++++++++++++++++++++++
 drivers/clk/socfpga/clk-periph.c |  87 +++++++++++
 drivers/clk/socfpga/clk-pll.c    | 114 ++++++++++++++
 drivers/clk/socfpga/clk.c        | 313 +--------------------------------------
 drivers/clk/socfpga/clk.h        |  56 +++++++
 6 files changed, 458 insertions(+), 312 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate.c
 create mode 100644 drivers/clk/socfpga/clk-periph.c
 create mode 100644 drivers/clk/socfpga/clk-pll.c
 create mode 100644 drivers/clk/socfpga/clk.h

-- 
1.8.4.rc3
