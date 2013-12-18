From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 18 Dec 2013 18:02:58 +0100
Subject: [PATCH V2 0/4] socfpga: clk: trivial fixes and cleanup
Message-ID: <1387386182-30923-1-git-send-email-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

This series includes two trivial fixes to the code (1/4 and 2/4),
and a fixes a compile error in 3/4 introduced by the patch

	clk: socfpga: Look for the GPIO_DB_CLK by its offset

from

	[GIT PULL] clk: socfpga: Clean-ups for 3.14

The series is rebased onto

	git://git.rocketboards.org/linux-socfpga-next.git socfpga-clk-for-3.14

and the patch

	clk: socfpga: Add a clk-phase property to the "altr, socfpga-gate-clk"

from the series

	socfpga: Enable SD/MMC support

Regards,
Steffen

Steffen Trumtrar (4):
  ARM: socfpga: clk: remove unused field
  ARM: socfpga: clk: fix define typo
  ARM: socfpga: clk: fix compile error
  ARM: socfpga: clk: split clk code

 drivers/clk/socfpga/Makefile     |   3 +
 drivers/clk/socfpga/clk-gate.c   | 223 +++++++++++++++++++++++++
 drivers/clk/socfpga/clk-periph.c |  94 +++++++++++
 drivers/clk/socfpga/clk-pll.c    | 111 +++++++++++++
 drivers/clk/socfpga/clk.c        | 347 +--------------------------------------
 drivers/clk/socfpga/clk.h        |  57 +++++++
 6 files changed, 490 insertions(+), 345 deletions(-)
 create mode 100644 drivers/clk/socfpga/clk-gate.c
 create mode 100644 drivers/clk/socfpga/clk-periph.c
 create mode 100644 drivers/clk/socfpga/clk-pll.c
 create mode 100644 drivers/clk/socfpga/clk.h

-- 
1.8.5.1
