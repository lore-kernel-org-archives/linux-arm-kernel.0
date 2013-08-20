From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 20 Aug 2013 19:34:19 +0200
Subject: [PATCH v2 0/4] clk: clock deregistration support
Message-ID: <1377020063-30213-1-git-send-email-s.nawrocki@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series combines my previous ones ([1], [2]) adding clk_unregister()
function's implementation and fixing a race condition in the device tree
related part of clk_get().

There are couple changes since the RFC v1:
 - moved of_clk_{lock, unlock}, __of_clk_get_from_provider() function
   declaractions to a local header,
 - renamed clk_dummy_* to clk_nodrv_*.

[1] https://lkml.org/lkml/2013/8/6/306
[2] http://www.spinics.net/lists/arm-kernel/msg265989.html

Sylwester Nawrocki (4):
  clk: add common __clk_get(), __clk_put() implementations
  clk: implement clk_unregister
  clk: Provide not locked variant of of_clk_get_from_provider()
  clkdev: Fix race condition in clock lookup from device tree

 arch/arm/include/asm/clkdev.h      |    2 +
 arch/blackfin/include/asm/clkdev.h |    2 +
 arch/mips/include/asm/clkdev.h     |    2 +
 arch/sh/include/asm/clkdev.h       |    2 +
 drivers/clk/clk.c                  |  185 +++++++++++++++++++++++++++++++++---
 drivers/clk/clk.h                  |   16 ++++
 drivers/clk/clkdev.c               |   12 ++-
 include/linux/clk-private.h        |    5 +
 include/linux/clkdev.h             |    5 +
 9 files changed, 218 insertions(+), 13 deletions(-)
 create mode 100644 drivers/clk/clk.h

--
1.7.9.5
